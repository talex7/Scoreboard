//
//  PlayerViewController.m
//  Scoreboard
//
//  Created by Matthew Mauro on 2016-11-28.
//
//

#import "Points+CoreDataClass.h"
#import "PageViewController.h"
#import "PlayerViewController.h"

@interface PlayerViewController () <Pages>
@property (weak, nonatomic) IBOutlet UIButton *finshButton;
@property (weak, nonatomic) IBOutlet UILabel *currentPlayerLabel;
@property (weak, nonatomic) IBOutlet UIButton *board;
@property Game *game;
@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.finshButton.hidden = YES;
    self.finshButton.userInteractionEnabled = NO;
    self.board.userInteractionEnabled = YES;
    
    AppDelegate *appDelegate = (AppDelegate*)([[UIApplication sharedApplication] delegate]);
    self.moc = appDelegate.managedObjectContext;
    
    NSError *error = nil;
    NSFetchRequest *gameRequest = [NSFetchRequest fetchRequestWithEntityName:@"Game"];
    NSFetchRequest *playerRequest = [NSFetchRequest fetchRequestWithEntityName:@"Player"];
    NSDate *date;
    [gameRequest setPredicate:[NSPredicate predicateWithFormat:@"timeEnded = %@", date]];
    NSArray *fetchResultsGames = [self.moc executeFetchRequest:gameRequest error:&error];
    NSArray *fetchResultsPlayer = [self.moc executeFetchRequest:playerRequest error:&error];
    
    Game *g = [fetchResultsGames objectAtIndex:0];
    self.game = g;
    self.players = fetchResultsPlayer;

    
    if (self.game.turnCounter == 1) {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Flipping"
                                     message:@"Flipping Coin for Turn Order"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"Got It!"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        //Handle your yes please button action here
                                        self.game.turnCounter += arc4random_uniform(2);
                                        if (self.game.turnCounter % 2 == 0) {
                                            self.currentPlayerLabel.text = [self.players objectAtIndex:1].name;
                                        }else{
                                            self.currentPlayerLabel.text = [self.players objectAtIndex:0].name;
                                        }
                                    }];
        [alert addAction:yesButton];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    if (self.game.turnCounter % 2 == 0) {
        self.currentPlayerLabel.text = [self.players objectAtIndex:1].name;
    }else{
        self.currentPlayerLabel.text = [self.players objectAtIndex:0].name;
    }
    [self updatePlayerScoring];
}

- (IBAction)toMainMenu:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Turn Progress/Reset
-(void)turnProgression
{
    if (self.game.turnCounter % 2 == 0) {
        self.currentPlayerLabel.text = [self.players objectAtIndex:1].name;
    }else{
        self.currentPlayerLabel.text = [self.players objectAtIndex:0].name;
    }
}

#pragma mark - Save Scoring to Core Data
-(void)updatePlayerScoring
{
    if (self.shotValues != nil) {
        // separate strings from array
        NSString *shot1 = self.shotValues[0];
        NSString *shot2 = self.shotValues[1];
        NSString *shot3 = self.shotValues[2];
        
        // separate those strings into ints.
        // one for value of slice hit, the other for the multiplier hit
        NSInteger shot1Val = [[shot1 substringToIndex:shot1.length-2]integerValue];
        NSInteger shot1Multi = [[shot1 substringFromIndex:shot1.length-1]integerValue];
        
        NSInteger shot2Val = [[shot2 substringToIndex:shot2.length-2]integerValue];
        NSInteger shot2Multi = [[shot2 substringFromIndex:shot2.length-1]integerValue];
        
        NSInteger shot3Val = [[shot3 substringToIndex:shot3.length-2]integerValue];
        NSInteger shot3Multi = [[shot3 substringFromIndex:shot3.length-1]integerValue];
        
        //fetch current point entity
        
        NSError *error = nil;
        NSFetchRequest *pointsRequest = [NSFetchRequest fetchRequestWithEntityName:@"Points"];
        NSArray *fetchResultsPoints = [self.moc executeFetchRequest:pointsRequest error:&error];
        
        Points *poi;
        if (self.game.turnCounter % 2 == 0) {
            poi = (Points*)[fetchResultsPoints objectAtIndex:1];
            poi.player = [self.players objectAtIndex:1];
            NSEntityDescription *entity = [poi entity];
            NSDictionary *attributes = [entity attributesByName];
            
            NSError *error = nil;
            for (NSString *str in attributes) {
                
                NSInteger timesHit = [[poi valueForKey:str]integerValue];
                NSCharacterSet *p = [NSCharacterSet characterSetWithCharactersInString:@"p"];
                NSInteger slice = [[str stringByTrimmingCharactersInSet:p]integerValue];
                
                if (shot1Val == slice) {
                    timesHit += shot1Multi;
                    [poi setValue:[NSNumber numberWithInteger:timesHit] forKey:str];
                    
                }
                if (shot2Val == slice){
                    timesHit += shot2Multi;
                    [poi setValue:[NSNumber numberWithInteger:timesHit] forKey:str];
                    
                }
                if (shot3Val == slice){
                    timesHit += shot3Multi;
                    [poi setValue:[NSNumber numberWithInteger:timesHit] forKey:str];
                    
                }
                
            }
            [self.moc save:&error];
            if (error){
                NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
            }
        }else{
            poi = (Points*)[fetchResultsPoints objectAtIndex:0];
            poi.player = [self.players objectAtIndex:0];
            NSEntityDescription *entity = [poi entity];
            NSDictionary *attributes = [entity attributesByName];
            NSError *error = nil;
            
            for (NSString *str in attributes) {
                NSInteger timesHit = [[poi valueForKey:str]integerValue];
                NSCharacterSet *p = [NSCharacterSet characterSetWithCharactersInString:@"p"];
                NSInteger slice = [[str stringByTrimmingCharactersInSet:p]integerValue];
                if (shot1Val == slice) {
                    timesHit += shot1Multi;
                    [poi setValue:[NSNumber numberWithInteger:timesHit] forKey:str];
                }
                if (shot2Val == slice){
                    timesHit += shot2Multi;
                    [poi setValue:[NSNumber numberWithInteger:timesHit] forKey:str];
                }
                if (shot3Val == slice){
                    timesHit += shot3Multi;
                    [poi setValue:[NSNumber numberWithInteger:timesHit] forKey:str];
                }
            }
            if (![self.moc save:&error]) {
                NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
            }
        }
        self.game.turnCounter ++;
        [self turnProgression];
    }
    self.shotValues = nil;
    if ([self checkIfGameIsComplete] == YES) {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"It's Over"
                                     message:@"Game has ended"
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"Done"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        //Handle your yes please button action here
                                        self.finshButton.hidden = NO;
                                        self.finshButton.userInteractionEnabled = YES;
                                        self.board.userInteractionEnabled = NO;
                                    }];
        [alert addAction:yesButton];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"detail"]) {
        BoardDetailViewController *vc = segue.destinationViewController;
        vc.delegate = self;
    }
}

-(BOOL)checkIfGameIsComplete
{
    NSError *error = nil;
    NSFetchRequest *pointsRequest = [NSFetchRequest fetchRequestWithEntityName:@"Points"];
    NSArray *fetchResultsPoints = [self.moc executeFetchRequest:pointsRequest error:&error];
    
    Points *p1Points = [fetchResultsPoints objectAtIndex:0];
    Points *p2Points = [fetchResultsPoints objectAtIndex:1];
    
    NSEntityDescription *p1Entity = [p1Points entity];
    NSDictionary *p1Attributes = [p1Entity attributesByName];
    NSEntityDescription *p2Entity = [p2Points entity];
    NSDictionary *p2Attributes = [p2Entity attributesByName];
    
    NSInteger p1S = [self.players objectAtIndex:0].totalPts;
    NSInteger p2S = [self.players objectAtIndex:1].totalPts;
    
    p1S = [self getPlayerScore:p1Points againstOpponent:p2Points];
    p2S = [self getPlayerScore:p2Points againstOpponent:p1Points];
    
    NSInteger p1Closed = 0;
    NSInteger p2Closed = 0;
    
    for (NSString *str in p1Attributes) {
        NSInteger timesHit = [[p1Attributes valueForKey:str]integerValue];
        if (timesHit >= 3) {
            p1Closed++;
        }
    }
    for (NSString *str in p2Attributes) {
        NSInteger timesHit = [[p2Attributes valueForKey:str]integerValue];
        if (timesHit >= 3) {
            p2Closed++;
        }
    }
    
    if (p1Closed >= 7 && p2Closed >= 7) {
        if (p1S > p2S) {
            self.game.timeEnded = [NSDate date];
            [self.players objectAtIndex:0].gamesWon++;
        }else if (p1S < p2S){
            self.game.timeEnded = [NSDate date];
            [self.players objectAtIndex:1].gamesWon++;
        }else{
            self.game.timeEnded = [NSDate date];
        }
        return YES;
    }
    if (p1Closed > 7 && p1S > p2S) {
        self.game.timeEnded = [NSDate date];
        [self.players objectAtIndex:0].gamesWon++;
        return YES;
    }
    if (p2Closed > 7 && p1S < p2S) {
        self.game.timeEnded = [NSDate date];
        [self.players objectAtIndex:0].gamesWon++;
        return YES;
    }
    return NO;
}

-(NSInteger)getPlayerScore:(Points*)points againstOpponent:(Points*)oppPoints
{
    NSInteger increasedScore = 0;
    NSEntityDescription *entity = [points entity];
    NSDictionary *attributes = [entity attributesByName];
    for (NSString *str in attributes) {
        NSInteger timesHit = [[points valueForKey:str]integerValue];
        NSCharacterSet *p = [NSCharacterSet characterSetWithCharactersInString:@"p"];
        NSInteger slice = [[str stringByTrimmingCharactersInSet:p]integerValue];
        if ([[oppPoints valueForKey:str]integerValue] < 3) {
            if (timesHit > 3) {
                increasedScore += (timesHit-3)*slice;
            }
        }
    }
    return increasedScore;
}

@end
