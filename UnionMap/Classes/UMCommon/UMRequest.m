//
//  UMRequest.m
//  CTMediator
//
//  Created by SummerSoft.CQ on 2019/4/1.
//

#import "UMRequest.h"

@implementation UMRequest

- (void)searchInputTips:(NSString *)input city:(NSString *)city cityLimit:(BOOL)cityLimit types:(NSString *)types location:(NSString *)location {
    !self.delegate ? : [self.delegate request:self searchInputTips:input city:city cityLimit:cityLimit types:types location:location];
}

- (void)searchPOIByKeyword:(NSString *)keyword city:(NSString *)city types:(NSString *)types {
    !self.delegate ? : [self.delegate request:self searchPOIByKeyword:keyword city:city types:types];
}

- (void)drivingRouteWithOrigin:(CLLocationCoordinate2D)origin destination:(CLLocationCoordinate2D)destination {
    !self.delegate ? : [self.delegate request:self drivingRouteWithOrigin:origin destination:destination];
}

- (void)removeRouteRenderer {
    !self.delegate ? : [self.delegate requestRemoveRouteRenderer:self];
}

@end
