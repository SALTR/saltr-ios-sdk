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

#define DLG_ALERT_DEVICE_REGISTRATION_TITLE @"Device Registration"
#define DLG_ALERT_BUTTON_OK @"Ok"

/// Protocol
@protocol AlertDialogProtocolDelegate <NSObject>

@required

- (void) show:(NSString*)theTitle andMessage:(NSString*)theMessage;

- (void) show:(NSString*)theTitle message:(NSString*)theMessage andCallback:(void(^)(void))theCallback;

@end

@class UIViewController;

@interface AlertDialog : NSObject <AlertDialogProtocolDelegate>

@end
