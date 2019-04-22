//
//  UMViewController.m
//  UnionMap
//
//  Created by nullcex on 03/29/2019.
//  Copyright (c) 2019 nullcex. All rights reserved.
//

#import "UMViewController.h"
#import "UMOperateView.h"
#import "UMSearchListVC.h"

#import <Masonry/Masonry.h>
#import <UnionMap.h>

typedef void(^CompletationBlock)(UMTip *tip);

@interface UMViewController () <UMResponderDelegate>

@property (nonatomic) UMConfig *config;
@property (nonatomic) UMRequest *request;
@property (nonatomic) UMResponder *responder;

@property (nonatomic) UMOperateView *opView;
@property (nonatomic) UMSearchListVC *searchList;
@property (nonatomic) UIButton *cancelRouteBtn;

@property (nonatomic) CLLocationCoordinate2D startLoc;
@property (nonatomic) CLLocationCoordinate2D endLoc;

@end

@implementation UMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initConfigure];
    [self initView];
    [self.config currentLocation];
}

- (void)initConfigure {
    [[UMManager shareInstance] setApiKey:@"85a1be5766422a009fed754df3578d65" forMap:MapTypeAMap];
    
    self.config = [[UMConfig alloc] init];  //创建地图配置对象，修改配置以调整地图
    self.config.frame = self.view.bounds;
    self.config.centerPointImage = @"map_icon_position";
    
    self.request = [[UMRequest alloc] init];
    self.responder = [[UMResponder alloc] init];    //创建地图相应对象，地图回调通过相应对象接受处理
    self.responder.delegate = self;
}
- (void)initView {
    self.view.backgroundColor = [UIColor whiteColor];
    //将config,request和responder绑定到地图，并返回地图视图，对request和responder的处理能响应到地图和config，为防止直接对地图做处理
    //identitier为用于管理adepter对象以免被释放
    UIView *mapView = (UIView *)[[UMManager shareInstance] initAdepter:MapTypeAMap
                                                                config:self.config
                                                               request:self.request
                                                             responder:self.responder
                                                            identifier:@"AMapView"];
    [self.view addSubview:mapView];
    [mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.leading.trailing.equalTo(@0);
    }];
    
    __weak typeof(self) weakSelf = self;
    self.opView = [[UMOperateView alloc] init];
    [self.opView setStartAction:^{
        [weakSelf showSearchList:^(UMTip *tip) {
            weakSelf.startLoc = tip.location;
            [weakSelf.opView setStartLocation:tip.name];
        }];
    }];
    [self.opView setEndAction:^{
        [weakSelf showSearchList:^(UMTip *tip) {
            weakSelf.endLoc = tip.location;
            [weakSelf.opView setEndLocation:tip.name];
            [weakSelf.request drivingRouteWithOrigin:weakSelf.startLoc destination:weakSelf.endLoc];
        }];
    }];
    [self.opView setLocationAction:^{
        [weakSelf.config currentLocation];
    }];
    [self.view addSubview:self.opView];
    [self.opView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@15);
        make.trailing.bottom.equalTo(@-15);
    }];
    
    self.cancelRouteBtn = [[UIButton alloc] init];
    [self.cancelRouteBtn setImage:[UIImage imageNamed:@"map_location"] forState:(UIControlStateNormal)];
    [self.cancelRouteBtn addTarget:self action:@selector(cancelRouteAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.cancelRouteBtn];
    [self.cancelRouteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@35);
        make.trailing.equalTo(@-15);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    self.cancelRouteBtn.hidden = YES;
}

- (void)cancelRouteAction {
    self.cancelRouteBtn.hidden = YES;
    self.opView.hidden = NO;
    [self.request removeRouteRenderer];
    [self.config currentLocation];
}

#pragma mark -- #####   UMResponderDelegate   #####
//mapview
- (void)responder:(UMResponder *)responder mapInfo:(UMMapInfo *)mapInfo mapWillMoveByUser:(BOOL)wasUserAction {
    [self.opView setStartLocation:@"正在获取上车地点。。。"];
}
//search
- (void)responder:(UMResponder *)responder onReGeocodeSearchDone:(UMSearchResponse *)response {
    self.startLoc = response.regeocode.location;
    [self.opView setStartLocation:response.regeocode.formattedAddress];
}
- (void)responder:(UMResponder *)responder onInputTipsSearchDone:(UMSearchResponse *)response {
    [self.searchList updateSearchList:response.tips];
}
- (void)responderOnRouteSearchDone:(UMResponder *)responder {
    self.opView.hidden = YES;
    self.cancelRouteBtn.hidden = NO;
}

- (void)showSearchList:(CompletationBlock)completation {
    __weak typeof(self) weakSelf = self;
    self.searchList = [[UMSearchListVC alloc] init];
    [self addChildViewController:self.searchList];
    [self.view addSubview:self.searchList.view];
    [self.searchList.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.equalTo(@15);
        make.bottom.trailing.equalTo(@-15);
    }];
    [self.searchList setDismissAction:^(UMTip * _Nonnull tip) {
        [weakSelf.searchList removeFromParentViewController];
        [weakSelf.searchList.view removeFromSuperview];
        !completation ? : completation(tip);
    }];
    [self.searchList setSearchForKeyword:^(NSString * _Nonnull keyword) {
        [weakSelf.request searchInputTips:keyword city:@"厦门" cityLimit:YES types:@"" location:@""];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[UMManager shareInstance] removeAdepterForIdentifier:@"AMapView"];
}

@end
