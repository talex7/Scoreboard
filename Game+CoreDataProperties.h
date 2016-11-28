//
//  Game+CoreDataProperties.h
//  Scoreboard
//
//  Created by Thomas Alexanian on 2016-11-28.
//
//  This file was automatically generated and should not be edited.
//

#import "Game+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Game (CoreDataProperties)

+ (NSFetchRequest<Game *> *)fetchRequest;

@property (nonatomic) int32_t turnCounter;
@property (nonatomic) BOOL isCompleted;
@property (nonatomic) int32_t id;
@property (nullable, nonatomic, retain) NSData *players;

@end

NS_ASSUME_NONNULL_END
