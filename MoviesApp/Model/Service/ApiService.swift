//
//  ApiService.swift
//  MoviesApp
//
//  Created by Virtual Machine on 09/05/22.
//

import Foundation

class ApiService {
    
    private var dataTask: URLSessionDataTask?

    func getPopularTvData(completion: @escaping ([TvPopular]?, Error?) -> Void) {
        let popularMoviesURL = "https://api.themoviedb.org/3/tv/popular?api_key=9cfd5674aee1f07e64a07d2ae76bd33c&language=pt-BR&page=1#"
        
        guard let url = URL(string: popularMoviesURL) else {return}
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            
            if let safeData = data {
                DispatchQueue.main.async {
                    if let safeJson = self.parserJSON(safeData) {
                        completion(safeJson.results, nil)
                    }
                }
            }
            
            if let error = error {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                print("DataTask error: \(error.localizedDescription)")
                return
            }
        }
        task.resume()
    }
    
    func parserJSON(_ moviesData: Data) -> TvPopularData? {
        let decoder = JSONDecoder()
        do {
            let jsonData = try decoder.decode(TvPopularData.self, from: moviesData)
            return jsonData
        } catch {
            print("Error JsonDecoder")
            return nil
        }
    }
}
