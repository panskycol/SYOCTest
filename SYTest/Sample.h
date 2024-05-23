//
//  Sample.h
//  SYTest
//
//  Created by Pan skycol on 2024/2/29.
//

#import <Foundation/Foundation.h>
#import <WCDBObjc/WCDBObjc.h>

NS_ASSUME_NONNULL_BEGIN

@interface Sample : NSObject<WCTTableCoding>

@property (nonatomic, assign) int identifier;
@property (nonatomic, strong) NSString* content;

WCDB_PROPERTY(identifier)
WCDB_PROPERTY(content)


@end

NS_ASSUME_NONNULL_END
