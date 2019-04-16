//
//  UMManager.m
//  CTMediator
//
//  Created by SummerSoft.CQ on 2019/4/1.
//

#import "UMManager.h"
#import <CTMediator/CTMediator.h>

@interface UMManager ()

@property (nonatomic) NSMutableDictionary *adepterCache;

@end

@implementation UMManager

static UMManager *instance = nil;

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[UMManager alloc] init];
        instance.adepterCache = [NSMutableDictionary dictionary];
    });
    return instance;
}

- (void)setApiKey:(NSString *)apiKey forMap:(MapType)mapType {
    NSDictionary *params = @{param_apiKey: apiKey};
    switch (mapType) {
        case MapTypeAMap:
            [[CTMediator sharedInstance] performTarget:target_AMap action:action_SetApiKey params:params shouldCacheTarget:NO];
            break;
        case MapTypeBaidu:
            
        case MapTypeGoogle:
            
        default:
            break;
    }
}

- (id)initAdepter:(MapType)mapType
           config:(UMConfig *)config
          request:(UMRequest *)request
        responder:(UMResponder *)responder
       identifier:(NSString *)identifier {
    NSDictionary *params = @{param_config       : config,
                             param_request      : request,
                             param_responder    : responder,
                             };
    NSString *target = @"";
    switch (mapType) {
        case MapTypeAMap:
            target = target_AMap;
            break;
        case MapTypeBaidu:
            target = target_BaiduMap;
            break;
        case MapTypeGoogle:
            target = target_GoogleMap;
            break;
        default:
            NSAssert(NO, @"Invaliable Map Type!!!");
            break;
    }
    
    id adepter = nil;
    if (self.adepterCache[identifier]) {
        adepter = self.adepterCache[identifier];
    } else {
        adepter = [[CTMediator sharedInstance] performTarget:target action:action_InitWithConfigAndResponder params:params shouldCacheTarget:NO];
        self.adepterCache[identifier] = adepter;
    }
    SEL getMapView = NSSelectorFromString(sel_GetMapView);
    if ([adepter respondsToSelector:getMapView]) {
        return [adepter performSelector:getMapView];
    } else {
        return nil;
    };
}

- (void)removeAdepterForIdentifier:(NSString *)identifier {
    if (self.adepterCache[identifier]) {
        [self.adepterCache removeObjectForKey:identifier];
    }
}

@end
