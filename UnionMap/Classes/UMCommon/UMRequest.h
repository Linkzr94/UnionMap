//
//  UMRequest.h
//  CTMediator
//
//  Created by SummerSoft.CQ on 2019/4/1.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol UMRequestDelegate;

@interface UMRequest : NSObject

@property (nonatomic, weak) id<UMRequestDelegate> delegate;

//search
- (void)searchPOIByKeyword:(NSString *)keyword
                      city:(NSString *)city
                     types:(NSString *)types;
- (void)searchInputTips:(NSString *)input
                   city:(NSString *)city
              cityLimit:(BOOL)cityLimit
                  types:(NSString *)types
               location:(NSString *)location;
//route
- (void)drivingRouteWithOrigin:(CLLocationCoordinate2D)origin
                   destination:(CLLocationCoordinate2D)destination; //获取驾车路线
- (void)removeRouteRenderer;

@end

@protocol UMRequestDelegate <NSObject>

- (void)request:(UMRequest *)request searchInputTips:(NSString *)input
                                                city:(NSString *)city
                                           cityLimit:(BOOL)cityLimit
                                               types:(NSString *)types
                                            location:(NSString *)location;
- (void)request:(UMRequest *)request searchPOIByKeyword:(NSString *)keyword
                                                   city:(NSString *)city
                                                  types:(NSString *)types;
- (void)request:(UMRequest *)request drivingRouteWithOrigin:(CLLocationCoordinate2D)origin
                                                destination:(CLLocationCoordinate2D)destination;
- (void)requestRemoveRouteRenderer:(UMRequest *)request;

@end

NS_ASSUME_NONNULL_END
