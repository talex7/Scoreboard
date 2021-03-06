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
@property Game *game;
@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = self;
    self.pageIndex = 0;
    self.viewCs = [NSMutableArray new];
    PlayerViewController *board = [self.storyboard instantiateViewControllerWithIdentifier:@"BoardController"];
    self.playerViewController = board;
    
    AppDelegate *appDelegate = (AppDelegate*)([[UIApplication sharedApplication] delegate]);
    self.moc = appDelegate.managedObjectContext;
    
    NSError *error = nil;
    NSFetchRequest *gameRequest = [NSFetchRequest fetchRequestWithEntityName:@"Game"];
    NSDate *date;
    [gameRequest setPredicate:[NSPredicate predicateWithFormat:@"timeEnded = %@", date]];
    NSArray *fetchResultsGames = [self.moc executeFetchRequest:gameRequest error:&error];
    
    Game *g = [fetchResultsGames objectAtIndex:0];
    self.game = g;
    
    [self.viewCs addObject:board];
    
    GameSummaryViewController *gameSummary = [self.storyboard instantiateViewControllerWithIdentifier:@"GameSummary"];
    self.gameSummary = gameSummary;
    [self.viewCs addObject:gameSummary];
    
    [self setViewControllers:@[self.playerViewController] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - viewControllerAtIndex function

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (index >= 2){
        return nil;
    }else if (index == 0){
        PlayerViewController *playerView = [self.storyboard instantiateViewControllerWithIdentifier:@"BoardController"];
        playerView.pageIndex = index;
        playerView.moc = self.moc;
        return playerView;
    }else{
        GameSummaryViewController *gameSummary = [self.storyboard instantiateViewControllerWithIdentifier:@"GameSummary"];
        gameSummary.pageIndex = index;
        gameSummary.moc = self.moc;
        return gameSummary;
    }
}

#pragma mark - PageView DataSource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(id<Pages>)viewController
{
    NSUInteger index = viewController.pageIndex;
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    index--;
    return [self viewControllerAtIndex:index];
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(id<Pages>)viewController
{
    NSUInteger index = viewController.pageIndex;
    if (index == NSNotFound||index == 1) {
        return nil;
    }
    index++;
    return [self viewControllerAtIndex:index];
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
