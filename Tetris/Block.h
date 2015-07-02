//
//  Block.h
//  Tetris
//
//  Created by 海野 竜也 on 2015/03/01.
//  Copyright (c) 2015年 海野 竜也. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Block : NSObject

@property(nonatomic)int size;
@property(nonatomic)NSInteger width;
@property(nonatomic)NSInteger height;
@property(nonatomic)NSMutableArray* array;
@end
