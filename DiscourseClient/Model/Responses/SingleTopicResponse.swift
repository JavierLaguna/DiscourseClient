import Foundation

// Puedes echar un vistazo en https://docs.discourse.org

struct SingleTopicResponse: Codable {
    let topic: Topic
    let details: TopicDetails
    
    init(from decoder: Decoder) throws {
        let rootObject = try decoder.singleValueContainer()
        topic = try rootObject.decode(Topic.self)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        details = try container.decode(TopicDetails.self, forKey: .details)
    }
}
