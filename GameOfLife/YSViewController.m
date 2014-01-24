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
#define DIMENSION 40
#define DEFAULT_SPEED 0.1

@interface YSViewController ()

@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (nonatomic) YSGrid *grid;
@property (nonatomic) NSMutableArray * gridButtonRows; //of coulmns
@property (nonatomic) BOOL isRunning;
//@property (strong, nonatomic) NSOperationQueue *gameQueue;
@property (weak, nonatomic) IBOutlet UISlider *speedSlider;
@property (strong, nonatomic) NSTimer *timer;
@property float speed;
@end

@implementation YSViewController

//-(NSOperationQueue *) gameQueue {
//    if (!_gameQueue) {
//        _gameQueue = [NSOperationQueue new];
//    }
//    return _gameQueue;
//
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //find out what is the size of grid
    [self setupGrid];
    
    
}

- (void) setupGrid {
    self.grid = [[YSGrid alloc] initWithXSize:DIMENSION andYSize:DIMENSION];
    float cellDimension = (self.view.frame.size.width/DIMENSION);
    
    self.gridButtonRows = [NSMutableArray new];
    
    for(int xCount = 0 ; xCount< self.grid.xSize ;  xCount++){
        
        NSMutableArray * column = [NSMutableArray new];
        
        for(int yCount = 0 ; yCount < self.grid.ySize ; yCount++ ){
            
            YSButton * button = [[YSButton alloc] init];
            button.xIndex = xCount;
            button.yIndex = yCount;
            button.cell = [self.grid getCellForIndexPath:xCount andY:yCount];
            UITapGestureRecognizer * gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellButtonPressed:)];
            [button addGestureRecognizer:gestureRecognizer];
            
            float x = (cellDimension * xCount);
            float y = ((cellDimension * yCount)+50);
            
            button.frame = CGRectMake(x, y, cellDimension, cellDimension);
            button.backgroundColor = [UIColor greenColor];
            
            [column addObject:button];
            [self.view addSubview:button];
        }
        
        [self.gridButtonRows addObject:column];
        
        
    }
}

-(void)cellButtonPressed:(UITapGestureRecognizer*)sender{
    YSButton *button = (YSButton *)sender.view;
    [self.grid toggleCellAtIndexPath:button.xIndex andY:button.yIndex];
    [self updateUI];
}

- (IBAction)sliderChanged:(UISlider *)sender {
    
    self.speed = self.speedSlider.value;
    if (self.timer) {
        [self.timer invalidate];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 - self.speed target:self selector:@selector(tick) userInfo:Nil repeats:YES];
    }
}
- (IBAction)clearButtonPressed:(UIButton *)sender {
    [self stopTimer];
    [self setupGrid];
    
}



- (IBAction)startButtonPressed:(UIButton *)sender {
    
    if (!self.isRunning) {
        
        [self.startButton setTitle:@"Stop" forState:UIControlStateNormal];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 - self.speed target:self selector:@selector(tick) userInfo:Nil repeats:YES];
        [self.timer fire];
        
    } else {
        [self stopTimer];
    }
    self.isRunning = !self.isRunning;
}

- (void)tick {
    //    [self.gameQueue addOperationWithBlock:^{
    [self.grid cycleOnce];
    //        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
    [self updateUI];
    //        }];
    //    }];
    
}

- (IBAction)gliderPressed:(UIButton *)sender {
    NSInteger x = (NSInteger) (arc4random() % (self.grid.xSize- 5)) ;
    NSInteger y = (NSInteger) (arc4random() % (self.grid.ySize- 5)) ;
    
    [self.grid toggleCellAtIndexPath:x + 1 andY:y + 1];
    [self.grid toggleCellAtIndexPath:x + 2 andY:y + 2];
    [self.grid toggleCellAtIndexPath:x + 3 andY:y + 2];
    [self.grid toggleCellAtIndexPath:x + 3 andY:y + 1];
    [self.grid toggleCellAtIndexPath:x + 3 andY:y ];
    
    [self updateUI];
}

- (IBAction)spaceshipPressed:(UIButton *)sender {
    NSInteger x = (NSInteger) (arc4random() % (self.grid.xSize- 5)) ;
    NSInteger y = (NSInteger) (arc4random() % (self.grid.ySize- 6)) ;

        [self.grid toggleCellAtIndexPath:x + 0 andY:y + 1];
        [self.grid toggleCellAtIndexPath:x + 0 andY:y + 2];
        [self.grid toggleCellAtIndexPath:x + 0 andY:y + 3];
        [self.grid toggleCellAtIndexPath:x + 1 andY:y + 0];
        [self.grid toggleCellAtIndexPath:x + 1 andY:y + 3];
        [self.grid toggleCellAtIndexPath:x + 2 andY:y + 3];
        [self.grid toggleCellAtIndexPath:x + 3 andY:y + 3];
        [self.grid toggleCellAtIndexPath:x + 4 andY:y + 0];
        [self.grid toggleCellAtIndexPath:x + 4 andY:y + 2];
    [self updateUI];

}


- (void) stopTimer {
    [self.timer invalidate];
    self.timer = nil;
    [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
}



-(void)updateUI
{
    for (NSArray *column in self.gridButtonRows) {
        for (YSButton *button in column) {
            if (button.cell.isAlive)
            {
                if (!(button.backgroundColor == [UIColor purpleColor])) button.backgroundColor = [UIColor purpleColor];
            }
            else
            {
                if (button.cell.hasBeenAlive){
                    if (!(button.backgroundColor == [UIColor yellowColor]))button.backgroundColor = [UIColor yellowColor];
                } else {
                    if (!(button.backgroundColor == [UIColor greenColor]))button.backgroundColor = [UIColor greenColor];
                }
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
