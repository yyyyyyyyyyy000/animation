//
//  PlayingcardView.swift
//  animation
//
//  Created by 无敌帅的yyyyy on 2019/1/19.
//  Copyright © 2019年 无敌帅的yyyy. All rights reserved.
//

import UIKit
@IBDesignable
class playingcardView: UIView {
    @IBInspectable
    var suit : String = "♥️"{didSet{setNeedsDisplay(); setNeedsLayout()}}
    @IBInspectable
    var rank : Int = 5 {didSet{setNeedsDisplay(); setNeedsLayout()}}
    @IBInspectable
    var isFaceup : Bool = true {didSet{setNeedsDisplay(); setNeedsLayout()}}
    var facescale: CGFloat = SizeRatio.facecardImageSizetoboundsize {didSet{setNeedsDisplay()}}
    
    @objc func dealthescalerecognizer(_ recognizer:UIPinchGestureRecognizer){
        facescale *= recognizer.scale
        recognizer.scale = 1.0
    }
    
    
    
    
    private lazy var upperlabel = cornerlabel()
    private lazy var downlabel = cornerlabel()
    
    
    private func cornerlabel()->UILabel{
        let label = UILabel()
        label.numberOfLines = 0
        addSubview(label)
        return label
        
    }
    private func configurecornerlabel(_ label:UILabel){
        label.attributedText = cornerString
        label.frame.size = CGSize.zero
        label.sizeToFit()
        label.isHidden = !isFaceup
        
        
    }
    //检测系统设置变化
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setNeedsDisplay()
        setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configurecornerlabel(upperlabel)
        upperlabel.frame.origin = bounds.origin.offsetBy(dx: cornerOffset, dy: cornerOffset)
        
        configurecornerlabel(downlabel)
        downlabel.transform = CGAffineTransform.identity.translatedBy(x: downlabel.frame.width, y: downlabel.frame.height).rotated(by: CGFloat.pi)
        downlabel.frame.origin = CGPoint(x: bounds.maxX, y: bounds.maxY).offsetBy(dx: -cornerOffset, dy: -cornerOffset).offsetBy(dx: -downlabel.frame.width, dy: -downlabel.frame.height)
        
    }
    
    
    
    
    
    private func centerattributesString(_ string : String , fontsize : CGFloat) -> NSAttributedString{
        var font = UIFont.preferredFont(forTextStyle: .body).withSize(fontsize)
        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
        
        let paragraphstyle = NSMutableParagraphStyle()
        paragraphstyle.alignment = .center
        return NSAttributedString(string: string, attributes: [NSAttributedString.Key.font : font,.paragraphStyle: paragraphstyle])
    }
    private var cornerString : NSAttributedString{
        return centerattributesString(rankString+"\n"+suit, fontsize: cornerFontSize)
    }
    
    override func draw(_ rect: CGRect) {
        let roundRect = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        roundRect.addClip()
        UIColor.white.setFill()
        roundRect.fill()
        if isFaceup{
            if let image = UIImage(named: "1"){
                image.draw(in: bounds.zoom(by: facescale))
            }
        }else{
            if let image = UIImage(named: "back"){
                image.draw(in: bounds)
            }
        }
        
    }
    
    
}

extension playingcardView{
    private struct SizeRatio{
        static let cornerFontSizeToboundsHeight:CGFloat = 0.085
        static let cornerRadiusToboundsheight : CGFloat = 0.06
        static let cornerOffsettoCornerradius:CGFloat = 0.33
        static let facecardImageSizetoboundsize:CGFloat = 0.6
    }
    private var cornerRadius:CGFloat {
        return bounds.size.height*SizeRatio.cornerRadiusToboundsheight
    }
    private var cornerOffset:CGFloat{
        return cornerRadius*SizeRatio.cornerOffsettoCornerradius
    }
    private var cornerFontSize: CGFloat{
        return bounds.size.height*SizeRatio.cornerFontSizeToboundsHeight
    }
    private var rankString:String{
        switch rank{
        case 1: return "A"
        case 2...10: return String(rank)
        case 11: return "J"
        case 12: return "Q"
        case 13: return "K"
        default: return "?"
        }
    }
    
    
}
extension CGRect {
    var leftHalf:CGRect{
        return CGRect(x: minX, y: minY, width: width/2, height: height/2)
    }
    var rightHalf:CGRect{
        return CGRect(x: midX, y: midY, width: width/2, height: height/2)
    }
    func inset(by size : CGSize)->CGRect{
        return insetBy(dx: size.width, dy: size.height)
    }
    func sized(to size:CGSize)->CGRect{
        return CGRect(origin: origin, size: size)
    }
    func zoom(by scale: CGFloat)->CGRect{
        let newWidth = width*scale
        let newHeight = height*scale
        return insetBy(dx: (width-newWidth)/2, dy: (height-newHeight)/2)
    }
}
extension CGPoint{
    func offsetBy(dx:CGFloat,dy:CGFloat)->CGPoint{
        return CGPoint(x:x+dx,y:y+dy)
    }
}
