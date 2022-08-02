//
//  StateViewController.h
//  HangOut
//
//  Created by Oluwanifemi Kolawole on 7/28/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol StateFilterDelegate <NSObject>
- (NSUInteger) numberOfStatesAvailable;
- (NSString *) stateNameForRow: (NSUInteger) row;
- (NSMutableArray *) cellSelected: row;

- (void) stateFilterEnabledForRow: (NSUInteger) row;
- (void) stateFilterDisabledForRow: (NSUInteger) row;

@end

@interface StateViewController : UIViewController
@property (nonatomic, weak) id <StateFilterDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
