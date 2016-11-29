//
//  PlayerViewController.h
//  Scoreboard
//
//  Created by Matthew Mauro on 2016-11-28.
//
//

#import <UIKit/UIKit.h>

@interface PlayerViewController : UIViewController

@property (nonatomic) NSMutableArray *players;
@property (nonatomic) NSInteger pageIndex;
@property (nonatomic) NSInteger shotCount;

@end
