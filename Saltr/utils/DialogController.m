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
    id <DeviceRegistrationDialogProtocolDelegate> _deviceRegistrationDialog;
}

@end

@implementation DialogController

- (id) initWithUiViewController:(UIViewController*)uiViewController
{
    self = [super init];
    if (self) {
        //float systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
        //anakonda
        _deviceRegistrationDialog = [[DeviceRegistrationDialogA alloc] init];
        /*if (systemVersion >= 8.0) {
            _deviceRegistrationDialog = [[DeviceRegistrationDialog alloc] initWithUiViewController:uiViewController];
        } else {
            _deviceRegistrationDialog = [[DeviceRegistrationDialogA alloc] init];
        }*/
    }
    return self;
}

- (void) showDeviceRegistrationDialog
{
    [_deviceRegistrationDialog show];
}

@end
