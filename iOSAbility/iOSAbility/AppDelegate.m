//
//  AppDelegate.m
//  iOSAbility
//
//  Created by ItghostFan on 2023/12/25.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    NSURL *url = [NSURL URLWithString:@"hago://channel/openToolsPanel?id=10000&hide_panel=true&sub_id=1144"];
    NSURLComponents *components = [NSURLComponents componentsWithString:@"hago://channel/openToolsPanel?id=10000&hide_panel=true&sub_id=1144"];
    [UIView appearance].semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
