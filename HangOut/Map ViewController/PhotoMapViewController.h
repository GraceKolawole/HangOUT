//
//  PhotoMapViewController.h
//  HangOut
//
//  Created by Oluwanifemi Kolawole on 7/26/22.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhotoMapViewController : UIViewController
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

NS_ASSUME_NONNULL_END
