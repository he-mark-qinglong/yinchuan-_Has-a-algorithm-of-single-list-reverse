//
//  MapViewController.m
//  YinChuan
//
//  Created by mark on 14-6-11.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "MapViewController.h"
#import "BMapKit.h"
@interface MapViewController ()<BMKMapViewDelegate, BMKUserLocationDelegate>

@property (strong, nonatomic) IBOutlet BMKMapView *contentMapView;
@property (strong ,nonatomic) NSString *lat;
@property (strong ,nonatomic) NSString *log;
@property (strong ,nonatomic) NSString *info;

@end

@implementation MapViewController
@synthesize contentMapView = contentMapView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (id)initWithLat:(NSString *)lat Log:(NSString *)log Info:(NSString *)info
{
    if (self = [super init]){
        self.lat = lat;
        self.log = log;
        self.info = info;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void) addpoint
{
    CLLocationCoordinate2D location;
    location.latitude  = [self.lat floatValue];
    location.longitude = [self.log floatValue];
    
    BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc]init];
    annotation.title               = self.info;
    annotation.coordinate          = location;
    [contentMapView addAnnotation:annotation];
}
- (void) viewDidAppear:(BOOL)animated
{
   // [self addpoint];
}
-(void)viewWillAppear:(BOOL)animated
{
    [contentMapView viewWillAppear];
    contentMapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    
    contentMapView.showsUserLocation = YES;
    
    [self addpoint];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [contentMapView viewWillDisappear];
    
    contentMapView.delegate = nil; // 不用时，置nil
}
#pragma mark - BMKMapViewDelegate
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView =
        [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
    }
    return nil;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
