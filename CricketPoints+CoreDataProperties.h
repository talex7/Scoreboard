//
//  CricketPoints+CoreDataProperties.h
//  Scoreboard
//
//  Created by Matthew Mauro on 2016-12-03.
//
//  This file was automatically generated and should not be edited.
//

#import "CricketPoints+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface CricketPoints (CoreDataProperties)

+ (NSFetchRequest<CricketPoints *> *)fetchRequest;

@property (nonatomic) int32_t p0;
@property (nonatomic) int32_t p15;
@property (nonatomic) int32_t p16;
@property (nonatomic) int32_t p17;
@property (nonatomic) int32_t p18;
@property (nonatomic) int32_t p19;
@property (nonatomic) int32_t p20;
@property (nonatomic) int32_t p25;
@property (nullable, nonatomic, retain) Game *game;
@property (nullable, nonatomic, retain) Player *player;

@end

NS_ASSUME_NONNULL_END
