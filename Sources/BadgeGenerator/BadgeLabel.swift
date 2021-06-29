//
//  BadgeLabel.swift
//  
//
//  Created by Kenneth Dubroff on 6/23/21.
//

import UIKit

public class BadgeLabel: UILabel {
    
    internal var padding: CGFloat = 8
    
    /// programmatic init
    ///   - Parameters:
    ///      - padding: The amount of padding from
    ///   the edges of the label to the text,
    ///   required to maintain circular shape
    ///   without clipping text
    public init(backgroundColor: UIColor = .systemRed, text: String, padding: CGFloat = 8) {
        
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        self.backgroundColor = backgroundColor
        self.text = text
        self.padding = padding
        
        commonInit()
        setConstraints()
        
    }
    
    /// constrain the height and width
    /// so the label forms a square,
    /// required to maintain circular shape
    private func setConstraints() {
        
        if bounds.size.width > bounds.size.height {
            heightAnchor.constraint(equalTo: widthAnchor).isActive = true
        } else {
            widthAnchor.constraint(equalTo: heightAnchor).isActive = true
        }
        
    }
    
    public required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        commonInit()
        
    }
    
    /// align text in the center of the label
    /// to avoid clipping and maintain visual
    /// consistency
    private func commonInit() {
        textAlignment = .center
    }
    
    public override func layoutSubviews() {
        
        super.layoutSubviews()
        clipShape()
        
    }
    
    /// - set the label's cornerRadius to make a circle
    /// - mask and clip to bounds to preserve circular
    /// shape without allowing other elements to bleed
    /// outside of the bounds of the shape
    private func clipShape() {
        
        let cornerRadius = 0.5 * bounds.size.width
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
        clipsToBounds = true
        
    }
    
    public override func drawText(in rect: CGRect) {
        
        let insets = padWithInsets()
        super.drawText(in: rect.inset(by: insets))
        
    }
    
    /// add padding (half of class property to each side)
    private func padWithInsets() -> UIEdgeInsets {
        
        UIEdgeInsets(top: 0,
                     left: padding/2,
                     bottom: 0,
                     right: padding/2)
        
    }
    
    // increase content size to account for padding
    public override var intrinsicContentSize: CGSize {
        
        var content = super.intrinsicContentSize
        content.width += padding
        return content
        
    }
    // MARK: - Badge Functionality -
    
    /// set the label's text with `value`
    public func set(_ value: String) {
        text = value
    }
    
    /// remove the label from its superview
    public func remove() {
        removeFromSuperview()
    }
    
    /// increment the current value by `num`
    @discardableResult public func incrementIntValue(by num: Int) -> IntValueResult {
        
        switch convertTextToInt {
        case let .success(value):
            let value = value.advanced(by: num)
            text = String(value)
            return .success(value)
            
        case let .failure(error):
            return .failure(error)
        }
        
        
    }
    
    private var convertTextToInt: IntValueResult {
        
        guard let text = text,
              let intVal = Int(text)
        else {
            let textValue = "\(text ?? "value")"
            let domain = "\(#function), \(textValue) cannot be converted to Int"
            let error = NSError(domain: domain, code: 0)
            return .failure(error)
        }
        return .success(intVal)
    }
    
}

extension BadgeLabel {
    
    public enum IntValueResult {
        
        case success(Int)
        case failure(Error)
        
    }
    
}
