//
//  Photo.swift
//  Image Viewer App
//
//  Created by Eszter Szabó on 2021. 02. 09..
//

import Foundation
import Alamofire

// Convert the data to this model.
struct Photo: Codable {
    let albumID: Int?
    let id: Int?
    let title: String?
    let url: String?
    let thumbnailURL: String?
    
    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case id = "id"
        case title = "title"
        case url = "url"
        case thumbnailURL = "thumbnailUrl"
    }
}

// MARK: Convenience initializers.
extension Photo {
    
    init(data: Data) throws {
        self = try JSONDecoder().decode(Photo.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
