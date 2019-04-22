//
//  UMOperateView.h
//  UnionMap_Example
//
//  Created by SummerSoft.CQ on 2019/4/4.
//  Copyright © 2019 nullcex. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef dispatch_block_t Action;

@interface UMOperateView : UIView

@property (nonatomic, copy) Action startAction;
@property (nonatomic, copy) Action endAction;
@property (nonatomic, copy) Action locationAction;

- (void)setStartLocation:(NSString *)startLocation;
- (void)setEndLocation:(NSString *)endLocation;

@end

NS_ASSUME_NONNULL_END
