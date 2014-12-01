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
#import <UIKit/UIViewController.h>

@interface DialogController () {
    void (^_addDeviceHandler)(NSString*);
    id <DeviceRegistrationDialogProtocolDelegate> _deviceRegistrationDialog;
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
        /*if (systemVersion >= 8.0) {
            _deviceRegistrationDialog = [[DeviceRegistrationDialog alloc] initWithUiViewController:uiViewController];
        } else {
            _deviceRegistrationDialog = [[DeviceRegistrationDialogA alloc] init];
        }*/
        [_deviceRegistrationDialog setSubmitHandler:devRegisterSubmitHandler];
    }
    return self;
}

- (void) showDeviceRegistrationDialog
{
    [_deviceRegistrationDialog show];
}

- (void) deviceRegistrationSubmitHandler:(NSString*)theEmail
{
    //anakonda
    _addDeviceHandler(theEmail);
}

@end
