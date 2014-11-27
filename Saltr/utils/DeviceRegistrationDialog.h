/*
 * @file DeviceRegistrationDialog.h
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import <Foundation/Foundation.h>

#define DLG_BUTTON_SUBMIT @"Submit"
#define DLG_BUTTON_CLOSE @"Close"
#define DLG_TITLE @"Device Registration"
#define DLG_DEVICE_REGISTRATION_DESCRIPTION @"Please insert your E-mail and device name"
#define DLG_EMAIL_NOT_VALID @"Please insert valid Email."
#define DLG_SUBMIT_SUCCESSFUL @"Your data has been successfully submitted."
#define DLG_SUBMIT_FAILED @"Your data has not been submitted."
#define DLG_SUBMIT_IN_PROCESS @"Your data submitting in progress."
#define DLG_NAME_NOT_VALID @"Please insert device name."
#define DLG_BOTH_NOT_VALID @"Please insert device name and valid Email."

#define DLG_PROMPT_EMAIL @"Valid E-mail"
#define DLG_PROMPT_DEVICE_NAME @"Device name"

/// Protocol
@protocol DeviceRegistrationDialogProtocolDelegate <NSObject>

@required

-(void) show;

@end


@class UIViewController;

@interface DeviceRegistrationDialog : NSObject <DeviceRegistrationDialogProtocolDelegate>

- (id) initWithUiViewController:(UIViewController*)uiViewController;

@end
