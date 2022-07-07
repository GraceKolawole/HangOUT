//
//  Post.m
//  HangOut
//
//  Created by Oluwanifemi Kolawole on 7/5/22.
//

#import "Post.h"

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
    newPost.likeCount = @(0);
    newPost.commentCount = @(0);
    
    [newPost saveInBackgroundWithBlock: completion];
}

//[post saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//    if (succeeded) {
//        // The object has been saved.
//    }
//    else {
//        NSLog(@"%@", error.localizedDescription);
//    }
//}];

@end
