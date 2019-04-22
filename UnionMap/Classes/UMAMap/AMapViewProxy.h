//
//  AMapViewProxy.h
//  CTMediator
//
//  Created by SummerSoft.CQ on 2019/4/9.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AMapViewProxy : NSObject

- (void)calPolylineByResponse:(AMapRouteSearchResponse *)response forMapView:(MAMapView *)mapView;

@end

NS_ASSUME_NONNULL_END
