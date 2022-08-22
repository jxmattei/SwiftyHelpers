//
//  Created by Jorge Mattei on 8/15/22.
//

import UIKit

public extension UIView {

    func anchorEdgeConstraints(to view: UIView,
                               edges: [Edge] = [.all],
                               attachToSafeArea: Bool = false) {
        self.translatesAutoresizingMaskIntoConstraints = false
        var modifiedEdges: [Edge]
        if edges.contains(.all) {
            modifiedEdges = [.top, .bottom, .leading, .trailing]
        } else {
            modifiedEdges = edges
        }

        if attachToSafeArea {
            let array = modifiedEdges.compactMap({
                switch $0 {
                case .top:
                    return self.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
                case .bottom:
                    return self.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
                case .leading:
                    return self.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
                case .trailing:
                    return self.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
                case .all: return nil
                }
            })
            NSLayoutConstraint.activate(array)
        } else {
            let array = modifiedEdges.compactMap({
                switch $0 {
                case .top:
                    return self.topAnchor.constraint(equalTo: view.topAnchor)
                case .bottom:
                    return self.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                case .leading:
                    return self.leadingAnchor.constraint(equalTo: view.leadingAnchor)
                case .trailing:
                    return self.trailingAnchor.constraint(equalTo: view.trailingAnchor)
                case .all: return nil
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
        var modifiedEdges: [Edge]
        if edges.contains(.all) {
            modifiedEdges = [.top, .bottom, .leading, .trailing]
        } else {
            modifiedEdges = edges
        }
        let topInset = modifiedEdges.contains(.top) ? value : 0
        let bottomInset = modifiedEdges.contains(.bottom) ? value : 0
        let leadingInset = modifiedEdges.contains(.leading) ? value : 0
        let trailingInset = modifiedEdges.contains(.trailing) ? value : 0
        self.layoutMargins = .init(top: topInset, left: leadingInset, bottom: bottomInset, right: trailingInset)
    }

}

public enum SizeConstraint {
    case height, width
}

public enum Edge {
    case top, bottom, leading, trailing, all
}
