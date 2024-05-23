//
//  MSAvatarSampleView.h
//  AiJiaoYou
//
//  Created by Wudi_Mac on 2019/4/29.
//  Copyright © 2019 User. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Macro.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SampleType) {
    SampleTypeAvatar = 0,
    SampleTypeCert = 1,
};

typedef enum userGender
{
    GenderValidate = 0,
    GenderMale =1,//男人
    GenderFemale =2,//女人
    GenderSecrect =3 //保密
}UserGender;

@interface MSAvatarSampleView : UIView

@property (assign, nonatomic) UserGender gender;

@property (strong, nonatomic) void (^confirmBlock)();

- (instancetype)initWithType:(SampleType)type;
- (void)show;

@end

NS_ASSUME_NONNULL_END
