//
//  FDTextView.h
//  School
//
//  Created by asus on 16/4/10.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDTextView : UITextView

- (void)insertAttributeText:(NSAttributedString *)text;

- (void)insertEmoji:(NSString *)emojiName;

- (void)insertEmojiName:(NSString *)emojiName doType:(BOOL) deleteBack;
@end
