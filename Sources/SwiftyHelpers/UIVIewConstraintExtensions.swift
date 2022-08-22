//
//  Created by Jorge Mattei on 8/15/22.
//

import UIKit

public extension UIView {

    func anchorEdgeConstraints(to view: UIView,
                               edges: [Edge] = Edge.all,
                               attachToSafeArea: Bool = false) {
        self.translatesAutoresizingMaskIntoConstraints = false

        if attachToSafeArea {
            let array = edges.compactMap({
                switch $0 {
                case .top:
                    return self.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
                case .bottom:
                    return self.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
                case .leading:
                    return self.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
                case .trailing:
                    return self.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
                }
            })
            NSLayoutConstraint.activate(array)
        } else {
            let array = edges.compactMap({
                switch $0 {
                case .top:
                    return self.topAnchor.constraint(equalTo: view.topAnchor)
                case .bottom:
                    return self.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                case .leading:
                    return self.leadingAnchor.constraint(equalTo: view.leadingAnchor)
                case .trailing:
                    return self.trailingAnchor.constraint(equalTo: view.trailingAnchor)
                }
            })
            NSLayoutConstraint.activate(array)
        }
    }

    func anchorSameHeightWidth() {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalTo: widthAnchor)
        ])
    }

    func setSizeConstraint(_ sizeConstraints: [SizeConstraint], value: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        let array = sizeConstraints.map { constraint in
            switch constraint {
            case .height: return self.heightAnchor.constraint(equalToConstant: value)
            case .width: return self.widthAnchor.constraint(equalToConstant: value)
            }
        }
        NSLayoutConstraint.activate(array)
    }

}

public extension UIStackView {

    func padding(_ edges: [Edge], value: CGFloat) {
        self.isLayoutMarginsRelativeArrangement = true
        let topInset = edges.contains(.top) ? value : 0
        let bottomInset = edges.contains(.bottom) ? value : 0
        let leadingInset = edges.contains(.leading) ? value : 0
        let trailingInset = edges.contains(.trailing) ? value : 0
        self.layoutMargins = .init(top: topInset, left: leadingInset, bottom: bottomInset, right: trailingInset)
    }

}

public enum SizeConstraint {
    case height, width
}

public enum Edge {
    case top, bottom, leading, trailing

    public static let all: [Edge] = []
}
