//
//  GameOverScene.m
//  GetCenter
//
//  Created by iBird_bluer on 14-4-15.
//  Copyright (c) 2014年 qianyu. All rights reserved.
//

#import "GameOverScene.h"
#import "IntroScene.h"
#import "StoneScene.h"
#import "PlayerVSComputer.h"
//#import <FacebookSDK/FacebookSDK.h>
static NSString *score;
static BOOL isPlayerVSAI;

@implementation GameOverScene

-(id)initWithSize:(CGSize)size won:(NSString *)won withScoreVS:(NSString *)scoreVS isPlayerVSComputer:(BOOL)isPlayerVSComputer{
    score = scoreVS;
    isPlayerVSAI = isPlayerVSComputer;
    if (self = [super initWithSize:size]) {
        
        self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        
        NSMutableString *message = [NSMutableString stringWithCapacity:20];
        [message appendFormat:@"%@\n",won];
        [message appendFormat: @"%@",scoreVS];
        
        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        label.text = message;
        label.fontSize = 50;
        label.fontColor = [SKColor blackColor];
        label.position = CGPointMake(self.size.width/2, self.size.height/2 + 100);
        [self addChild:label];
        
        SKLabelNode *playAgain = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        playAgain.text = @"play again";
        playAgain.name = @"playAgain";
        playAgain.fontSize = 40;
        playAgain.fontColor = [SKColor blackColor];
        playAgain.position = CGPointMake(self.size.width/2, self.size.height/2);
        [self addChild:playAgain];
        
        SKLabelNode *goBack = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        goBack.text = @"go back";
        goBack.name = @"goBack";
        goBack.fontSize = 40;
        goBack.fontColor = [SKColor blackColor];
        goBack.position = CGPointMake(self.size.width/2, self.size.height/2 - 80);
        [self addChild:goBack];
        
        if (isPlayerVSComputer){
        SKLabelNode *share = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        share.text = @"share";
        share.name = @"share";
        share.fontSize = 40;
        share.fontColor = [SKColor blackColor];
        share.position = CGPointMake(self.size.width/2, self.size.height/2 - 160);
        [self addChild:share];
        }
        
    }
    return self;

}

- (void)touchesBegan:(NSSet *) touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if ([node.name isEqualToString:@"playAgain"]){
        SKTransition *reveal = [SKTransition
                                revealWithDirection:SKTransitionDirectionDown duration:1.0];
        if (isPlayerVSAI) {
            SKScene *newScene = [[PlayerVSComputer alloc] initWithSize:self.size];
            [self.scene.view presentScene: newScene transition: reveal];
        }else{
            SKScene *newScene = [[StoneScene alloc] initWithSize:self.size];
            [self.scene.view presentScene: newScene transition: reveal];
        }
    }else if ([node.name isEqualToString:@"goBack"]){
        SKTransition *reveal = [SKTransition
                                revealWithDirection:SKTransitionDirectionDown duration:1.0];
        SKScene *newScene = [[IntroScene alloc] initWithSize:self.size];
        [self.scene.view presentScene: newScene transition: reveal];
    }else if ([node.name isEqualToString:@"share"]){
        id sender;
        NSMutableString *description = [NSMutableString stringWithCapacity:20];
        [description appendString:@"I won\n"];
        [description appendFormat: @"%@\n",score];
        [description appendString:@"point!"];

        [self shareClicked:(id)sender withDescription:description];
    }

//            SKScene *stoneScene  = [[IntroScene alloc]
//                                    initWithSize:self.size];
//            SKTransition *doors = [SKTransition
//                                   doorsOpenVerticalWithDuration:0.5];
//            [self.view presentScene:stoneScene transition:doors];

}

- (IBAction)shareClicked:(id)sender withDescription:(NSString *)description
{
//    FBShareDialogParams *params = [[FBShareDialogParams alloc] init];
//    params.link = [NSURL URLWithString:@"https://www.facebook.com/uyqian"];
//    params.picture = [NSURL URLWithString:@"https://raw.github.com/fbsamples/ios-3.x-howtos/master/Images/iossdk_logo.png"];
//    params.name = @"GetCenter";
//    params.caption = @"A strategy game inspired by curling";
//    params.description = description;
//    [FBDialogs presentShareDialogWithParams:params clientState:nil handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
//        if(error) {
//            NSLog(@"Error: %@", error.description);
//        } else {
//            NSLog(@"Success!");
//        }
//    }];
//    
//    // If the Facebook app is installed and we can present the share dialog
//    if ([FBDialogs canPresentShareDialogWithParams:params]) {
//        
//        // Present share dialog
//        [FBDialogs presentShareDialogWithLink:params.link
//                                         name:params.name
//                                      caption:params.caption
//                                  description:params.description
//                                      picture:params.picture
//                                  clientState:nil
//                                      handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
//                                          if(error) {
//                                              // An error occurred, we need to handle the error
//                                              // See: https://developers.facebook.com/docs/ios/errors
//                                              NSLog(@"Error publishing story: %@", error.description);
//                                          } else {
//                                              // Success
//                                              NSLog(@"result %@", results);
//                                          }
//                                      }];
//        
//        // If the Facebook app is NOT installed and we can't present the share dialog
//    } else {
//        // FALLBACK: publish just a link using the Feed dialog
//        
//        // Put together the dialog parameters
//        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
//                                       @"GetCenter", @"name",
//                                       @"A strategy game inspired by curling", @"caption",
//                                       description, @"description",
//                                       @"https://www.facebook.com/uyqian", @"link",
//                                       @"http://i.imgur.com/g3Qc1HN.png", @"picture",
//                                       nil];
//        
//        // Show the feed dialog
//        [FBWebDialogs presentFeedDialogModallyWithSession:nil
//                                               parameters:params
//                                                  handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
//                                                      if (error) {
//                                                          // An error occurred, we need to handle the error
//                                                          // See: https://developers.facebook.com/docs/ios/errors
//                                                          NSLog(@"Error publishing story: %@", error.description);
//                                                      } else {
//                                                          if (result == FBWebDialogResultDialogNotCompleted) {
//                                                              // User canceled.
//                                                              NSLog(@"User cancelled.");
//                                                          } else {
//                                                              // Handle the publish feed callback
//                                                              NSDictionary *urlParams = [self parseURLParams:[resultURL query]];
//                                                              
//                                                              if (![urlParams valueForKey:@"post_id"]) {
//                                                                  // User canceled.
//                                                                  NSLog(@"User cancelled.");
//                                                                  
//                                                              } else {
//                                                                  // User clicked the Share button
//                                                                  NSString *result = [NSString stringWithFormat: @"Posted story, id: %@", [urlParams valueForKey:@"post_id"]];
//                                                                  NSLog(@"result %@", result);
//                                                              }
//                                                          }
//                                                      }
//                                                  }];
//    }

}

//------------------------------------

// A function for parsing URL parameters returned by the Feed Dialog.
- (NSDictionary*)parseURLParams:(NSString *)query {
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        NSString *val =
        [kv[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        params[kv[0]] = val;
    }
    return params;
}

//------------------------------------


@end
