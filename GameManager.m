//
//  GameManager.m
//  Scoreboard
//
//  Created by Thomas Alexanian on 2016-11-28.
//
//

#import "GameManager.h"

@implementation GameManager

-(void)startGame{
    self.currentGame = [Game new];
    NSMutableDictionary *dict1 = [NSMutableDictionary
                                  dictionaryWithDictionary:@{@"20" : @0,
                                                             @"19" : @0,
                                                             @"18" : @0,
                                                             @"17" : @0,
                                                             @"16" : @0,
                                                             @"15" : @0,
                                                             @"Bull" : @0,
                                                             @"Miss" : @0}];
    
    NSMutableDictionary *dict2 = [NSMutableDictionary
                                  dictionaryWithDictionary:@{@"20" : @0,
                                                             @"19" : @0,
                                                             @"18" : @0,
                                                             @"17" : @0,
                                                             @"16" : @0,
                                                             @"15" : @0,
                                                             @"Bull" : @0,
                                                             @"Miss" : @0}];
    self.closedRooms = [NSMutableArray arrayWithObjects:
                        dict1, dict2, nil];
    self.playerScore = 0;
    self.opponentScore = 0;
}

@end
