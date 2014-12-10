/*
 * @file DialogController.m
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "DialogController.h"
#import "DeviceRegistrationDialog.h"
#import "DeviceRegistrationDialogA.h"
#import "AlertDialog.h"
#import "AlertDialogA.h"
#import "Utils.h"
#import <UIKit/UIViewController.h>

@interface DialogController () {
    void (^_addDeviceHandler)(NSString*);
    id <DeviceRegistrationDialogProtocolDelegate> _deviceRegistrationDialog;
    id <AlertDialogProtocolDelegate> _alertDialog;
}

@end

@implementation DialogController

- (id) initWithUiViewController:(UIViewController*)uiViewController andAddDeviceHandler:(void(^)(NSString*))addDeviceHandler
{
    self = [super init];
    if (self) {
        void (^devRegisterSubmitHandler)(NSString*) = ^(NSString* theEmail) {
            [self deviceRegistrationSubmitHandler:theEmail];
        };
        
        _addDeviceHandler = addDeviceHandler;
        //float systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
        //anakonda
        _deviceRegistrationDialog = [[DeviceRegistrationDialog alloc] initWithUiViewController:uiViewController];
        _alertDialog = [[AlertDialog alloc] initWithUiViewController:uiViewController];
        /*if (systemVersion >= 8.0) {
            _deviceRegistrationDialog = [[DeviceRegistrationDialog alloc] initWithUiViewController:uiViewController];
            _alertDialog = [[AlertDialog alloc] initWithUiViewController:uiViewController];
        } else {
            _deviceRegistrationDialog = [[DeviceRegistrationDialogA alloc] init];
            _alertDialog = [[AlertDialogA alloc] init];
        }*/
        [_deviceRegistrationDialog setSubmitHandler:devRegisterSubmitHandler];
    }
    return self;
}

- (void) showDeviceRegistrationDialog
{
    [_deviceRegistrationDialog show];
}

- (void) showAlertDialogWithTitile:(NSString*)theTitle andMessage:(NSString*)theMessage
{
    [_alertDialog show:theTitle andMessage:theMessage];
}

- (void) showAlertDialogWithTitile:(NSString*)theTitle message:(NSString*)theMessage andCallback:(void(^)(void))theCallback
{
    [_alertDialog show:theTitle message:theMessage andCallback:theCallback];
}

- (void) deviceRegistrationSubmitHandler:(NSString*)theEmail
{
    if ([Utils checkEmailValidation:theEmail]) {
        _addDeviceHandler(theEmail);
    } else {
        void (^incorrectEmailHandler)(void) = ^(void) {
            [self showDeviceRegistrationDialog];
        };
        [self showAlertDialogWithTitile:DLG_ALERT_DEVICE_REGISTRATION_TITLE message:DLG_EMAIL_NOT_VALID andCallback:incorrectEmailHandler];
    }
}

@end
