//
//  NetworkService.swift
//  News
//
//  Created by Даша Волошина on 17.05.25.
//

import Foundation

class NetworkService: ObservableObject {    
    @Published var news: News?
    @Published var block: Blocks?
    
    private let baseUrl = "https://us-central1-server-side-functions.cloudfunctions.net"
    private let authorization = "darya-voloshyna"
  
    //MARK: get news
    func getNews ()  async throws  -> News? {
        guard let url = URL(string: baseUrl + "/nytimes?period=1") else {
            throw NetworkError.decodingError
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(authorization, forHTTPHeaderField: "Authorization")
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            do {
                news =  try decoder.decode(News.self, from: data)
            } catch{
                print(error)
                NetworkError.decodingError
            }
            
        }catch {
            throw NetworkError.invalidRequest
        }
        
        return news
    }
    
    //MARK: get more blocks
    func getBlocks() async throws -> Blocks? {
        guard let url = URL(string: baseUrl + "/supplementary") else {
            throw NetworkError.decodingError
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(authorization, forHTTPHeaderField: "Authorization")
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            print(String(data: data, encoding: .utf8))
            
            do {
                block =  try decoder.decode(Blocks.self, from: data)
            } catch{
                print(error)
                NetworkError.decodingError
            }
        }catch{
            throw NetworkError.invalidRequest
        }
        return block
    }
}
