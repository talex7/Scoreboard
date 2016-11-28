//
//  PageViewController.m
//  Scoreboard
//
//  Created by Matthew Mauro on 2016-11-28.
//
//

#import "PageViewController.h"
#import "PlayerViewController.h"
#import "GameSummaryViewController.h"


@interface PageViewController ()

@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PageView DataSource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((UIViewController*) viewController).pageIndex;
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    index--;
    return [self viewControllerAtIndex:index];
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((UIViewController*) viewController).pageIndex;
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    if (index == [self.players count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}
- (UIViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if ((index == 0)||(index == 3)){
        return nil;
    }
    
    if (index  <= 1) {
        PlayerViewController *playerControl = [self.storyboard instantiateViewControllerWithIdentifier:@"BoardController"];
        playerControl.pageIndex = index;
        playerControl.players = self.players;
        return playerControl;
    }else{
        GameSummaryViewController *gameSummary = [self.storyboard instantiateViewControllerWithIdentifier:@"GameSummary"];
        gameSummary.pageIndex = index;
        gameSummary.players = self.players;
        return gameSummary;
    }
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return 2;
}
- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}



@end
