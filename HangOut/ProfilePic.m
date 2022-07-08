//
//  ProfilePic.m
//  HangOut
//
//  Created by Oluwanifemi Kolawole on 7/7/22.
//

#import "ProfilePic.h"
#import "Parse/Parse.h"

@implementation ProfilePic

@dynamic image;

+ (nonnull NSString *)parseClassName {
    return @"ProfilePic";
}
+ (void) profilepicUserImage: ( UIImage * _Nullable )image withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    ProfilePic *newPic = [ProfilePic new];
    newPic.image = [self getPFFileFromImage:image];
    [newPic saveInBackgroundWithBlock: completion];
}

+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
 
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
        return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
    
}
@end
