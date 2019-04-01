//
//  AMapAdepter.m
//  Pods
//
//  Created by SummerSoft.CQ on 2019/3/31.
//

#import "AMapAdepter.h"

@interface AMapAdepter () <UMConfigDelegate, MAMapViewDelegate>

@property (nonatomic) MAMapView *mapView;

@property (nonatomic) UMConfig *config;

@property (nonatomic) UMResponder *responder;

@end

@implementation AMapAdepter

+ (void)setApiKey:(NSString *)apiKey {
    [AMapServices sharedServices].apiKey = apiKey;
}

- (MAMapView *)getMapView {
    return self.mapView;
}

- (instancetype)initWithConfig:(UMConfig *)config responder:(UMResponder *)responder {
    if (self = [super init]) {
        self.config = config;
        self.config.delegate = self;    //成为config的代理，修改config时，收到消息做对应处理
        self.responder = responder;
        [self initMapWithConfig:config responder:responder];
    }
    return self;
}

- (void)initMapWithConfig:(UMConfig *)config responder:(UMResponder *)responder {
    self.mapView = [[MAMapView alloc] initWithFrame:config.frame];
    self.mapView.delegate = self;   //mapview回调通知时，调用responder对应方法回调给业务层
}

#pragma mark -- #####   UMConfigDelegate   #####
- (void)currentLocation {
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
}

@end
