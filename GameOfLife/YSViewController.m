//
//  YSViewController.m
//  GameOfLife
//
//  Created by Yair Szarf on 1/23/14.
//  Copyright (c) 2014 The 2 Handed Consortium. All rights reserved.
//

#import "YSViewController.h"
#import "YSGrid.h"
#import "YSButton.h"
#import "YSCell.h"
#define DIMENSION 20
#define DEFAULT_SPEED 0.1

@interface YSViewController ()

@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (nonatomic) YSGrid *grid;
@property (nonatomic) NSMutableArray * gridButtonRows; //of coulmns
@property (nonatomic) BOOL isRunning;
@property (strong, nonatomic) NSOperationQueue *gameQueue;
@property (weak, nonatomic) IBOutlet UISlider *speedSlider;
@property (strong, nonatomic) NSTimer *timer;
@property float speed;
@end

@implementation YSViewController

- (IBAction)sliderChanged:(UISlider *)sender {
    
    self.speed = self.speedSlider.value;
    [self.timer invalidate];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 - self.speed target:self selector:@selector(tick) userInfo:Nil repeats:YES];
}

- (void)tick {
    [self.gameQueue addOperationWithBlock:^{
        //            while (self.isRunning) {
        [self.grid cycleOnce];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self updateUI];
        }];
    }];

}

- (IBAction)startButtonPressed:(UIButton *)sender {
    self.gameQueue = [NSOperationQueue new];
    self.isRunning = !self.isRunning;
    if (self.isRunning) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 - self.speed target:self selector:@selector(tick) userInfo:Nil repeats:YES];
        [self.timer fire];
    } else {
        self.startButton.titleLabel.text = @"Stop";
        [self.timer invalidate];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //find out what is the size of grid
    self.grid = [[YSGrid alloc] initWithXSize:DIMENSION andYSize:DIMENSION];
    float cellDimension = (self.view.frame.size.width/DIMENSION);
    
    
    self.gridButtonRows = [NSMutableArray new];
    
    for(int xCount = 0 ; xCount< self.grid.xSize ;  xCount++){
        
        NSMutableArray * column = [NSMutableArray new];
        
        for(int yCount = 0 ; yCount < self.grid.ySize ; yCount++ ){
          
            YSButton * button = [YSButton buttonWithType:UIButtonTypeRoundedRect];
            button.titleLabel.text = @"a";
            button.xIndex = xCount;
            button.yIndex = yCount;
            button.cell = [self.grid getCellForIndexPath:xCount andY:yCount];
            
            float x = ((self.view.frame.size.width/cellDimension) * xCount);
            float y = ((self.view.frame.size.width/cellDimension) * yCount+50);
            NSLog(@"%d,%d",xCount,yCount);
            NSLog(@"%f,%f,%f",x, y, cellDimension);
            button.frame = CGRectMake(x*2, y*2, cellDimension, cellDimension);
            button.backgroundColor = [UIColor blueColor];
            [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [column addObject:button];
            [self.view addSubview:button];
        }
        
        [self.gridButtonRows addObject:column];
        
        
    }
    
}

-(void)buttonPressed:(UIButton*)sender{
    YSButton *button = (YSButton *)sender;
    [self.grid toggleCellAtIndexPath:button.xIndex andY:button.yIndex];
    [self updateUI];
}

-(void)updateUI
{
    for (NSArray *column in self.gridButtonRows) {
        for (YSButton *button in column) {
            if (button.cell.isAlive)
            {
                button.backgroundColor = [UIColor purpleColor];
            }
            else
            {
                button.backgroundColor = [UIColor greenColor];
            }
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
