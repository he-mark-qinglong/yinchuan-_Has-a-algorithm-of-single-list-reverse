//
//  BDMapBaseViewController.m
//  PudongTravel
//
//  Created by duwei on 14-4-11.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "BDMapBaseViewController.h"
//#import "UIImage+loadImage.h"
#import "BDMRouteAnnotation.h"

@interface BDMapBaseViewController ()
{
    CLLocationCoordinate2D _currentLocation;
    int curPage;
}

@property (nonatomic, retain) IBOutlet UISegmentedControl* segment;

@end

@implementation BDMapBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[BaiDuMapManager ShareInstrance] setBDMUserLocationDelegate:self];
    
    [self mapViewInit];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   // [[BaiDuMapManager ShareInstrance] BDMStartUserLocationService];
    [self.mapView viewWillAppear];
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil;
    self.mapView.showsUserLocation = NO;
    self.bdMapSearch.delegate = nil;
}

- (void)mapViewInit
{
    self.mapView.showsUserLocation = YES;
    self.bdMapSearch = [[BMKSearch alloc] init];
    [self setMapCenter:[BaiDuMapManager ShareInstrance].currentLocation];
}

- (void)mapViewDisplay
{
    self.mapView.centerCoordinate = _currentLocation;
    [self setMapCenter:_currentLocation];
}

#pragma -mark public methords

//初始化一个BDMRouteAnnotation标记
- (BDMRouteAnnotation*)BDMRouteAnnotationInit:(CLLocationCoordinate2D)location BDMPositionType:(BDMPosition)annotationType
{
    BDMRouteAnnotation *pointAnnotation = [[BDMRouteAnnotation alloc] init];
    CLLocationCoordinate2D coordinate;
    coordinate.longitude = location.longitude;
    coordinate.latitude = location.latitude;
    pointAnnotation.annotationType = annotationType;
    pointAnnotation.coordinate = coordinate;
    return pointAnnotation;
}
-(void)setMapCircle:(float)r{
    static const int km = 1000;
    BMKCoordinateRegion region = BMKCoordinateRegionMakeWithDistance(self.mapView.centerCoordinate,
                                                                     r * km, r * km * 640 / 1136);
    BMKCoordinateRegion newRegion = [self.mapView regionThatFits:region];
    [self.mapView setRegion:newRegion animated:NO];
}
//地图居中
- (void)setMapCenter:(CLLocationCoordinate2D)center
{
    static const int km = 1000;
    static const float r = 2.5;
    BMKCoordinateRegion region = BMKCoordinateRegionMakeWithDistance(center, r * km, r * km * 640 / 1136);
    BMKCoordinateRegion newRegion = [self.mapView regionThatFits:region];
     
    [self.mapView setRegion:newRegion animated:NO];
}

//地图标记添加
- (void)addPointAnnotation:(BDMRouteAnnotation*)pointAnnotation
{
    [self.mapView addAnnotation:pointAnnotation];
}

//放大一级尺寸
- (IBAction)zoomIn
{
    [self.mapView zoomIn];
}

//减小尺寸
- (IBAction)zoomOut
{
    [self.mapView zoomOut];
}

//定位当前位置
- (void)orientateLocation
{
    self.mapView.centerCoordinate = _currentLocation;
}

- (IBAction)changeMapType:(id)sender
{
     int index = _segment.selectedSegmentIndex;
    switch (index) {
        case 0:
            _mapView.mapType = BMKMapTypeStandard;
            break;
        case 1:
            _mapView.mapType = BMKMapTypeSatellite;
            break;
        case 2:
            _mapView.mapType = BMKMapTypeTrafficOn;
            break;
        case 3:
            _mapView.mapType = BMKMapTypeTrafficAndSatellite;
            break;
        default:
            break;
    }

}

- (IBAction)zoomLevelChange:(CGFloat)level
{
    // 地图比例尺级别，在手机上当前可使用的级别为3-19级
    _mapView.zoomLevel = level;
    
}

- (IBAction)rotationAngle:(CGFloat)angle
{
    _mapView.rotation = angle;
}

- (IBAction)overLooking:(CGFloat)angle
{
    //地图俯视角度，在手机上当前可使用的范围为－45～0度
    _mapView.overlooking = angle;
}

//指南针位置
- (void)setMapScaleBarPosition:(CGPoint)CGPointFrame
{
    _mapView.mapScaleBarPosition = CGPointFrame;
}

- (void)zoomEnabled:(BOOL)enable
{
    _mapView.zoomEnabled = enable;
}

- (void)moveEnabled:(BOOL)enabel
{
    _mapView.scrollEnabled = enabel;
}

- (void)scaleEnabled:(BOOL)enable position:(CGPoint)CGPointFrame
{
    _mapView.showMapScaleBar = enable;
    //自定义比例尺的位置
    _mapView.mapScaleBarPosition = CGPointFrame;
}

//普通态
- (IBAction)startLocation:(id)sender
{
    NSLog(@"进入普通定位态");
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
}

//罗盘态
- (IBAction)startFollowHeading:(id)sender
{
    NSLog(@"进入罗盘态");
    _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode = BMKUserTrackingModeFollowWithHeading;
    _mapView.showsUserLocation = YES;
    
}
//跟随态
- (IBAction)startFollowing:(id)sender
{
    NSLog(@"进入跟随态");
    _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;
    _mapView.showsUserLocation = YES;
    
}
//停止定位
- (IBAction)stopLocation:(id)sender
{
    _mapView.userTrackingMode = BMKUserTrackingModeNone;
    _mapView.showsUserLocation = NO;
}

- (BOOL)poiSearchInCity:(NSString*)city withKey:(NSString*)key
{
    curPage = 0;
    //城市内检索，请求发送成功返回YES，请求发送失败返回NO
	BOOL flag = [_bdMapSearch poiSearchInCity:city withKey:key pageIndex:curPage];
	if (flag) {
        //_nextPageButton.enabled = true;
        return YES;
	}
    else{
       // _nextPageButton.enabled = false;
        return NO;
    }
}

- (BOOL)poiSearchInCityNext:(NSString*)city withKey:(NSString*)key;
{
    curPage ++;
    //城市内检索，请求发送成功返回YES，请求发送失败返回NO
	BOOL flag = [_bdMapSearch poiSearchInCity:city withKey:key pageIndex:curPage];
	if (flag) {
        return YES;
	}
    else{
        return NO;
    }
}

- (BOOL)geocode:(NSString*)addr withCity:(NSString*)city
{
    return [_bdMapSearch geocode:addr withCity:city];
}

- (BOOL)reverseGeocode:(CLLocationCoordinate2D)center
{
    return [_bdMapSearch reverseGeocode:center];
}

//计算两经纬度之间的距离
- (CLLocationDistance)distanceWithCoordinate1:(CLLocationCoordinate2D)coordinate1 coordinate2:(CLLocationCoordinate2D)coordinate2
{
    BMKMapPoint point1 = BMKMapPointForCoordinate(coordinate1);
    
    BMKMapPoint point2 = BMKMapPointForCoordinate(coordinate2);
    CLLocationDistance distance = BMKMetersBetweenMapPoints(point1, point2);
    return distance;
}

//目标经纬度路线
- (void)addRounteLineWithTargetLocation:(CLLocationCoordinate2D)targetLocation
{
    BMKPlanNode* start = [[BMKPlanNode alloc]init];
	start.pt = _currentLocation;
	BMKPlanNode* end = [[BMKPlanNode alloc]init];
    end.pt = targetLocation;
    
    NSMutableArray * array = [[NSMutableArray alloc] initWithCapacity:10];
    BMKPlanNode* wayPointItem1 = [[BMKPlanNode alloc]init];
    wayPointItem1.cityName = @"上海";
    [array addObject:wayPointItem1];
    
	BOOL flag = [self.bdMapSearch drivingSearch:@"上海"
                                      startNode:start
                                        endCity:@"上海"
                                        endNode:end
                               throughWayPoints:array];
	if (flag) {
		NSLog(@"search success.");
	}else{
        NSLog(@"search failed!");
    }
}

- (BOOL)onBusSearchString:(NSString*)city startString:(NSString*)startString endString:(NSString*)endString BDMtype:(BDMPosition)type
{
    BMKPlanNode* startNode = [[BMKPlanNode alloc]init];
	startNode.name = startString;
	BMKPlanNode* endNode = [[BMKPlanNode alloc]init];
	endNode.name = endString;
    switch (type)
    {
        case BDMPositionBusPoint:
            return [_bdMapSearch transitSearch:city startNode:startNode endNode:endNode];
            break;
        case BDMPositionDrivingPoint:
            return [_bdMapSearch drivingSearch:city startNode:startNode endCity:city endNode:endNode];
            break;
        case BDMPosttionWalkPoint:
            return  [_bdMapSearch walkingSearch:city startNode:startNode endCity:city endNode:endNode];
            break;
        default:
            break;
    
    }
    return NO;
}

- (BOOL)busSearchInCity:(NSString*)city withKey:(NSString*)key
{
    return [_bdMapSearch poiSearchInCity:city withKey:key pageIndex:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - BMKUserLocationDelegate methods
- (void)viewDidGetLocatingUser:(CLLocationCoordinate2D)userLoc
{
    _currentLocation = userLoc;
//    NSLog(@"_currentLocation = %lf,%lf",userLoc.latitude,userLoc.longitude);
    [[BaiDuMapManager ShareInstrance] BDMStopUserLocationService];
    [self mapViewDisplay];
}


@end
