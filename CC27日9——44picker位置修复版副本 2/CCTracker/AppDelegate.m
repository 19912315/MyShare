//
//  AppDelegate.m
//  CCTracker
//
//  Created by LWB on 15/8/16.
//  Copyright (c) 2015年 Lvwenbin. All rights reserved.
//

#import "AppDelegate.h"
#import "CCData.h"
@interface AppDelegate ()

@end

@implementation AppDelegate






-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    

   

    
    
    NSMutableArray * array = [NSMutableArray arrayWithArray: [CCData tiptimeFromCC]];
    
    for (NSDictionary * dic in array) {
        
        if ([notification.userInfo[@"info"] isEqualToString:dic[@"info"]]) {
            if ([dic[@"repeat"] floatValue] > 1) {
                
                [[UIApplication sharedApplication] cancelLocalNotification:notification];
             
                
                
                UILocalNotification * localNoti = [[UILocalNotification alloc]init];
                
                
                if (localNoti) {
                    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
                    [formatter setDateFormat:@"yyyy-MM-dd hh:mm"];
                 NSDate * date = [formatter dateFromString:dic[@"alarm"]];
                    NSTimeInterval interval = 60*60*24*[dic[@"repeat"] floatValue];
                    NSDate * newDate = [[NSDate alloc]initWithTimeInterval:interval sinceDate:date];
                    
                    
                    localNoti.fireDate = newDate;
                    
                    localNoti.timeZone = [NSTimeZone defaultTimeZone];
                    localNoti.applicationIconBadgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber+1;
                    localNoti.alertBody = @"囚徒健身小助手提醒您:是时候开始今天的锻炼喽";
                    localNoti.alertAction = @"打开";
                    NSDictionary * info = @{@"info":dic[@"info"]};
                    localNoti.userInfo = info;
                    localNoti.soundName =  UILocalNotificationDefaultSoundName;
                    
                    [[UIApplication sharedApplication] scheduleLocalNotification:localNoti];
                    
                    
                    
                    
                    
                    
                    
                    
                }
                
                

                
                
                
            }
            
            
            
            
        }
        

        
        
        
        
    }
    
    
    
    
    
    
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]) {
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
        
    }
    
    
    
    
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
