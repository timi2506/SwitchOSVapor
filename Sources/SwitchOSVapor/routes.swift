import Vapor
import Foundation

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }
    func handleGetJSON(_ req: Request) async throws -> String {
        // Required query parameters
        guard
            let imageURLString = req.query[String.self, at: "imageURL"],
            let name = req.query[String.self, at: "name"],
            let contentType = req.query[String.self, at: "contentType"],
            let contentValue = req.query[String.self, at: "content"],
            let imageURL = URL(string: imageURLString)
        else {
            throw Abort(.badRequest, reason: "Missing or invalid query parameters")
        }

        // Optional user agent
        let userAgent = req.query[String.self, at: "userAgent"]

        // Parse content based on type
        let content: GameContent?
        switch contentType.lowercased() {
        case "url":
            guard let url = URL(string: contentValue) else {
                throw Abort(.badRequest, reason: "Invalid URL content")
            }
            content = .url(url)

        case "html":
            content = .html(contentValue)

        case "swiftui":
            content = .html(contentValue)

        default:
            content = nil // unknown content type
        }

        // Construct SwitchGame
        let game = SwitchGame(
            imageURL: imageURL,
            name: name,
            content: content,
            userAgent: userAgent
        )

        // Encode as JSON string
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try encoder.encode(game)
        return String(data: data, encoding: .utf8) ?? "Encoding failed"
    }

    // Register both routes
    app.get("getJSON", use: handleGetJSON)
    app.post("getJSON", use: handleGetJSON)

}
struct SwitchGame: Codable, Hashable, Identifiable {
    var id = UUID()
    let imageURL: URL
    let name: String
    var content: GameContent?
    var userAgent: String?
}

enum GameContent: Hashable {
    case url(URL)
    case html(String)
}

extension GameContent: Codable {
    private enum CodingKeys: String, CodingKey {
        case type
        case value
    }
    
    private enum ContentType: String, Codable {
        case url
        case html
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        switch self {
        case .url(let url):
            try container.encode(ContentType.url, forKey: .type)
            try container.encode(url, forKey: .value)
            
        case .html(let html):
            try container.encode(ContentType.html, forKey: .type)
            try container.encode(html, forKey: .value)
        }
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(ContentType.self, forKey: .type)
        
        switch type {
        case .url:
            let url = try container.decode(URL.self, forKey: .value)
            self = .url(url)
            
        case .html:
            let html = try container.decode(String.self, forKey: .value)
            self = .html(html)
        }
    }
}
