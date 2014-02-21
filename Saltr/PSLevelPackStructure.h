//
//  PSLevelPackStructure.h
//  Saltr
//
//  Created by Instigate Mobile on 2/18/14.
//  Copyright (c) 2014 Plexonic. All rights reserved.
//

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
