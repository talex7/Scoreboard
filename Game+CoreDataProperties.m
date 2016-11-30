//
//  Game+CoreDataProperties.m
//  Scoreboard
//
//  Created by Thomas Alexanian on 2016-11-30.
//
//  This file was automatically generated and should not be edited.
//

#import "Game+CoreDataProperties.h"

@implementation Game (CoreDataProperties)

+ (NSFetchRequest<Game *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Game"];
}

@dynamic idNo;
@dynamic turnCounter;
@dynamic timeStarted;
@dynamic timeEnded;
@dynamic player;
@dynamic points;

@end
