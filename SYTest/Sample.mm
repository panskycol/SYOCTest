//
//  Sample.m
//  SYTest
//
//  Created by Pan skycol on 2024/2/29.
//

#import "Sample.h"

@implementation Sample

WCDB_IMPLEMENTATION(Sample)
WCDB_SYNTHESIZE(identifier)
WCDB_SYNTHESIZE(content)

WCDB_INDEX("_multiIndex", identifier)


@end
