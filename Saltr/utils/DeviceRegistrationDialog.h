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
#define DLG_BUTTON_CANCEL @"Cancel"

#define DLG_DEVICE_REGISTRATION_TITLE @"Register Device with SALTR"
#define DLG_DEVICE_REGISTRATION_DESCRIPTION @""

#define DLG_EMAIL_NOT_VALID @"Please insert valid Email."
//#define DLG_SUBMIT_SUCCESSFUL @"Your data has been successfully submitted."
#define DLG_SUBMIT_FAILED @"Your data has not been submitted."
//#define DLG_SUBMIT_IN_PROCESS @"Your data submitting in progress."

#define DLG_PROMPT_EMAIL @"example@mail.com"

/// Protocol
@protocol DeviceRegistrationDialogProtocolDelegate <NSObject>

@required

-(void) show;

-(void) setSubmitHandler:(void(^)(NSString*))theSubmitHandler;

@end


@class UIViewController;

@interface DeviceRegistrationDialog : NSObject <DeviceRegistrationDialogProtocolDelegate>

- (id) initWithUiViewController:(UIViewController*)uiViewController;

@end
