//
//  AppDelegate.m
//  Squablr
//
//  Created by Zeke Reyes on 7/5/22.
//

#import "AppDelegate.h"
#import "AppUpdateTracker.h"

@interface AppDelegate ()

@property NSTimer *timer;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // Override point for customization after application launch.
    [AppUpdateTracker registerForFirstInstallWithBlock:^(NSTimeInterval installTimeSinceEpoch, NSUInteger installCount) {
        NSLog(@"first install detected at: %f amount of times app was (re)installed: %lu", installTimeSinceEpoch, (unsigned long)installCount);
    }];
    [AppUpdateTracker registerForIncrementedUseCountWithBlock:^(NSUInteger useCount) {
        NSLog(@"incremented use count to: %lu", (unsigned long)useCount);
    }];
    // Code to initialize Parse
    ParseClientConfiguration *config = [ParseClientConfiguration  configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {

        configuration.applicationId = @"w82tGVT2WGuyPYeFiNTNRrzpoYdlwWbE48RET8bz"; // <- UPDATE
        configuration.clientKey = @"8ygiZHLHS7zOJAEoV9nuqcJbIZkQYb9eRp5ijykU"; // <- UPDATE
        configuration.server = @"https://parseapi.back4app.com";
    }];

    [Parse initializeWithConfiguration:config];
    
    return YES;
}

- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    BOOL handled = [GIDSignIn.sharedInstance handleURL:url];
    
    return handled;
}

#pragma mark - UISceneSession lifecycle

- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}

@end
