//
//  UIView+BadgeFactory.swift
//  CareForMe
//
//  Created by Kenneth Dubroff on 6/22/21.
//

import UIKit

public enum BadgeDirection {
    
    case northEast
    case northWest
    case southEast
    case southWest
    case center
    
}

extension UIView {
    
    /// add a new badge to the view
    /// - Parameters:
    ///   - direction: where the view's x/y boundaries will be anchored
    @discardableResult public func setBadge(in direction: BadgeDirection, with text: String) -> BadgeLabel {
        
        let badge = BadgeLabel(text: text)
        addSubview(badge)        
        
        if #available(iOS 11, *) {
            setBadgeConstraintsInSafeArea(for: badge, in: direction)
        } else {
            setBadgeConstraints(for: badge, in: direction)
        }
        
        return badge
        
    }
    
    /// set a badge's constraints in the given direction's boundaries
    /// - NOTE: requires iOS 11 or greater
    @available(iOS 11, *)
    private func setBadgeConstraintsInSafeArea(for badge: BadgeLabel, in direction: BadgeDirection) {
        
        switch direction {
        
        case .center:
            NSLayoutConstraint.activate([
                badge.centerXAnchor.constraint(equalTo:safeAreaLayoutGuide.centerXAnchor),
                badge.centerYAnchor.constraint(equalTo:safeAreaLayoutGuide.centerYAnchor),
            ])
        case .northEast:
            NSLayoutConstraint.activate([
                badge.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                badge.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
            ])
        case .northWest:
            NSLayoutConstraint.activate([
                badge.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                badge.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            ])
        case .southEast:
            NSLayoutConstraint.activate([
                badge.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
                badge.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            ])
        case .southWest:
            NSLayoutConstraint.activate([
                badge.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
                badge.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            ])
            
        }
        
    }
    
    @available(iOS, deprecated: 11, renamed: "setBadgeConstraintsInSafeArea", message: "It's \"safer\" to use the safeAreaLayoutGuide")
    private func setBadgeConstraints(for badge: BadgeLabel, in direction: BadgeDirection) {
        
        switch direction {
        
        case .center:
            NSLayoutConstraint.activate([
                badge.centerXAnchor.constraint(equalTo: centerXAnchor),
                badge.centerYAnchor.constraint(equalTo: centerYAnchor),
            ])
        case .northEast:
            NSLayoutConstraint.activate([
                badge.topAnchor.constraint(equalTo: topAnchor),
                badge.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
        case .northWest:
            NSLayoutConstraint.activate([
                badge.topAnchor.constraint(equalTo: topAnchor),
                badge.leadingAnchor.constraint(equalTo: leadingAnchor),
            ])
        case .southEast:
            NSLayoutConstraint.activate([
                badge.bottomAnchor.constraint(equalTo: bottomAnchor),
                badge.trailingAnchor.constraint(equalTo: trailingAnchor),
            ])
        case .southWest:
            NSLayoutConstraint.activate([
                badge.bottomAnchor.constraint(equalTo: bottomAnchor),
                badge.leadingAnchor.constraint(equalTo: leadingAnchor),
            ])
            
        }
        
    }
    
}

#if DEBUG

import SwiftUI

@available(iOS 13.0, *)
struct BadgeView: UIViewRepresentable {
    
    private let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    
    init(view: (UIView) -> ()) {
        view(self.view)
    }
    
    func makeUIView(context: Context) -> UIView {
        view.layer.cornerRadius = 30
        return view
    }
    
    func updateUIView(_ view: UIView, context: Context) {}
}

@available(iOS 13.0, *)
fileprivate extension UIView {
    static let play = UIImage(systemName: "arrowtriangle.forward.circle.fill")
    static let alarm = UIImage(systemName: "alarm.fill")
    
    func image(_ image: UIImage) {
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.addSubview(imageView)
    }
}

fileprivate extension UIColor {
    
}

@available(iOS 13.0, *)
struct BadgeView_Preview: PreviewProvider {
    static var previews: some View {
        VStack {
            HStack {
                VStack {
                
                    BadgeView {
                        $0.backgroundColor = .brown
                        $0.setBadge(in: .northWest, with: "10")
                    }
                  
                }
                
                VStack {
                //    BadgeView(.southEast)
                 //   BadgeView(.southWest)
                }
                VStack {
                  //  BadgeView(.center)
                  //  BadgeView(.center)
                }
               
          
            }
            .padding()
            .frame(width: 400, height: 265)
            Spacer()
        }
    }
}
#endif
