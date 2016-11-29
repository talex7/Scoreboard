//
//  Player+CoreDataClass.m
//  Scoreboard
//
//  Created by Thomas Alexanian on 2016-11-28.
//
//  This file was automatically generated and should not be edited.
//

#import "Player+CoreDataClass.h"

@implementation Player

-(void)awakeFromInsert {
    self.totalPts = [NSKeyedArchiver archivedDataWithRootObject:[NSMutableArray new]];
    self.totalShots = [NSKeyedArchiver archivedDataWithRootObject:[NSMutableArray new]];
    self.gamesWon = 0;
    self.idNo = 01;
    self.name = "";
}


@end
