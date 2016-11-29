//
//  Player+CoreDataClass.h
//  Scoreboard
//
//  Created by Thomas Alexanian on 2016-11-28.
//
//  This file was automatically generated and should not be edited.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Player : NSManagedObject

- (NSManagedObject *)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context name:(NSString*)name;

@end

NS_ASSUME_NONNULL_END

#import "Player+CoreDataProperties.h"
