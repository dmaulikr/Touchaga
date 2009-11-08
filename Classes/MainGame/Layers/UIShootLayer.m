//
//  UIShootLayer.m
//  MyFirstGame
//
//  Created by Jacob O'Donnell on 8/9/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "UIShootLayer.h"
#import "defines.h"
#import "BulletsLayer.h"
#import "PlayerLayer.h"

@implementation UIShootLayer

@synthesize shootRect;

-(id) init
{
    if( (self=[super init] )) {
	self.isTouchEnabled = YES;
		
	shootRect = CGRectMake(0, 0, 30, 200);

	[self schedule: @selector(regainEnergy:) interval:0];
    }
    return self;
}

- (void) dealloc
{
    [super dealloc];
}

-(CocosNode *) getGamePlayScene
{
    return [self parent];
}

-(void) chargeShot: (ccTime) dt
{
    PlayerSprite *player = [self getPlayer];
    [player chargingEnergy:1];
}

-(void) regainEnergy: (ccTime) dt
{
    PlayerSprite *player = [self getPlayer];
    [player regainEnergy:1];
}

-(PlayerSprite *) getPlayer
{
    PlayerLayer *playerLayer = (PlayerLayer *)[[self getGamePlayScene] getChildByTag:kTagPlayerLayer];
    PlayerSprite *player = [playerLayer getPlayer];
    return player;
}

- (BOOL)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
	
    if( touch ) {
	CGPoint location = [touch locationInView: [touch view]];
	CGPoint convertedPoint = [[Director sharedDirector] convertCoordinate:location];

	if (CGRectContainsPoint(shootRect, convertedPoint))
	{
	    [self schedule: @selector(chargeShot:) interval:0];
	    [self unschedule: @selector(regainEnergy:)];
	    return kEventHandled;
	}
    }
    return kEventIgnored;
}

- (BOOL)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
	
    if( touch ) {
	CGPoint location = [touch locationInView: [touch view]];
	CGPoint convertedPoint = [[Director sharedDirector] convertCoordinate:location];
		
	if (CGRectContainsPoint(shootRect, convertedPoint))
	{
	    [self unschedule: @selector(chargeShot:)];
	    [self schedule: @selector(regainEnergy:) interval:0];

	    PlayerSprite *player = [self getPlayer];
	    int charge = [player fire];

	    BulletsLayer *bulletLayer = (BulletsLayer *)[[self getGamePlayScene] getChildByTag:kTagBulletLayer];
	    [bulletLayer addPlayerBullet:player.position andCharge: charge];
	    return kEventHandled;
	}
    }
    return kEventIgnored;
}

@end