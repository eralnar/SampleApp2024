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
    
    static let sample = RAMCharacterLocation(name: "Earth", url: "https://rickandmortyapi.com/api/location/1")
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
    var created: String //TODO: Parse as Date
    
    static let sample = RAMCharacter(id: 1,
                                     name: "Samplito",
                                     status: "Alive",
                                     species: "Dog",
                                     type: "",
                                     gender: "Female",
                                     origin: .sample,
                                     location: .sample,
                                     image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                                     episode: ["https://rickandmortyapi.com/api/episode/1",
                                               "https://rickandmortyapi.com/api/episode/2",
                                               "https://rickandmortyapi.com/api/episode/3"],
                                     url: "https://rickandmortyapi.com/api/character/1",
                                     created: "2017-11-04T18:48:46.250Z")
}
