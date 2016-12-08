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
    
    
    if (gameType == 0)
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"New Game"
                                     message:@"Choose the Game Rules"
                                     preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* fiveOOneButton = [UIAlertAction
                                         actionWithTitle:@"501"
                                         style:UIAlertActionStyleDefault
                                         handler:^(UIAlertAction * action) {
                                             
                                             // handle button
                                             [self saveGameSelection501];
                                             [self performSegueWithIdentifier:@"501" sender:sender];
                                         }];
        UIAlertAction* cricketButton = [UIAlertAction
                                        actionWithTitle:@"Cricket"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                                            
                                            // Handle button
                                            [self saveGameSelectionCricket];
                                            [self performSegueWithIdentifier:@"Cricket" sender:sender];
                                        }];
        [alert addAction:fiveOOneButton];
        [alert addAction:cricketButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        [self performSegueWithIdentifier:@"Continue" sender:sender];
    }
}

-(void)saveGameSelection501
{
    // Create and save new 501 game
    Game *g = [NSEntityDescription insertNewObjectForEntityForName:@"Game" inManagedObjectContext:self.moc];
    g.gameType = @"501";
    g.timeStarted = [NSDate date];
    NSFetchRequest *requestPlayers = [NSFetchRequest fetchRequestWithEntityName:@"Player"];
    NSError *error = nil;
    NSArray *fetchedPlayers = [self.moc executeFetchRequest:requestPlayers error:&error];
    Points501 *playerPoints = [NSEntityDescription insertNewObjectForEntityForName:@"Points501" inManagedObjectContext:self.moc];
    Points501 *opponentPoints = [NSEntityDescription insertNewObjectForEntityForName:@"Points501" inManagedObjectContext:self.moc];
    g.pointsFive = [[NSOrderedSet alloc]initWithObjects:playerPoints, opponentPoints, nil];
    g.turnCounter = 1;
    g.p1Pts = 501;
    g.p2Pts = 501;
    
    NSMutableArray *players = [NSMutableArray new];
    if (fetchedPlayers.count < 1) {
        Player *player = [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:self.moc];
        player.name = @"Player";
        player.pointsFive = [[NSOrderedSet alloc] initWithObjects:playerPoints, nil];
        [players addObject:player];
    }
    if (fetchedPlayers.count < 2) {
        Player *player = [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:self.moc];
        player.name = @"Opponent";
        player.pointsFive= [[NSOrderedSet alloc] initWithObjects:opponentPoints, nil];
        [players addObject:player];
    }
    if (fetchedPlayers.count > 0) {
        for (Player* p in fetchedPlayers) {
            [players addObject:p];
        }
    }
    g.player = [NSOrderedSet orderedSetWithArray:players];
    if (![self.moc save:&error]) {
        NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
    }
}
-(void)saveGameSelectionCricket
{
    // Create and save new Cricket game
    Game *g = [NSEntityDescription insertNewObjectForEntityForName:@"Game" inManagedObjectContext:self.moc];
    g.gameType = @"Cricket";
    g.timeStarted = [NSDate date];
    NSFetchRequest *requestPlayers = [NSFetchRequest fetchRequestWithEntityName:@"Player"];
    NSError *error = nil;
    NSArray *fetchedPlayers = [self.moc executeFetchRequest:requestPlayers error:&error];
    CricketPoints *playerPoints = [NSEntityDescription insertNewObjectForEntityForName:@"CricketPoints" inManagedObjectContext:self.moc];
    CricketPoints *opponentPoints = [NSEntityDescription insertNewObjectForEntityForName:@"CricketPoints" inManagedObjectContext:self.moc];
    g.pointsCricket = [NSOrderedSet orderedSetWithObjects:playerPoints, opponentPoints, nil];
    g.turnCounter = 1;
    g.p1Pts = 0;
    g.p2Pts = 0;
    
    NSMutableArray *players = [NSMutableArray new];
    if (fetchedPlayers.count < 1) {
        Player *player = [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:self.moc];
        player.name = @"Player";
        player.points = [[NSOrderedSet alloc] initWithObjects:playerPoints, nil];
        [players addObject:player];
    }
    if (fetchedPlayers.count < 2) {
        Player *player = [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:self.moc];
        player.name = @"Opponent";
        player.points = [[NSOrderedSet alloc] initWithObjects:opponentPoints, nil];
        [players addObject:player];
    }
    if (fetchedPlayers.count > 0) {
        for (Player* p in fetchedPlayers) {
            [players addObject:p];
        }
    }
    g.player = [NSOrderedSet orderedSetWithArray:players];
    if (![self.moc save:&error]) {
        NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
    }
}

#pragma mark - Segues
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UINavigationController *nav = (UINavigationController*)segue.destinationViewController;
    PageViewController *pVC = (PageViewController*)nav.topViewController;
    pVC.moc = self.moc;
    
    if ([segue.identifier isEqualToString:@"501"]) {
        
    }else if ([segue.identifier isEqualToString:@"Cricket"]){
        
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
