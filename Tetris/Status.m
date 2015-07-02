//
//  Status.m
//  Tetris
//
//  Created by 海野 竜也 on 2015/03/01.
//  Copyright (c) 2015年 海野 竜也. All rights reserved.
//

#import "Status.h"

@implementation Status

-(id)init{
    Block* bk = [[Block alloc]init];
    self = [super init];
    int ram = arc4random() % 6;
    _x = 4;
    _y = 0;
    _block = bk.array[ram];
    
    return self;
}

@end
