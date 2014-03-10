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

@class PSBoardData;

@interface PSLevelStructure : NSObject

@property (nonatomic, strong, readonly) NSString* levelId;
@property (nonatomic, strong, readonly) NSString* dataUrl;
@property (nonatomic, strong, readonly) NSString* index;
@property (nonatomic, strong, readonly) NSDictionary* properties;
@property (nonatomic, strong, readonly) PSBoardData* boardData;
@property (nonatomic, strong, readonly) NSString* version;
@property (nonatomic, strong, readonly) NSDictionary* innerProperties;
@property (nonatomic, strong, readonly) NSMutableDictionary* boards;

/**
 * @brief Inits instance of PSLevelStructure class with given id, index, dataUrl, properties and version
 *
 * @param theId - levelStructure id
 * @param theIndex - levelStructure index
 * @param theDataUrl - levelStructure dataUrl
 * @param theProperties - levelStructure properties
 * @param theVersion - levelStructure version
 * @return - The instance of PSLevelStructure class
 */
-(id) initWithLevelId:(NSString*)theId index:(NSString *)theIndex dataUrl:(NSString*)theDataUrl properties:(id)theProperties andVersion:(NSString*)theVersion;

/**
 *
 */
- (NSString*)boardWithId:(NSString*)boardId;

@end
