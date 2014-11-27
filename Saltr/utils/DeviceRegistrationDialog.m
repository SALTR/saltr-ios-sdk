/*
 * @file DeviceRegistrationDialog.m
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "DeviceRegistrationDialog.h"

#import <UIKit/UIViewController.h>
#import <UIKit/UIAlertController.h>

@interface DeviceRegistrationDialog () {
    UIViewController* _uiViewController;
}

@end

@implementation DeviceRegistrationDialog

- (id) initWithUiViewController:(UIViewController*)uiViewController
{
    self = [super init];
    if (self) {
        _uiViewController = uiViewController;
    }
    return self;
}


-(void) show
{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:DLG_TITLE
                                  message:DLG_DEVICE_REGISTRATION_DESCRIPTION
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"Submit" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action) {
                                                   //Do Some action here
                                                   
                                               }];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {
                                                       [alert dismissViewControllerAnimated:YES completion:nil];
                                                   }];
    
    [alert addAction:ok];
    [alert addAction:cancel];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Username";
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Password";
    }];
    
    [_uiViewController presentViewController:alert animated:YES completion:nil];
}

@end
