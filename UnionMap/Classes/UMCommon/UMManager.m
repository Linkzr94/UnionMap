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

#pragma mark -- #####   Target   #####
#define Target_AMap                 @"AMapAdepter"
#define Target_BaiduMap             @"BaiduMapAdepter"
#define Target_GoogleMap            @"GoogleMapAdepter"

#pragma mark -- #####   Action   #####
#define Action_SetApiKey            @"setApiKey"
#define Action_InitWithConfigAndResponder       @"initWithConfigAndResponder"

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
    NSDictionary *params = [NSDictionary dictionaryWithObject:apiKey forKey:@"apiKey"];
    switch (mapType) {
        case MapTypeAMap:
            [[CTMediator sharedInstance] performTarget:Target_AMap action:Action_SetApiKey params:params shouldCacheTarget:NO];
            break;
        case MapTypeBaidu:
            
        case MapTypeGoogle:
            
        default:
            break;
    }
}

- (id)initAdepter:(MapType)mapType
           config:(UMConfig *)config
        responder:(nonnull UMResponder *)responder
       identifier:(NSString *)identifier {
    NSDictionary *params = @{@"config"      : config,
                             @"responder"   : responder,
                             };
    NSString *target = @"";
    switch (mapType) {
        case MapTypeAMap:
            target = Target_AMap;
            break;
        case MapTypeBaidu:
            target = Target_BaiduMap;
            break;
        case MapTypeGoogle:
            target = Target_GoogleMap;
            break;
        default:
            NSAssert(NO, @"Invaliable Map Type!!!");
            break;
    }
    
    id adepter = nil;
    if (self.adepterCache[identifier]) {
        adepter = self.adepterCache[identifier];
    } else {
        adepter = [[CTMediator sharedInstance] performTarget:Target_AMap action:Action_InitWithConfigAndResponder params:params shouldCacheTarget:NO];
        self.adepterCache[identifier] = adepter;
    }
    SEL getMapView = NSSelectorFromString(@"getMapView");
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
