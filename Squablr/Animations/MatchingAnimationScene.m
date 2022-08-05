//
//  MyScene.m
//  Squablr
//
//  Created by Zeke Reyes on 8/4/22.
//

#import "MatchingAnimationScene.h"

static NSString* itemCategoryName = @"glove";

@implementation MatchingAnimationScene

static const long NUM_BOXING_GLOVES = 4;


-(id)initWithSize:(CGSize)size {
    return [super initWithSize:size];
}

- (void)didMoveToView:(SKView *)view {
    // Adding text to a scene
    SKLabelNode *match = [SKLabelNode labelNodeWithFontNamed:@"Palatino-BoldItalic"];
    match.text = [NSString stringWithFormat:@"You matched with %@!", [self.matchAnimationNameSource nameForMatchLabel]];
    match.fontSize = 23;
    match.fontColor = [SKColor blackColor];
    match.position = CGPointMake(0, -match.frame.size.height/2);
    
    SKSpriteNode *backgroundOfLabel = [SKSpriteNode spriteNodeWithColor:[UIColor whiteColor] size:CGSizeMake(match.frame.size.width + 10.0, match.frame.size.height + 30.0)];
    backgroundOfLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    [backgroundOfLabel addChild:match];
    [self addChild:backgroundOfLabel];
    
    self.backgroundColor = UIColor.clearColor;
    
    
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
    for (long i = 0; i < NUM_BOXING_GLOVES; i++) {
        SKSpriteNode* glove = [self makeSpriteNodesForBoxingGloves];
        [self addChild:glove];
        // Creates volume based body for the gloves
        [self setPhysicsOfBody:glove];
    }
}

#pragma mark - Initializing the glove properties
- (SKSpriteNode *) makeSpriteNodesForBoxingGloves {
    float width = (float)self.frame.size.width;
    float height = (float)self.frame.size.height;
    SKSpriteNode* spriteNode = [SKSpriteNode spriteNodeWithImageNamed: @"confrontation"];
    spriteNode.name = itemCategoryName;
    spriteNode.position = CGPointMake((float)arc4random_uniform(width), (float)arc4random_uniform(height));
    // Resizing of the gloves
    spriteNode.size = CGSizeMake(100.0, 100.0);
    return spriteNode;
}

#pragma mark - Setting the physics of the gloves
- (void) setPhysicsOfBody: (SKSpriteNode *) spriteNode {
    float xVelocity = ((float)rand() / RAND_MAX) * 200 + 100;
    float yVelocity = ((float)rand() / RAND_MAX) * 200 + 100;
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
    xVelocity = (rand() % 1) == 0 ? xVelocity : xVelocity * -1;
    yVelocity = (rand() % 1) == 0 ? xVelocity : xVelocity * -1;
    
    [spriteNode.physicsBody applyImpulse:CGVectorMake(xVelocity, -yVelocity)];
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
            [_animationCompletionDelegate didFinishTappingOnBoxingGloves];
        }
    }
}

@end
