//
//  GameSummaryViewController.h
//  Scoreboard
//
//  Created by Matthew Mauro on 2016-11-28.
//
//

#import "Player+CoreDataClass.h"
#import "CricketPoints+CoreDataClass.h"
#import "Game+CoreDataClass.h"
#import <UIKit/UIKit.h>

@interface GameSummaryViewController : UIViewController <Pages>

@property (nonatomic) NSInteger pageIndex;
@property (nonatomic) NSManagedObjectContext *moc;

@end
