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

@implementation DeviceRegistrationDialogA

-(void) show
{
    UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:DLG_TITLE message:DLG_DEVICE_REGISTRATION_DESCRIPTION delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
    alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    [alert addButtonWithTitle:@"Login"];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        UITextField *username = [alertView textFieldAtIndex:0];
        NSLog(@"username: %@", username.text);
        
        UITextField *password = [alertView textFieldAtIndex:1];
        NSLog(@"password: %@", password.text);
        
    }
}

@end
