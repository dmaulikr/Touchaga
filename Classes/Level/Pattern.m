//
//  Pattern.m
//  MyFirstGame
//
//  Created by Jacob O'Donnell on 2/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Pattern.h"
#import "Path.h"
#import "ActionPoint.h"
#import "SQLite3DataAccess.h"

@implementation Pattern

@synthesize path;
@synthesize actions;

-(id)init
{
    if( (self=[super init] )) {
        path = [[Path alloc] init];
        actions = [[NSMutableArray alloc] init];
    }

    return self;
}

-(id)initWithId:(int) patternId
{
    if( (self=[super init] )) {
        SQLite3DataAccess *da = [SQLite3DataAccess sharedInstance];
        NSArray *pathAndActionIds = [da getPattern:patternId];
        int pathId = [[pathAndActionIds objectAtIndex:0] intValue];
        int actionsId = [[pathAndActionIds objectAtIndex:1] intValue];

        path = [[Path alloc] initWithId:pathId];
//        actions = [[NSMutableArray alloc] initWithId:actionsId];
        actions = [[NSMutableArray alloc] init];
    }

    return self;
}

-(void) dealloc
{
    [path release];
    [actions release];

    [super dealloc];
}

-(BOOL) isPatternOverAtTime:(int) relativeTime
{
    return [path isPathOverAtTime:relativeTime];
}

-(CGPoint) getPosAtTime:(int) relativeTime
{
   return [path getPosAtTime:relativeTime];
}

-(NSMutableArray *) getActionPointsAtTime:(int) relativeTime
{
    NSMutableArray *nowActionPoints = [[NSMutableArray alloc] init];
    ActionPoint *action;
    for (action in actions) {
        if ([action time] == relativeTime)
            [nowActionPoints addObject:action];
    }
    return nowActionPoints;
}

@end