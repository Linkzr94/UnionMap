//
//  UMManager.h
//  CTMediator
//
//  Created by SummerSoft.CQ on 2019/4/1.
//

#import <Foundation/Foundation.h>
#import "UMConfig.h"
#import "UMRequest.h"
#import "UMResponder.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark -- #####   Target   #####
static const NSString *target_AMap =            @"AMapAdepter";
static const NSString *target_BaiduMap =        @"BaiduMapAdepter";
static const NSString *target_GoogleMap =       @"GoogleMapAdepter";

#pragma mark -- #####   Action   #####
static const NSString *action_SetApiKey =                   @"setApiKey";
static const NSString *action_InitWithConfigAndResponder =  @"initWithConfigAndResponder";

#pragma mark -- #####   Selector   #####
static const NSString *sel_GetMapView = @"getMapView";

#pragma mark -- #####   Param   #####
static const NSString *param_apiKey =           @"apiKey";
static const NSString *param_config =           @"config";
static const NSString *param_request =          @"request";
static const NSString *param_responder =        @"responder";

typedef NS_ENUM(NSInteger, MapType) {
    MapTypeAMap = 0,
    MapTypeBaidu,
    MapTypeGoogle,
};

@interface UMManager : NSObject

/**
 *  通过initAdepter创建的Adepter会被UMManager持有
 *  为了防止adepter被提早释放，导致消息传递失效，目前不支持复用
 *  需要释放时要手动调用removeAdepterForReuserIdentifier:以释放
 */

+ (instancetype)shareInstance;

- (void)setApiKey:(NSString *)apiKey forMap:(MapType)mapType;

- (id)initAdepter:(MapType)mapType
           config:(UMConfig *)config
          request:(UMRequest *)request
        responder:(UMResponder *)responder
       identifier:(NSString *)identifier;

- (void)removeAdepterForIdentifier:(NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
