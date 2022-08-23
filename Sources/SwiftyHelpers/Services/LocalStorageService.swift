//
//  File.swift
//  
//
//  Created by Jorge Mattei on 8/22/22.
//

import Foundation
import UniformTypeIdentifiers
import Combine

public protocol LocalStorageService { }

//MARK: Internal Storage Management
public extension LocalStorageService {

    func delete(_ file: StorableFileModel) -> AnyPublisher<Void,Error> {
        return Future<Void,Error>.future {
            return try await delete(file)
        }.eraseToAnyPublisher()
    }

    func delete(_ file: StorableFileModel) async throws {
        let url = file.localFileURL
        let path = url.path
        let fileManager = FileManager.default
        guard fileManager.fileExists(atPath: path) else { return }
        try fileManager.removeItem(atPath: path)
    }

    func write(_ data: Data, for file: StorableFileModel) -> AnyPublisher<Void,Error> {
        Future<Void,Error>.future {
            return try await write(data, for: file)
        }.eraseToAnyPublisher()
    }

    func write(_ data: Data, for file: StorableFileModel) async throws {
        let url = file.localFileURL
        let directoryURL = url.deletingLastPathComponent()
        let fileManager = FileManager.default
        try? fileManager.createDirectory(at: directoryURL, withIntermediateDirectories: true, attributes: nil)
        try data.write(to: url)
    }

    func load(_ file: StorableFileModel) -> AnyPublisher<Data, Error> {
        return Future<Data, Error>.future {
            return try await load(file)
        }.eraseToAnyPublisher()
    }

    func load(_ file: StorableFileModel) async throws -> Data {
        let path = file.localFileURL.path
        let fileManager = FileManager.default
        guard fileManager.fileExists(atPath: path) else {
            throw LocalStorageServiceError.fileNotFoundLocally
        }
        if let data = fileManager.contents(atPath: path) {
            return data
        } else {
            throw LocalStorageServiceError.errorLoadingInternalFile
        }
    }
}


private enum LocalStorageServiceError: LocalizedError {
    case fileNotFoundLocally
    case errorLoadingInternalFile
}
