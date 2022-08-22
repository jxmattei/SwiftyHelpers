//
//  File.swift
//  
//
//  Created by Jorge Mattei on 8/15/22.
//

import Combine

@available(iOS 13.0, *)
public class CancellableCollector {

    public var cancellables: Set<AnyCancellable> = []

    public static let shared = CancellableCollector()
}
