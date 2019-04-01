//
//  UMViewController.m
//  UnionMap
//
//  Created by nullcex on 03/29/2019.
//  Copyright (c) 2019 nullcex. All rights reserved.
//

#import "UMViewController.h"
#import <UnionMap.h>

@interface UMViewController () <UMResponderDelegate>

@property (nonatomic) UMConfig *config;
@property (nonatomic) UMResponder *responder;

@end

@implementation UMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[UMManager shareInstance] setApiKey:@"85a1be5766422a009fed754df3578d65" forMap:MapTypeAMap];
    
    self.config = [[UMConfig alloc] init];  //创建地图配置对象，修改配置以调整地图
    self.config.frame = self.view.bounds;
    
    self.responder = [[UMResponder alloc] init];    //创建地图相应对象，地图回调通过相应对象接受处理
    self.responder.delegate = self;
    
    //将config和responder绑定到地图，并返回地图视图，对config和responder的处理能响应到地图，为防止直接对地图做处理
    UIView *mapView = (UIView *)[[UMManager shareInstance] initAdepter:MapTypeAMap
                                                                 config:self.config
                                                             responder: self.responder
                                                            identifier:@"AMapView"];
    [self.view addSubview:mapView];
    
    [self.config currentLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [[UMManager shareInstance] removeAdepterForIdentifier:@"AMapView"];
}

@end
