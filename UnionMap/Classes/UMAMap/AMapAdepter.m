//
//  AMapAdepter.m
//  Pods
//
//  Created by SummerSoft.CQ on 2019/3/31.
//

#import "AMapAdepter.h"

typedef dispatch_block_t CanRespond;
typedef dispatch_block_t CanNotRespond;

@interface AMapAdepter () <UMConfigDelegate, UMRequestDelegate, MAMapViewDelegate>

@property (nonatomic) MAMapView *mapView;

@property (nonatomic) AMapSearchProxy *searchProxy;
@property (nonatomic) AMapViewProxy *mapViewProxy;

@property (nonatomic) UMConfig *config;
@property (nonatomic) UMRequest *request;
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

- (instancetype)initWithConfig:(UMConfig *)config
                       request:(UMRequest *)request
                     responder:(UMResponder *)responder {
    if (self = [super init]) {
        self.mapView = [[MAMapView alloc] init];
        self.mapView.delegate = self;   //mapview回调通知时，调用responder对应方法回调给业务层
        
        self.searchProxy = [[AMapSearchProxy alloc] init];
        self.mapViewProxy = [[AMapViewProxy alloc] init];
        
        self.config = config;
        self.config.delegate = self;    //成为config的代理，修改config时，收到消息做对应处理
        self.request = request;
        self.request.delegate = self;
        self.responder = responder;
    }
    return self;
}

#pragma mark -- #####   MAMapViewDelegate   #####
- (void)mapViewRegionChanged:(MAMapView *)mapView {
    [self target:self.responder.delegate respondeSEL:@selector(responder:mapRegionChanged:) canRespond:^{
        UMMapInfo *mapInfo = [self convertToUMMapInfo:mapView];
        [self.responder.delegate responder:self.responder mapRegionChanged:mapInfo];
    } canNotRespond:nil];
}
- (void)mapView:(MAMapView *)mapView mapDidMoveByUser:(BOOL)wasUserAction {
    UMMapInfo *mapInfo = [self convertToUMMapInfo:mapView];
    //根据经纬度搜索逆地址编码数据
    [self.searchProxy searchReGeoCodeByLocation:[AMapGeoPoint locationWithLatitude:mapInfo.coordinate.latitude longitude:mapInfo.coordinate.longitude] searchDone:^(UMSearchResponse * _Nonnull response) {
        [self target:self.responder.delegate respondeSEL:@selector(responder:onReGeocodeSearchDone:) canRespond:^{
            [self.responder.delegate responder:self.responder onReGeocodeSearchDone:response];
        } canNotRespond:nil];
    }];
    [self target:self.responder.delegate respondeSEL:@selector(responder:mapInfo:mapDidMoveByUser:) canRespond:^{
        [self.responder.delegate responder:self.responder mapInfo:mapInfo mapDidMoveByUser:wasUserAction];
    } canNotRespond:nil];
}
- (void)mapView:(MAMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    [self target:self.responder.delegate respondeSEL:@selector(responder:mapInfo:regionWillChangeAnimated:) canRespond:^{
        UMMapInfo *mapInfo = [self convertToUMMapInfo:mapView];
        [self.responder.delegate responder:self.responder mapInfo:mapInfo regionWillChangeAnimated:animated];
    } canNotRespond:nil];
}
- (void)mapView:(MAMapView *)mapView mapWillMoveByUser:(BOOL)wasUserAction {
    [self target:self.responder.delegate respondeSEL:@selector(responder:mapInfo:mapWillMoveByUser:) canRespond:^{
        UMMapInfo *mapInfo = [self convertToUMMapInfo:mapView];
        [self.responder.delegate responder:self.responder mapInfo:mapInfo mapWillMoveByUser:wasUserAction];
    } canNotRespond:nil];
}
- (void)mapView:(MAMapView *)mapView mapWillZoomByUser:(BOOL)wasUserAction {
    [self target:self.responder.delegate respondeSEL:@selector(responder:mapInfo:mapWillZoomByUser:) canRespond:^{
        UMMapInfo *mapInfo = [self convertToUMMapInfo:mapView];
        [self.responder.delegate responder:self.responder mapInfo:mapInfo mapWillZoomByUser:wasUserAction];
    } canNotRespond:nil];
}
- (void)mapView:(MAMapView *)mapView mapDidZoomByUser:(BOOL)wasUserAction {
    [self target:self.responder.delegate respondeSEL:@selector(responder:mapInfo:mapDidZoomByUser:) canRespond:^{
        UMMapInfo *mapInfo = [self convertToUMMapInfo:mapView];
        [self.responder.delegate responder:self.responder mapInfo:mapInfo mapDidZoomByUser:wasUserAction];
    } canNotRespond:nil];
}
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay {
    if ([overlay isKindOfClass:[MAPolyline class]]) {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        polylineRenderer.lineWidth    = 8.f;
        polylineRenderer.strokeColor  = [UIColor colorWithRed:0 green:0 blue:1 alpha:1];
        polylineRenderer.lineJoinType = kMALineJoinRound;
        polylineRenderer.lineCapType  = kMALineCapRound;
        return polylineRenderer;
    }
    return nil;
}

#pragma mark -- #####   UMConfigDelegate   #####
- (void)currentLocation {
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
}

#pragma mark -- #####   UMRequestDelegate   #####
- (void)request:(UMRequest *)request searchPOIByKeyword:(NSString *)keyword city:(NSString *)city types:(NSString *)types {
    [self.searchProxy searchPOIByKeyword:keyword city:city types:types searchDone:^(UMSearchResponse * _Nonnull response) {
        // TODO: POI Search By Keyword Responder
    }];
}
- (void)request:(UMRequest *)request searchInputTips:(NSString *)input city:(NSString *)city cityLimit:(BOOL)cityLimit types:(NSString *)types location:(NSString *)location {
    [self.searchProxy searchInputTips:input city:city cityLimit:cityLimit types:types location:location searchDone:^(UMSearchResponse * _Nonnull response) {
        [self target:self.responder.delegate respondeSEL:@selector(responder:onInputTipsSearchDone:) canRespond:^{
            [self.responder.delegate responder:self.responder onInputTipsSearchDone:response];
        } canNotRespond:nil];
    }];
}
- (void)request:(UMRequest *)request drivingRouteWithOrigin:(CLLocationCoordinate2D)origin destination:(CLLocationCoordinate2D)destination {
    [self.searchProxy drivingRouteWithOrigin:origin destination:destination searchDone:^(AMapRouteSearchResponse * _Nonnull response) {
        [self showUserLocation:NO];
        [self showCenterAnnotation:NO];
        [self.mapViewProxy calPolylineByResponse:response forMapView:self.mapView];
        [self target:self.responder.delegate respondeSEL:@selector(responderOnRouteSearchDone:) canRespond:^{
            [self.responder.delegate responderOnRouteSearchDone:self.responder];
        } canNotRespond:nil];
    }];
}
- (void)requestRemoveRouteRenderer:(UMRequest *)request {
    [self showUserLocation:YES];
    [self showCenterAnnotation:YES];
    [self.mapView removeOverlays:self.mapView.overlays];
    [self.mapView removeAnnotations:self.mapView.annotations];
}

#pragma mark -- #####   CommonMethod   #####
- (void)target:(id)target respondeSEL:(SEL)sel canRespond:(CanRespond)can canNotRespond:(CanNotRespond)canNot {
    (target && [target respondsToSelector:sel]) ? (!can ? : can()) : (!canNot ? : canNot());
}
- (UMMapInfo *)convertToUMMapInfo:(MAMapView *)mapView {
    UMMapInfo *mapInfo = [[UMMapInfo alloc] init];
    mapInfo.coordinate = mapView.centerCoordinate;
    return mapInfo;
}
- (void)showUserLocation:(BOOL)show {
    self.mapView.showsUserLocation = show;
}
- (void)showCenterAnnotation:(BOOL)show {
    self.config.showCenterPoint = show;
    self.centerPointImageView.hidden = !show;
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
