//
//  UMResponder.h
//  CTMediator
//
//  Created by SummerSoft.CQ on 2019/4/1.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UMMapInfo : NSObject

@property (nonatomic) CLLocationCoordinate2D coordinate;

@end

@interface UMReGeocode : NSObject

//reGeoCode
@property (nonatomic) NSString *formattedAddress;       //格式化地址
@property (nonatomic) NSString *country;                //国家
@property (nonatomic) NSString *province;               //省
@property (nonatomic) NSString *city;                   //市
@property (nonatomic) NSString *citycode;               //城市编码
@property (nonatomic) NSString *district;               //区
@property (nonatomic) NSString *adcode;                 //区域编码
@property (nonatomic) NSString *township;               //乡镇街道
@property (nonatomic) NSString *towncode;               //乡镇街道编码
@property (nonatomic) NSString *neighborhood;           //社区
@property (nonatomic) NSString *building;               //建筑
//门牌号
@property (nonatomic) NSString *street;                 //街道名称
@property (nonatomic) NSString *number;                 //门牌号
@property (nonatomic) CLLocationCoordinate2D location;  //坐标点
@property (nonatomic) NSInteger distance;               //距离（单位：米）
@property (nonatomic) NSString *direction;              //方向
// TODO
@property (nonatomic) NSArray *businessAreas;           //商圈列表 AMapBusinessArea 数组
@property (nonatomic) NSArray *roads;                   //道路信息 AMapRoad 数组
@property (nonatomic) NSArray *roadinters;              //道路路口信息 AMapRoadInter 数组
@property (nonatomic) NSArray *pois;                    //兴趣点信息 AMapPOI 数组
@property (nonatomic) NSArray *aois;                    //兴趣区域信息 AMapAOI 数组

@end

@interface UMTip : NSObject

//poi的id
@property (nonatomic, copy) NSString *uid;
//名称
@property (nonatomic, copy) NSString *name;
//区域编码
@property (nonatomic, copy) NSString *adcode;
//所属区域
@property (nonatomic, copy) NSString *district;
//地址
@property (nonatomic, copy) NSString *address;
//位置
@property (nonatomic) CLLocationCoordinate2D location;

@end

@interface UMSearchResponse : NSObject

@property (nonatomic) UMReGeocode *regeocode;   //regeocode

@property (nonatomic) NSArray<UMTip *> *tips;   //inputTips

@end

@protocol UMResponderDelegate;

@interface UMResponder : NSObject

@property (nonatomic, weak) id<UMResponderDelegate> delegate;

@end

@protocol UMResponderDelegate <NSObject>

@optional
//MAMapView
- (void)responder:(UMResponder *)responder mapRegionChanged:(UMMapInfo *)mapInfo;
- (void)responder:(UMResponder *)responder mapInfo:(UMMapInfo *)mapInfo mapDidMoveByUser:(BOOL)wasUserAction;
- (void)responder:(UMResponder *)responder mapInfo:(UMMapInfo *)mapInfo regionWillChangeAnimated:(BOOL)animated;
- (void)responder:(UMResponder *)responder mapInfo:(UMMapInfo *)mapInfo mapWillMoveByUser:(BOOL)wasUserAction;
- (void)responder:(UMResponder *)responder mapInfo:(UMMapInfo *)mapInfo mapWillZoomByUser:(BOOL)wasUserAction;
- (void)responder:(UMResponder *)responder mapInfo:(UMMapInfo *)mapInfo mapDidZoomByUser:(BOOL)wasUserAction;
//SearchApi
- (void)responder:(UMResponder *)responder onReGeocodeSearchDone:(UMSearchResponse *)response;
- (void)responder:(UMResponder *)responder onInputTipsSearchDone:(UMSearchResponse *)response;
- (void)responderOnRouteSearchDone:(UMResponder *)responder;

@end

NS_ASSUME_NONNULL_END
