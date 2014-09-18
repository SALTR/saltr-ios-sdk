/*
 * @file
 * SLTBoardLayer.h
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import <Foundation/Foundation.h>

/// Protocol
@protocol SLTBoardLayerDelegate <NSObject>

@required

-(void) regenerate;

@end

@interface SLTBoardLayer : NSObject <SLTBoardLayerDelegate>

@property (nonatomic, strong, readonly) NSString* token;

@property (nonatomic, assign, readonly) NSInteger index;

-(id) initWithToken:(NSString*)theToken andLayerIndex:(NSInteger)theLayerIndex;

@end
