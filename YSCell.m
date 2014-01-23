//
//  YSCell.m
//  GameOfLife
//
//  Created by Yair Szarf on 1/23/14.
//  Copyright (c) 2014 The 2 Handed Consortium. All rights reserved.
//

#import "YSCell.h"

@implementation YSCell

- (YSCell *)init {
    if (self = [super init]) {
        _isAlive = NO;
    }
    return self;
}

- (void) birth {
    self.nextGenerationState = YES;
}


- (void) death {
    self.nextGenerationState = NO;
}

- (void) nextGeneration{
    self.isAlive = self.nextGenerationState;
}

@end
