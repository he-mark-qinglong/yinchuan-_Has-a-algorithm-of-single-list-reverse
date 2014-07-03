//
//  AlertHandle.h
//  PromotionDemo
//
//  Created by lifuyong on 13-8-15.
//
//

#import <Foundation/Foundation.h>

@interface AlertViewHandle : NSObject <UIAlertViewDelegate>

//+ (id)shareAlertViewHandle;

+ (void)showAlertViewWithMessage:(NSString *)message;
+ (void)showAlertViewWithMessage:(NSString *)message delegate:(id<UIAlertViewDelegate>)delegate;

@end
