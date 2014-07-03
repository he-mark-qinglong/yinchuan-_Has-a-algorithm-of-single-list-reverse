//
//  implBMKSearchDelegate.m
//  PudongTravel
//
//  Created by mark on 14-5-27.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "implBMKSearchDelegate.h"
#import "AlertViewHandle.h"
#import "BDMRouteAnnotation.h"

@implementation implBMKSearchDelegate
@synthesize mapView = _mapView;

#pragma mark - BMKSearchDelegate
- (void)onGetPoiResult:(NSArray*)poiResultList searchType:(int)type errorCode:(int)error{
    // 清楚屏幕中所有的annotation
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
	[_mapView removeAnnotations:array];
    
    if (error == BMKErrorOk) {
		BMKPoiResult* result = [poiResultList objectAtIndex:0];
		for (int i = 0; i < result.poiInfoList.count; i++) {
            BMKPoiInfo* poi = [result.poiInfoList objectAtIndex:i];
            BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
            item.coordinate = poi.pt;
            item.title = poi.name;
            NSLog(@"%@", poi.name);
            [_mapView addAnnotation:item];
            if(i == 0){
                //将第一个点的坐标移到屏幕中央
                _mapView.centerCoordinate = poi.pt;
                
            }
		}
	} else if (error == BMKErrorRouteAddr){
        NSLog(@"起始点有歧义");
    } else {
        // 各种情况的判断。。。
    }
}

//公交车查询
- (void)onGetTransitRouteResult:(BMKPlanResult*)result errorCode:(int)error{
    if(!result){
        [AlertViewHandle showAlertViewWithMessage:@"没有查到相关路线"];
        return;
    }
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
	[_mapView removeAnnotations:array];
	array = [NSArray arrayWithArray:_mapView.overlays];
	[_mapView removeOverlays:array];
    if (error == BMKErrorOk) {
		BMKTransitRoutePlan* plan = (BMKTransitRoutePlan*)[result.plans objectAtIndex:0];
		BDMRouteAnnotation* item = [[BDMRouteAnnotation alloc]init];
		item.coordinate = plan.startPt;
		item.title = @"起点";
		item.annotationType = BDMPositionStartPoint;
		[_mapView addAnnotation:item]; // 添加起点标注
        
		item = [[BDMRouteAnnotation alloc]init];
		item.coordinate = plan.endPt;
		item.annotationType = BDMPositionEndPoint;
		item.title = @"终点";
		[_mapView addAnnotation:item]; // 终点标注
		
        // 计算路线方案中的点数
		int size = [plan.lines count];
		int planPointCounts = 0;
		for (int i = 0; i < size; i++) {
			BMKRoute* route = [plan.routes objectAtIndex:i];
			for (int j = 0; j < route.pointsCount; j++) {
				int len = [route getPointsNum:j];
				planPointCounts += len;
			}
			BMKLine* line = [plan.lines objectAtIndex:i];
			planPointCounts += line.pointsCount;
			if (i == size - 1) {
				i++;
				route = [plan.routes objectAtIndex:i];
				for (int j = 0; j < route.pointsCount; j++) {
					int len = [route getPointsNum:j];
					planPointCounts += len;
				}
				break;
			}
		}
		
        // 构造方案中点的数组，用户构建BMKPolyline
		BMKMapPoint* points = new BMKMapPoint[planPointCounts];
		planPointCounts = 0;
		
        // 查询队列中的元素，构建points数组，并添加公交标注
		for (int i = 0; i < size; i++) {
			BMKRoute* route = [plan.routes objectAtIndex:i];
			for (int j = 0; j < route.pointsCount; j++) {
				int len = [route getPointsNum:j];
				BMKMapPoint* pointArray = (BMKMapPoint*)[route getPoints:j];
				memcpy(points + planPointCounts, pointArray, len * sizeof(BMKMapPoint));
				planPointCounts += len;
			}
			BMKLine* line = [plan.lines objectAtIndex:i];
			memcpy(points + planPointCounts, line.points, line.pointsCount * sizeof(BMKMapPoint));
			planPointCounts += line.pointsCount;
			
			item = [[BDMRouteAnnotation alloc]init];
			item.coordinate = line.getOnStopPoiInfo.pt;
			item.title = line.tip;
			if (line.type == 0) {
				item.annotationType = BDMPositionBusPoint;
			} else {
				item.annotationType = BDMPositionMetroPoint;
			}
			
			[_mapView addAnnotation:item]; // 上车标注
            
			route = [plan.routes objectAtIndex:i+1];
			item = [[BDMRouteAnnotation alloc]init];
			item.coordinate = line.getOffStopPoiInfo.pt;
			item.title = route.tip;
			if (line.type == 0) {
				item.annotationType = BDMPositionBusPoint;
			} else {
				item.annotationType = BDMPositionMetroPoint;
			}
			[_mapView addAnnotation:item]; // 下车标注
			if (i == size - 1) {
				i++;
				route = [plan.routes objectAtIndex:i];
				for (int j = 0; j < route.pointsCount; j++) {
					int len = [route getPointsNum:j];
					BMKMapPoint* pointArray = (BMKMapPoint*)[route getPoints:j];
					memcpy(points + planPointCounts, pointArray, len * sizeof(BMKMapPoint));
					planPointCounts += len;
				}
				break;
			}
		}
        
        // 通过points构建BMKPolyline
		BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:points count:planPointCounts];
		[_mapView addOverlay:polyLine]; // 添加路线overlay
		delete []points;
        
        [_mapView setCenterCoordinate:result.startNode.pt animated:YES];
	}
}
//开车路线查询
- (void)onGetDrivingRouteResult:(BMKPlanResult*)result errorCode:(int)error{
    if(!result || error){
        [AlertViewHandle showAlertViewWithMessage:@"没有查到相关路线"];
        return;
    }
    if (result != nil) {
        NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
        [_mapView removeAnnotations:array];
        array = [NSArray arrayWithArray:_mapView.overlays];
        [_mapView removeOverlays:array];
        
        // error 值的意义请参考BMKErrorCode
        if (error == BMKErrorOk) {
            BMKRoutePlan* plan = (BMKRoutePlan*)[result.plans objectAtIndex:0];
            
            // 添加起点
            BDMRouteAnnotation* item = [[BDMRouteAnnotation alloc]init];
            item.coordinate = result.startNode.pt;
            item.title = @"起点";
            item.annotationType = BDMPositionStartPoint;
            [_mapView addAnnotation:item];
            
            
            // 下面开始计算路线，并添加驾车提示点
            int index = 0;
            int size = [plan.routes count];
            for (int i = 0; i < 1; i++) {
                BMKRoute* route = [plan.routes objectAtIndex:i];
                for (int j = 0; j < route.pointsCount; j++) {
                    int len = [route getPointsNum:j];
                    index += len;
                }
            }
            
            BMKMapPoint* points = new BMKMapPoint[index];
            index = 0;
            for (int i = 0; i < 1; i++) {
                BMKRoute* route = [plan.routes objectAtIndex:i];
                for (int j = 0; j < route.pointsCount; j++) {
                    int len = [route getPointsNum:j];
                    BMKMapPoint* pointArray = (BMKMapPoint*)[route getPoints:j];
                    memcpy(points + index, pointArray, len * sizeof(BMKMapPoint));
                    index += len;
                }
//                size = route.steps.count;
//                for (int j = 0; j < size; j++) {
//                    // 添加驾车关键点
//                    BMKStep* step = [route.steps objectAtIndex:j];
//                    item = [[BDMRouteAnnotation alloc]init];
//                    item.coordinate = step.pt;
//                    item.title = step.content;
//                    item.annotationType = BDMPositionDrivingPoint;
//                    [_mapView addAnnotation:item];
//                }
            }
            
            // 添加终点
            item = [[BDMRouteAnnotation alloc]init];
            item.coordinate = result.endNode.pt;
            item.annotationType = BDMPositionEndPoint;
            item.title = @"终点";
            [_mapView addAnnotation:item];
            
            // 添加途经点
//            if (result.wayNodes) {
//                for (BMKPlanNode* tempNode in result.wayNodes) {
//                    item = [[BDMRouteAnnotation alloc]init];
//                    item.coordinate = tempNode.pt;
//                    item.annotationType = BDMPosttionWalkPoint;
//                    item.title = tempNode.name;
//                    [_mapView addAnnotation:item];
//                }
//            }
            
            // 根究计算的点，构造并添加路线覆盖物
            BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:points count:index];
            [_mapView addOverlay:polyLine];
            delete []points;
            
            [_mapView setCenterCoordinate:result.startNode.pt animated:YES];
        }
    }
}
- (void)onGetWalkingRouteResult:(BMKPlanResult*)result errorCode:(int)error{
}
- (void)onGetAddrResult:(BMKAddrInfo*)result errorCode:(int)error{
}
- (void)onGetSuggestionResult:(BMKSuggestionResult*)result errorCode:(int)error{
}
- (void)onGetBusDetailResult:(BMKBusLineResult*)busLineResult errorCode:(int)error{
}
- (void)onGetShareUrl:(NSString*) url withType:(BMK_SHARE_URL_TYPE) urlType errorCode:(int)error{
}

@end
