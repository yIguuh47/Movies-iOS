//
//  RestGenre.swift
//  MoviesApp
//
//  Created by Virtual Machine on 03/08/22.
//

import Foundation

class GenreService {
    
    private var dataTask: URLSessionDataTask?
    
    func getGenresData(completion: @escaping ([Genres]?, Error?) -> Void) {
        let popularMoviesURL = "https://api.themoviedb.org/3/genre/movie/list?api_key=9cfd5674aee1f07e64a07d2ae76bd33c&language=pt-BR"
        
        guard let url = URL(string: popularMoviesURL) else {return}
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            
            if let error = error {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            if let safeData = data {
                DispatchQueue.main.async {
                    if let safeJson = self.parserJSON(safeData) {
                        completion(safeJson.genres, nil)
                    }
                }
            }
            
                    
        }
        task.resume()
    }
    
    func parserJSON(_ genresData: Data) -> GenresData? {
        let decoder = JSONDecoder()
        do {
            let jsonData = try decoder.decode(GenresData.self, from: genresData)
            return jsonData
        } catch {
            print("Error JsonDecoder")
            return nil
        }
    }
}

