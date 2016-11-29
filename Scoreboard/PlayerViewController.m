//
//  PlayerViewController.m
//  Scoreboard
//
//  Created by Matthew Mauro on 2016-11-28.
//
//


#import "PageViewController.h"
#import "PlayerViewController.h"

@interface PlayerViewController () <Pages>
@property (weak, nonatomic) IBOutlet UIButton *finshButton;
@property (weak, nonatomic) IBOutlet UILabel *currentPlayerLabel;

@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.finshButton.hidden = YES;
    self.finshButton.userInteractionEnabled = NO;
    
//    NSFetchRequest *gameFetch
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
