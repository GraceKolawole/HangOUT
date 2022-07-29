//
//  LocationsViewController.h
//  HangOut
//
//  Created by Oluwanifemi Kolawole on 7/26/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class LocationsViewController; // don't forget to add this line to avoid the "Expected a type..." error 😅

@protocol LocationsViewControllerDelegate

- (void)locationsViewController:(LocationsViewController *)controller didPickLocationWithLatitude:(NSNumber *)latitude longitude:(NSNumber *)longitude;

@end

@interface LocationsViewController : UIViewController

@property (weak, nonatomic) id<LocationsViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
