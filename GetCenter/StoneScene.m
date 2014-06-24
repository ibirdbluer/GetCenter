//
//  StoneScene.m
//  GetCenter
//
//  Created by qianyu on 14-3-23.
//  Copyright (c) 2014年 qianyu. All rights reserved.
//

#import "StoneScene.h"
#import "GameOverScene.h"

static NSArray *blueCircleName;
static NSArray *redCircleName;
static NSString *blueCircleCategoryName;
static NSString *redCircleCategoryName;
static BOOL isPlayerVSComputer = NO;



@interface StoneScene ()
@property BOOL contentCreated;
@property int countOfBlueCircle;
@property (nonatomic) NSTimeInterval lastSpawnTimeInterval;
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;
@property (nonatomic) int countOfTouchInLaunchbar;
@property (nonatomic) int countOfTouchInBlueLaunchbar;
@property (nonatomic) int countOfTouchInRedLaunchbar;
@end

// vector Calculate
//static inline CGPoint dirAdd(CGPoint a, CGPoint b) {
//    return CGPointMake(a.x + b.x, a.y + b.y);
//}

static inline CGPoint dirSub(CGPoint a, CGPoint b) {
    return CGPointMake(a.x - b.x, a.y - b.y);
}

//static inline CGPoint dirMult(CGPoint a, float b) {
//    return CGPointMake(a.x * b, a.y * b);
//}

static inline float dirLength(CGPoint a) {
    return sqrtf(a.x * a.x + a.y * a.y);
}

static inline float dirCos(CGPoint a) {
    return a.x/dirLength(a);
}

static inline float dirSin(CGPoint a) {
    return a.y/dirLength(a);
}

// Makes a vector have a length of 1
//static inline CGPoint dirNormalize(CGPoint a) {
//    float length = dirLength(a);
//    return CGPointMake(a.x / length, a.y / length);
//}


@implementation StoneScene

- (void)didMoveToView:(SKView *)view
{
    if (!self.contentCreated)
    {
        [self createSceneContents];
        self.contentCreated = YES;
    }
}

//-(id)initWithSize:(CGSize)size {
//    if (self = [super initWithSize:size]) {
//        [self createSceneContents];
//        
//    }
//    return self;
//}

- (void)createSceneContents
{
    SKSpriteNode* background = [SKSpriteNode spriteNodeWithImageNamed:@"background.png"];
    background.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    [self addChild:background];
    self.scaleMode = SKSceneScaleModeAspectFit;
    //  initialize the stone scene’s contents ------------
    self.physicsWorld.gravity = CGVectorMake(0,0);
    
    SKSpriteNode *blueStone = [SKSpriteNode spriteNodeWithImageNamed:@"blueStone2"];
    blueStone.position =  CGPointMake(CGRectGetMidX(self.frame)/4,
                                      CGRectGetMinY(self.frame)+100);
    SKSpriteNode *redStone = [SKSpriteNode spriteNodeWithImageNamed:@"redStone"];
    redStone.position = CGPointMake(CGRectGetMidX(self.frame)/4,
                                    CGRectGetMaxY(self.frame)-100);

    
    [self addChild:blueStone];
    [self addChild:redStone];
    

    blueCircleName = @[@"blueOne", @"blueTwo", @"blueThree", @"blueFour", @"blueFive", @"blueSix", @"blueSeven", @"blueEight", @"blueNine"];
    redCircleName = @[@"redOne", @"redTwo", @"redThree", @"redFour", @"redFive", @"redSix", @"redSeven", @"redEight", @"redNine"];
}

- (SKSpriteNode *)newBlueStone
{
    SKSpriteNode *circle = [SKSpriteNode spriteNodeWithImageNamed:@"blueStone"];
    circle.position = CGPointMake(CGRectGetMidX(self.frame)/4,
                                 CGRectGetMinY(self.frame)+100);
    circle.name = blueCircleName[self.countOfTouchInBlueLaunchbar];

    circle.physicsBody.dynamic = YES;
    circle.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:circle.size.width/2];
    circle.physicsBody.linearDamping = 0.8;
    circle.physicsBody.mass = 0.1;
    circle.physicsBody.restitution = 0.7;

    return circle;
}

- (SKSpriteNode *)newRedStone
{
    SKSpriteNode *circle = [SKSpriteNode spriteNodeWithImageNamed:@"redStone"];
    circle.position = CGPointMake(CGRectGetMidX(self.frame)/4,
                                 CGRectGetMaxY(self.frame)-100);
    circle.name = redCircleName[self.countOfTouchInRedLaunchbar];
    circle.physicsBody.dynamic = YES;
    circle.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:circle.size.width/2];
    circle.physicsBody.linearDamping = 0.8f;
    circle.physicsBody.mass = 0.1;
    circle.physicsBody.restitution = 0.7;


    return circle;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    // Add the new stone and Determine the number of touching in the launch bar
    if (location.x < 128 && location.y < 384) {
        if (self.countOfTouchInBlueLaunchbar >= 9) return;
        [self addChild: [self newBlueStone]];
    }
    if (location.x < 128 && location.y >=384) {
        if (self.countOfTouchInRedLaunchbar >= 9) return;
        [self addChild: [self newRedStone]];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // Choose one of the touches to work with
    UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    NSLog(@"%f,%f",location.x, location.y);
    
    NSString* circleCategoryName;
    if (location.y <= 384) {
        if (self.countOfTouchInBlueLaunchbar >= 9) return;
        circleCategoryName = blueCircleName[self.countOfTouchInBlueLaunchbar];
        self.countOfTouchInBlueLaunchbar ++;
        self.countOfTouchInLaunchbar ++;
    } else if (location.y >=384)
    {
        if (self.countOfTouchInRedLaunchbar >= 9) return;
        circleCategoryName = redCircleName[self.countOfTouchInRedLaunchbar];
        self.countOfTouchInRedLaunchbar ++;
        self.countOfTouchInLaunchbar ++;
    }
    
    SKSpriteNode* circle = (SKSpriteNode*)[self childNodeWithName: circleCategoryName];

    // Determine offset of location to projectile
    CGPoint offset = dirSub(location, circle.position);
    
    // The circle cannot go backward and cannot get impulse at second time(i don't know how to do it, but i set the offset and it's working!)
    if (offset.x >= 0) return;
    if (circle.position.x > 128) return;
    // Determine the circle's initial direction
    float cosDirection = dirCos(offset);
    float sinDirection = dirSin(offset);
    
    // Determine the circle's launch impulse
    float circleLaunchImpulse = -dirLength(offset) * 0.5;
    
    
    // Calculating the circle’s initial impulse
    [circle.physicsBody applyImpulse:
     CGVectorMake(circleLaunchImpulse*cosDirection,    //cosDirection = cosf(circleDirection) = x/length ;circleLaunchImpulse = offset
                  circleLaunchImpulse*sinDirection)];  //sinDirection = sinf(circleDirection) = y/length
    
}



- (void)updateWithTimeSinceLastUpdate:(CFTimeInterval)timeSinceLast {
    
    self.lastSpawnTimeInterval += timeSinceLast;
    if (self.lastSpawnTimeInterval > 10) {
        self.lastSpawnTimeInterval = 0;

        [self gameOver];
    }
}

- (void)update:(NSTimeInterval)currentTime {
    // Handle time delta.
    // If we drop below 60fps, we still want everything to move the same distance.
    CFTimeInterval timeSinceLast = currentTime - self.lastUpdateTimeInterval;
    self.lastUpdateTimeInterval = currentTime;
    if (timeSinceLast > 1) { // more than a second since last update
        timeSinceLast = 1.0 / 60.0;
        self.lastUpdateTimeInterval = currentTime;
    }
    if (self.countOfTouchInLaunchbar == 18) {
        [self updateWithTimeSinceLastUpdate:timeSinceLast];
    }
    
}

- (void)gameOver
{

    NSArray *blueCircleCategoryName = @[@"blueOne",@"blueTwo",@"blueThree",@"blueFour",@"blueFive",@"blueSix",@"blueSeven",@"blueEight",@"blueNine"];
    NSArray *redCircleCategoryName = @[ @"redOne",@"redTwo",@"redThree",@"redFour",@"redFive",@"redSix",@"redSeven",@"redEight",@"redNine"];

    // calculating scores of each circle
    int blueScore = 0;
    int redScore = 0;

    for (NSString *blue in blueCircleCategoryName)
    {
        SKSpriteNode* circle = (SKSpriteNode*)[self childNodeWithName:blue];
        int score;
        double lengthBetweenCircleAndCenter = dirLength(dirSub(circle.position, CGPointMake(658, 384)));
        if (lengthBetweenCircleAndCenter <= 30) {
            score = 5;
        }
        else if(lengthBetweenCircleAndCenter <= 122) {
            score = 3;
        }
        else if (lengthBetweenCircleAndCenter <= 244) {
            score = 2;
        }
        else if (lengthBetweenCircleAndCenter <= 366) {
            score = 1;
        }
        else {
            score = 0;
        }
        blueScore += score;
        NSLog(@"%f,%f,%f,%@,%d,%d",circle.position.x, circle.position.y,lengthBetweenCircleAndCenter, blue,score,blueScore);
    }
    
    for (NSString *red in redCircleCategoryName)
    {
        SKSpriteNode* circle = (SKSpriteNode*)[self childNodeWithName:red];
        int score;
        double lengthBetweenCircleAndCenter = dirLength(dirSub(circle.position, CGPointMake(658, 384)));
        if (lengthBetweenCircleAndCenter <= 30) {
            score = 5;
        }
        else if(lengthBetweenCircleAndCenter <= 122) {
            score = 3;
        }
        else if (lengthBetweenCircleAndCenter <= 244) {
            score = 2;
        }
        else if (lengthBetweenCircleAndCenter <= 366) {
            score = 1;
        }
        else {
            score = 0;
        }
        redScore += score;
        NSLog(@"%f,%f,%f,%@,%d,%d",circle.position.x, circle.position.y,lengthBetweenCircleAndCenter, red,score,redScore);
    }
    int score = fabs(blueScore - redScore);
    NSString* scoreVS = [NSString stringWithFormat:@"%d",score];

    NSString * winner;
    if (blueScore > redScore) {
        winner = @"winner is blue!";
    }else if (blueScore == redScore)
    {
        winner = @"no winner!";
    }else {
        winner = @"winner is red!";
    }
    // translate to game over scene
    SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
    SKScene * gameOverScene = [[GameOverScene alloc] initWithSize:self.size won:winner withScoreVS:scoreVS isPlayerVSComputer:isPlayerVSComputer];
    [self.view presentScene:gameOverScene transition: reveal];

}


@end
