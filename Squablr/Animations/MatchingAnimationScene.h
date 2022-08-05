//
//  MyScene.h
//  Squablr
//
//  Created by Zeke Reyes on 8/4/22.
//
@protocol AnimationCompletionDelegate

@required
- (void) didFinishTappingOnBoxingGloves;

@end

#import <SpriteKit/SpriteKit.h>
#import "AppDelegate.h"

//@protocol AnimationCompletionDelegate <NSObject>
//
//- (void) didFinishTappingOnBoxingGloves;
//
//@end

@interface MatchingAnimationScene : SKScene <SKPhysicsContactDelegate>

@property (nonatomic) BOOL didTouchBoxingGloves;
@property (nonatomic, strong) id <AnimationCompletionDelegate> animationCompletionDelegate;

@end
