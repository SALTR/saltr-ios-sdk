/*
 * @file AlertDialog.h
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import <Foundation/Foundation.h>

#define DLG_BUTTON_OK @"Ok"

/// Protocol
@protocol AlertDialogProtocolDelegate <NSObject>

@required

-(void) show:(NSString*)theTitle andMessage:(NSString*)theMessage;

-(void) setOkHandler:(void(^)(void))theOkHandler;

@end

@class UIViewController;

@interface AlertDialog : NSObject <AlertDialogProtocolDelegate>

- (id) initWithUiViewController:(UIViewController*)uiViewController;

@end
