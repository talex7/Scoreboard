//
//  GameManager.h
//  Scoreboard
//
//  Created by Thomas Alexanian on 2016-11-28.
//
//

#import <Foundation/Foundation.h>
#import "Player+CoreDataClass.h"
#import "Game+CoreDataClass.h"

@interface GameManager : NSObject

@property (nonatomic) NSArray<Player*> *players; // is this property necessary? perhaps access through game instance? ex. game.players
@property (nonatomic) Game *currentGame;
@property (nonatomic) NSInteger playerScore;  //Keep scores separate or together? Also keeps score in this class or in Game class?
@property (nonatomic) NSInteger opponentScore;
@property (nonatomic) NSMutableArray<NSDictionary*> *closedRooms; //Keep here or in game class?



-(void)startGame;




@end
