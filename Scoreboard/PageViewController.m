//
//  PageViewController.m
//  Scoreboard
//
//  Created by Matthew Mauro and Tommy Alexian
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
    self.dataSource = self;
    
    PlayerViewController *board = [self.storyboard instantiateViewControllerWithIdentifier:@"PlayerContent"];
    [self.viewCs addObject:board];
    GameSummaryViewController *gameSummary = [self.storyboard instantiateViewControllerWithIdentifier:@"GameSummary"];
    [self.viewCs addObject:gameSummary];
    
    self.playerViewController = (PlayerViewController*)[self viewControllerAtIndex:0];
    self.gameSummary = (GameSummaryViewController*)[self viewControllerAtIndex:1];
    
    //    [self addChildViewController:self.playerViewController];
    [self setViewControllers:@[self.playerViewController] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
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
    if (index  <= 0) {
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
