//
//  PageViewController.h
//  Scoreboard
//
//  Created by Matthew Mauro on 2016-11-28.
//
//
#import "UIViewController_ViewExtensions.h"
#import <UIKit/UIKit.h>
@class PlayerViewController, GameSummaryViewController;

@interface PageViewController : UIPageViewController <UIPageViewControllerDataSource>

@property PlayerViewController *playerViewController;
@property GameSummaryViewController *gameSummary;
@property NSMutableArray *players;
@property (strong, nonatomic) NSMutableArray *viewCs;

@end
