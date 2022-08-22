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

    var fileExists: Bool {
        let path = localFileURL.path
        return FileManager.default.fileExists(atPath: path)
    }
}

public protocol StorableFileModel: OwnedDataModel {
    static var type: UTType { get }
    var filename: String { get }
}


public protocol OwnedDataModel: IdentifiableDataModel {
    var ownerId: String { get set }
}

public protocol IdentifiableDataModel: Codable {
    static var recordPath : String { get }
    var id: String { get set }
    var createdOn: Date { get set }
    var updatedOn: Date { get set }
}

public extension IdentifiableDataModel {
    mutating func updateDates() {
        updatedOn = Date()
    }
}

public protocol RecordDataModel: IdentifiableDataModel {
    var recordExists: Bool { get set }
}

private let recordLocalFolderURL = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
