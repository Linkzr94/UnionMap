//
//  AMapSearchProxy.h
//  CTMediator
//
//  Created by SummerSoft.CQ on 2019/4/9.
//

#import <Foundation/Foundation.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "UnionMap.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SearchDone)(UMSearchResponse *response);
typedef void(^DriveRouteDone)(AMapRouteSearchResponse *response);

@interface AMapSearchProxy : NSObject

@property (nonatomic) AMapSearchAPI *searchApi;

- (void)searchReGeoCodeByLocation:(AMapGeoPoint *)location searchDone:(SearchDone)done;

- (void)searchPOIByKeyword:(NSString *)keyword city:(NSString *)city types:(NSString *)types searchDone:(SearchDone)done;

- (void)searchInputTips:(NSString *)input city:(NSString *)city cityLimit:(BOOL)cityLimit types:(NSString *)types location:(NSString *)location searchDone:(SearchDone)done;

- (void)drivingRouteWithOrigin:(CLLocationCoordinate2D)origin destination:(CLLocationCoordinate2D)destination searchDone:(DriveRouteDone)done;

@end

NS_ASSUME_NONNULL_END
