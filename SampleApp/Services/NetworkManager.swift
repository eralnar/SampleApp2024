import Foundation

class Network {
    static let shared = Network()
    internal func getJSON<JSON>(request: URLRequest, type: JSON.Type) async throws -> JSON where JSON: Decodable {
        let (data, _) = try await URLSession.shared.data(for: request)
        let result = try JSONDecoder().decode(type.self, from: data)
        return result
    }
}

class NetworkTest {
    static let shared = NetworkTest()
    internal func getJSON<JSON>(filename: String, type: JSON.Type) async throws -> JSON where JSON: Decodable {
        let path = Bundle.main.path(forResource: filename, ofType: "json")!
        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let result = try JSONDecoder().decode(type.self, from: data)
        return result
    }
}
