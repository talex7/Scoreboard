//
//  FiveSummaryViewController.m
//  Scoreboard
//
//  Created by Matthew Mauro on 2016-12-03.
//
//

#import "Game+CoreDataProperties.h"
#import "Player+CoreDataClass.h"
#import "Points501+CoreDataClass.h"
#import "FiveSummaryViewController.h"

@interface FiveSummaryViewController ()
@property (weak, nonatomic) IBOutlet UILabel *p1Label;
@property (weak, nonatomic) IBOutlet UILabel *p2Label;
@property (weak, nonatomic) IBOutlet UILabel *p1Score;
@property (weak, nonatomic) IBOutlet UILabel *p2Score;
@property (nonatomic) Game *game;
@property ScoringStatus *p1Status;
@property ScoringStatus *p2Status;
@property (nonatomic) NSMutableDictionary *p1TimesHit;
@property (nonatomic) NSMutableDictionary *p2TimesHit;
@end

@implementation FiveSummaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.p1TimesHit = [NSMutableDictionary new];
    self.p2TimesHit = [NSMutableDictionary new];
    
    self.p1Label.text = [self.game.player objectAtIndex:0].name;
    self.p2Label.text = [self.game.player objectAtIndex:1].name;
}
-(void)viewWillAppear:(BOOL)animated
{
    
    NSError *error = nil;
    NSFetchRequest *gameRequest = [NSFetchRequest fetchRequestWithEntityName:@"Game"];
    NSFetchRequest *pointsRequest = [NSFetchRequest fetchRequestWithEntityName:@"Points501"];
    NSFetchRequest *playerRequest = [NSFetchRequest fetchRequestWithEntityName:@"Player"];
    NSDate *date;
    [gameRequest setPredicate:[NSPredicate predicateWithFormat:@"timeEnded = %@", date]];
    
    NSArray *fetchResultsPoints = [self.moc executeFetchRequest:pointsRequest error:&error];
    NSArray *fetchResultsPlayer = [self.moc executeFetchRequest:playerRequest error:&error];
    NSArray *fetchRequestGames = [self.moc executeFetchRequest:gameRequest error:&error];
    
    Game *g = [fetchRequestGames objectAtIndex:[fetchRequestGames count]-1];
    if (g.turnCounter == 1) {
        g.p1Pts = 501;
        g.p2Pts = 501;
        self.p1Status = ScoringClosed;
        self.p2Status = ScoringClosed;
    }
    self.game = g;
    
    Player *p1 = [fetchResultsPlayer objectAtIndex:[fetchResultsPlayer count]-2];
    Player *p2 = [fetchResultsPlayer objectAtIndex:[fetchResultsPlayer count]-1];
    
    Points501 *p1Points = [fetchResultsPoints objectAtIndex:[fetchResultsPoints count]-2];
    Points501 *p2Points = [fetchResultsPoints objectAtIndex:[fetchResultsPlayer count]-1];
    
    self.p1Score.text = [NSString stringWithFormat:@"%d", self.game.p1Pts];
    self.p2Score.text = [NSString stringWithFormat:@"%d", self.game.p2Pts];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
