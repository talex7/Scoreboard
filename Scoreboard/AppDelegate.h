//
//  AppDelegate.h
//  Scoreboard
//
//  Created by Thomas Alexanian on 2016-11-27.
//
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

