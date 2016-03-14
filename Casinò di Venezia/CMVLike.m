//
//  CMVLike.m
//  Casinò di Venezia
//
//  Created by Massimo Moro on 10/03/14.
//  Copyright (c) 2014 Casinò di Venezia SPA. All rights reserved.
//

#import "CMVLike.h"

@implementation CMVLike

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    UIColor *color=[[UIColor alloc] init];
    //// Color Declarations
    if (!self.highlitedColor) {
        color = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
    } else {
        color = self.highlitedColor;
    }
    
    //// Frames
    CGRect frame = rect;
    
    
    //// Livello 1 Drawing
    UIBezierPath* livello1Path = [UIBezierPath bezierPath];
    [livello1Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.64072 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.97425 * CGRectGetHeight(frame))];
    [livello1Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.49154 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.96168 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.59095 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.97032 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.54067 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.96942 * CGRectGetHeight(frame))];
    [livello1Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.32502 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.92594 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.43551 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.95286 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.38059 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.93763 * CGRectGetHeight(frame))];
    [livello1Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.29329 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.92524 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.31485 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.92380 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.30381 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.92447 * CGRectGetHeight(frame))];
    [livello1Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.27609 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.90841 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.27992 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.92621 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.27607 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.92035 * CGRectGetHeight(frame))];
    [livello1Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.27685 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.54898 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.27630 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.78860 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.27600 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.66879 * CGRectGetHeight(frame))];
    [livello1Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.29127 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.53127 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.27690 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.54279 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.28555 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.53200 * CGRectGetHeight(frame))];
    [livello1Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.34871 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.48209 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.32261 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.52729 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.33647 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.50596 * CGRectGetHeight(frame))];
    [livello1Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.41442 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.35578 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.37039 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.43986 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.39027 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.39664 * CGRectGetHeight(frame))];
    [livello1Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.46965 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.28637 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.42929 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.33061 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.44793 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.30622 * CGRectGetHeight(frame))];
    [livello1Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.57735 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.07541 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.53293 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.22854 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.56206 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.15555 * CGRectGetHeight(frame))];
    [livello1Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.57897 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.06321 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.57812 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.07138 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.57844 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.06728 * CGRectGetHeight(frame))];
    [livello1Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.65005 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.02748 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.58423 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.02228 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.61038 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.00905 * CGRectGetHeight(frame))];
    [livello1Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.72169 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.14010 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.69880 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.05014 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.71764 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.09062 * CGRectGetHeight(frame))];
    [livello1Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.68176 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.30139 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.72643 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.19812 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.70702 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.25040 * CGRectGetHeight(frame))];
    [livello1Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.65250 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.36053 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.67200 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.32110 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.66224 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.34081 * CGRectGetHeight(frame))];
    [livello1Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.66578 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.38932 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.64528 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.37517 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.64769 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.38713 * CGRectGetHeight(frame))];
    [livello1Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.76205 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.39737 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.69774 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.39320 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.72992 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.39703 * CGRectGetHeight(frame))];
    [livello1Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.88688 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.39416 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.80365 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.39780 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.84532 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.39319 * CGRectGetHeight(frame))];
    [livello1Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.92768 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.41178 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.90080 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.39448 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.91735 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.40228 * CGRectGetHeight(frame))];
    [livello1Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.97577 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.50578 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.95510 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.43696 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.97770 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.46599 * CGRectGetHeight(frame))];
    [livello1Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.97161 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.52546 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.97544 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.51244 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.97491 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.51995 * CGRectGetHeight(frame))];
    [livello1Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.96738 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.59817 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.95735 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.54925 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.95833 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.57306 * CGRectGetHeight(frame))];
    [livello1Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.95795 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.66879 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.97628 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.62287 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.97068 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.64559 * CGRectGetHeight(frame))];
    [livello1Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.95282 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.71111 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.95143 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.68067 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.94879 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.69850 * CGRectGetHeight(frame))];
    [livello1Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.92176 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.81927 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.96674 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.75468 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.95214 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.78805 * CGRectGetHeight(frame))];
    [livello1Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.90657 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.85305 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.91355 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.82772 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.91063 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.84137 * CGRectGetHeight(frame))];
    [livello1Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.90519 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.87130 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.90462 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.85864 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.90671 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.86547 * CGRectGetHeight(frame))];
    [livello1Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.78486 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.96647 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.89471 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.91158 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.82775 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.96545 * CGRectGetHeight(frame))];
    [livello1Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.64102 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.96674 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.73694 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.96762 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.68896 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.96674 * CGRectGetHeight(frame))];
    [livello1Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.64072 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.97425 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.64092 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.96924 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.64082 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.97174 * CGRectGetHeight(frame))];
    [livello1Path closePath];
    [livello1Path moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.26072 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.72641 * CGRectGetHeight(frame))];
    [livello1Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.26065 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.90917 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.26071 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.78733 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.26087 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.84825 * CGRectGetHeight(frame))];
    [livello1Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.21098 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.95741 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.26052 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.94477 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.24729 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.95738 * CGRectGetHeight(frame))];
    [livello1Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.10488 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.95737 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.17562 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.95744 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.14025 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.95761 * CGRectGetHeight(frame))];
    [livello1Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.06183 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.92149 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.07995 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.95720 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.06451 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.94529 * CGRectGetHeight(frame))];
    [livello1Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.03828 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.69733 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.05344 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.84683 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.04624 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.77204 * CGRectGetHeight(frame))];
    [livello1Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.02073 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.54109 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.03273 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.64522 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.02696 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.59313 * CGRectGetHeight(frame))];
    [livello1Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.05733 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.49825 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.01789 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.51742 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.03256 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.49854 * CGRectGetHeight(frame))];
    [livello1Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.21860 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.49817 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.11108 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.49763 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.16485 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.49763 * CGRectGetHeight(frame))];
    [livello1Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.26063 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.54365 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.24699 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.49846 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.26046 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.51329 * CGRectGetHeight(frame))];
    [livello1Path addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.26072 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.72641 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.26098 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.60457 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.26073 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.66549 * CGRectGetHeight(frame))];
    [livello1Path closePath];
    [color setStroke];
    livello1Path.lineWidth = 1;
    [livello1Path stroke];
    self.highlitedColor=nil;
}


@end
