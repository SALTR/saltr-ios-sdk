/*
 * @file
 * Saltr
 *
 * Copyright Teoken LLC. (c) 2014. All rights reserved.
 * Copying or usage of any piece of this source code without written notice from Teoken LLC is a major crime.
 * Այս կոդը Թեոկեն ՍՊԸ ընկերության սեփականությունն է:
 * Առանց գրավոր թույլտվության այս կոդի պատճենահանումը կամ օգտագործումը քրեական հանցագործություն է:
 */

#import "PSLevelBoard.h"

@implementation PSLevelBoard

-(id) initWithRowBoard:(id)rowBoard andBoardData:(PSBoardData *)boardData {
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void) regenerateChunks {
    
}

-(NSDictionary *)composites {
    return [NSDictionary dictionary];
}

-(NSDictionary *) chunks {
    return [NSDictionary dictionary];
}

-(NSInteger) countOfRows {
    return -1;
}

-(NSInteger) countOfColumns {
    return  -1;
}

-(NSArray *) blockedCells {
    return [NSArray array];
}

-(NSArray *) position {
    return [NSArray array];
}

-(NSArray *) properties {
    return [NSArray array];
}

-(PSVector2D *) boardVector {
    return [[PSVector2D alloc] init];
}

-(PSBoardData *) boardData {
    return [[PSBoardData alloc] init];
}

@end
