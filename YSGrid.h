//
//  YSGrid.h
//  GameOfLife
//
//  Created by Yair Szarf on 1/23/14.
//  Copyright (c) 2014 The 2 Handed Consortium. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSGrid : NSObject

@property (nonatomic) NSMutableArray * columnsOfRows; //of NSArray of rowsOfCell
@property (nonatomic) NSInteger xSize;
@property (nonatomic) NSInteger ySize;

- (YSGrid *) init;
- (void)toggleCellAtIndexPath:(NSInteger)x andY:(NSInteger)y;
-(void)cycleOnce;


@end
