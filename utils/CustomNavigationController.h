//
//  CustomNavigationController.h
//  PudongTravel
//
//  Created by duwei on 14-4-23.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomNavigationController : UINavigationController
- (UIBarButtonItem *)navBarItemWithTarget:(id)target
                                   action:(SEL)action
                                imageName:(NSString*)imgName;
@end
