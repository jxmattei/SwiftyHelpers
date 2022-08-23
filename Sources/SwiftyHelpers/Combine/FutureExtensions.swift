//
//  FutureExtensions.swift
//  
//
//  Created by Jorge Mattei on 8/22/22.
//

import Combine

public extension Future {

    static func future<T>(containing: @escaping () async throws ->(T)) -> Future<T,Error> {
        return Future<T,Error> { promise in
            Task {
                do {
                    let result = try await containing()
                    promise(.success(result))
                } catch {
                    promise(.failure(error))
                }
            }
        }
    }

}
