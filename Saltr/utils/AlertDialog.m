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
#import <UIKit/UIWindow.h>

@interface AlertDialog () {
    UIViewController* _uiViewController;
    void (^_okHandler)(void);
}

@end

@implementation AlertDialog

- (id) init
{
    self = [super init];
    if (self) {
        _uiViewController = [[UIViewController alloc] init];
    }
    return self;
}

-(void) show:(NSString*)theTitle andMessage:(NSString*)theMessage
{
    UIAlertController * alert =   [UIAlertController
                                  alertControllerWithTitle:theTitle
                                  message:theMessage
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:DLG_ALERT_BUTTON_OK style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {
                                                       [alert dismissViewControllerAnimated:YES completion:nil];
                                                       if(nil != _okHandler) {
                                                           _okHandler();
                                                       }
                                                       _okHandler = nil;
                                                       
                                                   }];
    [alert addAction:ok];
    
    UIWindow* window =  [[[UIApplication sharedApplication] windows] lastObject];
    [window.rootViewController addChildViewController:_uiViewController];
    [_uiViewController presentViewController:alert animated:YES completion:^(void){[_uiViewController removeFromParentViewController];}];
}

- (void) show:(NSString*)theTitle message:(NSString*)theMessage andCallback:(void(^)(void))theCallback
{
    _okHandler = theCallback;
    [self show:theTitle andMessage:theMessage];
}

@end
