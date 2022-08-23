//
//  File.swift
//  
//
//  Created by Jorge Mattei on 8/22/22.
//

import Foundation
import UniformTypeIdentifiers

public extension StorableFileModel {

    var fileId: String { return id }

    var localFileURL: URL {
        return recordLocalFolderURL
            .appendingPathComponent(Self.recordPath, isDirectory: true)
            .appendingPathComponent(ownerId, isDirectory: true)
            .appendingPathComponent(fileId, isDirectory: true)
            .appendingPathExtension(for: Self.type)

    }

    var localFileExists: Bool {
        let path = localFileURL.path
        return FileManager.default.fileExists(atPath: path)
    }
}

public protocol StorableFileModel: UserOwnedDataModel {
    static var recordPath: String { get }
    static var type: UTType { get }
    var filename: String { get }
}

public protocol IdentifiableDataModel: Codable {
    var id: String { get set }
}


public protocol UserOwnedDataModel: IdentifiableDataModel {
    var ownerId: String { get set }
}

private var recordLocalFolderURL: URL {
    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    return URL(fileURLWithPath: path)
}
