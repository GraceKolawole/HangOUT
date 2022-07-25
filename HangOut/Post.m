//
//  Post.m
//  HangOut
//
//  Created by Oluwanifemi Kolawole on 7/5/22.
//

#import "Post.h"
#import "Parse/Parse.h"

@implementation Post

@dynamic postID;
@dynamic userID;
@dynamic author;
@dynamic caption;
@dynamic image;
@dynamic likeCount;
@dynamic commentCount;

+ (nonnull NSString *)parseClassName {
    return @"Post";
}

+ (void) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    Post *newPost = [Post new];
    newPost.postID = @"PostID";
    newPost.userID = @"userID";
    newPost.author = [PFUser currentUser];
    newPost.caption = caption;
    newPost.image = [self getPFFileFromImage:image];
    newPost.likeCount = @(0);
    newPost.commentCount = @(0);

    [newPost saveInBackgroundWithBlock: completion];
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
