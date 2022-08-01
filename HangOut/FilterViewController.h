//
//  FilterViewController.h
//  HangOut
//
//  Created by Oluwanifemi Kolawole on 7/28/22.
//
#import "StateCell.h"
#import <UIKit/UIKit.h>
#import "StateViewController.h"

NS_ASSUME_NONNULL_BEGIN
@protocol FilterDelegate <StateFilterDelegate>
-(void) filterDismissed;

@end

@interface FilterViewController : UIViewController 
@property (nonatomic, weak) id <FilterDelegate> stateFilterdelegate;

@end

NS_ASSUME_NONNULL_END
