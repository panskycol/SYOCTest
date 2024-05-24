//
//  UIImage+JZCategory.m
//  JinZuan
//
//  Created by 123 on 2022/8/15.
//

#import "UIImage+JZCategory.h"
#import "FXBlurView.h"

@implementation UIImage (JZCategory)
+ (UIImage *)backImage {
    return [UIImage imageNamed:@"icon_left_white"];
}

+ (UIImage *)backBlackImage {
    return [UIImage imageNamed:@"msg_detail_back"];
}

+ (UIImage *)defaultPlaceHolderImage {
    return [UIImage imageNamed:@"ic_common_defu_header"];
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    return [self imageWithColor:color size:CGSizeMake(1, 1)];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/**
 *  从图片中按指定的位置大小截取图片的一部分
 *
 *  @param image UIImage image 原始的图片
 *  @param rect  CGRect rect 要截取的区域
 *
 *  @return UIImage
 */
+ (UIImage *)jz_cutImageFromImage:(UIImage *)image inRect:(CGRect)rect{
    
    //把像素rect 转化为点rect（如无转化则按原图像素取部分图片）
    CGFloat scale = image.scale;
    CGFloat x= rect.origin.x*scale,y=rect.origin.y*scale,w=rect.size.width*scale,h=rect.size.height*scale;
    CGRect dianRect = CGRectMake(x, y, w, h);
    
    //截取部分图片并生成新图片
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, dianRect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    return newImage;
}

+ (UIImage *)createImageWithSize:(CGSize)size startColor:(UIColor *)startColor endColor:(UIColor *)endColor cornerRadius:(CGFloat)cornerRadius {
    CAGradientLayer* g = [CAGradientLayer layer];
    g.cornerRadius = cornerRadius;
    g.frame = (CGRect){{0,0},size};
    g.startPoint = (CGPoint){0,0};
    g.endPoint   = (CGPoint){1,0};
    g.colors = @[(__bridge id)startColor.CGColor,
                 (__bridge id)endColor.CGColor];
    g.locations = @[@(0.0f),@(1.0f)];
    g.contentsScale = [UIScreen mainScreen].scale;
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [g renderInContext:context];
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)createImageWithSize:(CGSize)size startColor:(UIColor *)startColor endColor:(UIColor *)endColor startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint cornerRadius:(CGFloat)cornerRadius{
    
    CAGradientLayer* g = [CAGradientLayer layer];
    g.cornerRadius = cornerRadius;
    g.frame = (CGRect){{0,0},size};
    g.startPoint = startPoint;
    g.endPoint   = endPoint;
    g.colors = @[(__bridge id)startColor.CGColor,
                 (__bridge id)endColor.CGColor];
    g.locations = @[@(0.0f),@(1.0f)];
    g.contentsScale = [UIScreen mainScreen].scale;
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [g renderInContext:context];
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)createUpDownImageWithSize:(CGSize)size startColor:(UIColor*)startColor endColor:(UIColor* )endColor {
    CAGradientLayer* g = [CAGradientLayer layer];
    g.frame = (CGRect){{0,0},size};
    g.startPoint = (CGPoint){0,0};
    g.endPoint   = (CGPoint){0,1};
    g.colors = @[(__bridge id)startColor.CGColor,
                 (__bridge id)endColor.CGColor];
    g.locations = @[@(0.0f),@(1.0f)];
    
    UIGraphicsBeginImageContextWithOptions(size,NO,[UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [g renderInContext:context];
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//获取镜像图片
- (UIImage *)getMirroredImage{
    return [UIImage imageWithCGImage:self.CGImage
                               scale:self.scale
                         orientation:UIImageOrientationUpMirrored];
}

//存图片到沙盒
//+ (void)saveImgToCacheWithUrl:(NSString *)urlStr andImg:(UIImage *)img{
//    NSString *defaultPath = [self getDefaultPathWithUrl:urlStr];
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        //把图片直接保存到指定的路径（同时应该把图片的路径imagePath存起来，下次就可以直接用来取）
//        [UIImagePNGRepresentation(img) writeToFile:defaultPath atomically:YES];
//    });
//}

//取图片到沙盒
//+ (UIImage *)getImgFromCacheWithUrl:(NSString *)urlStr{
//    NSString *defaultPath = [self getDefaultPathWithUrl:urlStr];
//    UIImage *defaultImg = [[UIImage alloc] initWithContentsOfFile:defaultPath];
//    return defaultImg;
//}

//+ (NSString *)getDefaultPathWithUrl:(NSString *)urlStr{
//    NSString *imgMD5 = [urlStr md5String];
//    NSString *defaultPathName = [NSString stringWithFormat:@"%@",imgMD5];
//    NSString *defaultPath = [JZFileManager getFileCachePath:defaultPathName];
//    return defaultPath;
//}

- (UIImage *)imageWithWaterMark:(NSDictionary *)waterMarkInfo{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    
    UIImage *waterMarkImage = [UIImage getWaterMarkImage:waterMarkInfo];
    CGSize imageSize = CGSizeMake(waterMarkImage.size.width/3*2, waterMarkImage.size.height/3*2);
    CGRect rect = [UIImage getWaterMarkScaleSizeByMediaSize:self.size originSize:imageSize];
    [waterMarkImage drawInRect:rect];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage *)getWaterMarkImage:(NSDictionary *)waterMarkInfo{
    NSString *inviteStr = [waterMarkInfo objectForKey:@"invite_code"];
    NSString *showLogo = [waterMarkInfo objectForKey:@"watermark"];
    CGFloat contentViewW = 59;
    
    UIView *contentView = [[UIView alloc] init];
    if ([showLogo isEqualToString:@"1"]) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"watermark"]];
        [contentView addSubview:imageView];
        imageView.frame = RECT(6, 0, 103, 28);
    }
    
    if (!IsStrEmpty(inviteStr)) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont boldSystemFontOfSize:13];
        label.textColor = [UIColor whiteColor];
        label.layer.shadowOpacity = 0.5;
        label.layer.shadowOffset = CGSizeMake(1,1);
        label.text = inviteStr;
        [contentView addSubview:label];
        
        CGSize adjustSize = [inviteStr sizeWithAttributes:@{NSFontAttributeName:label.font}];
        label.frame = RECT(0, 28, adjustSize.width, 18);
        contentViewW = adjustSize.width > 59 ? adjustSize.width : 59;
    }
    
    contentView.frame = RECT(FX(contentView), FY(contentView), contentViewW, 46);
    
    UIImage *waterMarkImage = [UIImage makeImageWithView:contentView withSize:contentView.bounds.size];
    return waterMarkImage;
}
+ (UIImage *)makeImageWithView:(UIView *)view withSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (CGRect)getWaterMarkScaleSizeByMediaSize:(CGSize)size originSize:(CGSize)originSize{
    CGRect waterMarkRect;
    CGFloat horizontalRatio = 750.0f / size.width;
    CGFloat verticalRatio = 1334.0f / size.height;
    // UIViewContentModeScaleAspectFit方式填充屏幕 视频缩放到屏幕上时会乘以缩放因子，为了保证屏幕上看到的水印是同样大小，这里把水印除以缩放因子放在视频上
    CGFloat ratio = MIN(horizontalRatio, verticalRatio);
    CGFloat w = originSize.width*2/ratio;
    CGFloat h = originSize.height*2/ratio;
    CGFloat margin = 44/ratio;
    CGFloat x = size.width-w-margin/2;
    waterMarkRect = CGRectMake(x, margin, w, h);
    return waterMarkRect;
}

//得到变灰图片
+ (UIImage*)getGrayImageFromImage:(UIImage *)image{
    // Adapted from this thread: http://stackoverflow.com/questions/1298867/convert-image-to-grayscale
    const int RED =1;
    const int GREEN =2;
    const int BLUE =3;
    
    // Create image rectangle with current image width/height
    CGRect imageRect = CGRectMake(0,0, image.size.width* image.scale, image.size.height* image.scale);
    
    int width = imageRect.size.width;
    int height = imageRect.size.height;
    
    // the pixels will be painted to this array
    uint32_t *pixels = (uint32_t*) malloc(width * height *sizeof(uint32_t));
    
    // clear the pixels so any transparency is preserved
    memset(pixels,0, width * height *sizeof(uint32_t));
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // create a context with rgba pixels
    CGContextRef context = CGBitmapContextCreate(pixels, width, height,8, width *sizeof(uint32_t), colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedLast);
    
    // paint the bitmap to our context which will fill in the pixels array
    CGContextDrawImage(context,CGRectMake(0,0, width, height), [image CGImage]);
    
    for(int y = 0; y < height; y++) {
        for(int x = 0; x < width; x++) {
            uint8_t *rgbaPixel = (uint8_t*) &pixels[y * width + x];
            
            // convert to grayscale using recommended method: http://en.wikipedia.org/wiki/Grayscale#Converting_color_to_grayscale
            uint32_t gray = 0.3 * rgbaPixel[RED] +0.59 * rgbaPixel[GREEN] +0.11 * rgbaPixel[BLUE];
            
            // set the pixels to gray
            rgbaPixel[RED] = gray;
            rgbaPixel[GREEN] = gray;
            rgbaPixel[BLUE] = gray;
        }
    }
    
    // create a new CGImageRef from our context with the modified pixels
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    
    // we're done with the context, color space, and pixels
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    free(pixels);
    
    // make a new UIImage to return
    UIImage *resultUIImage = [UIImage imageWithCGImage:imageRef scale:image.scale orientation:UIImageOrientationUp];
    
    // we're done with image now too
    CGImageRelease(imageRef);
    
    return resultUIImage;
}

+(NSData*)getDataFromImage:(UIImage*)image{
    
    NSData *data;
    
    /*判断图片是不是png格式的文件*/
    
    if(UIImagePNGRepresentation(image))
        
        data = UIImagePNGRepresentation(image);
    
    /*判断图片是不是jpeg格式的文件*/
    
    else
        
        data = UIImageJPEGRepresentation(image,1.0);
    
    return data;
}

+ (UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur
{
    int boxSize = (int)(blur * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    CGImageRef img = image.CGImage;
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    
    //从CGImage中获取数据
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    //设置从CGImage获取对象的属性
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    if(pixelBuffer == NULL)
//        JZLog(@"No pixelbuffer");
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if(error){
//        JZLog(@"error from convolution %ld", error);
    }
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate( outBuffer.data, outBuffer.width, outBuffer.height, 8, outBuffer.rowBytes, colorSpace, kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage(ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up CGContextRelease(ctx)
    CGColorSpaceRelease(colorSpace);
    free(pixelBuffer);
    CFRelease(inBitmapData);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    return returnImage;
}

- (UIImage *)imageWithBlurComponent:(CGFloat)blur{
    
    UIImage *image = [self blurredImageWithRadius:blur iterations:4 tintColor:[UIColor clearColor]];
    return image;
}

- (void)imageWithBlurComponent:(CGFloat)blur completeHandle:(nonnull void (^)(UIImage * _Nonnull))completed{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage *image = [self blurredImageWithRadius:blur iterations:4 tintColor:[UIColor clearColor]];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completed) {
                completed(image);
            }
        });
    });
}

- (UIImage *)blurredImageWithRadius:(CGFloat)radius iterations:(NSUInteger)iterations tintColor:(UIColor *)tintColor
{
    //image must be nonzero size
    if (floorf(self.size.width) * floorf(self.size.height) <= 0.0f) return self;

    //boxsize must be an odd integer
    uint32_t boxSize = (uint32_t)(radius * self.scale);
    if (boxSize % 2 == 0) boxSize ++;

    //create image buffers
    CGImageRef imageRef = self.CGImage;

    //convert to ARGB if it isn't
    if (CGImageGetBitsPerPixel(imageRef) != 32 ||
        CGImageGetBitsPerComponent(imageRef) != 8 ||
        !((CGImageGetBitmapInfo(imageRef) & kCGBitmapAlphaInfoMask)))
    {
        UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
        [self drawAtPoint:CGPointZero];
        imageRef = UIGraphicsGetImageFromCurrentImageContext().CGImage;
        UIGraphicsEndImageContext();
    }

    vImage_Buffer buffer1, buffer2;
    buffer1.width = buffer2.width = CGImageGetWidth(imageRef);
    buffer1.height = buffer2.height = CGImageGetHeight(imageRef);
    buffer1.rowBytes = buffer2.rowBytes = CGImageGetBytesPerRow(imageRef);
    size_t bytes = buffer1.rowBytes * buffer1.height;
    buffer1.data = malloc(bytes);
    buffer2.data = malloc(bytes);
  
    if (NULL == buffer1.data || NULL == buffer2.data)
    {
        free(buffer1.data);
        free(buffer2.data);
        return self;
    }

    //create temp buffer
    void *tempBuffer = malloc((size_t)vImageBoxConvolve_ARGB8888(&buffer1, &buffer2, NULL, 0, 0, boxSize, boxSize,
                                                                 NULL, kvImageEdgeExtend + kvImageGetTempBufferSize));

    //copy image data
    CGDataProviderRef provider = CGImageGetDataProvider(imageRef);
    CFDataRef dataSource = CGDataProviderCopyData(provider);
    if (NULL == dataSource)
    {
        return self;
    }
    const UInt8 *dataSourceData = CFDataGetBytePtr(dataSource);
    CFIndex dataSourceLength = CFDataGetLength(dataSource);
    memcpy(buffer1.data, dataSourceData, MIN(bytes, dataSourceLength));
    CFRelease(dataSource);

    for (NSUInteger i = 0; i < iterations; i++)
    {
        //perform blur
        vImageBoxConvolve_ARGB8888(&buffer1, &buffer2, tempBuffer, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);

        //swap buffers
        void *temp = buffer1.data;
        buffer1.data = buffer2.data;
        buffer2.data = temp;
    }

    //free buffers
    free(buffer2.data);
    free(tempBuffer);

    //create image context from buffer
    CGContextRef ctx = CGBitmapContextCreate(buffer1.data, buffer1.width, buffer1.height,
                                             8, buffer1.rowBytes, CGImageGetColorSpace(imageRef),
                                             CGImageGetBitmapInfo(imageRef));

    //apply tint
    if (tintColor && CGColorGetAlpha(tintColor.CGColor) > 0.0f)
    {
        CGContextSetFillColorWithColor(ctx, [tintColor colorWithAlphaComponent:0.25].CGColor);
        CGContextSetBlendMode(ctx, kCGBlendModePlusLighter);
        CGContextFillRect(ctx, CGRectMake(0, 0, buffer1.width, buffer1.height));
    }

    //create image from context
    imageRef = CGBitmapContextCreateImage(ctx);
    UIImage *image = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    CGContextRelease(ctx);
    free(buffer1.data);
    return image;
}


+ (UIImage*)imageWithImage:(UIImage*)sourceImage scaledToWidth:(float)i_width
{
    float oldWidth = sourceImage.size.width;
    float scaleFactor = i_width / oldWidth;
    float newHeight = sourceImage.size.height * scaleFactor;
    float newWidth = oldWidth * scaleFactor;
    
    newWidth = UI_SCREEN_WIDTH;
    newHeight = 140;
    

    UIGraphicsBeginImageContextWithOptions(CGSizeMake(newWidth, newHeight), NO, 0);
    [sourceImage drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
//- (UIImage *)fixOrientation {
//
//    // No-op if the orientation is already correct
//    if (self.imageOrientation == UIImageOrientationUp) return self;
//
//    // We need to calculate the proper transformation to make the image upright.
//    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
//    CGAffineTransform transform = CGAffineTransformIdentity;
//
//    switch (self.imageOrientation) {
//        case UIImageOrientationDown:
//        case UIImageOrientationDownMirrored:
//            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
//            transform = CGAffineTransformRotate(transform, M_PI);
//            break;
//
//        case UIImageOrientationLeft:
//        case UIImageOrientationLeftMirrored:
//            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
//            transform = CGAffineTransformRotate(transform, M_PI_2);
//            break;
//
//        case UIImageOrientationRight:
//        case UIImageOrientationRightMirrored:
//            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
//            transform = CGAffineTransformRotate(transform, -M_PI_2);
//            break;
//        default:
//            break;
//    }
//
//    switch (self.imageOrientation) {
//        case UIImageOrientationUpMirrored:
//        case UIImageOrientationDownMirrored:
//            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
//            transform = CGAffineTransformScale(transform, -1, 1);
//            break;
//
//        case UIImageOrientationLeftMirrored:
//        case UIImageOrientationRightMirrored:
//            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
//            transform = CGAffineTransformScale(transform, -1, 1);
//            break;
//        default:
//            break;
//    }
//
//    // Now we draw the underlying CGImage into a new context, applying the transform
//    // calculated above.
//    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
//                                             CGImageGetBitsPerComponent(self.CGImage), 0,
//                                             CGImageGetColorSpace(self.CGImage),
//                                             CGImageGetBitmapInfo(self.CGImage));
//    CGContextConcatCTM(ctx, transform);
//    switch (self.imageOrientation) {
//        case UIImageOrientationLeft:
//        case UIImageOrientationLeftMirrored:
//        case UIImageOrientationRight:
//        case UIImageOrientationRightMirrored:
//            // Grr...
//            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
//            break;
//
//        default:
//            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
//            break;
//    }
//
//    // And now we just create a new UIImage from the drawing context
//    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
//    UIImage *img = [UIImage imageWithCGImage:cgimg];
//    CGContextRelease(ctx);
//    CGImageRelease(cgimg);
//    return img;
//}

//- (UIImage *) horizontalMirror {
//    UIImageOrientation flippedOrientation = UIImageOrientationUpMirrored;
//    switch (self.imageOrientation) {
//        case UIImageOrientationUp: break;
//        case UIImageOrientationDown: flippedOrientation = UIImageOrientationDownMirrored; break;
//    }
//    UIImage * flippedImage = [UIImage imageWithCGImage:self.CGImage scale:1.0 orientation:flippedOrientation];
//
//    CGImageRef inImage = self.CGImage;
//    CGContextRef ctx = CGBitmapContextCreate(NULL,
//                                             CGImageGetWidth(inImage),
//                                             CGImageGetHeight(inImage),
//                                             CGImageGetBitsPerComponent(inImage),
//                                             CGImageGetBytesPerRow(inImage),
//                                             CGImageGetColorSpace(inImage),
//                                             CGImageGetBitmapInfo(inImage)
//                                             );
//    CGRect cropRect = CGRectMake(flippedImage.size.width/2, 0, flippedImage.size.width/2, flippedImage.size.height);
//    CGImageRef TheOtherHalf = CGImageCreateWithImageInRect(flippedImage.CGImage, cropRect);
//    CGContextDrawImage(ctx, CGRectMake(0, 0, CGImageGetWidth(inImage), CGImageGetHeight(inImage)), inImage);
//
//    CGAffineTransform transform = CGAffineTransformMakeTranslation(flippedImage.size.width, 0.0);
//    transform = CGAffineTransformScale(transform, -1.0, 1.0);
//    CGContextConcatCTM(ctx, transform);
//
//    CGContextDrawImage(ctx, cropRect, TheOtherHalf);
//
//    CGImageRef imageRef = CGBitmapContextCreateImage(ctx);
//    CGContextRelease(ctx);
//    UIImage *finalImage = [UIImage imageWithCGImage:imageRef];
//    CGImageRelease(imageRef);
//
//    return finalImage;
//}
//static CGRect swapWidthAndHeight(CGRect rect)
//{
//    CGFloat  swap = rect.size.width;
//
//    rect.size.width  = rect.size.height;
//    rect.size.height = swap;
//
//    return rect;
//}
//
//-(UIImage*)rotate:(UIImageOrientation)orient
//{
//    CGRect             bnds = CGRectZero;
//    UIImage*           copy = nil;
//    CGContextRef       ctxt = nil;
//    CGImageRef         imag = self.CGImage;
//    CGRect             rect = CGRectZero;
//    CGAffineTransform  tran = CGAffineTransformIdentity;
//
//    rect.size.width  = CGImageGetWidth(imag);
//    rect.size.height = CGImageGetHeight(imag);
//
//    bnds = rect;
//     switch (orient)
//    {
//          case UIImageOrientationUp:
//                  // would get you an exact copy of the original
//                   return  nil;
//        case UIImageOrientationUpMirrored:
//                tran = CGAffineTransformMakeTranslation(rect.size.width, 0.0);
//                tran = CGAffineTransformScale(tran, -1.0, 1.0);
//                break;
//
//        case UIImageOrientationDown:
//                tran = CGAffineTransformMakeTranslation(rect.size.width,rect.size.height);
//                tran = CGAffineTransformRotate(tran, M_PI);
//                break;
//
//        case UIImageOrientationDownMirrored:
//                tran = CGAffineTransformMakeTranslation(0.0, rect.size.height);
//                tran = CGAffineTransformScale(tran, 1.0, -1.0);
//                break;
//        case UIImageOrientationLeft:
//                bnds = swapWidthAndHeight(bnds);
//                tran = CGAffineTransformMakeTranslation(0.0, rect.size.width);
//                tran = CGAffineTransformRotate(tran, 3.0 * M_PI / 2.0);
//                break;
//
//        case UIImageOrientationLeftMirrored:
//                bnds = swapWidthAndHeight(bnds);
//                tran = CGAffineTransformMakeTranslation(rect.size.height,rect.size.width);
//                tran = CGAffineTransformScale(tran, -1.0, 1.0);
//                tran = CGAffineTransformRotate(tran, 3.0 * M_PI / 2.0);
//                break;
//
//        case UIImageOrientationRight:
//                bnds = swapWidthAndHeight(bnds);
//                tran = CGAffineTransformMakeTranslation(rect.size.height, 0.0);
//                tran = CGAffineTransformRotate(tran, M_PI / 2.0);
//                break;
//
//        case UIImageOrientationRightMirrored:
//                 bnds = swapWidthAndHeight(bnds);
//                 tran = CGAffineTransformMakeScale(-1.0, 1.0);
//                 tran = CGAffineTransformRotate(tran, M_PI / 2.0);
//                break;
//
//      default:
//      // orientation value supplied is invalid
//      return  nil;
//
//    }
//
//    UIGraphicsBeginImageContext(bnds.size);
//    ctxt = UIGraphicsGetCurrentContext();
//    switch (orient)
//    {
//        case UIImageOrientationLeft:
//        case UIImageOrientationLeftMirrored:
//        case UIImageOrientationRight:
//        case UIImageOrientationRightMirrored:
//        CGContextScaleCTM(ctxt, -1.0, 1.0);
//        CGContextTranslateCTM(ctxt, -rect.size.height, 0.0);
//        break;
//
//        default:
//        CGContextScaleCTM(ctxt, 1.0, -1.0);
//        CGContextTranslateCTM(ctxt, 0.0, -rect.size.height);
//        break;
//    }
//
//    CGContextConcatCTM(ctxt, tran);
//    CGContextDrawImage(UIGraphicsGetCurrentContext(), rect, imag);
//
//    copy = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//
//    return copy;
//
//}


@end
