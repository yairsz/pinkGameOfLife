//
//  YSGrid.h
//  GameOfLife
//
//  Created by Yair Szarf on 1/23/14.
//  Copyright (c) 2014 The 2 Handed Consortium. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YSCell.h"

@interface YSGrid : NSObject

@property (nonatomic) NSMutableArray * columnsOfRows; //of NSArray of rowsOfCell
@property (nonatomic) NSInteger xSize;
@property (nonatomic) NSInteger ySize;

- (YSCell *)getCellForIndexPath:(NSInteger) x andY: (NSInteger) y;
- (YSGrid *) initWithXSize:(NSInteger) xSize andYSize:(NSInteger) ySize;
- (void)toggleCellAtIndexPath:(NSInteger)x andY:(NSInteger)y;
-(void)cycleOnce;


@end
