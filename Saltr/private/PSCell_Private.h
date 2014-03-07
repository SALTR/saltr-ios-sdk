//
//  PSCell_Private.h
//  Saltr
//
//  Created by employee on 3/7/14.
//  Copyright (c) 2014 Plexonic. All rights reserved.
//

#import "PSCell.h"

@interface PSCell ()

@property (nonatomic, assign, readwrite) BOOL isBlocked;
@property (nonatomic, strong, readwrite) NSDictionary* properties;
@property (nonatomic, strong, readwrite) PSAssetInstance* assetInstance;

@end
