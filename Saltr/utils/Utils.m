/*
 * @file Utils.m
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "Utils.h"

@implementation Utils

+ (NSString*) formatString:(NSString*)theFormat args:(NSArray*)theArgs
{
    for(NSUInteger i = 0; i< [theArgs count]; ++i) {
        NSString* pattern = [NSString stringWithFormat:@"%@%i%@", @"{", i, @"}"];
        
        theFormat = [theFormat stringByReplacingOccurrencesOfString:pattern withString:[theArgs objectAtIndex:i] ];
    }
    
    return theFormat;
}

@end
