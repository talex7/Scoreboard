//
//  PageViewController.m
//  Scoreboard
//
//  Created by Matthew Mauro on 2016-11-28.
//
//

#import "PageViewController.h"

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
    if (([self.players count] == 0) || (index == [self.players count]+2)) {
        return nil;
    }
    
    if (index  <= [self.players count]) {
        PlayerViewController *playerContent = [self.storyboard instantiateViewControllerWithIdentifier:@"BoardController"];
        
        pageContentViewController.pageIndex = index;
        pageContentViewController.players = self.players;
        return pageContentViewController;
    }
    
    
}
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.players count];
}
- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}
-(NSString*)findPlayerName:(NSUInteger)index
{
    Player *p = [self.players objectAtIndex:index];
    return p.name;
}


@end
