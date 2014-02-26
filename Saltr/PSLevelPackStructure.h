/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import <Foundation/Foundation.h>

@interface PSLevelPackStructure : NSObject

@property (nonatomic, strong, readonly) NSString* token;
@property (nonatomic, strong, readonly) NSArray* levelStructureList;
@property (nonatomic, strong, readonly) NSString* index;

/**
 * @brief Inits instance of PSLevelPackStructure class with given token, levelStructureList and index
 *
 * @param theToken - levelPackStructure token
 * @param theDefaultProperties - levelPackStructure default properties
 * @param theProperties - levelPackStructure properties
 * @return - The instance of PSLevelPackStructure class
 */
-(id) initWithToken:(NSString*)theToken levelStructureList:(NSArray*)theLevelStructureList andIndex:(NSString*)theIndex;

@end
