/*
 * @file Utils.h
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import <Foundation/Foundation.h>

@interface Utils : NSObject

/** Formats a String in .Net-style, with curly braces ("{0}"). Does not support any
 *  number formatting options yet. */
+ (NSString*) formatString:(NSString*)theFormat args:(NSArray*)theArgs;

@end
