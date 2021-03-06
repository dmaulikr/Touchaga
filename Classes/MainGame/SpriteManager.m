//
//  SpriteManager.m
//  Touchaga
//
//  Created by Jacob O'Donnell on 12/28/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SpriteManager.h"
#import "Globals.h"

enum {
    kTagPlayer = 1,
    kTagPlayerBullet = 2,

    kTagBackground = 3,
    kTagWarpOutSprite = 4,
    
    kTagEnemySprite = 5,
};



@implementation SpriteManager

@synthesize manager;
@synthesize imageRect;
@synthesize tag;
@synthesize zIndex;

-(id) init
{
    if( (self=[super init] )) {
    }
    return self;
}

-(void) dealloc
{
    [manager release];
    [super dealloc];
}

@end


@implementation PlayerSpriteManager

-(id) init
{
    if( (self=[super init] )) {
        [self setManager: [[Globals sharedInstance] playerManager]];
        imageRect = CGRectMake(0,0,1,1);
        tag = kTagPlayer;
        zIndex = 1;
    }
    return self;
}

@end

@implementation PlayerBulletSpriteManager

-(id) init
{
    if( (self=[super init] )) {
        [self setManager: [[Globals sharedInstance] bulletManager]];
        imageRect = CGRectMake(0,0,16,32);
        tag = kTagPlayerBullet;
        zIndex = 1;
    }
    return self;
}

@end

@implementation WarpOutSpriteManager

-(id) init
{
    if( (self=[super init] )) {
        [self setManager: [[Globals sharedInstance] warpOutManager]];
        imageRect = CGRectMake(0,0,100,100);
        tag = kTagWarpOutSprite;
        zIndex = 2;
    }
    return self;
}

@end

@implementation BackgroundSpriteManager

-(id) init
{
    if( (self=[super init] )) {
        [self setManager: [[Globals sharedInstance] backgroundMangaer]];
        imageRect = CGRectMake(0,0,480,320);
        tag = kTagBackground;
        zIndex = 0;
    }
    return self;
}

@end

@implementation EnemySpriteManager

-(id) init
{
    if( (self=[super init] )) {
        [self setManager: [[Globals sharedInstance] enemyManager]];
        imageRect = CGRectMake(0,0,22,22);
        tag = kTagEnemySprite;
        zIndex = 0;
    }
    return self;
}

@end
