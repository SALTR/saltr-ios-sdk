/*
 * @file SLTMatchingBoardLayer.m
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "SLTMatchingBoardLayer.h"
#import "SLTChunk.h"

@interface SLTMatchingBoardLayer() {
    NSMutableArray* _chunks;
}

@end

@implementation SLTMatchingBoardLayer

-(id)initWithToken:(NSString*)theLayerId andLayerIndex:(NSInteger)theLayerIndex;
{
    self = [super initWithToken:theLayerId andLayerIndex:theLayerIndex];
    if (self) {
        _chunks = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)regenerate
{
    for (NSUInteger i=0; i<_chunks.count; ++i) {
        SLTChunk* chunk = [_chunks objectAtIndex:i];
        assert(nil != chunk);
        [chunk generateContent];
    }
}

- (void)addChunk:(SLTChunk*)chunk
{
    [_chunks addObject:chunk];
}

@end
