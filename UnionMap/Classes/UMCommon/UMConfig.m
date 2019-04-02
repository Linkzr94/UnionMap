//
//  UMConfig.m
//  Pods-UnionMap_Example
//
//  Created by SummerSoft.CQ on 2019/3/29.
//

#import "UMConfig.h"

@implementation UMConfig

- (instancetype)init {
    if (self = [super init]) {
        self.frame = CGRectZero;
        self.zoomLevel = 14;
        self.rotationDegree = 0;
        self.zoomEnabled = YES;
        self.scrollEnabled = YES;
        self.rotateEnabled = NO;
        self.rotateCameraEnabled = NO;
        self.showTraffic = NO;
        self.showCompass = NO;
        self.showScale = NO;
        self.showCenterPoint = YES;
        self.centerPointImage = @"";
    }
    return self;
}

- (void)currentLocation {
    !self.delegate ? : [self.delegate currentLocation];
}

@end
