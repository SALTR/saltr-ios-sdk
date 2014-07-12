/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "SLTCell.h"

@interface SLTCell() {
    NSMutableDictionary* _instancesByLayerId;
    NSMutableDictionary* _instancesByLayerIndex;
}
@end

@implementation SLTCell

@synthesize col = _col;
@synthesize row = _row;
@synthesize isBlocked = _isBlocked;
@synthesize properties = _properties;

-(id) initWithCol:(NSInteger)col andRow:(NSInteger)row
{
    self = [super init];
    if (self) {
        _col = col;
        _row = row;
        _properties = [NSMutableDictionary new];
        _isBlocked = false;
        _instancesByLayerId = [NSMutableDictionary new];
        _instancesByLayerIndex = [NSMutableDictionary new];
    }
    return self;
}

-(SLTAssetInstance*) getAssetInstanceByLayerId:(NSString*)layerId
{
    return [_instancesByLayerId objectForKey:layerId];
}

-(SLTAssetInstance*) getAssetInstanceByLayerIndex:(NSInteger)layerIndex
{
    return [_instancesByLayerIndex objectForKey:[@(layerIndex) stringValue]];
    
}

-(void) setAssetInstanceByLayerId:(NSString*)theLayerId layerIndex:(NSInteger)theLayerIndex andAssetInstance:(SLTAssetInstance*)theAssetInstance
{
    if(_isBlocked == false){
        [_instancesByLayerId setObject:theAssetInstance forKey:theLayerId];
        [_instancesByLayerIndex setObject:theAssetInstance forKey:[@(theLayerIndex) stringValue]];
    }
}

-(void) removeAssetInstanceByLayerId:(NSString*)theLayerId andLayerIndex:(NSInteger)theLayerIndex
{
    [_instancesByLayerId removeObjectForKey:theLayerId];
    [_instancesByLayerIndex removeObjectForKey:[@(theLayerIndex) stringValue]];
}

//-(NSString *)description
//{
//    return [NSString stringWithFormat:@"[coords: (%d , %d)], [isblocked: %i], [properties: %@], [assetInstance: %@]", self.x, self.y, self.isBlocked,self.properties, self.assetInstance];
//}

@end
