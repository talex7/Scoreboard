//
//  Game+CoreDataProperties.m
//  Scoreboard
//
//  Created by Thomas Alexanian on 2016-11-28.
//
//  This file was automatically generated and should not be edited.
//

#import "Game+CoreDataProperties.h"

@implementation Game (CoreDataProperties)

+ (NSFetchRequest<Game *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Game"];
}

@dynamic turnCounter;
@dynamic isCompleted;
@dynamic id;
@dynamic players;

@end
