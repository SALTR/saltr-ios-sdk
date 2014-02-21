//
//  PSLevelStructure.h
//  Saltr
//
//  Created by Instigate Mobile on 2/18/14.
//  Copyright (c) 2014 Plexonic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PSLevelStructure : NSObject


@property (nonatomic, strong, readonly) NSString* levelId;
@property (nonatomic, strong, readonly) NSString* dataUrl;
@property (nonatomic, assign, readonly) NSInteger index;
@property (nonatomic, strong, readonly) NSObject* properties;
//TODO review the dataFetched property, whether it is really needed
@property (nonatomic, assign, readonly) BOOL dataFetched;
@property (nonatomic, strong, readonly) NSObject* keyset;
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
-(id) initWithLevelId:(NSString*)theId index:(NSInteger)theIndex dataUrl:(NSString*)theDataUrl properties:(NSObject*)theProperties andVersion:(NSString*)theVersion;

/**
 *
 */
- (void)parseData:(NSObject*)data;

/**
 *
 */
- (NSString*)boardWithId:(NSString*)boardId;

/**
 *
 */
- (NSObject*)innerProperties;



@end
