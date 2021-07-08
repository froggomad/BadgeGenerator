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
    
    private let view = UIView()
    
    init(view: (UIView) -> ()) {
        view(self.view)
    }
    
    func makeUIView(context: Context) -> UIView {
        view.layer.cornerRadius = 15
        return view
    }
    
    func updateUIView(_ view: UIView, context: Context) {}
}

fileprivate extension UIColor {
    static let majorelle = UIColor(red: 0.36, green: 0.40, blue: 0.91, alpha: 1.0)
    static let flamenco = UIColor(red: 0.92, green: 0.51, blue: 0.30, alpha: 1.0)
    static let wisteria = UIColor(red: 0.81, green: 0.64, blue: 0.83, alpha: 1.0)
    static let clamShall = UIColor(red: 0.84, green: 0.70, blue: 0.63, alpha: 1.0)
    static let lilac = UIColor(red: 1.00, green: 0.66, blue: 0.67, alpha: 1.0)
}

fileprivate extension UIView {
    func image(_ image: UIImage) {
        let imageView = UIImageView(image: image)
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 40),
            imageView.heightAnchor.constraint(equalToConstant: 40),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        addSubview(imageView)
    }
}

@available(iOS 13.0, *)
fileprivate extension UIImage {
    static let play = UIImage(systemName: "arrowtriangle.forward.circle.fill")!
    static let alarm = UIImage(systemName: "alarm.fill")!
}


@available(iOS 13.0, *)
struct BadgeView_Preview: PreviewProvider {
    static var previews: some View {
        VStack {
            HStack {
                VStack {
                    BadgeView {
                        $0.backgroundColor = .majorelle
                        $0.setBadge(in: .northEast, with: "10")
                    }
                    BadgeView {
                        $0.backgroundColor = .flamenco
                        $0.setBadge(in: .southEast, with: "300")
                    }
                }
                VStack {
                    BadgeView {
                        $0.backgroundColor = .wisteria
                        $0.setBadge(in: .northWest, with: "20")
                    }
                    BadgeView {
                        $0.backgroundColor = .clamShall
                        $0.setBadge(in: .southWest, with: "430")
                    }
                }
                VStack {
                    BadgeView {
                        $0.backgroundColor = .lilac
                        $0.setBadge(in: .center, with: "5000")
                    }
                }
            }
            .padding()
            .frame(width: 400, height: 265)
            
            Spacer()
        }
    }
}
#endif
