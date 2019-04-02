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

@protocol UMResponderDelegate;

@interface UMResponder : NSObject

@property (nonatomic, weak) id<UMResponderDelegate> delegate;

@end

@protocol UMResponderDelegate <NSObject>

@optional
- (void)responder:(UMResponder *)responder mapRegionChanged:(UMMapInfo *)mapInfo;
- (void)responder:(UMResponder *)responder mapInfo:(UMMapInfo *)mapInfo mapDidMoveByUser:(BOOL)wasUserAction;
- (void)responder:(UMResponder *)responder mapInfo:(UMMapInfo *)mapInfo regionWillChangeAnimated:(BOOL)animated;
- (void)responder:(UMResponder *)responder mapInfo:(UMMapInfo *)mapInfo mapWillMoveByUser:(BOOL)wasUserAction;
- (void)responder:(UMResponder *)responder mapInfo:(UMMapInfo *)mapInfo mapWillZoomByUser:(BOOL)wasUserAction;
- (void)responder:(UMResponder *)responder mapInfo:(UMMapInfo *)mapInfo mapDidZoomByUser:(BOOL)wasUserAction;

@end

NS_ASSUME_NONNULL_END
