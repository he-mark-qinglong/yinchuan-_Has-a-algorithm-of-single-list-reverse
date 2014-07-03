//
//  BDMapBaseViewController.h
//  PudongTravel
//
//  Created by duwei on 14-4-11.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaiDuMapManager.h"
#import "BDMRouteAnnotation.h"

@interface BDMapBaseViewController : UIViewController<BMKUserLocationDelegate>

@property (strong, nonatomic) IBOutlet BMKMapView *mapView;
@property (strong, nonatomic) BMKSearch *bdMapSearch;

//初始化一个BDMRouteAnnotation标记
- (BDMRouteAnnotation*)BDMRouteAnnotationInit:(CLLocationCoordinate2D)location BDMPositionType:(BDMPosition)annotationType;
-(void)setMapCircle:(float)r;
//地图居中
- (void)setMapCenter:(CLLocationCoordinate2D)center;

//地图标记添加
- (void)addPointAnnotation:(BDMRouteAnnotation*)pointAnnotation;

//放大一级尺寸
- (IBAction)zoomIn;

//减小尺寸
- (IBAction)zoomOut;

//定位当前位置
- (IBAction)orientateLocation;

//地图类型
- (IBAction)changeMapType:(id)sender;

//地图缩放等级 3 ~ 19
- (IBAction)zoomLevelChange:(CGFloat)level;

//地图旋转角度，在手机上当前可使用的范围为－180～180度
- (IBAction)rotationAngle:(CGFloat)angle;

//指南针位置
- (void)setMapScaleBarPosition:(CGPoint)CGPointFrame;

//地图俯视角度，在手机上当前可使用的范围为－45～0度
- (IBAction)overLooking:(CGFloat)angle;

//缩放开关
- (void)zoomEnabled:(BOOL)enable;

//平移开关
- (void)moveEnabled:(BOOL)enable;

//比例尺
- (void)scaleEnabled:(BOOL)enable position:(CGPoint)CGPointFrame;

//普通态
- (IBAction)startLocation:(id)sender;

//罗盘态
- (IBAction)startFollowHeading:(id)sender;

//跟随态
- (IBAction)startFollowing:(id)sender;

//停止定位
- (IBAction)stopLocation:(id)sender;

//详细地址查询，如广中西路444号,
//返回结果在BMKSearchDelegate的onGetAddrResult通知
- (BOOL)geocode:(NSString*)addr withCity:(NSString*)city;

//根据地理坐标获取地址信息
//返回结果在BMKSearchDelegate的onGetAddrResult通知
- (BOOL)reverseGeocode:(CLLocationCoordinate2D)center;

//在xx城市搜索xx目的地，第一次搜索, 结果在 - (void)onGetPoiResult:(BMKSearch*)searcher result:(NSArray*)poiResultList searchType:(int)type errorCode:(int)error
- (BOOL)poiSearchInCity:(NSString*)city withKey:(NSString*)key;

//在xx城市搜索xx目的地，下组数据
- (BOOL)poiSearchInCityNext:(NSString*)city withKey:(NSString*)key;

//计算两经纬度之间的距离
- (CLLocationDistance)distanceWithCoordinate1:(CLLocationCoordinate2D)coordinate1 coordinate2:(CLLocationCoordinate2D)coordinate2;

//目标经纬度路线
- (void)addRounteLineWithTargetLocation:(CLLocationCoordinate2D)targetLocation;

//路线查询  公交，驾乘，步行
- (BOOL)onBusSearchString:(NSString*)city startString:(NSString*)startString endString:(NSString*)endString BDMtype:(BDMPosition)type;

//公交途径站查询
//返回结果在BMKSearchDelegate的onGetPoiResult通知 种调用busLineSearch
- (BOOL)busSearchInCity:(NSString*)city withKey:(NSString*)key;


@end
