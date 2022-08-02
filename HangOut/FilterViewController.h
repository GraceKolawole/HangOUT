//
//  FilterViewController.h
//  HangOut
//
//  Created by Oluwanifemi Kolawole on 7/28/22.
//
#import "StateCell.h"
#import <UIKit/UIKit.h>
#import "StateViewController.h"
#import "TypeViewController.h"

NS_ASSUME_NONNULL_BEGIN
@protocol FilterStateDelegate <StateFilterDelegate>
- (void) filterDismissed;

@end

@protocol FilterTypeDelegate <TypeFilterDelegate>
- (void) filterDismissed;

@end

@interface FilterViewController : UIViewController 
@property (nonatomic, weak) id <FilterStateDelegate> stateFilterdelegate;
@property (nonatomic, weak) id <FilterTypeDelegate> typeFilterdelegate;

@end

NS_ASSUME_NONNULL_END
