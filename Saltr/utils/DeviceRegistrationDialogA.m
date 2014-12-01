/*
 * @file DeviceRegistrationDialogA.m
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "DeviceRegistrationDialogA.h"

@interface DeviceRegistrationDialogA () {
    void (^_submitHandler)(NSString*);
}

@end

@implementation DeviceRegistrationDialogA

-(void) show
{
    UIAlertView* alert =[[UIAlertView alloc ] initWithTitle:DLG_DEVICE_REGISTRATION_TITLE message:DLG_DEVICE_REGISTRATION_DESCRIPTION delegate:self cancelButtonTitle:DLG_BUTTON_CANCEL otherButtonTitles: nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField* email = [alert textFieldAtIndex:0];
    email.placeholder = DLG_PROMPT_EMAIL;
    [alert addButtonWithTitle:DLG_BUTTON_SUBMIT];
    [alert show];
}

-(void) setSubmitHandler:(void(^)(NSString*))theSubmitHandler
{
    _submitHandler = theSubmitHandler;
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (1 == buttonIndex) {
        UITextField* email = [alertView textFieldAtIndex:0];
        _submitHandler(email.text);
    }
}

@end
