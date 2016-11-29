//
//  PlayerViewController.h
//  Scoreboard
//
//  Created by Matthew Mauro on 2016-11-28.
//
//

#import "AppDelegate.h"
#import <UIKit/UIKit.h>
@class GameManager;

@interface PlayerViewController : UIViewController

@property (strong) GameManager *gm;
@property (nonatomic) NSMutableArray *players;
@property (nonatomic) NSInteger pageIndex;
@property (nonatomic) NSInteger shotCount;

@end
