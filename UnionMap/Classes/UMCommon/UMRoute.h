//
//  UMRoute.h
//  CTMediator
//
//  Created by SummerSoft.CQ on 2019/4/9.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

//路段基本信息
@interface UMStep : NSObject

@property (nonatomic, copy)   NSString  *instruction;   //行走指示
@property (nonatomic, copy)   NSString  *orientation;   //方向
@property (nonatomic, copy)   NSString  *road;  //道路名称
@property (nonatomic, assign) NSInteger  distance;  //此路段长度（单位：米）
@property (nonatomic, assign) NSInteger  duration;  //此路段预计耗时（单位：秒）
@property (nonatomic, copy)   NSString  *polyline;  //此路段坐标点串
@property (nonatomic, copy)   NSString  *action;    //导航主要动作
@property (nonatomic, copy)   NSString  *assistantAction;   //导航辅助动作
@property (nonatomic, assign) CGFloat    tolls; //此段收费（单位：元）
@property (nonatomic, assign) NSInteger  tollDistance;  //收费路段长度（单位：米）
@property (nonatomic, copy)   NSString  *tollRoad;  //主要收费路段
@property (nonatomic, strong) NSArray *cities;  //途径城市 AMapCity 数组，只有驾车路径规划时有效
@property (nonatomic, strong) NSArray *tmcs; //路况信息数组，只有驾车路径规划时有效

@end

@interface UMPath : NSObject

@property (nonatomic, assign) NSInteger  distance;  //起点和终点的距离
@property (nonatomic, assign) NSInteger  duration;  //预计耗时（单位：秒）
@property (nonatomic, copy)   NSString  *strategy;  //导航策略
@property (nonatomic, strong) NSArray<UMStep *> *steps;   //导航路段 AMapStep 数组
@property (nonatomic, assign) CGFloat    tolls; //此方案费用（单位：元）
@property (nonatomic, assign) NSInteger  tollDistance;  //此方案收费路段长度（单位：米）
@property (nonatomic, assign) NSInteger  totalTrafficLights;    //此方案交通信号灯个数

@end

@interface UMTransit : NSObject

@end

@interface UMRoute : NSObject

@property (nonatomic) CLLocationCoordinate2D origin;        //起点
@property (nonatomic) CLLocationCoordinate2D destination;   //终点
@property (nonatomic) CGFloat taxiCost;                     //出租车费用
@property (nonatomic) NSArray<UMPath *> *paths;             //驾车方案列表
@property (nonatomic) NSArray<UMTransit *> *transits;       //公交换乘方案列表

@end

NS_ASSUME_NONNULL_END
