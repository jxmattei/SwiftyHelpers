//
//  File.swift
//  
//
//  Created by Jorge Mattei on 8/19/22.
//

import Foundation
import UIKit
import Combine

open class ActionableViewController<T: Action>: UIViewController, Actionable, CancellableContainer {
    public var actions: PassthroughSubject<T, Never> = .init()
    public var cancellables: Set<AnyCancellable> = []

    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder: NSCoder) {
        nil
    }

    open func process(action: T) {
        fatalError("class should be overriden")
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        registerActions()
    }

}

public protocol Actionable: CancellableContainer {
    associatedtype ActionModel: Action
    var actions: PassthroughSubject<ActionModel, Never> { get set }
    func process(action: ActionModel)
}

public extension Actionable {
    func registerActions() {
        actions.sink(receiveValue: { self.process(action: $0) })
            .store(in: &CancellableCollector.shared.cancellables)
    }

    func sendAction(_ action: ActionModel) {
        self.actions.send(action)
    }
}

public protocol Action { }
