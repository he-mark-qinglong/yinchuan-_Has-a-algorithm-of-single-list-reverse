//
//  AppDelegate.h
//  YinChuan
//
//  Created by mark on 14-6-10.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate>
{
    BMKMapManager* _mapManager;
}

@property (strong, nonatomic) UIWindow *window;

@end
