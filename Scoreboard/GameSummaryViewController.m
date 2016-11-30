//
//  GameSummaryViewController.m
//  Scoreboard
//
//  Created by Matthew Mauro on 2016-11-28.
//
//
#import "PageViewController.h"
#import "GameSummaryViewController.h"

@interface GameSummaryViewController () <Pages>
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *p1ScoreImages;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *p2ScoreImages;
@property (weak, nonatomic) IBOutlet UILabel *p1ScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *p2ScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *p1Label;
@property (weak, nonatomic) IBOutlet UILabel *p2Label;


@end

@implementation GameSummaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.p1Label.text = [self.game.player objectAtIndex:0].name;
    self.p2Label.text = [self.game.player objectAtIndex:1].name;
    
    Points *p1Points = (Points*)[self.game.player objectAtIndex:0].points;
    Points *p2Points = (Points*)[self.game.player objectAtIndex:1].points;
    
    [self scoreFinder:p1Points in:self.p1ScoreImages];
    [self scoreFinder:p2Points in:self.p2ScoreImages];
}


#pragma mark - Scoring fuctions

-(void)scoreFinder:(Points*)points in:(NSArray*)array
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
-(void)getPlayerScore:(UILabel*)score andPoints:(Points*)points
{
    NSInteger currentScore = [score.text integerValue];
    NSInteger increasedScore = 0;
    NSEntityDescription *entity = [points entity];
    NSDictionary *attributes = [entity attributesByName];
    for (NSString *str in attributes) {
        NSInteger timesHit = [[points valueForKey:str]integerValue];
        NSCharacterSet *p = [NSCharacterSet characterSetWithCharactersInString:@"p"];
        NSInteger slice = [[str stringByTrimmingCharactersInSet:p]integerValue];
        if (timesHit > 3) {
            increasedScore += (timesHit-3)*slice;
        }
    }
    currentScore += increasedScore;
    score.text = [NSString stringWithFormat:@"%ld", currentScore];
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
