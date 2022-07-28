//
//  EventsViewController.h
//  HangOut
//
//  Created by Oluwanifemi Kolawole on 7/8/22.
//

#import <UIKit/UIKit.h>

@class EventsViewController;
NS_ASSUME_NONNULL_BEGIN
@protocol EventsViewControllerDelegate

//- (void)eventsViewController:(LocationsViewController *)controller didPickLocationWithLatitude:(NSNumber *)latitude longitude:(NSNumber *)longitude;

@end
@interface EventsViewController : UIViewController

@property (weak, nonatomic) id<EventsViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
