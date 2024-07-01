//
//  XMHTMLParsedElementModel.m
//  XiaoMoZB
//
//  Created by ailiao_04 on 2022/11/30.
//  Copyright © 2022 User. All rights reserved.
//

#import "XMHTMLParsedElementModel.h"

@implementation XMHTMLParsedElementModel

- (instancetype)initTextTypeWithContent:(NSString *)content tapUrl:(NSString *)tapUrl textColor:(UIColor *)textColor {
    if (self = [super init]) {
        self.type = XMHTMLElementTypeText;
        self.content = content;
        self.tapUrl = tapUrl;
        self.textColor = textColor;
    }
    return self;
}

- (instancetype)initImgTypeWithImgUrl:(NSString *)imgUrl {
    if (self = [super init]) {
        self.type = XMHTMLElementTypeImg;
        self.imgUrl = imgUrl;
    }
    return self;
}

@end
