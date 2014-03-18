/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "SLTCompositeAsset.h"

@implementation SLTCompositeAsset

@synthesize cellInfos = _cellInfos;

- (id)initWithCellInfos:(NSArray*)theCellInfos type:(NSString*)theType andKeys:(NSDictionary*)theKeys
{
    self = [super initWithType:theType andKeys:theKeys];
    if (self) {
        _cellInfos = theCellInfos;
    }
    return  self;
}

- (NSString *)description
{
    NSString* superDescription = [super description];
    return [NSString stringWithFormat: @"PSCompositeAsset : [cellInfos : %@], %@ ", self.cellInfos, superDescription];
}

- (BOOL)isEqual:(SLTCompositeAsset*)object
{
    if (object == self) {
        return YES;
    }
    return [super isEqual:object] && [self.cellInfos isEqual:object.cellInfos];
}

@end
