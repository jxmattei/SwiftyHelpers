//
//  File.swift
//  
//
//  Created by Jorge Mattei on 8/15/22.
//

import UIKit
import Combine

@available(iOS 13.0, *)
open class CancellableViewController: UIViewController {
    public var cancellables: Set<AnyCancellable> = []
}

@available(iOS 13.0, *)
open class CancellableClass {
    public var cancellables: Set<AnyCancellable> = []
    public init() { }
}

@available(iOS 13.0, *)
public protocol CancellableContainer {
    var cancellables: Set<AnyCancellable> { get set }
}
