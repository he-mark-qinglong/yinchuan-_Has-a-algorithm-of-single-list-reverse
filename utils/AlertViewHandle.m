 //
//  AlertHandle.m
//  PromotionDemo
//
//  Created by lifuyong on 13-8-15.
//
//

#import "AlertViewHandle.h"

@implementation AlertViewHandle

+ (id)shareAlertViewHandle{
    static AlertViewHandle *alertViewhandle;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        alertViewhandle = [[AlertViewHandle alloc] init];
    });
    
    return alertViewhandle;
}

+ (void)showAlertViewWithMessage:(NSString *)message{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:@"确认"
                                              otherButtonTitles: nil];
    
    [alertView show];
    
    [[AlertViewHandle shareAlertViewHandle] performSelector:@selector(dimissAlert:) withObject:alertView afterDelay:0.75];
}

+ (void)showAlertViewWithMessage:(NSString *)message delegate:(id<UIAlertViewDelegate>)delegate{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:message
                                                       delegate:delegate
                                              cancelButtonTitle:@"确认"
                                              otherButtonTitles: nil];
    UIImage *img = [[UIImage alloc] initWithContentsOfFile:@"pages_background.png"];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    [alertView addSubview:imgView];
    [alertView show];
}

- (void) dimissAlert:(UIAlertView *)alert {
    if(alert) {
        [alert dismissWithClickedButtonIndex:[alert cancelButtonIndex] animated:YES];
    }
}

@end
