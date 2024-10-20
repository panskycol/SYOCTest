//
//  JZUIMarco.h
//  JZUIKitDemo
//
//  Created by 桑尼 on 2021/9/24.
//

#ifndef JZUIMarco_h
#define JZUIMarco_h

#define FX(view)    view.frame.origin.x
#define FY(view)    view.frame.origin.y
#define FW(view)    view.frame.size.width
#define FH(view)    view.frame.size.height

#define JZRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define JZDefaultTextColor JZRGBA(51, 51, 51, 1)
#define JZGlobalColor JZRGBA(144, 75, 255, 1)
#define JZGlobalBorderColor JZRGBA(232, 232, 232, 1)

#endif /* JZUIMarco_h */
