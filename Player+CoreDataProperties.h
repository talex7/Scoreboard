//
//  Player+CoreDataProperties.h
//  Scoreboard
//
//  Created by Thomas Alexanian on 2016-11-28.
//
//  This file was automatically generated and should not be edited.
//

#import "Player+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Player (CoreDataProperties)

+ (NSFetchRequest<Player *> *)fetchRequest;

@property (nullable, nonatomic, retain) NSData *totalPts;
@property (nonatomic) int32_t gamesWon;
@property (nullable, nonatomic, retain) NSData *totalShots;
@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int32_t id;

@end

NS_ASSUME_NONNULL_END
