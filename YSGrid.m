//
//  YSGrid.m
//  GameOfLife
//
//  Created by Yair Szarf on 1/23/14.
//  Copyright (c) 2014 The 2 Handed Consortium. All rights reserved.
//

#import "YSGrid.h"
#import "YSCell.h"

#define X_SIZE 10
#define Y_SIZE 10

@implementation YSGrid

-(id)init{
    self = [super init];
    
    self.columnsOfRows = [NSMutableArray new];
    
    for(int xCount = 0 ; xCount<X_SIZE ;  xCount++){
        
        NSMutableArray *rows = [NSMutableArray new];
        
        for(int yCount = 0 ; yCount < Y_SIZE ; yCount++ ){
            
            YSCell *newCell = [[YSCell alloc] init];
            [rows addObject:newCell];
            
        }
        
        [self.columnsOfRows addObject:rows];
        
    }
    
    NSLog(@"%@", self.columnsOfRows);
    
    _xSize = X_SIZE;
    _ySize = Y_SIZE;
    
    return self;
    
}


- (void)toggleCellAtIndexPath:(NSInteger)x andY:(NSInteger)y
{
    NSMutableArray *column = [self.columnsOfRows objectAtIndex:x];
    YSCell *cell = [column objectAtIndex:y];
    
    cell.isAlive = !cell.isAlive;
}


- (void)cycleOnce
{
    for(int xCount = 0 ; xCount<X_SIZE ;  xCount++){
        for(int yCount = 0 ; yCount < Y_SIZE ; yCount++ ){
            [self checkRulesForIndexPath:xCount andY:yCount];
        }
    }
}

- (void)checkRulesForIndexPath:(NSInteger) x andY: (NSInteger) y
{
    NSInteger numberOfAliveNeighbors = [self numberOfAliveNeighborsForCellAtIndexPath:x andY:y];
    YSCell * cell = [self getCellForIndexPath:x andY:y];
    
    if (cell.isAlive && numberOfAliveNeighbors < 2) {
        [cell death];
    }else if (cell.isAlive && numberOfAliveNeighbors > 3){
        [cell death];
    }else if ((!cell.isAlive) && numberOfAliveNeighbors == 3){
        [cell birth];
    }
    
    
    
    
}

- (YSCell *)getCellForIndexPath:(NSInteger) x andY: (NSInteger) y
{
    //check for grid limits
    if ((x < 0) ||(x >= X_SIZE) || (y < 0) || (y >= Y_SIZE)){
        return [[YSCell alloc] init];
    }
    NSMutableArray *column = [self.columnsOfRows objectAtIndex:x];
    YSCell *cell = [column objectAtIndex:y];
    return cell;
}

- (NSInteger) numberOfAliveNeighborsForCellAtIndexPath:(NSInteger)x andY:(NSInteger)y
{
    NSMutableArray *neighbors = [NSMutableArray new];
    [neighbors addObject:[self getCellForIndexPath:x - 1 andY:y -1]] ;
    [neighbors addObject:[self getCellForIndexPath:x andY:y -1]];
    [neighbors addObject:[self getCellForIndexPath:x + 1 andY:y -1]];
    [neighbors addObject:[self getCellForIndexPath:x + 1 andY:y]];
    [neighbors addObject:[self getCellForIndexPath:x + 1 andY:y + 1]];
    [neighbors addObject:[self getCellForIndexPath:x andY:y + 1]];
    [neighbors addObject:[self getCellForIndexPath:x - 1 andY:y +1]];
    [neighbors addObject:[self getCellForIndexPath:x - 1 andY:y]];
    
    NSInteger counter = 0;
    for (YSCell * cell in neighbors) {
        if (cell.isAlive) counter++;
    }
    return counter;
}

@end
