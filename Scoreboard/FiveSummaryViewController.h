//
//  FiveSummaryViewController.h
//  Scoreboard
//
//  Created by Matthew Mauro on 2016-12-03.
//
//
#import "Points501+CoreDataClass.h"
#import "PageViewController.h"
#import <UIKit/UIKit.h>

enum {
    ScoringClosed = 0,
    ScoringOpen = 1,
    ScoringFinished = 2
};
typedef NSInteger ScoringStatus;


@interface FiveSummaryViewController : UIViewController <Pages>

@property (nonatomic) NSInteger pageIndex;
@property (nonatomic) NSManagedObjectContext *moc;

@end
