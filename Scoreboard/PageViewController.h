//
//  PageViewController.h
//  Scoreboard
//
//  Created by Matthew Mauro on 2016-11-28.
//
//

#import <UIKit/UIKit.h>
@class GameManager;

@class PlayerViewController, GameSummaryViewController, Game;

@protocol Pages <NSObject>
@property (nonatomic) NSInteger pageIndex;
@property (nonatomic) NSManagedObjectContext *moc;
@end


@interface PageViewController : UIPageViewController <UIPageViewControllerDataSource>


@property (nonatomic) NSInteger pageIndex;
@property (nonatomic) NSManagedObjectContext *moc;
@property (nonatomic) PlayerViewController *playerViewController;
@property (nonatomic) GameSummaryViewController *gameSummary;
@property (strong, nonatomic) NSMutableArray<UIViewController*> *viewCs;

@end
