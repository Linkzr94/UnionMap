//
//  Target_AMapAdepter.m
//  CTMediator
//
//  Created by SummerSoft.CQ on 2019/4/1.
//

#import "Target_AMapAdepter.h"

@implementation Target_AMapAdepter

- (void)Action_setApiKey:(NSDictionary *)params {
    if (params[@"apiKey"] == nil) {
        NSAssert(NO, @"apiKey is invalid!");
    }
    [AMapAdepter setApiKey:params[@"apiKey"]];
}

- (id)Action_initWithConfigAndResponder:(NSDictionary *)params {
    if (params[param_config] == nil) {
        NSAssert(NO, @"no config object, amap adepter initial fail!");
    }
    if (params[param_responder] == nil) {
        NSAssert(NO, @"no responder object, amap adepter initial fail!");
    }
    return [[AMapAdepter alloc] initWithConfig:params[@"config"] responder:params[@"responder"]];
}

@end
