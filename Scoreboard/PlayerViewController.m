//
//  PlayerViewController.m
//  Scoreboard
//
//  Created by Matthew Mauro on 2016-11-28.
//
//

#import "Points501+CoreDataClass.h"
#import "Player+CoreDataClass.h"
#import "CricketPoints+CoreDataClass.h"
#import "PageViewController.h"
#import "PlayerViewController.h"
#import "FiveSummaryViewController.h"

@interface PlayerViewController () <Pages>
@property (weak, nonatomic) IBOutlet UIButton *finshButton;
@property (weak, nonatomic) IBOutlet UILabel *currentPlayerLabel;
@property (weak, nonatomic) IBOutlet UIButton *board;
@property Game *game;
@property (nonatomic) NSMutableDictionary *p1TimesHit;
@property (nonatomic) NSMutableDictionary *p2TimesHit;
@property ScoringStatus *p1Status;
@property ScoringStatus *p2Status;
@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.players = [NSMutableArray new];
    
    self.finshButton.hidden = YES;
    self.finshButton.userInteractionEnabled = NO;
    self.board.userInteractionEnabled = YES;
    
    NSArray *slices = @[@"p20", @"p19", @"p18", @"p17", @"p16", @"p15", @"p25"];
    NSArray *values = @[@0, @0, @0, @0, @0, @0, @0];
    self.p1TimesHit = [[NSMutableDictionary alloc]initWithObjects:values forKeys:slices];
    self.p2TimesHit = [[NSMutableDictionary alloc]initWithObjects:values forKeys:slices];
    
    AppDelegate *appDelegate = (AppDelegate*)([[UIApplication sharedApplication] delegate]);
    self.moc = appDelegate.managedObjectContext;
    
    NSError *error = nil;
    NSFetchRequest *gameRequest = [NSFetchRequest fetchRequestWithEntityName:@"Game"];
    NSFetchRequest *playerRequest = [NSFetchRequest fetchRequestWithEntityName:@"Player"];
    NSDate *date;
    [gameRequest setPredicate:[NSPredicate predicateWithFormat:@"timeEnded = %@", date]];
    NSArray *fetchResultsGames = [self.moc executeFetchRequest:gameRequest error:&error];
    NSArray *fetchResultsPlayer = [self.moc executeFetchRequest:playerRequest error:&error];
    
    Game *g = [fetchResultsGames lastObject];
    self.game = g;
    
    [self.players addObject:[fetchResultsPlayer objectAtIndex:0]];
    [self.players addObject:[fetchResultsPlayer objectAtIndex:1]];
    
    if (self.newGame == YES){
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
        self.newGame = NO;
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    if (self.newGame == YES) {
        
        self.p1TimesHit = [NSMutableDictionary new];
        self.p2TimesHit = [NSMutableDictionary new];
        NSError *error = nil;
        NSFetchRequest *cricketPointsRequest = [NSFetchRequest fetchRequestWithEntityName:@"CricketPoints"];
        NSArray *fetchResultsCricketPoints = [self.moc executeFetchRequest:cricketPointsRequest error:&error];
        
        for (CricketPoints* cricketPoints in fetchResultsCricketPoints) {
            NSEntityDescription *entity = [cricketPoints entity];
            NSDictionary *attributes = [entity attributesByName];
            for (NSString *str in attributes) {
                [cricketPoints setValue:0 forKey:str];
            }
        }
    }
    
    if (self.game.turnCounter % 2 == 0) {
        self.currentPlayerLabel.text = [self.players objectAtIndex:1].name;
    }else{
        self.currentPlayerLabel.text = [self.players objectAtIndex:0].name;
    }
    
    [self updatePlayerScoring];
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
                                        for (Player *p in self.players) {
                                            p.totalPts = 0;
                                        }
                                    }];
        [alert addAction:yesButton];
        [self presentViewController:alert animated:YES completion:nil];
    }
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
        
        // depends on game type
        if ([self.game.gameType isEqualToString:@"Cricket"]) {
            
            //fetch current point entity
            NSError *error = nil;
            NSFetchRequest *CricketPointsRequest = [NSFetchRequest fetchRequestWithEntityName:@"CricketPoints"];
            NSArray *fetchResultsCricketPoints = [self.moc executeFetchRequest:CricketPointsRequest error:&error];
            
            CricketPoints *p1CricketPoints = [fetchResultsCricketPoints objectAtIndex:[fetchResultsCricketPoints count]-2];
            CricketPoints *p2CricketPoints = [fetchResultsCricketPoints objectAtIndex:[fetchResultsCricketPoints count]-1];
            
            if (self.game.turnCounter % 2 == 0) {
                p2CricketPoints.player = [self.players objectAtIndex:1];
                NSEntityDescription *entity = [p2CricketPoints entity];
                NSDictionary *attributes = [entity attributesByName];
                NSError *error = nil;
                for (NSString *str in attributes) {
                    NSInteger timesHit = [[p2CricketPoints valueForKey:str]integerValue];
                    [self.p2TimesHit setValue:[NSNumber numberWithInteger:timesHit] forKey:str];
                    NSCharacterSet *p = [NSCharacterSet characterSetWithCharactersInString:@"p"];
                    NSInteger slice = [[str stringByTrimmingCharactersInSet:p]integerValue];
                    if (shot1Val == slice) {
                        timesHit += shot1Multi;
                        [p2CricketPoints setValue:[NSNumber numberWithInteger:timesHit] forKey:str];
                    }
                    if (shot2Val == slice){
                        timesHit += shot2Multi;
                        [p2CricketPoints setValue:[NSNumber numberWithInteger:timesHit] forKey:str];
                    }
                    if (shot3Val == slice){
                        timesHit += shot3Multi;
                        [p2CricketPoints setValue:[NSNumber numberWithInteger:timesHit] forKey:str];
                    }
                }
                self.game.p2Pts += [self getPlayerScore:[self.players objectAtIndex:1] with:p2CricketPoints againstOpponent:p1CricketPoints];
                [self.moc save:&error];
                if (error){
                    NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
                }
            }else{
                p1CricketPoints.player = [self.players objectAtIndex:0];
                NSEntityDescription *entity = [p1CricketPoints entity];
                NSDictionary *attributes = [entity attributesByName];
                NSError *error = nil;
                
                for (NSString *str in attributes) {
                    NSInteger timesHit = [[p1CricketPoints valueForKey:str]integerValue];
                    [self.p1TimesHit setValue:[NSNumber numberWithInteger:timesHit] forKey:str];
                    NSCharacterSet *p = [NSCharacterSet characterSetWithCharactersInString:@"p"];
                    NSInteger slice = [[str stringByTrimmingCharactersInSet:p]integerValue];
                    if (shot1Val == slice) {
                        timesHit += shot1Multi;
                        [p1CricketPoints setValue:[NSNumber numberWithInteger:timesHit] forKey:str];
                    }
                    if (shot2Val == slice){
                        timesHit += shot2Multi;
                        [p1CricketPoints setValue:[NSNumber numberWithInteger:timesHit] forKey:str];
                    }
                    if (shot3Val == slice){
                        timesHit += shot3Multi;
                        [p1CricketPoints setValue:[NSNumber numberWithInteger:timesHit] forKey:str];
                    }
                }
                self.game.p1Pts += [self getPlayerScore:[self.players objectAtIndex:0] with:p1CricketPoints againstOpponent:p2CricketPoints];
                if (![self.moc save:&error]) {
                    NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
                }
            }
        }else if ([self.game.gameType isEqualToString:@"501"]){
            
            //fetch current point entity
            NSError *error = nil;
            NSFetchRequest *Points501Request = [NSFetchRequest fetchRequestWithEntityName:@"Points501"];
            NSArray *fetchResultsPoints501 = [self.moc executeFetchRequest:Points501Request error:&error];
            
            Points501 *p1Points501 = [fetchResultsPoints501 objectAtIndex:[fetchResultsPoints501 count]-2];
            Points501 *p2Points501 = [fetchResultsPoints501 objectAtIndex:[fetchResultsPoints501 count]-1];
            
            if (self.game.turnCounter % 2 == 0) {
                p2Points501.player = [self.players objectAtIndex:1];
                NSEntityDescription *entity = [p2Points501 entity];
                NSDictionary *attributes = [entity attributesByName];
                NSError *error = nil;
                for (NSString *str in attributes) {
                    NSInteger timesHit = [[p2Points501 valueForKey:str]integerValue];
                    [self.p2TimesHit setValue:[NSNumber numberWithInteger:timesHit] forKey:str];
                    NSCharacterSet *p = [NSCharacterSet characterSetWithCharactersInString:@"p"];
                    NSInteger slice = [[str stringByTrimmingCharactersInSet:p]integerValue];
                    if (shot1Val == slice) {
                        if (shot1Multi == 2 && ScoringClosed == self.p2Status) {
                            self.p2Status = (long*)ScoringOpen;
                            timesHit += shot1Multi;
                        }else if ((long*)ScoringOpen == self.p2Status){
                            timesHit += shot1Multi;
                        }
                        [p2Points501 setValue:[NSNumber numberWithInteger:timesHit] forKey:str];
                    }
                    if (shot2Val == slice){
                        if (shot2Multi == 2 && ScoringClosed == self.p2Status) {
                            self.p2Status = (long*)ScoringOpen;
                            timesHit += shot2Multi;
                        }else if ((long*)ScoringOpen == self.p2Status){
                            timesHit += shot2Multi;
                        }
                        timesHit += shot2Multi;
                        [p2Points501 setValue:[NSNumber numberWithInteger:timesHit] forKey:str];
                    }
                    if (shot3Val == slice){
                        if (shot3Multi == 2 && ScoringClosed == self.p2Status) {
                            self.p2Status = (long*)ScoringOpen;
                            timesHit += shot3Multi;
                        }else if ((long*)ScoringOpen == self.p2Status){
                            timesHit += shot3Multi;
                        }
                        timesHit += shot3Multi;
                        [p2Points501 setValue:[NSNumber numberWithInteger:timesHit] forKey:str];
                    }
                }
                self.game.p2Pts += [self getPlayer501Score:[self.players objectAtIndex:1] with:p2Points501];
                [self.moc save:&error];
                if (error){
                    NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
                }
            }else{
                p1Points501.player = [self.players objectAtIndex:0];
                NSEntityDescription *entity = [p1Points501 entity];
                NSDictionary *attributes = [entity attributesByName];
                NSError *error = nil;
                
                for (NSString *str in attributes) {
                    NSInteger timesHit = [[p1Points501 valueForKey:str]integerValue];
                    [self.p1TimesHit setValue:[NSNumber numberWithInteger:timesHit] forKey:str];
                    NSCharacterSet *p = [NSCharacterSet characterSetWithCharactersInString:@"p"];
                    NSInteger slice = [[str stringByTrimmingCharactersInSet:p]integerValue];
                    if (shot1Val == slice) {
                        timesHit += shot1Multi;
                        [p1Points501 setValue:[NSNumber numberWithInteger:timesHit] forKey:str];
                    }
                    if (shot2Val == slice){
                        timesHit += shot2Multi;
                        [p1Points501 setValue:[NSNumber numberWithInteger:timesHit] forKey:str];
                    }
                    if (shot3Val == slice){
                        timesHit += shot3Multi;
                        [p1Points501 setValue:[NSNumber numberWithInteger:timesHit] forKey:str];
                    }
                }
                self.game.p1Pts += [self getPlayer501Score:[self.players objectAtIndex:0] with:p1Points501];
                if (![self.moc save:&error]) {
                    NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
                }
            }
        }
        self.game.turnCounter++;
        [self turnProgression];
    }
    self.shotValues = nil;
}

#pragma mark - Update Player's score
-(NSInteger)getPlayerScore:(Player*)player with:(CricketPoints*)cricketPoints againstOpponent:(CricketPoints*)oppCricketPoints
{
    NSInteger increasedScore = 0;
    NSEntityDescription *entity = [cricketPoints entity];
    NSDictionary *attributes = [entity attributesByName];
    for (NSString *str in attributes) {
        
        // get previous Hits from dictionary
        
        NSInteger previousHits;
        if ([player.name isEqualToString:@"Player"]) {
            previousHits = [[self.p1TimesHit valueForKey:str]integerValue];
        }else{
            previousHits = [[self.p2TimesHit valueForKey:str]integerValue];
        }
        
        NSInteger timesHit = [[cricketPoints valueForKey:str]integerValue];
        NSCharacterSet *p = [NSCharacterSet characterSetWithCharactersInString:@"p"];
        NSInteger slice = [[str stringByTrimmingCharactersInSet:p]integerValue];
        if ([[oppCricketPoints valueForKey:str]integerValue] < 3) {
            if (timesHit > 3 && timesHit > previousHits) {
                increasedScore += (timesHit-3)*slice;
                if (increasedScore < 0) {
                    increasedScore = 0;
                }
            }
        }
    }
    return increasedScore;
}
#pragma mark - Update Player's score (501)
-(NSInteger)getPlayer501Score:(Player*)player with:(Points501*)points
{
    ScoringStatus *status;
    NSInteger roundScore = 0;
    NSInteger playerScore;
    if ([player.name isEqualToString:@"Player"]) {
        playerScore = self.game.p1Pts;
        status = self.p1Status;
    }else{
        playerScore = self.game.p2Pts;
        status = self.p2Status;
    }
    NSEntityDescription *entity = [points entity];
    NSDictionary *attributes = [entity attributesByName];
    for (NSString *str in attributes) {
        
        // get previous Hits from dictionary
        NSInteger previousHits;
        if ([player.name isEqualToString:@"Player"]) {
            previousHits = [[self.p1TimesHit valueForKey:str]integerValue];
        }else{
            previousHits = [[self.p2TimesHit valueForKey:str]integerValue];
        }
        
        NSInteger timesHit = [[points valueForKey:str]integerValue];
        NSCharacterSet *p = [NSCharacterSet characterSetWithCharactersInString:@"p"];
        NSInteger slice = [[str stringByTrimmingCharactersInSet:p]integerValue];
        if (timesHit > previousHits) {
            roundScore += (timesHit-3)*slice;
            if (roundScore < 0) {
                roundScore = 0;
            }
        }
    }
    return roundScore;
    
}

-(BOOL)checkIfGameIsComplete
{
    BOOL ended = NO;
    NSError *error = nil;
    
    if ([self.game.gameType isEqualToString:@"Cricket"]) {
        NSFetchRequest *CricketPointsRequest = [NSFetchRequest fetchRequestWithEntityName:@"CricketPoints"];
        NSArray *fetchResultsCricketPoints = [self.moc executeFetchRequest:CricketPointsRequest error:&error];
        
        CricketPoints *p1CricketPoints = [fetchResultsCricketPoints objectAtIndex:[fetchResultsCricketPoints count]-2];
        CricketPoints *p2CricketPoints = [fetchResultsCricketPoints objectAtIndex:[fetchResultsCricketPoints count]-1];
        
        NSEntityDescription *p1Entity = [p1CricketPoints entity];
        NSDictionary *p1Attributes = [p1Entity attributesByName];
        
        NSEntityDescription *p2Entity = [p2CricketPoints entity];
        NSDictionary *p2Attributes = [p2Entity attributesByName];
        
        NSInteger p1S = self.game.p1Pts;
        NSInteger p2S = self.game.p2Pts;
        
        NSInteger p1Closed = 0;
        NSInteger p2Closed = 0;
        
        for (NSString *str in p1Attributes) {
            NSInteger timesHit = [[p1CricketPoints valueForKey:str]integerValue];
            if (timesHit >= 3) {
                p1Closed++;
            }
        }
        for (NSString *str in p2Attributes) {
            NSInteger timesHit = [[p2CricketPoints valueForKey:str]integerValue];
            if (timesHit >= 3) {
                p2Closed++;
            }
        }
        
        if (p1Closed == 7 && p1S > p2S) {
            self.game.timeEnded = [NSDate date];
            [self.players objectAtIndex:0].gamesWon++;
            ended = YES;
        }
        if (p2Closed == 7 && p1S < p2S) {
            self.game.timeEnded = [NSDate date];
            [self.players objectAtIndex:0].gamesWon++;
            ended = YES;
        }
        if (![self.moc save:&error]) {
            NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
        }
    } else if ([self.game.gameType isEqualToString:@"501"]){
        
        // Setup Endgame conditions for 501
        
        
        
    }
    return ended;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"detail"]) {
        BoardDetailViewController *vc = segue.destinationViewController;
        vc.delegate = self;
    }
}

@end
