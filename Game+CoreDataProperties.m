//
//  Game+CoreDataProperties.m
//  Scoreboard
//
//  Created by Matthew Mauro on 2016-12-03.
//
//  This file was automatically generated and should not be edited.
//

#import "Game+CoreDataProperties.h"

@implementation Game (CoreDataProperties)

+ (NSFetchRequest<Game *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Game"];
}

@dynamic idNo;
@dynamic p1Pts;
@dynamic p2Pts;
@dynamic timeEnded;
@dynamic timeStarted;
@dynamic turnCounter;
@dynamic gameType;
@dynamic player;
@dynamic points;

@end
