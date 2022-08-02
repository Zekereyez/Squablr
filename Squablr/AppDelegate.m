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

- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}

-(void)applicationWillEnterForeground:(UIApplication *)application {
    // probably would be the place to make the timer  and create it?
    // the only problem is if it will even be accessible since its in
    // this function maybe i need to make it like a global function
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(writeToParse) userInfo:nil repeats:YES];
    NSLog(@"%@", @"Will enter foreground method");
}

-(void)applicationDidBecomeActive:(UIApplication *)application {
    // Start the user timer
    self.timer = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(writeToParse) userInfo:nil repeats:YES];
    NSLog(@"%@", @"App did become active");
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // pause timer in here since the user is no longer active on the app/no longer in the foreground
    [self.timer invalidate];
    NSLog(@"%@", @"App entered the background aka no longer active");
}

- (void) writeToParse {
    // update the current user count of app usage to parse
    NSLog(@"%@", @"Call to parse method!");
    
}

@end
