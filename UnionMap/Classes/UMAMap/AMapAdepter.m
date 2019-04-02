//
//  AMapAdepter.m
//  Pods
//
//  Created by SummerSoft.CQ on 2019/3/31.
//

#import "AMapAdepter.h"

@interface AMapAdepter () <UMConfigDelegate, MAMapViewDelegate, AMapSearchDelegate>

@property (nonatomic) MAMapView *mapView;

@property (nonatomic) AMapSearchAPI *searchApi;

@property (nonatomic) UMConfig *config;

@property (nonatomic) UMResponder *responder;

@property (nonatomic) UIImageView *centerPointImageView;

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
        self.mapView = [[MAMapView alloc] init];
        self.mapView.delegate = self;   //mapview回调通知时，调用responder对应方法回调给业务层
        
        self.searchApi = [[AMapSearchAPI alloc] init];
        self.searchApi.delegate = self;
        
        self.config = config;
        self.config.delegate = self;    //成为config的代理，修改config时，收到消息做对应处理
        self.responder = responder;
    }
    return self;
}

#pragma mark -- #####   ReGeocode   #####
- (void)searchReGeoCodeByLocation:(AMapGeoPoint *)location {
    
}

#pragma mark -- #####   MAMapViewDelegate   #####
- (void)mapViewRegionChanged:(MAMapView *)mapView {
    UMMapInfo *mapInfo = [[UMMapInfo alloc] init];
    mapInfo.coordinate = mapView.centerCoordinate;
    ![self.responder.delegate respondsToSelector:@selector(responder:mapRegionChanged:)] ? : [self.responder.delegate responder:self.responder mapRegionChanged:mapInfo];
}
- (void)mapView:(MAMapView *)mapView mapDidMoveByUser:(BOOL)wasUserAction {
    UMMapInfo *mapInfo = [[UMMapInfo alloc] init];
    mapInfo.coordinate = mapView.centerCoordinate;
    ![self.responder.delegate respondsToSelector:@selector(responder:mapInfo:mapDidMoveByUser:)] ? : [self.responder.delegate responder:self.responder mapInfo:mapInfo mapDidMoveByUser:wasUserAction];
    
    //根据经纬度搜索逆地址编码数据
    [self searchReGeoCodeByLocation:[AMapGeoPoint locationWithLatitude:mapInfo.coordinate.latitude longitude:mapInfo.coordinate.longitude]];
}
- (void)mapView:(MAMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    UMMapInfo *mapInfo = [[UMMapInfo alloc] init];
    mapInfo.coordinate = mapView.centerCoordinate;
    ![self.responder.delegate respondsToSelector:@selector(responder:mapInfo:regionWillChangeAnimated:)] ? : [self.responder.delegate responder:self.responder mapInfo:mapInfo regionWillChangeAnimated:animated];
}
- (void)mapView:(MAMapView *)mapView mapWillMoveByUser:(BOOL)wasUserAction {
    UMMapInfo *mapInfo = [[UMMapInfo alloc] init];
    mapInfo.coordinate = mapView.centerCoordinate;
    ![self.responder.delegate respondsToSelector:@selector(responder:mapInfo:mapWillMoveByUser:)] ? : [self.responder.delegate responder:self.responder mapInfo:mapInfo mapWillMoveByUser:wasUserAction];
}
- (void)mapView:(MAMapView *)mapView mapWillZoomByUser:(BOOL)wasUserAction {
    UMMapInfo *mapInfo = [[UMMapInfo alloc] init];
    mapInfo.coordinate = mapView.centerCoordinate;
    ![self.responder.delegate respondsToSelector:@selector(responder:mapInfo:mapWillZoomByUser:)] ? : [self.responder.delegate responder:self.responder mapInfo:mapInfo mapWillZoomByUser:wasUserAction];
}
- (void)mapView:(MAMapView *)mapView mapDidZoomByUser:(BOOL)wasUserAction {
    UMMapInfo *mapInfo = [[UMMapInfo alloc] init];
    mapInfo.coordinate = mapView.centerCoordinate;
    ![self.responder.delegate respondsToSelector:@selector(responder:mapInfo:mapDidZoomByUser:)] ? : [self.responder.delegate responder:self.responder mapInfo:mapInfo mapDidZoomByUser:wasUserAction];
}

#pragma mark -- #####   UMConfigDelegate   #####
- (void)currentLocation {
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
}

#pragma mark -- #####   Setter&Getter   #####
- (void)setConfig:(UMConfig *)config {
    _config = config;
    self.mapView.frame = config.frame;
//    self.mapView.zoomLevel = config.zoomLevel;
    [self.mapView setZoomLevel:config.zoomLevel animated:YES];
    self.mapView.rotationDegree = config.rotationDegree;
    self.mapView.zoomEnabled = config.zoomEnabled;
    self.mapView.scrollEnabled = config.scrollEnabled;
    self.mapView.rotateEnabled = config.rotateEnabled;
    self.mapView.rotateCameraEnabled = config.rotateCameraEnabled;
    self.mapView.showTraffic = config.showTraffic;
    self.mapView.showsCompass = config.showCompass;
    self.mapView.showsScale = config.showScale;
    self.centerPointImageView.hidden = !config.showCenterPoint;
    
    //设置地图中心点
    UIImage *centerPointImage = [UIImage imageNamed:config.centerPointImage];
    self.centerPointImageView.image = centerPointImage;
    CGRect frame = self.centerPointImageView.frame;
    frame.size = centerPointImage.size;
    self.centerPointImageView.frame = frame;
    self.centerPointImageView.center = self.mapView.center;
}

- (UIImageView *)centerPointImageView {
    if (nil == _centerPointImageView) {
        _centerPointImageView = [[UIImageView alloc] init];
        [self.mapView addSubview:_centerPointImageView];
    }
    return _centerPointImageView;
}

@end
