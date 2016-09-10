//
//  DPCommonUtils.h
//  TestTask
//
//  Created by Dmitry Povolotsky on 9/10/16.
//  Copyright © 2016 Dmitry Povolotskyi. All rights reserved.
//

#ifndef DPCommonUtils_h
#define DPCommonUtils_h

#ifdef DEBUG
#    define DLog(format, ...) NSLog(format, __VA_ARGS__)
#else
#    define DLog(...)
#endif


#endif /* DPCommonUtils_h */
