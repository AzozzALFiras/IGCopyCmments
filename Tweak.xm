// Developer By Azozz ALFiras
// github : https://github.com/AzozzALFiras
// Twitter : https://twitter.com/AzozzALFiras

#import <UIKit/UIKit.h>


@interface IGStyledString : NSObject
@property (strong) NSMutableAttributedString* attributedString;
@end

@interface IGCoreTextView : UIView
@property (strong) IGStyledString* styledString;
@end


@interface IGCommetContentView : UITableViewCell
@property (strong) IGCoreTextView* commentCoreTextView;
@end

@interface IGCommentCell : UITableViewCell
@property (strong) IGCommetContentView* commentView;
@end



%hook IGCommentCell // Copy Comment Text
- (void)_didLongPressCommentCell:(UILongPressGestureRecognizer*)sender{
if(sender.state == UIGestureRecognizerStateBegan) {

NSString *CommentTextWithOutUsername = [NSString stringWithFormat:@"%@", MSHookIvar<NSMutableString *>(self.commentView.commentCoreTextView.styledString.attributedString, "mutableString")];
NSUInteger indexUsername = [CommentTextWithOutUsername rangeOfString:@" "].location;
NSString *CommentText = [CommentTextWithOutUsername substringFromIndex:indexUsername+1];

UIAlertController *alert = [UIAlertController alertControllerWithTitle:@Name_Tweak message:CommentText preferredStyle:UIAlertControllerStyleAlert];

UIAlertAction* copyAction = [UIAlertAction actionWithTitle:@"Copy Text" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {

[UIPasteboard generalPasteboard].string = CommentText;
}];

UIAlertAction* shareAction = [UIAlertAction actionWithTitle:@"Share Text" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {

NSArray * shareItems;

shareItems = @[CommentText];

UIActivityViewController * avc = [[ UIActivityViewController alloc] initWithActivityItems:shareItems applicationActivities:nil];

[[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:avc animated:YES completion:NULL];
[avc setCompletionWithItemsHandler:^(NSString *activityType,BOOL completed, NSArray *returnedItems, NSError *activityError){

}];



}];

[alert addAction:copyAction];

[alert addAction:shareAction];

UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"الغاء" style:UIAlertActionStyleCancel handler:nil];
[alert addAction:cancel];
[[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}
} else {
return %orig;
}
}
%end
