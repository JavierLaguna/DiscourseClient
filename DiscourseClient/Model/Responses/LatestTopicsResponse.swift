import Foundation

// DOC Puedes echar un vistazo en https://docs.discourse.org

struct LatestTopicsResponse: Codable {
    let topics: Topics
    
    enum CodingKeys: String, CodingKey {
        case topicsRoot = "topic_list"
        case topics
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let rootTopics = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .topicsRoot)
        
        topics = try rootTopics.decode(Topics.self, forKey: .topics)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(topics, forKey: .topics)
    }
}


