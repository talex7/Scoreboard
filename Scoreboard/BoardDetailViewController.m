//
//  BoardDetailViewController.m
//  Scoreboard
//
//  Created by Matthew Mauro on 2016-11-28.
//
//

#import "BoardDetailViewController.h"

@interface BoardDetailViewController ()

@end

@implementation BoardDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.leftSliceLabel setTransform:CGAffineTransformMakeRotation(-M_PI_2/2)];
    [self.rightSliceLabel setTransform:CGAffineTransformMakeRotation(M_PI_2/2)];
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
