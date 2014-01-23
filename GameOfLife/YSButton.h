//
//  YSButton.h
//  GameOfLife
//
//  Created by Yair Szarf on 1/23/14.
//  Copyright (c) 2014 The 2 Handed Consortium. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSCell.h"

@interface YSButton : UIButton

@property (nonatomic) NSInteger xIndex;
@property (nonatomic) NSInteger yIndex;
@property (nonatomic, weak) YSCell *cell;

@end
