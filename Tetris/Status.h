//
//  Status.h
//  Tetris
//
//  Created by 海野 竜也 on 2015/03/01.
//  Copyright (c) 2015年 海野 竜也. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Block.h"

@interface Status : NSObject

@property(nonatomic)float x;
@property(nonatomic)float y;
@property(nonatomic)NSMutableArray* block;
@end
