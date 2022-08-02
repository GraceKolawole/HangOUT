//
//  TypeViewController.h
//  HangOut
//
//  Created by Oluwanifemi Kolawole on 8/1/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol TypeFilterDelegate <NSObject>
- (NSUInteger) numberOfTypesAvailable;
- (NSString *) typeNameForRow: (NSUInteger) row;
- (BOOL) cellTypeSelected: (NSUInteger) row;
- (void) typeFilterEnabledForRow: (NSUInteger) row;
- (void) typeFilterDisabledForRow: (NSUInteger) row;

@end

@interface TypeViewController : UIViewController
@property (nonatomic, weak) id <TypeFilterDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
