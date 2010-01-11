//
//  WarpOutCircle.h
//  Touchaga
//
//  Created by Jacob O'Donnell on 1/3/10.
//  Copyright 2009 __MyCompanyName__. All rights reserved.


#import "cocos2d.h"
#import "TouchagaSprite.h"

@class Player;

/**
 * The sprite that represents the area that a player can warp in to.  The sprite
 * gets scaled smaller as the player warp energy runs out.  When the player is warped out
 * this sprite is active, it looks for touches to signal that the player is warping back in,
 * if it gets a touch it sets warpIn.
 */
@interface WarpOutCircle : TouchagaSprite <TargetedTouchDelegate> {
    BOOL warpIn;
    Player *player;
}

/** A BOOL, when YES it signals the player to warp in. */
@property (nonatomic) BOOL warpIn;

/** The player object. */
@property (retain, nonatomic) Player *player;

/**
 * Constructor
 * @param thePlayer The Player object.
 * @return id The PlayerInactiveLayer
 */
-(id) initWithPlayer:(Player *) thePlayer;

/**
 * Drains the player's warp energy.
 */
-(void)drainEnergy;

/**
 * Updates the scale factor of the sprite.
 */
-(void)update;

@end
