import Foundation

// DOC Puedes echar un vistazo en https://docs.discourse.org

struct LatestTopicsResponse: Decodable {
    let topics: Topics
    let users: Users
    
    enum CodingKeys: String, CodingKey {
        case topicsRoot = "topic_list"
        case topics, users
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        users = try container.decode(Users.self, forKey: .users)

        let rootTopics = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .topicsRoot)
        topics = try rootTopics.decode(Topics.self, forKey: .topics)
    }
}


