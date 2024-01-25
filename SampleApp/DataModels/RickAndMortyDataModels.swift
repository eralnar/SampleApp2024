import Foundation

struct RickAndMortyGetAllCharactersResponse: Decodable {
    var info: RAMInfo
    var results: [RAMCharacter]
}

struct RAMInfo: Decodable {
    var count: Int
    var pages: Int
    var next: String?
    var prev: String?
}

struct RAMCharacterLocation: Decodable {
    var name: String
    var url: String
}

struct RAMCharacter: Decodable, Identifiable {
    var id: Int
    var name: String
    var status: String
    var species: String
    var type: String
    var gender: String
    var origin: RAMCharacterLocation
    var location: RAMCharacterLocation
    var image: String
    var episode: [String]
    var url: String
    var created: String
}
