//
//  PhotoMapViewController.h
//  HangOut
//
//  Created by Oluwanifemi Kolawole on 7/26/22.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "LocationsViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PhotoMapViewController : UIViewController <LocationsViewControllerDelegate, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *mapSegueControl;

@end

NS_ASSUME_NONNULL_END
