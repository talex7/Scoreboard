//
//  Game+CoreDataClass.m
//  Scoreboard
//
//  Created by Thomas Alexanian on 2016-11-28.
//
//  This file was automatically generated and should not be edited.
//

#import "Game+CoreDataClass.h"

@implementation Game

- (Game NSManagedObject *)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context {
    self = [super init];
    if (self) {
        self.isCompleted = NO;
        self.turnCounter = 1;
        //  self.id += ?????;
        //  self.players =
    }
    return self;
    
}

-(void)awakeFromInsert {
    self.isCompleted = NO;
    self.turnCounter = 1;
  //  self.id += ?????;
  //  self.players =
}

-(void)awakeFromFetch {
    
}

@end
