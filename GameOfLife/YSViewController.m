//
//  YSViewController.m
//  GameOfLife
//
//  Created by Yair Szarf on 1/23/14.
//  Copyright (c) 2014 The 2 Handed Consortium. All rights reserved.
//

#import "YSViewController.h"
#import "YSGrid.h"

@interface YSViewController ()

@property (nonatomic) YSGrid *grid;
@property (nonatomic) NSMutableArray * gridButtonRows; //of coulmns

@end

@implementation YSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.grid = [[YSGrid alloc] init];

    
    for(int xCount = 0 ; xCount< self.grid.xSize ;  xCount++){
        
        NSMutableArray * column = [NSMutableArray new];
        
        for(int yCount = 0 ; yCount < self.grid.ySize ; yCount++ ){
          
            UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            float x = ((self.view.frame.size.width/self.grid.xSize) * xCount);
            float y = ((self.view.frame.size.height/self.grid.ySize)*yCount);
            float width = (self.view.frame.size.width/self.grid.xSize);
            float height = (self.view.frame.size.height/self.grid.ySize);
            NSLog(@"%d,%d",xCount,yCount);
            NSLog(@"%f,%f,%f,%f",x, y, width, height);
            button.frame = CGRectMake(x, y, width, height);
            button.backgroundColor = [UIColor blueColor];
            [button setTitle:@"A" forState:UIControlStateNormal] ;
            [column addObject:button];
            [self.view addSubview:button];
        }
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
