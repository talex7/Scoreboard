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
@property (nonatomic) int32_t turnCounter;
@property (nullable, nonatomic, copy) NSDate *timeStarted;
@property (nullable, nonatomic, copy) NSDate *timeEnded;
@property (nullable, nonatomic, retain) NSOrderedSet<Player *> *player;
@property (nullable, nonatomic, retain) NSOrderedSet<Points *> *points;

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

- (void)insertObject:(Points *)value inPointsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromPointsAtIndex:(NSUInteger)idx;
- (void)insertPoints:(NSArray<Points *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removePointsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInPointsAtIndex:(NSUInteger)idx withObject:(Points *)value;
- (void)replacePointsAtIndexes:(NSIndexSet *)indexes withPoints:(NSArray<Points *> *)values;
- (void)addPointsObject:(Points *)value;
- (void)removePointsObject:(Points *)value;
- (void)addPoints:(NSOrderedSet<Points *> *)values;
- (void)removePoints:(NSOrderedSet<Points *> *)values;

@end

NS_ASSUME_NONNULL_END
