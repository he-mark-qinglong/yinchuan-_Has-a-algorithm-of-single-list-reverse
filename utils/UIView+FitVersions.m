//
//  UIView+FitVersions.m
//  PudongTravel
//
//  Created by duwei on 14-4-9.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "UIView+FitVersions.h"

#define FitOffsetHeight  64

@implementation UIView (FitVersions)

- (void)FitViewOffsetY{
    if(IOSVersion70){
        CGFloat offsetY = self.frame.origin.y + FitOffsetHeight;
        
        self.frame =  CGRectMake(self.frame.origin.x, offsetY, self.frame.size.width, self.frame.size.height);
    }
}

- (void)FitViewOffsetYSubtract{
    CGFloat offsetY = [UIScreen mainScreen].bounds.size.height - self.frame.size.height;
    if(!IOSVersion70){
        offsetY -= FitOffsetHeight;
    }
    self.frame =  CGRectMake(self.frame.origin.x, offsetY, self.frame.size.width, self.frame.size.height);
}

- (void)FitViewHeight{
    CGFloat height = self.frame.size.height - FitOffsetHeight;
    
    self.frame =  CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width,height);
}

-(void)moveDownY:(NSInteger)y{
    self.frame = self.frame =  CGRectMake(self.frame.origin.x, self.frame.origin.y + y,
                                          self.frame.size.width,self.frame.size.height);
}

@end
