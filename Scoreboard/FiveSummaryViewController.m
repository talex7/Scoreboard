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
@property (nonatomic) NSMutableDictionary *p1TimesHit;
@property (nonatomic) NSMutableDictionary *p2TimesHit;
@property (weak, nonatomic) IBOutlet UITextView *p1Text;
@property (weak, nonatomic) IBOutlet UITextView *p2Text;
@end

@implementation FiveSummaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.p1TimesHit = [NSMutableDictionary new];
    self.p2TimesHit = [NSMutableDictionary new];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    self.p1Text.textColor = [UIColor whiteColor];
    self.p2Text.textColor = [UIColor whiteColor];
    NSError *error = nil;
    NSFetchRequest *gameRequest = [NSFetchRequest fetchRequestWithEntityName:@"Game"];
    NSFetchRequest *playerRequest = [NSFetchRequest fetchRequestWithEntityName:@"Player"];
    NSDate *date;
    [gameRequest setPredicate:[NSPredicate predicateWithFormat:@"timeEnded = %@", date]];
    
    NSArray *fetchResultsPlayer = [self.moc executeFetchRequest:playerRequest error:&error];
    NSArray *fetchRequestGames = [self.moc executeFetchRequest:gameRequest error:&error];
    
    Game *g = [fetchRequestGames objectAtIndex:[fetchRequestGames count]-1];
    
    self.game = g;
    
    Player *p1 = [fetchResultsPlayer objectAtIndex:[fetchResultsPlayer count]-2];
    Player *p2 = [fetchResultsPlayer objectAtIndex:[fetchResultsPlayer count]-1];
    
    self.p1Label.text = p1.name;
    self.p2Label.text = p2.name;
    
    self.p1Score.text = [NSString stringWithFormat:@"%d", self.game.p1Pts];
    self.p2Score.text = [NSString stringWithFormat:@"%d", self.game.p2Pts];
    
    if (self.game.p1Pts < 501 && self.game.p1Pts > 180) {
        self.p1Text.text = @"Keep Scoring Points!";
    }
    if (self.game.p2Pts < 501 && self.game.p2Pts > 180) {
        self.p2Text.text = @"Keep Scoring Points!";
    }
    
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
