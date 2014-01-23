//
//  YSCell.h
//  GameOfLife
//
//  Created by Yair Szarf on 1/23/14.
//  Copyright (c) 2014 The 2 Handed Consortium. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSCell : NSObject

@property (nonatomic) BOOL isAlive;


- (YSCell *) init;
- (void) birth;
- (void) death;

@end
