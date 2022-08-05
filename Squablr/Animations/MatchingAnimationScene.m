//
//  MyScene.m
//  Squablr
//
//  Created by Zeke Reyes on 8/4/22.
//

#import "MatchingAnimationScene.h"

static NSString* itemCategoryName = @"glove";

@implementation MatchingAnimationScene


-(id)initWithSize:(CGSize)size {
    return [super initWithSize:size];
}

- (void)didMoveToView:(SKView *)view {
    // Adding text to a scene
    SKLabelNode *match = [SKLabelNode labelNodeWithFontNamed:@"Palatino-BoldItalic"];
    match.text = @"It's a Match!";
    match.fontSize = 23;
    match.fontColor = [SKColor blackColor];
    match.position = CGPointMake(0, -match.frame.size.height/2);
    
    SKSpriteNode *backgroundOfLabel = [SKSpriteNode spriteNodeWithColor:[UIColor whiteColor] size:CGSizeMake(match.frame.size.width + 10.0, match.frame.size.height + 30.0)];
    backgroundOfLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    [backgroundOfLabel addChild:match];
    [self addChild:backgroundOfLabel];
    
    
    // Creates the gravity of the world
    self.physicsWorld.gravity = CGVectorMake(0.0f, 0.0f); // Reality can be whatever I want
    
    // Create a physics edge-based body that borders the screen
    SKPhysicsBody* borderBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    // Set physicsBody of scene to borderBody
    self.physicsBody = borderBody;
    // Set the friction of that physicsBody to 0
    self.physicsBody.friction = 0.0f;
    
#pragma mark - Glove making 👩‍❤️‍💋‍👨
    
    // Sprite node which will be boxing gloves
    SKSpriteNode* glove1 = [self makeSpriteNodesForBoxingGloves];
    [self addChild:glove1];
    self.backgroundColor = UIColor.clearColor;
    // Creates volume based body for the gloves
    [self setPhysicsOfBody:glove1];
    
    
    SKSpriteNode* glove2 = [self makeSpriteNodesForBoxingGloves];
    [self addChild:glove2];
    self.backgroundColor = UIColor.clearColor;
    // Creates volume based body for the gloves
    [self setPhysicsOfBody:glove2];
    
    SKSpriteNode* glove3 = [self makeSpriteNodesForBoxingGloves];
    [self addChild:glove3];
    self.backgroundColor = UIColor.clearColor;
    // Creates volume based body for the gloves
    [self setPhysicsOfBody:glove3];
    
    SKSpriteNode* glove4 = [self makeSpriteNodesForBoxingGloves];
    [self addChild:glove4];
    self.backgroundColor = UIColor.clearColor;
    // Creates volume based body for the gloves
    [self setPhysicsOfBody:glove4];
}

- (SKSpriteNode *) makeSpriteNodesForBoxingGloves {
    SKSpriteNode* spriteNode = [SKSpriteNode spriteNodeWithImageNamed: @"confrontation"];
    spriteNode.name = itemCategoryName;
    spriteNode.position = CGPointMake(self.frame.size.width/3, self.frame.size.height/3);
    // Resizing of the gloves
    spriteNode.size = CGSizeMake(100.0, 100.0);
    return spriteNode;
}

- (void) setPhysicsOfBody: (SKSpriteNode *) spriteNode {
    float randomNum = ((float)rand() / RAND_MAX) * 200 + 100;
    spriteNode.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:spriteNode.frame.size.width/2];
    spriteNode.physicsBody.friction = 0.0f;
    // How elastic the node is
    spriteNode.physicsBody.restitution = 1.0f;
    // How much fluid/air friction is present
    spriteNode.physicsBody.linearDamping = 0.0f;
    // No rotation for the glove
    spriteNode.physicsBody.allowsRotation = NO;
    // Initial push of the object
    // Make random
    [spriteNode.physicsBody applyImpulse:CGVectorMake(randomNum, -randomNum)];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    UITouch* touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self];
    
    
    SKPhysicsBody* body = [self.physicsWorld bodyAtPoint:touchLocation];
    if (body) {
        SKNode* node = [body node];
        [node removeFromParent];
        unsigned long childCount  = [self children].count;
        if (childCount == 1) {
            [self.view presentScene:nil];
            [delegate didFinishTappingOnGloves];
        }
    }
//    SKSpriteNode* node = [body node];
//    [node]
//    if (body && [body.node.name isEqualToString: itemCategoryName]) {
//        NSLog(@"Began touch on glove");
//        [body ]
//        self.didTouchBoxingGloves = YES;
//    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

@end
