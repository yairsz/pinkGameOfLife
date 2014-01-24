//
//  YSGrid.m
//  GameOfLife
//
//  Created by Yair Szarf on 1/23/14.
//  Copyright (c) 2014 The 2 Handed Consortium. All rights reserved.
//

#import "YSGrid.h"

@implementation YSGrid

-(YSGrid *) initWithXSize:(NSInteger)xSize andYSize:(NSInteger)ySize
{
    self = [super init];
    self.columnsOfRows = [NSMutableArray new];
    for(int xCount = 0 ; xCount < xSize ;  xCount++){
        NSMutableArray *rows = [NSMutableArray new];
        for(int yCount = 0 ; yCount < ySize ; yCount++ ){
            
            YSCell *newCell = [[YSCell alloc] init];
            [rows addObject:newCell];
        }
        
        [self.columnsOfRows addObject:rows];
    }
    
    //properties are set for convenience when the controller is using the grid
    _xSize = xSize;
    _ySize = ySize;
    
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
    //find out the state of the next generation will be first
    for(int xCount = 0 ; xCount<self.xSize ;  xCount++){
        for(int yCount = 0 ; yCount < self.ySize ; yCount++ ){
            [self checkRulesForIndexPath:xCount andY:yCount];
        }
    }
    //change the whole model to the next genaration first
    for(int xCount = 0 ; xCount<self.xSize ;  xCount++){
        for(int yCount = 0 ; yCount < self.ySize ; yCount++ ){
            YSCell * cell = [self getCellForIndexPath:xCount andY:yCount];
            [cell nextGeneration];
        }
    }
    
    
}

- (void)checkRulesForIndexPath:(NSInteger) x andY: (NSInteger) y
{
    NSInteger numberOfAliveNeighbors = [self numberOfAliveNeighborsForCellAtIndexPath:x andY:y];
    YSCell * cell = [self getCellForIndexPath:x andY:y];
    
    //These if statements represent the classic rules for conways game of life
    
    if (cell.isAlive && numberOfAliveNeighbors < 2) {
        [cell death];
    }else if (cell.isAlive && numberOfAliveNeighbors > 3){
        [cell death];
    } else if (cell.isAlive && (numberOfAliveNeighbors == 2 || numberOfAliveNeighbors == 3)){
        [cell birth];
    } else if ((!cell.isAlive) && numberOfAliveNeighbors == 3){
        [cell birth];
    }
}

- (YSCell *)getCellForIndexPath:(NSInteger) x andY: (NSInteger) y
{
    //check for grid limits
    if ((x < 0) ||(x >= self.xSize) || (y < 0) || (y >= self.ySize)){
        return [[YSCell alloc] init];
    }
    NSMutableArray *column = [self.columnsOfRows objectAtIndex:x];
    YSCell *cell = [column objectAtIndex:y];
    return cell;
}

- (NSInteger) numberOfAliveNeighborsForCellAtIndexPath:(NSInteger)x andY:(NSInteger)y
{
    NSMutableArray *neighbors = [NSMutableArray new]; //add all neighbors to matrix
    
    //there is probably a better way to do this
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
