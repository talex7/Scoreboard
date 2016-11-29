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
    // Do any additional setup after loading the view.
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
