//
//  UMConfig.h
//  Pods-UnionMap_Example
//
//  Created by SummerSoft.CQ on 2019/3/29.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol UMConfigDelegate <NSObject>

- (void)currentLocation;

@end

@interface UMConfig : NSObject

@property (nonatomic, weak) id<UMConfigDelegate> delegate;
//map frame,default CGRectZero
@property (nonatomic) CGRect frame;
//缩放等级,default 14
@property (nonatomic) CGFloat zoomLevel;
//地图旋转角度,default 0
@property (nonatomic) CGFloat rotationDegree;
//地图缩放手势的开关,default YES
@property (nonatomic) BOOL zoomEnabled;
//地图滑动手势的开关,default YES
@property (nonatomic) BOOL scrollEnabled;
//地图旋转手势的开关,default NO
@property (nonatomic) BOOL rotateEnabled;
//地图旋转旋转的开关,default NO
@property (nonatomic) BOOL rotateCameraEnabled;
//显示交通状况,default NO
@property (nonatomic) BOOL showTraffic;
//显示指南针,default NO
@property (nonatomic) BOOL showCompass;
//显示比例尺,default NO
@property (nonatomic) BOOL showScale;
//显示地图中心点
@property (nonatomic) BOOL showCenterPoint;
//地图中心点图片
@property (nonatomic) NSString *centerPointImage;

- (void)currentLocation;

@end

NS_ASSUME_NONNULL_END
