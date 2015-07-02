//
//  ViewController.m
//  Tetris
//
//  Created by 海野 竜也 on 2015/03/01.
//  Copyright (c) 2015年 海野 竜也. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    
    int width;
    int height;
    NSMutableArray* map;
    NSMutableArray* temp_bk;
    UIImageView* wall;
    UIImageView* block;
    UIView *uv;
    float speed;
    NSTimer *timer;
    Block* bk;
    Status* status;
    int landingCount;
    UITapGestureRecognizer* tap;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *lImg = [UIImage imageNamed:@"left_try.png"];
    UIImage *rImg = [UIImage imageNamed:@"right_try.png"];
    UIImage *uImg = [UIImage imageNamed:@"under_try.png"];
    UIButton *lButton = [[UIButton alloc]init];
    UIButton *rButton = [[UIButton alloc]init];
    UIButton *uButton = [[UIButton alloc]init];
    [lButton setBackgroundImage:lImg forState:UIControlStateNormal];
    [rButton setBackgroundImage:rImg forState:UIControlStateNormal];
    [uButton setBackgroundImage:uImg forState:UIControlStateNormal];
    lButton.frame = CGRectMake(40, self.view.frame.size.height - 80, 60, 60);
    rButton.frame = CGRectMake(self.view.frame.size.width - 100, self.view.frame.size.height - 80, 60, 60);
    uButton.frame = CGRectMake((self.view.frame.size.width / 2) - 30, self.view.frame.size.height - 60, 60, 60);
    [lButton addTarget:self action:@selector(lButton_tapped:) forControlEvents:UIControlEventTouchDown];
    [rButton addTarget:self action:@selector(rButton_tapped:) forControlEvents:UIControlEventTouchDown];
    [uButton addTarget:self action:@selector(uButton_tapped:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:lButton];
    [self.view addSubview:rButton];
    [self.view addSubview:uButton];
    uv = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 100)];
    [self.view addSubview:uv];
    width = 12;
    height = 21;
    map = [[NSMutableArray alloc] init];
    speed = 0.05;
    timer = [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(update:) userInfo:nil repeats:YES];
    bk = [[Block alloc]init];
    status = [[Status alloc]init];
    temp_bk = [[NSMutableArray alloc]init];
    landingCount = 10;
    tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapGes:)];
    [self.view addGestureRecognizer:tap];
    self.view.backgroundColor = [UIColor blackColor];
    for (int y = 0; y < height; y++){
        if (y == height-1){
            [map addObject:[NSMutableArray arrayWithObjects:@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1, nil]];
        }else{
            [map addObject:[NSMutableArray arrayWithObjects:@1,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@1, nil]];
        }
    }
    
    [self update_draw];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//ブロックが接触した時の処理
-(BOOL)check:(int)y x:(int)x{
    temp_bk = status.block;
    for (int by = 0; by < bk.size; by++) {
        for (int bx = 0; bx < bk.size; bx++) {
            if ([(NSNumber*)temp_bk[by][bx] intValue] && [(NSNumber*)map[y + by][x + bx] intValue]){
                return true;
            }
        }
    }
    return false;
}

-(void)endProcess{
    [timer invalidate];
    [self lock];
    [self deleteLine];
    [self draw];
    status = [[Status alloc]init];
    //landingCount = 10;
    
    if ([self check:status.y x:status.x]) {
        [self gameOver];
    }else{
        timer = [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(update:) userInfo:nil repeats:YES];
    }
    
}

//壁と固定されたブロックの描画
-(void)update_draw{
    for (int y = 0; y < height; y++){
        for (int x = 0; x < width; x++) {
            if ([(NSNumber*)map[y][x] intValue] > 0) {
                if (x == 0 || y == height -1 || x == width - 1 ) {
                    wall = [UIImageView new];
                    wall.image = [UIImage imageNamed:@"WallBlock.png"];
                    wall.frame = CGRectMake(x * uv.frame.size.width / width, y * uv.frame.size.height / height, uv.frame.size.width / width, uv.frame.size.width / width);
                    [uv addSubview:wall];
                }else{
                    block = [UIImageView new];
                    block.image = [UIImage imageNamed:@"Block.png"];
                    block.frame = CGRectMake(x * uv.frame.size.width /width, y * uv.frame.size.height / height,uv.frame.size.width / width, uv.frame.size.width / width );
                    [uv addSubview:block];
                }
            }
        }
    }
}


-(void)update:(NSTimer *)timer{
    status.y += 0.5;
    
    if ([self check:status.y + 1 x:status.x]){
        status.y = (int)status.y;
    }
    
    //着地してから固定されるまでのタイムラグ
    if ([self check:status.y + 1 x:status.x]) {
        //if (--landingCount <= 0) {
            [self endProcess];
        //}
    }/*else{
        landingCount = 10;
    }*/
    [self draw];
}


-(void)draw{
    for (UIView* view in [uv subviews]){
        [view removeFromSuperview];
    }
    
    [self update_draw];
    //NSLog(@"y = %ld, x = %ld",(long)status.y,(long)status.x);
    int bkSize = bk.size;
    for(int y = 0; y < bkSize; y++){
        for (int x = 0; x < bkSize; x++) {
            if ([(NSNumber* )status.block[y][x] intValue] > 0) {
                block = [UIImageView new];
                block.image = [UIImage imageNamed:@"Block.png"];
                block.frame = CGRectMake((x + status.x) * uv.frame.size.width /width, (y + status.y) * uv.frame.size.height / height,uv.frame.size.width / width, uv.frame.size.width / width );
                [uv addSubview:block];
                
                UIImageView* nextBk = [UIImageView new];
                nextBk.image = [UIImage imageNamed:@"Block2.png"];
                nextBk.frame = CGRectMake((x + status.x) * uv.frame.size.width /width, (y + [self getDropPosition]) * uv.frame.size.height / height,uv.frame.size.width / width, uv.frame.size.width / width );
                [uv addSubview:nextBk];
            }
        }
    }
    
}

-(void)lock{
    temp_bk = status.block;
    for(int y = 0; y < bk.size; y++){
        for (int x = 0; x < bk.size; x++) {
            if ([(NSNumber*)temp_bk[y][x] intValue]) {
                map[(int)status.y + y][(int)status.x + x] = temp_bk[y][x];
            }
        }
    }
}

-(void)lButton_tapped:(id)sender{
    if (![self check:ceilf(status.y) x:status.x - 1] && ![self check:floorf(status.x) x:status.x - 1]) {
        status.x--;
    }
}

-(void)rButton_tapped:(id)sender{
    if (![self check:ceilf(status.y) x:status.x + 1] && ![self check:floorf(status.x) x:status.x + 1]) {
        status.x++;
    }
}

-(void)uButton_tapped:(id)sender{
    status.y = [self getDropPosition];
}


-(void)gameOver{
    NSLog(@"gameOver");
}

-(void)deleteLine{
    for (int y = height - 2; y >= 0; y--) {
        bool flg = true;
        for (int x = 1; x <= width - 2; x++) {
            //NSLog(@"x = %d, y = %d, flg = %d",x,y,[(NSNumber*)map[y][x] intValue]);
            if ([(NSNumber*)map[y][x] intValue] == 0) {
                //NSLog(@"flg = %d",[(NSNumber*)map[y][x] intValue]);
                flg = false;
                break;
            }
        }
        
        if (flg == true) {
            NSLog(@"flg");
            for (int y2 = y - 1 ;y2 >= 0 ; y2--) {
                for (int x = 1; x <= width - 2; x++) {
                    map[y2 + 1][x] = map[y2][x];
                }
            }
            y++;
        }
    }
}

-(int)getDropPosition{
    for (int y = status.y; y < height- 1 ; y++) {
        if ([self check:y x:status.x]) {
            return y - 1;
        }
    }
    return 0;
}

-(void)TapGes:(UITapGestureRecognizer* )gasture{
    NSMutableArray* copyArray = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:status.block]];
    
    for (int y = 0; y < bk.size; y++){
        for (int x = 0; x < bk.size; x++){
            copyArray[x][bk.size - 1 - y] = status.block[y][x];
        }
    }
    status.block = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:copyArray]];
    
    if ([self check:status.y x:status.x]) {
        for (int y = 0; y < bk.size; y++){
            for (int x = 0; x < bk.size; x++){
                copyArray[bk.size - 1 - x][y] = status.block[y][x];
            }
        }
        status.block = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:copyArray]];
    }
}

@end
