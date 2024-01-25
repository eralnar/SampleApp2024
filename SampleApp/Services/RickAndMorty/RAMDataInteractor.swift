protocol RAMDataInteractor {
    func getRAMCharacterList(page: Int) async throws -> RickAndMortyGetAllCharactersResponse
}


extension Network: RAMDataInteractor {
    func getRAMCharacterList(page: Int = 0) async throws -> RickAndMortyGetAllCharactersResponse {
        try await getJSON(request: RAMApi.charatersList(page: page).request!, type: RickAndMortyGetAllCharactersResponse.self)
    }
}

extension NetworkTest: RAMDataInteractor {
    func getRAMCharacterList(page: Int) async throws -> RickAndMortyGetAllCharactersResponse {
        try await getJSON(filename: RAMApi.charatersList(page: page).testFileName, type: RickAndMortyGetAllCharactersResponse.self)
    }
}

