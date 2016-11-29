//
//  Player+CoreDataProperties.m
//  Scoreboard
//
//  Created by Thomas Alexanian on 2016-11-29.
//
//  This file was automatically generated and should not be edited.
//

#import "Player+CoreDataProperties.h"

@implementation Player (CoreDataProperties)

+ (NSFetchRequest<Player *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Player"];
}

@dynamic gamesWon;
@dynamic idNo;
@dynamic name;
@dynamic totalPts;
@dynamic totalShots;
@dynamic game;
@dynamic points;

@end
