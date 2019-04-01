//
//  AMapAdepter.h
//  Pods
//
//  Created by SummerSoft.CQ on 2019/3/31.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>
#import "UMConfig.h"
#import "UMResponder.h"

NS_ASSUME_NONNULL_BEGIN

@interface AMapAdepter : NSObject

+ (void)setApiKey:(NSString *)apiKey;

- (MAMapView *)getMapView;

- (instancetype)initWithConfig:(UMConfig *)config responder:(UMResponder *)responder;

@end

NS_ASSUME_NONNULL_END
