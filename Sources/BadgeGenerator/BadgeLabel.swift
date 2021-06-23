//
//  BadgeLabel.swift
//  
//
//  Created by Kenneth Dubroff on 6/23/21.
//

import UIKit

public class BadgeLabel: UILabel {
    
    internal var padding: CGFloat = 8
    
    public init(backgroundColor: UIColor = .systemRed, text: String, padding: CGFloat = 8) {
        
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        self.backgroundColor = backgroundColor
        self.text = text
        self.padding = padding
        
        commonInit()
        setConstraints()
        
    }
    
    
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
    
    private func commonInit() {
        textAlignment = .center
    }
    
    public override func layoutSubviews() {
        
        super.layoutSubviews()
        let cornerRadius = 0.5 * bounds.size.width
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
        clipsToBounds = true
        
    }
    
    // add padding
    public override func drawText(in rect: CGRect) {
        
        let insets = UIEdgeInsets(top: 0,
                                  left: padding/2,
                                  bottom: 0,
                                  right: padding/2)
        
        super.drawText(in: rect.inset(by: insets))
        
    }
    
    // increase content size to account for padding
    public override var intrinsicContentSize: CGSize {
        
        var content = super.intrinsicContentSize
        content.width += padding
        return content
        
    }
    
    public func set(_ value: String) {
        text = value
    }
    
    public func remove() {
        removeFromSuperview()
    }
    
}
