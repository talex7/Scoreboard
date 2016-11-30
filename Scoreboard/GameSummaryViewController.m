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
    
    NSOrderedSet *p1Points = [self.game.player objectAtIndex:0].points;
    NSOrderedSet *p2Points = [self.game.player objectAtIndex:1].points;
    
    
    
}

-(void)scoreFinder:(Points*)points
{
    NSEntityDescription *entity = [points entity];
    NSDictionary *attributes = [entity attributesByName];
    for (NSString *str in attributes) {
        NSInteger *timesHit = [[points valueForKey:str]integerValue];
        NSCharacterSet *p = [NSCharacterSet characterSetWithCharactersInString:@"p"];
        NSString *slice = [str stringByTrimmingCharactersInSet:p];
        
    }
}

-(UIImageView*)setStrikeImage:(NSInteger)sliceTag forScore:(NSInteger)timesHit
{
    UIImageView *imageView = [UIImageView new];
    
    
    
    
    return imageView;
}

@end
