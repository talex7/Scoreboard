//
//  Game+CoreDataProperties.h
//  Scoreboard
//
//  Created by Matthew Mauro on 2016-12-03.
//
//  This file was automatically generated and should not be edited.
//

#import "Game+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Game (CoreDataProperties)

+ (NSFetchRequest<Game *> *)fetchRequest;

@property (nonatomic) int32_t idNo;
@property (nonatomic) int32_t p1Pts;
@property (nonatomic) int32_t p2Pts;
@property (nullable, nonatomic, copy) NSDate *timeEnded;
@property (nullable, nonatomic, copy) NSDate *timeStarted;
@property (nonatomic) int32_t turnCounter;
@property (nullable, nonatomic, copy) NSString *gameType;
@property (nullable, nonatomic, retain) NSOrderedSet<Player *> *player;
@property (nullable, nonatomic, retain) NSOrderedSet<CricketPoints *> *points;

@end

@interface Game (CoreDataGeneratedAccessors)

- (void)insertObject:(Player *)value inPlayerAtIndex:(NSUInteger)idx;
- (void)removeObjectFromPlayerAtIndex:(NSUInteger)idx;
- (void)insertPlayer:(NSArray<Player *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removePlayerAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInPlayerAtIndex:(NSUInteger)idx withObject:(Player *)value;
- (void)replacePlayerAtIndexes:(NSIndexSet *)indexes withPlayer:(NSArray<Player *> *)values;
- (void)addPlayerObject:(Player *)value;
- (void)removePlayerObject:(Player *)value;
- (void)addPlayer:(NSOrderedSet<Player *> *)values;
- (void)removePlayer:(NSOrderedSet<Player *> *)values;

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
