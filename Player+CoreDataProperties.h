//
//  Player+CoreDataProperties.h
//  Scoreboard
//
//  Created by Matthew Mauro on 2016-12-03.
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
@property (nonatomic) int32_t totalPts;
@property (nullable, nonatomic, retain) NSOrderedSet<Game *> *game;
@property (nullable, nonatomic, retain) NSOrderedSet<CricketPoints *> *points;

@end

@interface Player (CoreDataGeneratedAccessors)

- (void)insertObject:(Game *)value inGameAtIndex:(NSUInteger)idx;
- (void)removeObjectFromGameAtIndex:(NSUInteger)idx;
- (void)insertGame:(NSArray<Game *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeGameAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInGameAtIndex:(NSUInteger)idx withObject:(Game *)value;
- (void)replaceGameAtIndexes:(NSIndexSet *)indexes withGame:(NSArray<Game *> *)values;
- (void)addGameObject:(Game *)value;
- (void)removeGameObject:(Game *)value;
- (void)addGame:(NSOrderedSet<Game *> *)values;
- (void)removeGame:(NSOrderedSet<Game *> *)values;

- (void)insertObject:(CricketPoints *)value inPointsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromPointsAtIndex:(NSUInteger)idx;
- (void)insertPoints:(NSArray<CricketPoints *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removePointsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInPointsAtIndex:(NSUInteger)idx withObject:(CricketPoints *)value;
- (void)replacePointsAtIndexes:(NSIndexSet *)indexes withPoints:(NSArray<CricketPoints *> *)values;
- (void)addPointsObject:(CricketPoints *)value;
- (void)removePointsObject:(CricketPoints *)value;
- (void)addPoints:(NSOrderedSet<CricketPoints *> *)values;
- (void)removePoints:(NSOrderedSet<CricketPoints *> *)values;

@end

NS_ASSUME_NONNULL_END
