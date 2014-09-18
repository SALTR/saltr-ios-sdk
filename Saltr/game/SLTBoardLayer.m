/*
 * @file
 * SLTBoardLayer.m
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "SLTBoardLayer.h"

@implementation SLTBoardLayer

@synthesize token = _token;
@synthesize index = _index;

-(id) initWithToken:(NSString*)theToken andLayerIndex:(NSInteger)theLayerIndex
{
    self = [super init];
    if (self) {
        _token = theToken;
        _index = theLayerIndex;
    }
    return self;
}

-(void) regenerate
{
    //override
}

@end
