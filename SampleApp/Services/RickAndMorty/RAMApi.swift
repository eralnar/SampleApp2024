import Foundation


enum URLRequestMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
}

enum RAMApi {
    case charatersList(page: Int)
    
    var baseURL: String { "https://rickandmortyapi.com" }
    
    var path: String {
        switch self {
        case .charatersList: return "/api/character"
        }
    }
    
    var method: URLRequestMethod {
        switch self {
        default: return .GET
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
    
    var bodyParameters: [String: Any]? {
        return nil
    }
    
    var urlParameters: [String: String]? {
        switch self {
        case .charatersList(let page):
            return ["page": String(describing: page)]
        //default: return nil
        }
    }
    
    var testFileName: String {
        switch self {
        case .charatersList: return "characterList"
        }
    }
    
    var request: URLRequest? {
        guard var urlComponents = URLComponents(string: self.baseURL) else { return nil }
        urlComponents.path = self.path
        if let urlParams = self.urlParameters {
            urlComponents.queryItems = urlParams.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        guard let url = urlComponents.url else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = self.method.rawValue
        //TODO: Add body params to URLRequest if needed -> urlRequest.httpBody
        return urlRequest
    }
}


