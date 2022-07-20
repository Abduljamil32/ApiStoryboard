import Foundation

struct User: Decodable{
    var avatar_url: String
    var bio: String
    var followers: Int
    var following: Int
    var location: String
    var login: String
    var name: String
    var public_repos: Int
}
