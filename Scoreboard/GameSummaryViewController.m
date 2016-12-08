//
//  GameSummaryViewController.m
//  Scoreboard
//
//  Created by Matthew Mauro on 2016-11-28.
//
//
#import "PageViewController.h"
#import "GameSummaryViewController.h"

@interface GameSummaryViewController () 
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *p1ScoreImages;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *p2ScoreImages;
@property (weak, nonatomic) IBOutlet UILabel *p1ScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *p2ScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *p1Label;
@property (weak, nonatomic) IBOutlet UILabel *p2Label;
@property (nonatomic) Game *game;
@end

@implementation GameSummaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    NSError *error = nil;
    NSFetchRequest *gameRequest = [NSFetchRequest fetchRequestWithEntityName:@"Game"];
    NSFetchRequest *pointsRequest = [NSFetchRequest fetchRequestWithEntityName:@"CricketPoints"];
    NSFetchRequest *playerRequest = [NSFetchRequest fetchRequestWithEntityName:@"Player"];
    NSDate *date;
    [gameRequest setPredicate:[NSPredicate predicateWithFormat:@"timeEnded = %@", date]];
    
    NSArray *fetchResultsPoints = [self.moc executeFetchRequest:pointsRequest error:&error];
    NSArray *fetchResultsPlayer = [self.moc executeFetchRequest:playerRequest error:&error];
    NSArray *fetchRequestGames = [self.moc executeFetchRequest:gameRequest error:&error];
    
    Game *g = [fetchRequestGames objectAtIndex:[fetchRequestGames count]-1];
    self.game = g;
    
    Player *p1 = [fetchResultsPlayer objectAtIndex:[fetchResultsPlayer count]-2];
    Player *p2 = [fetchResultsPlayer objectAtIndex:[fetchResultsPlayer count]-1];
    
    self.p1Label.text = p1.name;
    self.p2Label.text = p2.name;
    
    CricketPoints *p1Points = [fetchResultsPoints objectAtIndex:[fetchResultsPoints count]-2];
    CricketPoints *p2Points = [fetchResultsPoints objectAtIndex:[fetchResultsPoints count]-1];
    
    [self scoreFinder:p1Points in:self.p1ScoreImages];
    [self scoreFinder:p2Points in:self.p2ScoreImages];
    
    self.p1ScoreLabel.text = [NSString stringWithFormat:@"%d", self.game.p1Pts];
    self.p2ScoreLabel.text = [NSString stringWithFormat:@"%d", self.game.p2Pts];
}


#pragma mark - Scoring fuctions

-(void)scoreFinder:(CricketPoints*)points in:(NSArray*)array
{
    NSEntityDescription *entity = [points entity];
    NSDictionary *attributes = [entity attributesByName];
    for (NSString *str in attributes) {
        NSInteger timesHit = [[points valueForKey:str]integerValue];
        NSCharacterSet *p = [NSCharacterSet characterSetWithCharactersInString:@"p"];
        NSString *slice = [str stringByTrimmingCharactersInSet:p];
        [self setStrikeImageOf:[slice integerValue] inside:array forScore:timesHit];
    }
}
-(void)setStrikeImageOf:(NSInteger)key inside:(NSArray*)scoreImages forScore:(NSInteger)timesHit
{
    for (UIImageView *imV in scoreImages) {
        if (imV.tag == key) {
            switch (timesHit) {
                case 0:
                    imV.image = nil;
                    break;
                case 1:
                    imV.image = [UIImage imageNamed:@"single"];
                    break;
                case 2:
                    imV.image = [UIImage imageNamed:@"double"];
                    break;
                case 3:
                    imV.image = [UIImage imageNamed:@"triple"];
                    break;
                default:
                    imV.image = [UIImage imageNamed:@"triple"];
                    break;
            }
        }
    }
}

@end
