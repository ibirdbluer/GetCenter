//
//  CenterViewController.m
//  GetCenter
//
//  Created by qianyu on 14-3-23.
//  Copyright (c) 2014年 qianyu. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "CenterViewController.h"
#import "IntroScene.h"

@interface CenterViewController ()

@end

@implementation CenterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    SKView *centerView = (SKView *) self.view;
    centerView.showsDrawCount = YES;
    centerView.showsNodeCount = YES;
    centerView.showsFPS = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    IntroScene* intro = [[IntroScene alloc] initWithSize:CGSizeMake(1024, 768)];
    SKView *introView = (SKView *) self.view;
    [introView presentScene: intro];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
