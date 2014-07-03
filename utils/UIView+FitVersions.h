//
//  UIView+FitVersions.h
//  PudongTravel
//
//  Created by duwei on 14-4-9.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FitVersions)

- (void)FitViewOffsetY;
- (void)FitViewHeight;
- (void)FitViewOffsetYSubtract;
-(void)moveDownY:(NSInteger)y;
@end
