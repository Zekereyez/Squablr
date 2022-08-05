//
//  MyScene.h
//  Squablr
//
//  Created by Zeke Reyes on 8/4/22.
//

#import <SpriteKit/SpriteKit.h>
#import "AppDelegate.h"

@protocol AnimationCompletionDelegate

@required
- (void) didFinishTappingOnBoxingGloves;

@end

@protocol MatchAnimationNameSource

@required
- (NSString *) nameForMatchLabel;

@end

@interface MatchingAnimationScene : SKScene <SKPhysicsContactDelegate>

@property (nonatomic) BOOL didTouchBoxingGloves;
@property (nonatomic, weak) id <AnimationCompletionDelegate> animationCompletionDelegate;
@property (nonatomic, weak) id <MatchAnimationNameSource> matchAnimationNameSource;

@end
