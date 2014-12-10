/*
 * @file AlertDialogA.m
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "AlertDialogA.h"

@interface AlertDialogA () {
    void (^_okHandler)(void);
}

@end

@implementation AlertDialogA

-(void) show:(NSString*)theTitle andMessage:(NSString*)theMessage
{
    UIAlertView* alert =[[UIAlertView alloc ] initWithTitle:theTitle message:theMessage delegate:self cancelButtonTitle:DLG_BUTTON_OK otherButtonTitles: nil];
    alert.alertViewStyle = UIAlertViewStyleDefault;
    [alert show];
}

-(void) setOkHandler:(void(^)(void))theOkHandler
{
    _okHandler = theOkHandler;
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(nil != _okHandler) {
        _okHandler();
    }
}

@end
