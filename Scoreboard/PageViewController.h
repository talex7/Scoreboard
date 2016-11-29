//
//  PageViewController.h
//  Scoreboard
//
//  Created by Matthew Mauro on 2016-11-28.
//
//

#import <UIKit/UIKit.h>

@class PlayerViewController, GameSummaryViewController;

@protocol Pages <NSObject>
@property (nonatomic) NSInteger pageIndex;
@end


@interface PageViewController : UIPageViewController <UIPageViewControllerDataSource>

@property (nonatomic) NSInteger pageIndex;
@property (nonatomic) NSMutableArray *players;
@property PlayerViewController *playerViewController;
@property GameSummaryViewController *gameSummary;
@property (strong, nonatomic) NSMutableArray<UIViewController*> *viewCs;

@end
