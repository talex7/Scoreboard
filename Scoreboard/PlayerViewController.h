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
#import "Game+CoreDataClass.h"
#import "BoardDetailViewController.h"

@interface PlayerViewController : UIViewController <displayBoard>


@property (nonatomic) NSArray<Player*> *players;
@property (nonatomic) Game *game;
@property NSArray *shotValues;
@property (nonatomic) NSInteger pageIndex;
@property (nonatomic) NSInteger shotCount;

@end
