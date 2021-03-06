//
//  Post.h
//  HangOut
//
//  Created by Oluwanifemi Kolawole on 7/5/22.
//

#import "PFObject.h"
#import "Parse/Parse.h"

NS_ASSUME_NONNULL_BEGIN

@interface Post : PFObject<PFSubclassing>

@property (nonatomic, strong) NSString *postID;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) PFFileObject *image;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *address;



@property (nonatomic, strong) NSNumber *likeCount;
@property (nonatomic, strong) PFUser *author;
@property (nonatomic, strong) NSNumber *commentCount;
@property (nonatomic, strong) NSString *caption;
@property (nonatomic, strong) NSDate *createdAt;

+ (void) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion;


@end

NS_ASSUME_NONNULL_END
