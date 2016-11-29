//
//  Player+CoreDataProperties.h
//  Scoreboard
//
//  Created by Thomas Alexanian on 2016-11-29.
//
//  This file was automatically generated and should not be edited.
//

#import "Player+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Player (CoreDataProperties)

+ (NSFetchRequest<Player *> *)fetchRequest;

@property (nonatomic) int32_t gamesWon;
@property (nonatomic) int32_t idNo;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) NSData *totalPts;
@property (nullable, nonatomic, retain) NSData *totalShots;

@end

NS_ASSUME_NONNULL_END
