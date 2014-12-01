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
    void (^_submitHandler)(NSString*);
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
                                  alertControllerWithTitle:DLG_DEVICE_REGISTRATION_TITLE
                                  message:DLG_DEVICE_REGISTRATION_DESCRIPTION
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* submit = [UIAlertAction actionWithTitle:DLG_BUTTON_SUBMIT style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action) {
                                                        [alert dismissViewControllerAnimated:YES completion:nil];
                                                            UITextField* email = alert.textFields[0];
                                                            _submitHandler(email.text);
                                                   
                                               }];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:DLG_BUTTON_CANCEL style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {
                                                       [alert dismissViewControllerAnimated:YES completion:nil];
                                                   }];
    
    [alert addAction:cancel];
    [alert addAction:submit];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = DLG_PROMPT_EMAIL;
    }];
    
    [_uiViewController presentViewController:alert animated:YES completion:nil];
}

-(void) setSubmitHandler:(void(^)(NSString*))theSubmitHandler
{
    _submitHandler = theSubmitHandler;
}

@end
