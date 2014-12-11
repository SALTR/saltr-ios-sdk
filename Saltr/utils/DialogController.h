/*
 * @file DialogController.h
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import <Foundation/Foundation.h>

@class UIViewController;

@interface DialogController : NSObject

- (id) initWithUiViewController:(UIViewController*)uiViewController andAddDeviceHandler:(void(^)(NSString*))addDeviceHandler;

- (void) showDeviceRegistrationDialog;

- (void) showAlertDialogWithTitile:(NSString*)theTitle andMessage:(NSString*)theMessage;

- (void) showAlertDialogWithTitile:(NSString*)theTitle message:(NSString*)theMessage andCallback:(void(^)(void))theCallback;

- (void) showDeviceRegistrationFailStatus:(NSString*)theStatus;

@end
