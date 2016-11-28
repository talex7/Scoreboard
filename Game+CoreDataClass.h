//
//  Game+CoreDataClass.h
//  Scoreboard
//
//  Created by Thomas Alexanian on 2016-11-28.
//
//  This file was automatically generated and should not be edited.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Game : NSManagedObject

-(void)awakeFromInsert;
-(void)awakeFromFetch;

@end

NS_ASSUME_NONNULL_END

#import "Game+CoreDataProperties.h"
