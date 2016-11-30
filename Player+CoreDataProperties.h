//
//  Player+CoreDataProperties.h
//  Scoreboard
//
//  Created by Thomas Alexanian on 2016-11-30.
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
@property (nullable, nonatomic, retain) NSOrderedSet<Points *> *points;

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
