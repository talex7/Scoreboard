//
//  GameSummaryViewController.h
//  Scoreboard
//
//  Created by Matthew Mauro on 2016-11-28.
//
//

#import "Player+CoreDataClass.h"
#import "Points+CoreDataClass.h"
#import "Game+CoreDataClass.h"
#import <UIKit/UIKit.h>

@interface GameSummaryViewController : UIViewController

@property (nonatomic) NSInteger pageIndex;
@property (nonatomic) NSArray *players;
@property (nonatomic) Game *game;

@end
