//
//  SYStudentModel.h
//  SYTest
//
//  Created by Pan skycol on 2024/5/22.
//

#import <Foundation/Foundation.h>
#import "SYPersonModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SYStudentModel : SYPersonModel

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *year;
@property (nonatomic, copy) NSString *obj;


@end

NS_ASSUME_NONNULL_END
