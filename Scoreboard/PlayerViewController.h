//
//  PlayerViewController.h
//  Scoreboard
//
//  Created by Matthew Mauro on 2016-11-28.
//
//
#import "Player+CoreDataClass.h"
#import "AppDelegate.h"
#import <UIKit/UIKit.h>
#import "BoardDetailViewController.h"

@class GameManager;

@interface PlayerViewController : UIViewController <displayBoard>

@property (strong) GameManager *gm;
@property NSArray *shotValues;
@property (nonatomic) NSMutableArray<Player*> *players;
@property (nonatomic) NSInteger pageIndex;
@property (nonatomic) NSInteger shotCount;

@end
