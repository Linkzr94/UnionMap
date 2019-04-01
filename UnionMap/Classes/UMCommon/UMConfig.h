//
//  UMConfig.h
//  Pods-UnionMap_Example
//
//  Created by SummerSoft.CQ on 2019/3/29.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol UMConfigDelegate <NSObject>

- (void)currentLocation;

@end

@interface UMConfig : NSObject

@property (nonatomic, weak) id<UMConfigDelegate> delegate;

@property (nonatomic) CGRect frame;

- (void)currentLocation;

@end

NS_ASSUME_NONNULL_END
