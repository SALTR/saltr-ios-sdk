/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import <Foundation/Foundation.h>

@class PSCell;
@class PSCompositeAsset;
@class PSLevelBoard;

@interface PSComposite : NSObject

@property (nonatomic, strong, readonly) PSLevelBoard* ownerLevelBoard;
@property (nonatomic, strong, readonly) NSString* compositeId;
@property (nonatomic, strong, readonly) PSCell* position;

- (id)initWithId:(NSString*)compositeId position:(PSCell*)position andOwnerLevelBoard:(PSLevelBoard*)theOwnerLevelBoard;

- (void)generate;

@end
