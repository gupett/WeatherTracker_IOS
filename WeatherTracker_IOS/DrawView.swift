//
//  DrawView.swift
//  WeatherTracker_IOS
//
//  Created by Gustav on 16/04/16.
//  Copyright © 2016 Gustav. All rights reserved.
//

import UIKit

protocol GPMapDrawDelegate {
    func dismissDrawView()
    func convertLinesToOverlay(lines: [Line])
}

class DrawView: UIView {
    
    var lines: [Line] = []
    var lastPoint: CGPoint!
    var delegate: GPMapDrawDelegate? = nil
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //touches.first creates an UITouch
        guard let touch: UITouch = touches.first else{
            return
        }
        //Sets the first point touched
        lastPoint = touch.locationInView(self)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        guard let touch: UITouch = touches.first else{
            return
        }
        
        let newPoint = touch.locationInView(self)
        let line = Line(_start: lastPoint, _end: newPoint)
        lines.append(line)
        lastPoint = newPoint
        
        self.setNeedsDisplay()
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        guard let touch = touches.first else{
            return
        }
        
        guard let firstLine: Line = lines[0] else {
            return
        }
        
        lines.append(Line(_start: touch.locationInView(self), _end: firstLine.start))
        
        self.setNeedsDisplay()
        
        //Go back to mapView and use Lines to create an overlay based on map coordinates
        delegate?.dismissDrawView()
        
        delegate?.convertLinesToOverlay(lines)
    }

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        //Creates a context were all the cgpoints will be displayed
        let context = UIGraphicsGetCurrentContext()
        CGContextBeginPath(context)
        
        for line in lines {
            CGContextMoveToPoint(context, line.start.x, line.start.y)
            CGContextAddLineToPoint(context, line.end.x, line.end.y)
        }
        
        CGContextSetRGBStrokeColor(context, 0, 0, 1, 1)
        CGContextSetLineCap(context, CGLineCap.Round)
        CGContextSetLineWidth(context, 2.0)
        //Tells the context to be printed on the screen
        CGContextStrokePath(context)
    }
    

}
