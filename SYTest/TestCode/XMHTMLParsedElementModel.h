//
//  XMHTMLParsedElementModel.h
//  XiaoMoZB
//
//  Created by ailiao_04 on 2022/11/30.
//  Copyright © 2022 User. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    XMHTMLElementTypeUnknow = 0,
    XMHTMLElementTypeText,
    XMHTMLElementTypeImg,
} XMHTMLElementType;

@interface XMHTMLParsedElementModel : NSObject

@property (nonatomic, assign) XMHTMLElementType type;
///text 类型用到的字段
@property (nonatomic, copy) NSString *content; //文本内容
@property (nonatomic, copy) NSString *tapUrl;  //文本点击响应的 url
@property (nonatomic, strong) UIColor *textColor; //字体颜色（可能为nil，外面自己处理）
///图片类型用到的字段
@property (nonatomic, copy) NSString *imgUrl;


- (instancetype)initTextTypeWithContent:(NSString *)content tapUrl:(NSString *)tapUrl textColor:(UIColor *)textColor;
- (instancetype)initImgTypeWithImgUrl:(NSString *)imgUrl;

@end

NS_ASSUME_NONNULL_END
