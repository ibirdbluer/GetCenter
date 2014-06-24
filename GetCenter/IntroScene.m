//
//  IntroScene.m
//  GetCenter
//
//  Created by qianyu on 14-3-23.
//  Copyright (c) 2014年 qianyu. All rights reserved.
//

#import "IntroScene.h"
#import "StoneScene.h"
#import "PlayerVSComputer.h"

@interface IntroScene ()
@property BOOL contentCreated;
@end

@implementation IntroScene

- (void)didMoveToView: (SKView *) view
{
    if (!self.contentCreated)
    {
        [self createSceneContents];
        self.contentCreated = YES;
    }
}

- (void)createSceneContents
{
    self.backgroundColor = [SKColor whiteColor];
    self.scaleMode = SKSceneScaleModeAspectFit;
    
    SKSpriteNode *buttonForDoublePlayer = [SKSpriteNode
                                           spriteNodeWithImageNamed:@"button_2Player.png"];
    buttonForDoublePlayer.position = CGPointMake(CGRectGetMidX(self.frame)-100, CGRectGetMidY(self.frame));
    SKSpriteNode *buttonForSinglePlayer = [SKSpriteNode
                                           spriteNodeWithImageNamed:@"button_1Player.png"];
    buttonForSinglePlayer.position = CGPointMake(CGRectGetMidX(self.frame)+100, CGRectGetMidY(self.frame));
    
    buttonForSinglePlayer.name = @"single";
    buttonForDoublePlayer.name = @"double";
    
    [self addChild:buttonForDoublePlayer];
    [self addChild:buttonForSinglePlayer];
}

//- (SKLabelNode *)newIntroNode
//{
//
//    SKLabelNode *introNode = [SKLabelNode
//                              labelNodeWithFontNamed:@"Chalkduster"];
//    introNode.text = @"Start!";
//    introNode.fontSize = 42;
//    introNode.position =
//    CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
//    
//    introNode.name = @"introNode";
//    return introNode;
//}

- (void)touchesBegan:(NSSet *) touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if ([node.name isEqualToString:@"single"]){
        SKTransition *reveal = [SKTransition
                                revealWithDirection:SKTransitionDirectionDown duration:1.0];
        SKScene *newScene = [[PlayerVSComputer alloc] initWithSize:self.size];
        [self.scene.view presentScene: newScene transition: reveal];
    }else if ([node.name isEqualToString:@"double"]){
        SKTransition *reveal = [SKTransition
                                revealWithDirection:SKTransitionDirectionDown duration:1.0];
        SKScene *newScene = [[StoneScene alloc] initWithSize:self.size];
        [self.scene.view presentScene: newScene transition: reveal];
    }
    
//    SKNode *introNode = [self childNodeWithName:@"introNode"];
//    if (introNode != nil)
//    {
//        introNode.name = nil;
//        SKAction *moveUp = [SKAction moveByX: 0 y: 100.0 duration: 0.5];
//        SKAction *zoom = [SKAction scaleTo: 2.0 duration: 0.25];
//        SKAction *pause = [SKAction waitForDuration: 0.5];
//        SKAction *fadeAway = [SKAction fadeOutWithDuration: 0.25];
//        SKAction *remove = [SKAction removeFromParent];
//        
//        SKAction *moveSequence = [SKAction sequence:@[moveUp, zoom, pause, fadeAway, remove]];
//        [introNode runAction: moveSequence completion:^{
//            SKScene *stoneScene  = [[PlayerVSComputer alloc]
//                                        initWithSize:self.size];
//            SKTransition *doors = [SKTransition
//                                   doorsOpenVerticalWithDuration:0.5];
//            [self.view presentScene:stoneScene transition:doors];
//        }];
//      
//    }
}

@end
