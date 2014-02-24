//
//  PSLevelBoard.m
//  Saltr
//
//  Created by Instigate Mobile on 2/21/14.
//  Copyright (c) 2014 Plexonic. All rights reserved.
//

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
