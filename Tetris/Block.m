//
//  Block.m
//  Tetris
//
//  Created by 海野 竜也 on 2015/03/01.
//  Copyright (c) 2015年 海野 竜也. All rights reserved.
//

#import "Block.h"

@implementation Block

-(id)init{
    self = [super init];
    
    _size = 4;
    _array = [NSMutableArray arrayWithObjects:[NSMutableArray arrayWithObjects:
              [NSMutableArray arrayWithObjects:@0,@0,@0,@0, nil],
              [NSMutableArray arrayWithObjects:@0,@1,@1,@0, nil],
              [NSMutableArray arrayWithObjects:@0,@1,@1,@0, nil],
              [NSMutableArray arrayWithObjects:@0,@0,@0,@0, nil],nil],
             [NSMutableArray arrayWithObjects:
              [NSMutableArray arrayWithObjects:@0,@2,@0,@0, nil],
              [NSMutableArray arrayWithObjects:@0,@2,@0,@0, nil],
              [NSMutableArray arrayWithObjects:@0,@2,@0,@0, nil],
              [NSMutableArray arrayWithObjects:@0,@2,@0,@0, nil], nil],
            [NSMutableArray arrayWithObjects:
             [NSMutableArray arrayWithObjects:@0,@0,@0,@0, nil],
             [NSMutableArray arrayWithObjects:@0,@3,@3,@0, nil],
             [NSMutableArray arrayWithObjects:@3,@3,@0,@0, nil],
             [NSMutableArray arrayWithObjects:@0,@0,@0,@0, nil], nil],
            [NSMutableArray arrayWithObjects:
             [NSMutableArray arrayWithObjects:@0,@0,@0,@0, nil],
             [NSMutableArray arrayWithObjects:@4,@4,@0,@0, nil],
             [NSMutableArray arrayWithObjects:@0,@4,@4,@0, nil],
             [NSMutableArray arrayWithObjects:@0,@0,@0,@0, nil], nil],
            [NSMutableArray arrayWithObjects:
             [NSMutableArray arrayWithObjects:@0,@0,@0,@0, nil],
             [NSMutableArray arrayWithObjects:@5,@0,@0,@0, nil],
             [NSMutableArray arrayWithObjects:@5,@5,@5,@0, nil],
             [NSMutableArray arrayWithObjects:@0,@0,@0,@0, nil], nil],
            [NSMutableArray arrayWithObjects:
             [NSMutableArray arrayWithObjects:@0,@0,@0,@0, nil],
             [NSMutableArray arrayWithObjects:@0,@0,@6,@0, nil],
             [NSMutableArray arrayWithObjects:@6,@6,@6,@0, nil],
             [NSMutableArray arrayWithObjects:@0,@0,@0,@0, nil], nil],
            [NSMutableArray arrayWithObjects:
             [NSMutableArray arrayWithObjects:@0,@0,@0,@0, nil],
             [NSMutableArray arrayWithObjects:@0,@7,@0,@0, nil],
             [NSMutableArray arrayWithObjects:@7,@7,@7,@0, nil],
             [NSMutableArray arrayWithObjects:@0,@0,@0,@0, nil], nil],
              nil];
    return self;
}

@end
