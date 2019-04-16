//
//  UMOperateView.m
//  UnionMap_Example
//
//  Created by SummerSoft.CQ on 2019/4/4.
//  Copyright © 2019 nullcex. All rights reserved.
//

#import "UMOperateView.h"
#import <Masonry/Masonry.h>

@interface UMOperateView ()

@property (nonatomic) UIButton *startBtn;
@property (nonatomic) UIButton *endBtn;
@property (nonatomic) UIButton *locBtn;

@end

@implementation UMOperateView

- (instancetype)init {
    if (self = [super init]) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    self.backgroundColor = [UIColor clearColor];
    
    self.startBtn = [[UIButton alloc] init];
    [self.startBtn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    [self.startBtn setBackgroundColor:[UIColor whiteColor]];
    [self.startBtn addTarget:self action:@selector(startClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.startBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self addSubview:self.startBtn];
    
    self.endBtn = [[UIButton alloc] init];
    [self.endBtn setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
    [self.endBtn setBackgroundColor:[UIColor whiteColor]];
    [self.endBtn addTarget:self action:@selector(endClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.endBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self addSubview:self.endBtn];
    
    self.locBtn = [[UIButton alloc] init];
    [self.locBtn setImage:[UIImage imageNamed:@"map_location"] forState:(UIControlStateNormal)];
    [self.locBtn addTarget:self action:@selector(locationClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:self.locBtn];
    
    [self.endBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.leading.bottom.equalTo(@0);
        make.height.equalTo(@50);
    }];
    [self.startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(@0);
        make.bottom.equalTo(self.endBtn.mas_top);
        make.height.equalTo(self.endBtn.mas_height);
    }];
    [self.locBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.with.equalTo(@27);
        make.leading.top.equalTo(@0);
        make.bottom.equalTo(self.startBtn.mas_top).offset(-20);
    }];
}

- (void)startClick {
    !self.startAction ? : self.startAction();
}

- (void)endClick {
    !self.endAction ? : self.endAction();
}

- (void)locationClick {
    !self.locationAction ? : self.locationAction();
}

- (void)setStartLocation:(NSString *)startLocation {
    [self.startBtn setTitle:startLocation forState:(UIControlStateNormal)];
}

- (void)setEndLocation:(NSString *)endLocation {
    [self.endBtn setTitle:endLocation forState:(UIControlStateNormal)];
}

@end
