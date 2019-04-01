//
//  UMConfig.m
//  Pods-UnionMap_Example
//
//  Created by SummerSoft.CQ on 2019/3/29.
//

#import "UMConfig.h"

@implementation UMConfig

- (void)currentLocation {
    !self.delegate ? : [self.delegate currentLocation];
}

@end
