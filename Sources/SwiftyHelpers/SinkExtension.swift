//
//  File.swift
//  
//
//  Created by Jorge Mattei on 8/15/22.
//

import Foundation
import UIKit
import Combine

@available(iOS 13.0, *)
public extension Publisher {
    @MainActor func bind(receiveCompletion: @escaping ((Subscribers.Completion<Self.Failure>) -> Void), receiveValue: @escaping ((Self.Output) -> Void)) {
        self.receive(on: DispatchQueue.main)
            .sink(receiveCompletion: receiveCompletion, receiveValue: receiveValue)
            .store(in: &CancellableCollector.shared.cancellables)
    }
}

@available(iOS 13.0, *)
public extension Publisher where Self.Failure == Never {
    @MainActor func bind(receiveValue: @escaping ((Self.Output) -> Void)) {
        self.receive(on: DispatchQueue.main)
            .sink(receiveValue: receiveValue)
            .store(in: &CancellableCollector.shared.cancellables)
    }
}
