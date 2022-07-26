//
//  AppDelegate.h
//  HangOut
//
//  Created by Oluwanifemi Kolawole on 7/5/22.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

