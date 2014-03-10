/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "Helper.h"

@implementation Helper


+(NSString *) formatString:(NSString *) formattedString1
                andString2:(NSString *)formattedString2
               andString3 :(NSString *)formattedString3 {
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"{[^;]*}" options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSString* mergedString = [[formattedString1 stringByAppendingString:formattedString2] stringByAppendingString:formattedString3];
    
    NSString *modifiedString1 = [regex stringByReplacingMatchesInString:mergedString options:0 range:NSMakeRange(0, [mergedString length]) withTemplate:@""];
    return modifiedString1;
}

@end
