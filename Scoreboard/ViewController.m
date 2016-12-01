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
#import "Points+CoreDataClass.h"

@interface ViewController ()

@property (nonatomic) NSInteger noOfPlayers;
@property (nonatomic) NSManagedObjectContext *moc;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.playerPicker.dataSource = self;
    self.playerPicker.delegate = self;
    
    AppDelegate *appDelegate = (AppDelegate*)([[UIApplication sharedApplication] delegate]);
    
    self.moc = appDelegate.persistentContainer.viewContext;
    
    NSFetchRequest *requestGames = [NSFetchRequest fetchRequestWithEntityName:@"Game"];
    NSDate *date;
    [requestGames setPredicate:[NSPredicate predicateWithFormat:@"timeEnded = %@", date]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Segues
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UINavigationController *nav = (UINavigationController*)[segue destinationViewController];
    
    NSFetchRequest *requestPlayers = [NSFetchRequest fetchRequestWithEntityName:@"Player"];
    NSFetchRequest *requestGames = [NSFetchRequest fetchRequestWithEntityName:@"Game"];
    NSDate *date;
    [requestGames setPredicate:[NSPredicate predicateWithFormat:@"timeEnded = %@", date]];
    
    NSInteger gameType = [self.playerPicker selectedRowInComponent:0];
    PageViewController *pVC = (PageViewController*)nav.topViewController;
    
    NSError *error = nil;
    NSArray *fetchResultsPlayers = [self.moc executeFetchRequest:requestPlayers error:&error];
    NSArray *fetchResultsGames = [self.moc executeFetchRequest:requestGames error:&error];
    
    NSMutableArray <Player *> *playerArray = [NSMutableArray new];
    
    if (gameType == 0)
    {
        Game *game = [NSEntityDescription insertNewObjectForEntityForName:@"Game" inManagedObjectContext:self.moc];
        Points *playerPoints = [NSEntityDescription insertNewObjectForEntityForName:@"Points" inManagedObjectContext:self.moc];
        Points *opponentPoints = [NSEntityDescription insertNewObjectForEntityForName:@"Points" inManagedObjectContext:self.moc];
        game.points = [[NSOrderedSet alloc] initWithObjects:playerPoints, opponentPoints, nil];
        game.timeStarted = [NSDate date];
        game.turnCounter = 1;
        
        if (fetchResultsPlayers.count < 1) {
            Player *player = [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:self.moc];
            player.name = @"Player";
            player.points = [[NSOrderedSet alloc] initWithObjects:playerPoints, nil];
            [playerArray addObject:player];
            
        }
        
        if (fetchResultsPlayers.count < 2) {
            Player *player = [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:self.moc];
            player.name = @"Opponent";
            player.points = [[NSOrderedSet alloc] initWithObjects:opponentPoints, nil];
            [playerArray addObject:player];
        }

        
        game.player = (NSOrderedSet<Player*>*)[NSOrderedSet orderedSetWithArray:playerArray];
        
        if (fetchResultsGames.count > 0) {
            Game *game = fetchResultsGames.firstObject;
            NSOrderedSet *points = game.points;
            [self.moc deleteObject:game];
            [self.moc deleteObject:[points objectAtIndex:0]];
            [self.moc deleteObject:[points objectAtIndex:1]];
        }
    }
    
    if ([[self moc] save:&error] == NO) {
        NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
    }
    
    pVC.moc = self.moc;
    pVC.pageIndex = 0;
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
