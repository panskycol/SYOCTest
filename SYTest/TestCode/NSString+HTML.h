//
//  NSString+HTML.h
//  XiaoMoZB
//
//  Created by 许启升 on 2022/11/29.
//  Copyright © 2022 User. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMHTMLParsedElementModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSString (HTML)

-(NSURL *)encodeUrl;

- (NSString *)setHtmlDefaultColor:(NSString *)colorStr;

/**
 * html 字符串生成富文本
 *
 * @param fontSize 字体大小
 * @param picSize 图片的高度，如果图片没有加载成功，则size默认为 picSize，加载成功后会等比缩放到 picSize 范围内
 * @param lineSpacing 行间距
 * @param showUnderLine 可点击跳转处是否显示下划线
 * @param defaultTextColor 如果文本对应的标签没有 color 属性的话，默认的 color 属性。 例：#888888
 * @param picLoadSucBlock 对于带图片链接的，会等待图片下载成功之后再生成新的富文本回调给外面
 *
 * @return 生成的富文本
 */
- (NSMutableAttributedString *)getAttributedTextFromHtmlStr:(CGFloat)fontSize
                                                    picSize:(CGFloat)picSize
                                                lineSpacing:(CGFloat)lineSpacing
                                              showUnderLine:(BOOL)showUnderLine
                                           defaultTextColor:(NSString *)defaulTextColor
                                            picLoadSucBlock:(nullable void(^)(NSMutableAttributedString *_Nullable attributedText))picLoadSucBlock;

/**
 * html 字符串解析成 XMHTMLParsedElementModel 数组
 */
- (NSArray<XMHTMLParsedElementModel *> *)getHtmlElementModelArrayFromHtmlStr;


/**
 * 生成一个控件
 * 对于只显示一行文本的场景，当用户的昵称出现特殊字符时(如 ༒❀蕊༒྅，꧁王府꧂，🍒二丑🍒)，用 YYLabel 显示富文本无法居中显示，用 UILabel 又无法支持 tag 的点击事件，所以拆成一组视图组装成一个控件
 *
 * @param fontSize 字体大小
 * @param picSize 图片的高度，如果图片没有加载成功，则size默认为 picSize，加载成功后会等比缩放到 picSize 范围内
 * @param showUnderLine 可点击跳转处是否显示下划线
 * @param defaultTextColor 如果文本对应的标签没有 color 属性的话，默认的 color 属性。 例：#888888
 * @param picLoadSucBlock 对于带图片链接的，会等待图片下载成功之后再生成一个新的控件给外面
 */
- (UIView *)getAttributedViewFromHtmlStr:(CGFloat)fontSize
                                 picSize:(CGFloat)picSize
                           showUnderLine:(BOOL)showUnderLine
                        defaultTextColor:(NSString *)defaulTextColor
                         picLoadSucBlock:(nullable void(^)(UIView *_Nullable attributedView))picLoadSucBlock;

@end

NS_ASSUME_NONNULL_END
