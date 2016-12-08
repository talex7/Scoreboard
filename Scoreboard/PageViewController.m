//
//  PageViewController.m
//  Scoreboard
//
//  Created by Matthew Mauro and Tommy Alexanian
//
//

#import "Game+CoreDataProperties.h"
#import "PageViewController.h"
#import "PlayerViewController.h"
#import "GameSummaryViewController.h"
#import "FiveSummaryViewController.h"

@interface PageViewController ()
@property Game *game;
@property (nonatomic) BOOL newGame;
@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSError *error = nil;
    NSFetchRequest *gameRequest = [NSFetchRequest fetchRequestWithEntityName:@"Game"];
    NSDate *date;
    [gameRequest setPredicate:[NSPredicate predicateWithFormat:@"timeEnded = %@", date]];
    
    NSArray *fetchResultsGames = [self.moc executeFetchRequest:gameRequest error:&error];
    
    Game *g = [fetchResultsGames lastObject];
    self.game = g;
    
    if (g.turnCounter == 1) {
        self.newGame = YES;
    }
    self.dataSource = self;
    self.pageIndex = 0;
    self.viewCs = [NSMutableArray new];
    PlayerViewController *board = [self.storyboard instantiateViewControllerWithIdentifier:@"BoardController"];
    board.newGame = self.newGame;
    board.moc = self.moc;
    self.playerViewController = board;
    
    AppDelegate *appDelegate = (AppDelegate*)([[UIApplication sharedApplication] delegate]);
    self.moc = appDelegate.managedObjectContext;
    
    [self.viewCs addObject:board];
    
    if ([self.game.gameType isEqualToString:@"Cricket"]) {
        GameSummaryViewController *gameSummary = [self.storyboard instantiateViewControllerWithIdentifier:@"CricketSummary"];
        self.gameSummary = gameSummary;
        [self.viewCs addObject:gameSummary];
    }else if ([self.game.gameType isEqualToString:@"501"]){
        FiveSummaryViewController *gameSummary = [self.storyboard instantiateViewControllerWithIdentifier:@"Summary501"];
        gameSummary.newGame = self.newGame;
        self.gameSummary = gameSummary;
        [self.viewCs addObject:gameSummary];
    }
    
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
        playerView.newGame = self.newGame;
        playerView.pageIndex = index;
        playerView.moc = self.moc;
        return playerView;
    }else{
        if ([self.game.gameType isEqualToString:@"Cricket"]) {
            GameSummaryViewController *gameSummary = [self.storyboard instantiateViewControllerWithIdentifier:@"CricketSummary"];
            gameSummary.pageIndex = index;
            gameSummary.moc = self.moc;
            return gameSummary;
        }else{
            FiveSummaryViewController *gameSummary = [self.storyboard instantiateViewControllerWithIdentifier:@"Summary501"];
            gameSummary.pageIndex = index;
            gameSummary.moc = self.moc;
            return gameSummary;
        }
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
