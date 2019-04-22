//
//  UMSearchListVC.h
//  UnionMap_Example
//
//  Created by SummerSoft.CQ on 2019/4/4.
//  Copyright © 2019 nullcex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UnionMap/UnionMap.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^DismissAction)(UMTip *tip);
typedef void(^SearchPOI)(NSString *keyword);

@interface UMSearchListVC : UIViewController

@property (nonatomic, copy) DismissAction dismissAction;
@property (nonatomic, copy) SearchPOI searchForKeyword;

- (void)updateSearchList:(NSArray<UMTip *> *)list;

@end

NS_ASSUME_NONNULL_END
