//
//  Game+CoreDataProperties.h
//  Scoreboard
//
//  Created by Thomas Alexanian on 2016-11-29.
//
//  This file was automatically generated and should not be edited.
//

#import "Game+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Game (CoreDataProperties)

+ (NSFetchRequest<Game *> *)fetchRequest;

@property (nonatomic) int32_t idNo;
@property (nonatomic) BOOL isCompleted;
@property (nullable, nonatomic, retain) NSData *players;
@property (nonatomic) int32_t turnCounter;

@end

NS_ASSUME_NONNULL_END
