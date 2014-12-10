/*
 * @file AlertDialog.m
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "AlertDialog.h"

#import <UIKit/UIViewController.h>
#import <UIKit/UIAlertController.h>

@interface AlertDialog () {
    UIViewController* _uiViewController;
    void (^_okHandler)(void);
}

@end

@implementation AlertDialog

- (id) initWithUiViewController:(UIViewController*)uiViewController
{
    self = [super init];
    if (self) {
        _uiViewController = uiViewController;
    }
    return self;
}

-(void) show:(NSString*)theTitle andMessage:(NSString*)theMessage
{
    UIAlertController * alert =   [UIAlertController
                                  alertControllerWithTitle:theTitle
                                  message:theMessage
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:DLG_BUTTON_OK style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {
                                                       [alert dismissViewControllerAnimated:YES completion:nil];
                                                       if(nil != _okHandler) {
                                                           _okHandler();
                                                       }
                                                       
                                                   }];
    [alert addAction:ok];
    
    [_uiViewController presentViewController:alert animated:YES completion:nil];
}

-(void) setOkHandler:(void(^)(void))theOkHandler
{
    _okHandler = theOkHandler;
}

@end
