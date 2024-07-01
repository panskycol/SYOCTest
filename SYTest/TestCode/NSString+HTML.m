//
//  NSString+HTML.m
//  XiaoMoZB
//
//  Created by 许启升 on 2022/11/29.
//  Copyright © 2022 User. All rights reserved.
//

#import "NSString+HTML.h"
#import "TFHpple.h"
//#import <YYText/YYText.h>
//#import <YYImage/YYImage.h>
#import <objc/runtime.h>

@interface NSString ()

@property (nonatomic, strong) NSMutableArray *toLoadImgs; //记录需要下载的图片 url

@property (nonatomic, copy) NSArray *elementModelArr;

@end

@implementation NSString (HTML)

/**
 * 查找当前节点字体颜色
 */
- (UIColor *)getElementColor:(TFHppleElement *)element defaultTextColor:(NSString *)defaulTextColor {
    UIColor *color = nil;
    while (element) {
        NSString *colorHexString = element.attributes[@"color"];
        if (!IsStrEmpty(colorHexString)) {
            color = [UIColor colorWithHexString:colorHexString];
            return color;
        }
        element = element.parent;
    }
    
    if (!color && (!IsStrEmpty(defaulTextColor))) {
        color = [UIColor colorWithHexString:defaulTextColor];
    }
    
    return color;
}


/**
 * 查找当前节点点击跳转的url
 */
- (NSString *)getElementUrl:(TFHppleElement *)element {
    while (element) {
        if (!IsStrEmpty(element.attributes[@"url"])) {
            return element.attributes[@"url"];
        }
        element = element.parent;
    }
    return nil;
}



#pragma mark - 生成富文本逻辑处理
- (NSString *)setHtmlDefaultColor:(NSString *)colorStr{
    
    NSString *subStr = [NSString stringWithFormat:@"<font color=\"%@\">%@<\/font>",colorStr,self];
    return subStr;
}

- (void)setToLoadImgs:(NSMutableArray *)toLoadImgs {
    objc_setAssociatedObject(self, @selector(toLoadImgs), toLoadImgs, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)toLoadImgs {
    NSMutableArray *toLoadImgs = objc_getAssociatedObject(self, @selector(toLoadImgs));
    if (!toLoadImgs) {
        toLoadImgs = [[NSMutableArray alloc]init];
        self.toLoadImgs = toLoadImgs;
    }
    return toLoadImgs;
}


- (NSMutableAttributedString *)getAttributedTextFromHtmlStr:(CGFloat)fontSize
                                                    picSize:(CGFloat)picSize
                                                lineSpacing:(CGFloat)lineSpacing
                                              showUnderLine:(BOOL)showUnderLine
                                           defaultTextColor:(NSString *)defaulTextColor
                                            picLoadSucBlock:(nullable void (^)(NSMutableAttributedString * _Nullable))picLoadSucBlock {
    
    if (IsStrEmpty(self)) return nil;
    
    [self.toLoadImgs removeAllObjects];
    
    @weakify(self);
    NSMutableAttributedString *attrStrM = [self getAttributedString:fontSize picSize:picSize showUnderLine:showUnderLine defaultTextColor:defaulTextColor picLoadSucBlock:^(NSMutableAttributedString *attrText) {
        @strongify(self);
        //等待图片加载成功
        if (picLoadSucBlock) {
            NSMutableAttributedString *attributedText = [self resetAttributes:attrText fontSize:fontSize lineSpacing:lineSpacing];
            picLoadSucBlock(attributedText);
        }
    }];
    return [self resetAttributes:attrStrM fontSize:fontSize lineSpacing:lineSpacing];
}


- (NSMutableAttributedString *)resetAttributes:(NSMutableAttributedString *)attrStrM
                               fontSize:(CGFloat)fontSize
                            lineSpacing:(CGFloat)lineSpacing {
    [attrStrM setFont:[UIFont systemFontOfSize:fontSize] range:NSMakeRange(0, attrStrM.length)];
    [attrStrM setLineSpacing:lineSpacing range:NSMakeRange(0, attrStrM.length)];
    return attrStrM;
}


- (NSMutableAttributedString *)getAttributedString:(CGFloat)fontSize
                                           picSize:(CGFloat)picSize
                                     showUnderLine:(BOOL)showUnderLine
                                  defaultTextColor:(NSString *)defaulTextColor
                                   picLoadSucBlock:(void(^)(NSMutableAttributedString *attrText))picLoadSucBlock {
    NSString *originStr = self;
    //最外层不是 p 标签的话手动加上，方便统一解析
    if (![originStr hasPrefix:@"<p"]) {
        if (IsStrEmpty(defaulTextColor)) {
            originStr = [NSString stringWithFormat:@"<p>%@", originStr];
        }else {
            originStr = [NSString stringWithFormat:@"<p color=\"%@\">%@", defaulTextColor, originStr];
        }
    }
    if (![originStr hasSuffix:@"</p>"]) {
        originStr = [NSString stringWithFormat:@"%@</p>", originStr];
    }
    
    NSData *data = [originStr dataUsingEncoding:NSUTF8StringEncoding];
    TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:data];
    
    //查找所有 p 节点
    NSArray *dataArr = [xpathParser searchWithXPathQuery:@"//p"];
    
    NSMutableAttributedString *attributedStrM = [[NSMutableAttributedString alloc]init];
    for (TFHppleElement *element in dataArr) {
        [self appendElement:element attributedStrM:attributedStrM fontSize:fontSize picSize:picSize showUnderLine:showUnderLine defaultTextColor:defaulTextColor];
    }

    //下载网络图片
    [self loadNetImgs:fontSize picSize:picSize showUnderLine:showUnderLine defaultTextColor:defaulTextColor picLoadSucBlock:picLoadSucBlock];
    
    return attributedStrM;
}

- (void)loadNetImgs:(CGFloat)fontSize
            picSize:(CGFloat)picSize
      showUnderLine:(BOOL)showUnderLine
   defaultTextColor:(NSString *)defaulTextColor
    picLoadSucBlock:(void(^)(NSMutableAttributedString *attrText))picLoadSucBlock {
    //如果有需要网络加载的图片的图片，则统一加载完之后回调
    if (self.toLoadImgs.count > 0) {
        dispatch_group_t group = dispatch_group_create();
        for (NSString *imgUrlStr in self.toLoadImgs) {
            dispatch_group_enter(group);
            [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:imgUrlStr.encodeUrl completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
                if (image) {
                    NSString *cacheKey  = [[SDWebImageManager sharedManager] cacheKeyForURL:imgUrlStr.encodeUrl];
                    [[SDImageCache sharedImageCache] storeImage:image forKey:cacheKey completion:nil];
                    
                }
                dispatch_group_leave(group);
            }];
        }
        
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            //重新生成一遍富文本
            if (picLoadSucBlock) {
                NSMutableAttributedString *attrText = [self getAttributedString:fontSize picSize:picSize showUnderLine:showUnderLine defaultTextColor:defaulTextColor picLoadSucBlock:nil];
                picLoadSucBlock(attrText);
            }
        });
    }
}

- (void)appendElement:(TFHppleElement *)element
       attributedStrM:(NSMutableAttributedString *)attributedStrM
             fontSize:(CGFloat)fontSize
              picSize:(CGFloat)picSize
        showUnderLine:(BOOL)showUnderLine
     defaultTextColor:(NSString *)defaulTextColor {
    if (element.hasChildren) {
        for (TFHppleElement *subElement in element.children) {
            [self appendElement:subElement attributedStrM:attributedStrM fontSize:fontSize picSize:picSize showUnderLine:showUnderLine defaultTextColor:defaulTextColor];
        }
    }else {
        if ([element.tagName isEqualToString:@"text"]) {
            NSMutableAttributedString *attrText = [[NSMutableAttributedString alloc]initWithString:element.content];
            UIColor *color = [self getElementColor:element defaultTextColor:defaulTextColor];
            if (color) {
                [attrText setColor:color];
            }else {
                [attrText setColor:UIColor.blackColor];
            }
            
            NSString *url = [self getElementUrl:element];
            if ([url length]) {
                YYTextHighlight *hi = [[YYTextHighlight alloc] init];
                hi.tapAction = ^(UIView *containerView,NSAttributedString *text,NSRange range, CGRect rect) {
//                    [getCurrentViewController() xm_parseUrlAndRedirect:url];
                };
                [attrText setTextHighlight:hi range:NSMakeRange(0, attrText.length)];
                if (showUnderLine) {
                    [attrText setUnderlineStyle:NSUnderlineStyleSingle range:NSMakeRange(0, attrText.length)];
                }
            }
            [attributedStrM appendAttributedString:attrText];
        }else if([element.tagName isEqualToString:@"img"]){
            NSString *imgUrlStr = element.attributes[@"src"];
            
            NSString *cacheKey  = [[SDWebImageManager sharedManager] cacheKeyForURL:imgUrlStr.encodeUrl];
            UIImage *localImage = [[SDImageCache sharedImageCache] imageFromCacheForKey:cacheKey];
            
            //可以将图片作为特殊字符处理
            //需要使用 YYAnimatedImageView 控件，直接使用 UIImageView 添加无效。
            YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc] initWithImage:localImage];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            if (localImage) {
                // 本地有图片，设置图片高度 picSize，宽度根据高度等比缩放
                CGFloat imageH = picSize;
                CGFloat imageW = localImage.size.width / localImage.size.height * imageH;
                imageView.frame = RECT(0, 0, imageW, imageH);
            }else {
                // 默认图片的宽高设置成 picSize
                imageView.frame = RECT(0, 0, picSize, picSize);
                if (!IsStrEmpty(imgUrlStr)) {
                    [self.toLoadImgs addObject:imgUrlStr];
                }
            }
    
            // attchmentSize 修改，可以处理内边距
            NSMutableAttributedString *attachText = [NSMutableAttributedString attachmentStringWithContent:imageView contentMode:UIViewContentModeScaleAspectFit attachmentSize:imageView.frame.size alignToFont:[UIFont systemFontOfSize:picSize] alignment:YYTextVerticalAlignmentCenter];
             //插入图片
            [attributedStrM appendAttributedString:attachText];
        }
    }
}


#pragma mark - 生成 XMHTMLParsedElementModel 数组逻辑处理
- (NSArray<XMHTMLParsedElementModel *> *)getHtmlElementModelArrayFromHtmlStr {
    NSString *originStr = self;
    //最外层不是 p 标签的话手动加上，方便统一解析
    if (![originStr hasPrefix:@"<p"]) {
        originStr = [NSString stringWithFormat:@"<p>%@", originStr];
    }
    if (![originStr hasSuffix:@"</p>"]) {
        originStr = [NSString stringWithFormat:@"%@</p>", originStr];
    }
    
    NSData *data = [originStr dataUsingEncoding:NSUTF8StringEncoding];
    TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:data];
    
    //查找所有 p 节点
    NSArray *dataArr = [xpathParser searchWithXPathQuery:@"//p"];
    
    NSMutableArray *elementArrM = [[NSMutableArray alloc]init];
    for (TFHppleElement *element in dataArr) {
        [self appendElement:element elementArrM:elementArrM];
    }
    return elementArrM;
}

- (void)appendElement:(TFHppleElement *)element elementArrM:(NSMutableArray *)elementArrM {
    if (element.hasChildren) {
        for (TFHppleElement *subElement in element.children) {
            [self appendElement:subElement elementArrM:elementArrM];
        }
    }else {
        if ([element.tagName isEqualToString:@"text"]) {
            NSString *content = element.content;
            NSString *tapUrl = [self getElementUrl:element];
            UIColor *textColor = [self getElementColor:element defaultTextColor:nil];
            XMHTMLParsedElementModel *elementModel = [[XMHTMLParsedElementModel alloc]initTextTypeWithContent:content tapUrl:tapUrl textColor:textColor];
            [elementArrM addObject:elementModel];
        }else if([element.tagName isEqualToString:@"img"]){
            NSString *imgUrl = element.attributes[@"src"];
            XMHTMLParsedElementModel *elementModel = [[XMHTMLParsedElementModel alloc]initImgTypeWithImgUrl:imgUrl];
            [elementArrM addObject:elementModel];
        }
    }
}



#pragma mark - 生成 一个控件 的逻辑处理
#define kAttributedSubViewTag  12222
- (void)setElementModelArr:(NSArray *)elementModelArr {
    objc_setAssociatedObject(self, @selector(elementModelArr), elementModelArr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray *)elementModelArr {
    return objc_getAssociatedObject(self, @selector(elementModelArr));
}


- (UIView *)getAttributedViewFromHtmlStr:(CGFloat)fontSize
                                 picSize:(CGFloat)picSize
                           showUnderLine:(BOOL)showUnderLine
                        defaultTextColor:(NSString *)defaulTextColor
                         picLoadSucBlock:(nullable void (^)(UIView * _Nullable))picLoadSucBlock {
    self.elementModelArr = [self getHtmlElementModelArrayFromHtmlStr];
    
    UIView *view = [self createViewFromHtmlStr:fontSize picSize:picSize showUnderLine:showUnderLine defaultTextColor:defaulTextColor picLoadSucBlock:picLoadSucBlock];
    return view;
}

- (UIView *)createViewFromHtmlStr:(CGFloat)fontSize
                      picSize:(CGFloat)picSize
                showUnderLine:(BOOL)showUnderLine
             defaultTextColor:(NSString *)defaulTextColor
              picLoadSucBlock:(nullable void (^)(UIView * _Nullable))picLoadSucBlock {
    
    UIView *contentView = [[UIView alloc]init];
    NSMutableArray *viewsArr = @[].mutableCopy;
    NSMutableArray *needToDownLoadImgElementArr = @[].mutableCopy; //记录需要下载的网络图片
    
    //生成子控件
    for (NSInteger i = 0; i < self.elementModelArr.count; i ++) {
        XMHTMLParsedElementModel *elementModel = self.elementModelArr[i];
        if (elementModel.type == XMHTMLElementTypeText) {
            UIColor *textColor = elementModel.textColor;
            if (!textColor && (!IsStrEmpty(defaulTextColor))) {
                textColor = [UIColor colorWithHexString:defaulTextColor];
            }
            UILabel *lbl = [self createLblWithText:elementModel.content font:[UIFont systemFontOfSize:fontSize] textColor:textColor showUnderLine:showUnderLine tapUrl:elementModel.tapUrl];
            lbl.tag = kAttributedSubViewTag + i;
            [viewsArr addObject:lbl];
        }else if (elementModel.type == XMHTMLElementTypeImg) {
            NSString *imgUrlStr = elementModel.imgUrl;
            NSString *cacheKey  = [[SDWebImageManager sharedManager] cacheKeyForURL:imgUrlStr.encodeUrl];
            UIImage *localImage = [[SDImageCache sharedImageCache] imageFromCacheForKey:cacheKey];
            
            if (localImage) {
                // 本地有图片
                UIImageView *imgView = [self createImgViewWithImg:localImage];
                imgView.tag = kAttributedSubViewTag + i;
                [viewsArr addObject:imgView];
            }else {
                // 本地没有图片
                UIImageView *imgView = [self createImgViewWithImg:nil];
                imgView.tag = kAttributedSubViewTag + i;
                [viewsArr addObject:imgView];
                if (!IsStrEmpty(imgUrlStr)) {
                    [needToDownLoadImgElementArr addObject:elementModel];
                }
            }
        }
    }
    
    
    //组装子控件
    UIView *lastView = nil;
    for (UIView *subView in viewsArr) {
        [contentView addSubview:subView];
        
        if ([subView isKindOfClass:[UIImageView class]]) {
            UIImageView *imgView = (UIImageView *)subView;
            CGFloat imgWidth = picSize;
            CGFloat imgHeight = picSize;
            if (imgView.image) {
                imgWidth = imgView.image.size.width / imgView.image.size.height * imgHeight;
            }
            [subView mas_makeConstraints:^(MASConstraintMaker *make) {
                if (lastView) {
                    make.leading.mas_equalTo(lastView.mas_trailing);
                }else {
                    make.leading.mas_equalTo(contentView);
                }
                make.centerY.mas_equalTo(contentView);
                make.size.mas_equalTo(CGSizeMake(imgWidth, imgHeight));
                if (subView == viewsArr.lastObject) {
                    make.trailing.mas_equalTo(contentView);
                }
            }];
        }else {
            [subView mas_makeConstraints:^(MASConstraintMaker *make) {
                if (lastView) {
                    make.leading.mas_equalTo(lastView.mas_trailing);
                }else {
                    make.leading.mas_equalTo(contentView);
                }
                make.centerY.mas_equalTo(contentView);
                if (subView == viewsArr.lastObject) {
                    make.trailing.mas_equalTo(contentView);
                }
            }];
        }
        lastView = subView;
    }
    
    //判断是否需要加载网络图片
    if (picLoadSucBlock && needToDownLoadImgElementArr.count > 0) {
        [self loadNetImgs:needToDownLoadImgElementArr complete:^{
            //加载网络图片成功，重新生成一个新的控件
            UIView *view = [self createViewFromHtmlStr:fontSize picSize:picSize showUnderLine:showUnderLine defaultTextColor:defaulTextColor picLoadSucBlock:nil];
            if (picLoadSucBlock) {
                picLoadSucBlock(view);
            }
        }];
    }
    
    return contentView;
}

- (UILabel *)createLblWithText:(NSString *)text
                          font:(UIFont *)font
                     textColor:(UIColor *)textColor
                 showUnderLine:(BOOL)showUnderLine
                        tapUrl:(NSString *)tapUrl {
    UILabel *lbl = [[UILabel alloc]init];
    if (showUnderLine && (!IsStrEmpty(tapUrl))) {
        //要显示下划线
        NSMutableAttributedString *attrText = [[NSMutableAttributedString alloc]initWithString:text];
        [attrText setFont:font];
        if (textColor) {
            [attrText setColor:textColor];
        }else {
            [attrText setColor:UIColor.blackColor];
        }
        [attrText setUnderlineStyle:NSUnderlineStyleSingle range:NSMakeRange(0, attrText.length)];
        lbl.attributedText = attrText;
    }else {
        lbl.font = font;
        lbl.textColor = textColor;
        lbl.text = text;
    }
    
    if (!IsStrEmpty(tapUrl)) {
        lbl.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tagTapAction:)];
        [lbl addGestureRecognizer:tap];
    }
    
    return lbl;
}

- (void)tagTapAction:(UITapGestureRecognizer *)tap {
    UILabel *linkLbl = (UILabel *)tap.view;
    NSInteger index = linkLbl.tag - kAttributedSubViewTag;
    if (index >= self.elementModelArr.count) return;
    
    XMHTMLParsedElementModel *elementModel = self.elementModelArr[index];
    NSString *tag = elementModel.tapUrl;
//    [MSRouter routeWithTag:tag];
}

- (NSURL *)encodeUrl{
    
    return [NSURL URLWithString:[self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
}

- (UIImageView *)createImgViewWithImg:(UIImage *)image {
    UIImageView *imgView = [[UIImageView alloc]init];
    imgView.image = image;
    return imgView;
}


- (void)loadNetImgs:(NSArray *)imgElementArr complete:(dispatch_block_t)complete {
    //有需要网络加载的图片的图片，统一加载完之后回调
    dispatch_group_t group = dispatch_group_create();
    for (XMHTMLParsedElementModel *imgElement in imgElementArr) {
        dispatch_group_enter(group);
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:imgElement.imgUrl.encodeUrl completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
            if (image) {
                NSString *cacheKey  = [[SDWebImageManager sharedManager] cacheKeyForURL:imgElement.imgUrl.encodeUrl];
                [[SDImageCache sharedImageCache] storeImage:image forKey:cacheKey completion:nil];
                
            }
            dispatch_group_leave(group);
        }];
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        //重新生成一遍富文本
        if (complete) {
            complete();
        }
    });
}



@end
