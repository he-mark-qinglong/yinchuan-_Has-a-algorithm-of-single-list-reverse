//
//  BaiDuMapManager.m
//  PudongTravel
//
//  Created by duwei on 14-4-10.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "BaiDuMapManager.h"

@interface BaiDuMapManager ()

@property (strong, nonatomic) BMKMapManager *mapManager;
@property (strong, nonatomic) BMKUserLocation *userLocation;

@end

static BaiDuMapManager * BDMManager = nil;
@implementation BaiDuMapManager

+(BaiDuMapManager*)ShareInstrance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        BDMManager = [[self alloc] init];
        [BDMManager BDMKeyInit];
    });
    return BDMManager;
}

- (void)BDMKeyInit
{
    self.mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:BAIDU_DITU_KEY  generalDelegate:nil];
    if (!ret) {
        NSLog(@"Map manager start failed!");
    }
    self.userLocation = [[BMKUserLocation alloc] init];;
    self.userLocation.delegate = self;
    [self BDMStartUserLocationService];
}

- (void)BDMStartUserLocationService
{
    [self.userLocation startUserLocationService];
}

- (void)BDMStopUserLocationService
{
    [self.userLocation stopUserLocationService];
}

- (void)setBDMUserLocationDelegate:(id<BMKUserLocationDelegate>)delegate
{
    self.userLocation.delegate = delegate;
}

#pragma mark - BMKUserLocationDelegate methods
- (void)viewDidGetLocatingUser:(CLLocationCoordinate2D)userLoc
{
    _currentLocation = userLoc;
    NSLog(@"BaiDuMapManager_currentLocation = %lf,%lf",userLoc.latitude,userLoc.longitude);
    [[BaiDuMapManager ShareInstrance] BDMStopUserLocationService];
}

@end
