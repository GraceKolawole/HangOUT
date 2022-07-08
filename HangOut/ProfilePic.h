//
//  Change.h
//  HangOut
//
//  Created by Oluwanifemi Kolawole on 7/7/22.
//

#import "PFObject.h"
#import "Parse/Parse.h"
NS_ASSUME_NONNULL_BEGIN

@interface ProfilePic : PFObject<PFSubclassing>

@property (nonatomic, strong) PFFileObject *image;


+ (void) profilepicUserImage: ( UIImage * _Nullable )image withCompletion: (PFBooleanResultBlock  _Nullable)completion;

@end

NS_ASSUME_NONNULL_END
