//
//  YSCell.h
//  GameOfLife
//
//  Created by Yair Szarf on 1/23/14.
//  Copyright (c) 2014 The 2 Handed Consortium. All rights reserved.
//

#import <Foundation/Foundation.h>

//The Cell class is the model representation of each square on the grid.

@interface YSCell : NSObject

@property (nonatomic) BOOL isAlive;
@property (nonatomic) BOOL nextGenerationState;
@property (nonatomic) BOOL hasBeenAlive;


- (YSCell *) init; // Init class returns a "dead" cell

//birth and death will always happen in the next generation
- (void) birth;
- (void) death;

//next generation will actually change the isAlive to next genration state
- (void) nextGeneration;
@end
