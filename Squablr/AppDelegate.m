//
//  AppDelegate.m
//  Squablr
//
//  Created by Zeke Reyes on 7/5/22.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // Code to initialize Parse
    ParseClientConfiguration *config = [ParseClientConfiguration  configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {

        configuration.applicationId = @"FyAsM3YWS6d3vjuscmvQc2bW1N6ijce9iuvOzSCd"; // <- UPDATE
        configuration.clientKey = @"oP0YFwYBd74GG8CnTNRbHoApORkzZOVtCYGdEPG6"; // <- UPDATE
        configuration.server = @"https://parseapi.back4app.com";
    }];

    [Parse initializeWithConfiguration:config];
    
    // Google sign in to restore user signed in state
    [GIDSignIn.sharedInstance restorePreviousSignInWithCallback:^(GIDGoogleUser * _Nullable user,
                                                                    NSError * _Nullable error) {
        if (error) {
            // Show the app's signed-out state.
            // Must account for the user persistence with other sign in method
            // FIXME: This crashes the app but lets the user go to profile screen only
            if (!user) {
                /*
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                LoginViewController *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"loginVC"];
                self.window.rootViewController = loginVC;
                */
            }
        }
        else {
            // Show the app's signed-in state.
        }
      }];
    return YES;
}

- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    BOOL handled = [GIDSignIn.sharedInstance handleURL:url];
    
    if (handled) {
        return YES;
    }
    // If not handled by this app, return NO.
    return NO;
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
