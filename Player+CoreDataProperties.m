//
//  Player+CoreDataProperties.m
//  Scoreboard
//
//  Created by Matthew Mauro on 2016-12-03.
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
@dynamic game;
@dynamic points;

@end
