/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "SLTBoard.h"

@interface SLT2DBoard : SLTBoard

/// The width.
@property (nonatomic, strong, readonly) NSNumber* width;

/// The height.
@property (nonatomic, strong, readonly) NSNumber* height;

/**
 * @brief Inits an instance of @b SLT2DBoard class with the given width, height, layers and properties
 *
 * @param theWidth - the width
 * @param theHeight - the height
 * @param theLayers - the layers
 * @param theProperties - the properties
 * @return - The instance of @b SLT2DBoard class
 */
- (id) initWithWidth:(NSNumber * )theWidth theHeight:(NSNumber *)theHeight layers:(NSMutableArray*)theLayers andProperties:(NSDictionary*)theProperties;

@end
