//
//  AMapViewProxy.m
//  CTMediator
//
//  Created by SummerSoft.CQ on 2019/4/9.
//

#import "AMapViewProxy.h"

@implementation AMapViewProxy

//计算路线polyline，提交地图展示
- (void)calPolylineByResponse:(AMapRouteSearchResponse *)response forMapView:(MAMapView *)mapView {
    if (!response.route || response.route.paths.count == 0) {
        return ;
    }
    AMapPath *path = response.route.paths[0];
    for (AMapStep *step in path.steps) {
        uint i = 0;
        NSArray *pointArr = [step.polyline componentsSeparatedByString:@";"];
        CLLocationCoordinate2D *polylineCoord = (CLLocationCoordinate2D *)malloc(pointArr.count * sizeof(CLLocationCoordinate2D));
        for (NSString *pointStr in pointArr) {
            if (pointStr.length == 0) continue;
            NSArray *coordArr = [pointStr componentsSeparatedByString:@","];
            polylineCoord[i].longitude = [coordArr[0] doubleValue];
            polylineCoord[i].latitude = [coordArr[1] doubleValue];
            i++;
        }
        MAPolyline *polyline = [MAPolyline polylineWithCoordinates:polylineCoord count:i];
        [mapView addOverlay:polyline];
        free(polylineCoord);
        polylineCoord = NULL;
    }
    //计算整段路线的外接矩阵,用于缩放地图展示全段路线
    NSInteger count = mapView.overlays.count;
    MAMapRect *buffer = (MAMapRect *)malloc(count * sizeof(MAMapRect));
    [mapView.overlays enumerateObjectsUsingBlock:^(id<MAOverlay> obj, NSUInteger idx, BOOL * _Nonnull stop) {
        buffer[idx] = [obj boundingMapRect];
    }];
    MAMapRect unionRect;
    if (buffer == NULL || count == 0) {
        unionRect = MAMapRectZero;
    }
    unionRect = buffer[0];
    for (int i = 1; i < count; i++) {
        CGRect rect1 = CGRectMake(unionRect.origin.x, unionRect.origin.y, unionRect.size.width, unionRect.size.height);
        CGRect rect2 = CGRectMake(buffer[i].origin.x, buffer[i].origin.y, buffer[i].size.width, buffer[i].size.height);
        CGRect bufRect = CGRectUnion(rect1, rect2);
        unionRect = MAMapRectMake(bufRect.origin.x, bufRect.origin.y, bufRect.size.width, bufRect.size.height);
    }
    free(buffer);
    [mapView setVisibleMapRect:unionRect edgePadding:UIEdgeInsetsMake(50, 50, 50, 50) animated:YES];
}

@end
