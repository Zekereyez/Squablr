//
//  MyScene.h
//  Squablr
//
//  Created by Zeke Reyes on 8/4/22.
//

#import <SpriteKit/SpriteKit.h>
#import "AppDelegate.h"

@interface MatchingAnimationScene : SKScene <SKPhysicsContactDelegate>

@property (nonatomic) BOOL didTouchBoxingGloves;
@property (nonatomic) AnimationCompletionDelegate animationCompletionDelegate;

@end
