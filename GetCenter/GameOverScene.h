//
//  GameOverScene.h
//  GetCenter
//
//  Created by iBird_bluer on 14-4-15.
//  Copyright (c) 2014年 qianyu. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GameOverScene : SKScene
-(id)initWithSize:(CGSize)size won:(NSString *)won withScoreVS:(NSString *)scoreVS isPlayerVSComputer:(BOOL)isPlayerVSComputer;

@end
