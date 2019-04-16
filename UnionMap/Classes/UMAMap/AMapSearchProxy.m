//
//  AMapSearchProxy.m
//  CTMediator
//
//  Created by SummerSoft.CQ on 2019/4/9.
//

#import "AMapSearchProxy.h"

@interface AMapSearchProxy () <AMapSearchDelegate>

@property (nonatomic, copy) SearchDone regeocodeSearchDone;
@property (nonatomic, copy) SearchDone poiSearchDone;
@property (nonatomic, copy) SearchDone inputTipSearchDone;

@property (nonatomic, copy) DriveRouteDone drivingRouteSearchDone;

@end

@implementation AMapSearchProxy

- (instancetype)init {
    if (self = [super init]) {
        self.searchApi = [[AMapSearchAPI alloc] init];
        self.searchApi.delegate = self;
    }
    return self;
}

#pragma mark -- #####   SearchMethod   #####
- (void)searchReGeoCodeByLocation:(AMapGeoPoint *)location searchDone:(SearchDone)done {
    AMapReGeocodeSearchRequest *regeoRequest = [[AMapReGeocodeSearchRequest alloc] init];
    regeoRequest.requireExtension = YES;
    regeoRequest.location = location;
    [self.searchApi AMapReGoecodeSearch:regeoRequest];
    self.regeocodeSearchDone = done;
}
- (void)searchPOIByKeyword:(NSString *)keyword city:(NSString *)city types:(NSString *)types searchDone:(SearchDone)done {
    AMapPOIKeywordsSearchRequest *poiRequest = [[AMapPOIKeywordsSearchRequest alloc] init];
    poiRequest.keywords = keyword;
    if (city) poiRequest.city = city;
    if (types) poiRequest.types = types;
    poiRequest.requireExtension = YES;
    poiRequest.cityLimit = YES;
    [self.searchApi AMapPOIKeywordsSearch:poiRequest];
    self.poiSearchDone = done;
}
- (void)searchInputTips:(NSString *)input city:(NSString *)city cityLimit:(BOOL)cityLimit types:(NSString *)types location:(NSString *)location searchDone:(SearchDone)done {
    AMapInputTipsSearchRequest *request = [[AMapInputTipsSearchRequest alloc] init];
    request.keywords = input;
    if (city) request.city = city;
    request.cityLimit = cityLimit;
    if (types) request.types = types;
    if (location) request.location = location;
    [self.searchApi AMapInputTipsSearch:request];
    self.inputTipSearchDone = done;
}
- (void)drivingRouteWithOrigin:(CLLocationCoordinate2D)origin destination:(CLLocationCoordinate2D)destination searchDone:(DriveRouteDone)done {
    AMapDrivingRouteSearchRequest *request = [[AMapDrivingRouteSearchRequest alloc] init];
    request.origin = [AMapGeoPoint locationWithLatitude:origin.latitude longitude:origin.longitude];
    request.destination = [AMapGeoPoint locationWithLatitude:destination.latitude longitude:destination.longitude];
    request.requireExtension = YES;
    request.strategy = 16;  // TODO: 可业务传入配置
    [self.searchApi AMapDrivingRouteSearch:request];
    self.drivingRouteSearchDone = done;
}

#pragma mark -- #####   AMapSearchDelegate   #####
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error {
    if ([request isKindOfClass:[AMapDrivingRouteSearchRequest class]]) {
        // TODO:驾车导航路径获取失败
    }
}
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response {
    if (response) {
        UMSearchResponse *searchResponse = [self convertAMapReGeocodeSearchResponse:response];
        !self.regeocodeSearchDone ? : self.regeocodeSearchDone(searchResponse);
    }
}
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response {
    if (response) {
        UMSearchResponse *searchResponse = [self converAMapPOISearchResponse:response];
        !self.poiSearchDone ? : self.poiSearchDone(searchResponse);
    }
}
- (void)onInputTipsSearchDone:(AMapInputTipsSearchRequest *)request response:(AMapInputTipsSearchResponse *)response {
    if (response) {
        UMSearchResponse *searchResponse = [self convertAMapInputTipsSearchResponse:response];
        !self.inputTipSearchDone ? : self.inputTipSearchDone(searchResponse);
    }
}
- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response {
    !self.drivingRouteSearchDone ? : self.drivingRouteSearchDone(response);
}

#pragma mark -- #####   CommonMethod   #####
//AMapReGeocodeSearchResponse -> UMSearchResponse
- (UMSearchResponse *)convertAMapReGeocodeSearchResponse:(AMapReGeocodeSearchResponse *)response {
    UMSearchResponse *searchResponse = [[UMSearchResponse alloc] init];
    UMReGeocode *regeocode = [[UMReGeocode alloc] init];
    AMapReGeocode *code = response.regeocode;
    regeocode.formattedAddress = code.formattedAddress;
    regeocode.country = code.addressComponent.country;
    regeocode.province = code.addressComponent.province;
    regeocode.city = code.addressComponent.city;
    regeocode.district = code.addressComponent.district;
    regeocode.adcode = code.addressComponent.adcode;
    regeocode.township = code.addressComponent.township;
    regeocode.towncode = code.addressComponent.towncode;
    regeocode.neighborhood = code.addressComponent.neighborhood;
    regeocode.building = code.addressComponent.building;
    regeocode.street = code.addressComponent.streetNumber.street;
    regeocode.number = code.addressComponent.streetNumber.number;
    AMapGeoPoint *loc = code.addressComponent.streetNumber.location;
    regeocode.location = CLLocationCoordinate2DMake(loc.latitude, loc.longitude);
    regeocode.distance = code.addressComponent.streetNumber.distance;
    regeocode.direction = code.addressComponent.streetNumber.direction;
    // TODO: businessAreas, roads, roadinters, pois, aois
    searchResponse.regeocode = regeocode;
    return searchResponse;
}
//AMapPOISearchResponse -> UMSearchResponse
- (UMSearchResponse *)converAMapPOISearchResponse:(AMapPOISearchResponse *)response {
    UMSearchResponse *searchResponse = [[UMSearchResponse alloc] init];
    // TODO:
    return searchResponse;
}
//AMapInputTipsSearchResponse -> UMSearchResponse
- (UMSearchResponse *)convertAMapInputTipsSearchResponse:(AMapInputTipsSearchResponse *)response {
    UMSearchResponse *searchResponse = [[UMSearchResponse alloc] init];
    NSMutableArray *tips = [NSMutableArray array];
    for (AMapTip *aMapTip in response.tips) {
        UMTip *tip = [[UMTip alloc] init];
        tip.uid = aMapTip.uid;
        tip.name = aMapTip.name;
        tip.adcode = aMapTip.adcode;
        tip.district = aMapTip.district;
        tip.address = aMapTip.address;
        tip.location = CLLocationCoordinate2DMake(aMapTip.location.latitude, aMapTip.location.longitude);
        [tips addObject:tip];
    }
    searchResponse.tips = tips;
    return searchResponse;
}

@end
