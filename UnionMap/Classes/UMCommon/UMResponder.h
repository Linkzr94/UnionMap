//
//  UMResponder.h
//  CTMediator
//
//  Created by SummerSoft.CQ on 2019/4/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol UMResponderDelegate <NSObject>

@end

@interface UMResponder : NSObject

@property (nonatomic, weak) id<UMResponderDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
