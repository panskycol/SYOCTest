//
//  UIImage+JZCategory.h
//  JinZuan
//
//  Created by 123 on 2022/8/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (JZCategory)
+ (UIImage *)defaultPlaceHolderImage;

+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)jz_cutImageFromImage:(UIImage *)image inRect:(CGRect)rect;
+ (UIImage *)createImageWithSize:(CGSize)size startColor:(UIColor*)startColor endColor:(UIColor* )endColor cornerRadius:(CGFloat)cornerRadius;
+ (UIImage *)createImageWithSize:(CGSize)size startColor:(UIColor*)startColor endColor:(UIColor* )endColor startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint cornerRadius:(CGFloat)cornerRadius;
+ (UIImage *)backImage;
+ (UIImage *)backBlackImage;
+ (UIImage *)createUpDownImageWithSize:(CGSize)size startColor:(UIColor*)startColor endColor:(UIColor* )endColor;

//获取镜像图片
- (UIImage *)getMirroredImage;
//存图片到沙盒
+ (void)saveImgToCacheWithUrl:(NSString *)urlStr andImg:(UIImage *)img;
//取图片到沙盒
+ (UIImage *)getImgFromCacheWithUrl:(NSString *)urlStr;

/// 生成水印图片
/// @param waterMarkInfo 水印信息(后台获取)
- (UIImage *)imageWithWaterMark:(NSDictionary *)waterMarkInfo;

//得到变灰图片
+ (UIImage*)getGrayImageFromImage:(UIImage *)image;
+ (NSData*)getDataFromImage:(UIImage*)imag;

//模糊图片
+ (UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;
- (UIImage *)imageWithBlurComponent:(CGFloat)blur;
///异步处理
- (void)imageWithBlurComponent:(CGFloat)blur completeHandle:(void(^)(UIImage *img))completed;
- (UIImage *)blurredImageWithRadius:(CGFloat)radius iterations:(NSUInteger)iterations tintColor:(UIColor *)tintColor;

//根据宽度缩放图片
+ (UIImage*)imageWithImage:(UIImage*)sourceImage scaledToWidth:(float)i_width;

+ (UIImage *)makeImageWithView:(UIView *)view withSize:(CGSize)size;
//- (UIImage *) horizontalMirror;
//- (UIImage*)rotate:(UIImageOrientation)orient;

@end

NS_ASSUME_NONNULL_END
