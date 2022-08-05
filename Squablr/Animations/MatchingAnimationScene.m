//
//  MyScene.m
//  Squablr
//
//  Created by Zeke Reyes on 8/4/22.
//

#import "MatchingAnimationScene.h"

@implementation MatchingAnimationScene


-(id)initWithSize:(CGSize)size {
    return [super initWithSize:size];
}

- (void)didMoveToView:(SKView *)view {
    // Creates the gravity of the world
    self.physicsWorld.gravity = CGVectorMake(0.0f, 0.0f); // Reality can be whatever I want
    
    // Create a physics edge-based body that borders the screen
    SKPhysicsBody* borderBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    // Set physicsBody of scene to borderBody
    self.physicsBody = borderBody;
    // Set the friction of that physicsBody to 0
    self.physicsBody.friction = 0.0f;
    
    // Sprite node which will be boxing gloves
    SKSpriteNode* glove1 = [SKSpriteNode spriteNodeWithImageNamed: @"confrontation"];
    glove1.name = @"glove";
    glove1.position = CGPointMake(self.frame.size.width/3, self.frame.size.height/3);
    // Resizing of the gloves
    glove1.size = CGSizeMake(100.0, 100.0);
    [self addChild:glove1];
    // Makes the scene overlay the userfeed cards
    self.backgroundColor = UIColor.clearColor;
    
    // Creates volume based body for the gloves
    glove1.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:glove1.frame.size.width/2];
    glove1.physicsBody.friction = 0.0f;
    // How elastic the node is
    glove1.physicsBody.restitution = 1.0f;
    // How much fluid/air friction is present
    glove1.physicsBody.linearDamping = 0.0f;
    // No rotation for the glove
    glove1.physicsBody.allowsRotation = NO;
    // Initial push of the object
    [glove1.physicsBody applyImpulse:CGVectorMake(100.0f, -100.0f)];
}

@end
