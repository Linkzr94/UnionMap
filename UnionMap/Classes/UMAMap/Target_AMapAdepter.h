//
//  Target_AMapAdepter.h
//  CTMediator
//
//  Created by SummerSoft.CQ on 2019/4/1.
//

#import <Foundation/Foundation.h>
#import "AMapAdepter.h"
#import "UMManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface Target_AMapAdepter : NSObject

- (void)Action_setApiKey:(NSDictionary *)params;

- (id)Action_initWithConfigAndResponder:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
