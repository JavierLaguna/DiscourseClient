import Foundation

// Puedes echar un vistazo en https://docs.discourse.org

struct SingleTopicResponse: Codable {
    let topic: Topic
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        topic = try container.decode(Topic.self)
    }
}
