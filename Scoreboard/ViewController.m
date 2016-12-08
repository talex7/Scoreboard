//
//  ViewController.m
//  Scoreboard
//
//  Created by Thomas Alexanian on 2016-11-27.
//
//

#import "ViewController.h"
#import "PageViewController.h"
#import "AppDelegate.h"
#import "Player+CoreDataClass.h"
#import "Game+CoreDataClass.h"
#import "CricketPoints+CoreDataClass.h"
#import "Points501+CoreDataClass.h"

@interface ViewController ()

@property (nonatomic) NSInteger noOfPlayers;
@property (nonatomic) NSManagedObjectContext *moc;
@property (weak, nonatomic) IBOutlet UIImageView *gameSelectView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.playerPicker.dataSource = self;
    self.playerPicker.delegate = self;
    
    AppDelegate *appDelegate = (AppDelegate*)([[UIApplication sharedApplication] delegate]);
    self.moc = appDelegate.managedObjectContext;
    
    NSFetchRequest *requestGames = [NSFetchRequest fetchRequestWithEntityName:@"Game"];
    NSDate *date;
    [requestGames setPredicate:[NSPredicate predicateWithFormat:@"timeEnded = %@", date]];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.playerPicker reloadAllComponents];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)newGameButton:(id)sender {
    
    //Set Game Type, and save game to context
    
    NSInteger gameType = [self.playerPicker selectedRowInComponent:0];
    
    __block BOOL alertDone = FALSE;
    if (gameType == 0)
    {
        Game *game = [NSEntityDescription insertNewObjectForEntityForName:@"Game" inManagedObjectContext:self.moc];
        
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"New Game"
                                     message:@"Choose the Game Rules"
                                     preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* fiveOOneButton = [UIAlertAction
                                         actionWithTitle:@"501"
                                         style:UIAlertActionStyleDefault
                                         handler:^(UIAlertAction * action) {
                                             //Handle your yes please button action here
                                             game.gameType = @"501";
                                             NSError *error = nil;
                                             if (![self.moc save:&error]) {
                                                 NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
                                             }
                                             alertDone = YES;
                                             [self performSegueWithIdentifier:@"501" sender:sender];
                                         }];
        UIAlertAction* cricketButton = [UIAlertAction
                                        actionWithTitle:@"Cricket"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                                            //Handle your yes please button action here
                                            game.gameType = @"Cricket";
                                            NSError *error = nil;
                                            if (![self.moc save:&error]) {
                                                NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
                                            }
                                            alertDone = TRUE;
                                            [self performSegueWithIdentifier:@"Cricket" sender:sender];
                                        }];
        [alert addAction:fiveOOneButton];
        [alert addAction:cricketButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        [self performSegueWithIdentifier:@"Continue" sender:sender];
    }
}

-(void)saveGameSelection
{
    // Save game settings and perform segue
}

#pragma mark - Segues
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UINavigationController *nav = (UINavigationController*)segue.destinationViewController;
    PageViewController *pVC = (PageViewController*)nav.topViewController;
    
    if ([segue.identifier isEqualToString:@"501"]) {
        NSFetchRequest *requestPlayers = [NSFetchRequest fetchRequestWithEntityName:@"Player"];
        NSFetchRequest *requestGames = [NSFetchRequest fetchRequestWithEntityName:@"Game"];
        NSDate *date;
        [requestGames setPredicate:[NSPredicate predicateWithFormat:@"timeEnded = %@", date]];
        NSError *error = nil;
        NSArray *fetchedPlayers = [self.moc executeFetchRequest:requestPlayers error:&error];
        NSArray *fetchedGames = [self.moc executeFetchRequest:requestGames error:&error];
        NSMutableArray *playerArray = [NSMutableArray new];
        
        Game *game = [NSEntityDescription insertNewObjectForEntityForName:@"Game" inManagedObjectContext:self.moc];
        Points501 *playerPoints = [NSEntityDescription insertNewObjectForEntityForName:@"Points501" inManagedObjectContext:self.moc];
        Points501 *opponentPoints = [NSEntityDescription insertNewObjectForEntityForName:@"Points501" inManagedObjectContext:self.moc];
        
        game.pointsFive = [[NSOrderedSet alloc]initWithObjects:playerPoints, opponentPoints, nil];
        game.timeStarted = [NSDate date];
        game.turnCounter = 1;
        
        if (fetchedPlayers.count >0) {
            for (Player *p in fetchedPlayers) {
                p.totalPts = 501;
            }
        }
        
        if (fetchedPlayers.count < 1) {
            Player *player = [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:self.moc];
            player.name = @"Player";
            player.totalPts = 501;
            player.pointsFive = [[NSOrderedSet alloc] initWithObjects:playerPoints, nil];
            [playerArray addObject:player];
        }
        if (fetchedPlayers.count < 2) {
            Player *player = [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:self.moc];
            player.name = @"Opponent";
            player.totalPts = 501;
            player.pointsFive= [[NSOrderedSet alloc] initWithObjects:opponentPoints, nil];
            [playerArray addObject:player];
        }
        
        game.player = (NSOrderedSet<Player*>*)[NSOrderedSet orderedSetWithArray:playerArray];
        
        if (fetchedGames.count > 0) {
            Game *game = [fetchedGames firstObject];
            NSOrderedSet *points501 = game.pointsFive;
            [self.moc deleteObject:game];
            if (points501.count >= 2) {
                [self.moc deleteObject:[points501 objectAtIndex:0]];
                [self.moc deleteObject:[points501 objectAtIndex:1]];
            }
        }
        if (![self.moc save:&error]) {
            NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
        }
        
    }else if ([segue.identifier isEqualToString:@"Cricket"]){
        NSFetchRequest *requestPlayers = [NSFetchRequest fetchRequestWithEntityName:@"Player"];
        NSFetchRequest *requestGames = [NSFetchRequest fetchRequestWithEntityName:@"Game"];
        
        NSDate *date;
        [requestGames setPredicate:[NSPredicate predicateWithFormat:@"timeEnded = %@", date]];
        
        NSError *error = nil;
        NSArray *fetchedPlayers = [self.moc executeFetchRequest:requestPlayers error:&error];
        NSArray *fetchedGames = [self.moc executeFetchRequest:requestGames error:&error];
        NSMutableArray *playerArray = [NSMutableArray new];
        
        Game *game = [NSEntityDescription insertNewObjectForEntityForName:@"Game" inManagedObjectContext:self.moc];
        CricketPoints *playerPoints = [NSEntityDescription insertNewObjectForEntityForName:@"CricketPoints" inManagedObjectContext:self.moc];
        CricketPoints *opponentPoints = [NSEntityDescription insertNewObjectForEntityForName:@"CricketPoints" inManagedObjectContext:self.moc];
        
        game.pointsCricket = [[NSOrderedSet alloc]initWithObjects:playerPoints, opponentPoints, nil];
        game.timeStarted = [NSDate date];
        game.turnCounter = 1;
        
        if (fetchedPlayers.count >0) {
            for (Player *p in fetchedPlayers) {
                p.totalPts = 0;
            }
        }
        
        if (fetchedPlayers.count < 1) {
            Player *player = [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:self.moc];
            player.name = @"Player";
            player.totalPts = 0;
            player.points = [[NSOrderedSet alloc] initWithObjects:playerPoints, nil];
            [playerArray addObject:player];
        }
        if (fetchedPlayers.count < 2) {
            Player *player = [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:self.moc];
            player.name = @"Opponent";
            player.totalPts = 0;
            player.points= [[NSOrderedSet alloc] initWithObjects:opponentPoints, nil];
            [playerArray addObject:player];
        }
        
        game.player = (NSOrderedSet<Player*>*)[NSOrderedSet orderedSetWithArray:playerArray];
        
        if (fetchedGames.count > 0) {
            Game *game = [fetchedGames firstObject];
            NSOrderedSet *pointsCricket = game.pointsCricket;
            [self.moc deleteObject:game];
            if (pointsCricket.count >= 2) {
                [self.moc deleteObject:[pointsCricket objectAtIndex:0]];
                [self.moc deleteObject:[pointsCricket objectAtIndex:1]];
            }
        }
        if (![self.moc save:&error]) {
            NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
        }
    }else{
        
    }
}

#pragma mark - PickerView

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *rowLabel;
    switch (row) {
        case 0:
            rowLabel = @"New Game";
            return rowLabel;
        case 1:
            rowLabel = @"Continue";
            return rowLabel;
    }
    return rowLabel;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSFetchRequest *requestGames = [NSFetchRequest fetchRequestWithEntityName:@"Game"];
    NSDate *date;
    [requestGames setPredicate:[NSPredicate predicateWithFormat:@"timeEnded = %@", date]];
    NSError *error = nil;
    NSArray *fetchResultsGames = [self.moc executeFetchRequest:requestGames error:&error];
    
    if (fetchResultsGames.count == 0) {
        return 1;
    } else {
        return 2;
    }
}



@end
