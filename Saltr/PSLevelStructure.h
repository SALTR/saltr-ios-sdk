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

@interface PSLevelStructure : NSObject


@property (nonatomic, strong, readonly) NSString* levelId;
@property (nonatomic, strong, readonly) NSString* dataUrl;
@property (nonatomic, assign, readonly) NSInteger index;
@property (nonatomic, strong, readonly) id properties;
//TODO review the dataFetched property, whether it is really needed
@property (nonatomic, assign, readonly) BOOL dataFetched;
@property (nonatomic, strong, readonly) id keyset;
@property (nonatomic, strong, readonly) NSString* version;


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
-(id) initWithLevelId:(NSString*)theId index:(NSInteger)theIndex dataUrl:(NSString*)theDataUrl properties:(id)theProperties andVersion:(NSString*)theVersion;

/**
 *
 */
- (void)parseData:(id)data;

/**
 *
 */
- (NSString*)boardWithId:(NSString*)boardId;

/**
 *
 */
- (id)innerProperties;



@end
