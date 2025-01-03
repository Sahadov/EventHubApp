import Foundation


class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func createURL(for endpoint: APIEndpoints, with query: String? = nil) -> URL? {
        var components = URLComponents()
        components.scheme = API.scheme
        components.host = API.host
        components.path = endpoint.patch
        components.queryItems = makeParameters(for: endpoint).compactMap({
            URLQueryItem(name: $0.key, value: $0.value)
        })
        return components.url
    }
    
    private func makeParameters(for endpoint: APIEndpoints) -> [String: String] {
        var parameters = [String: String]()
        
        switch endpoint {
        case .getCities(lang: let lang):
            parameters["lang"] = "\(lang)"
            parameters["fields"] = "slug,name,coords"
        case .getCategories(lang: let lang):
            parameters["lang"] = "\(lang)"
        case .getEnvents(lang: let lang, location: let location, page: let page):
            parameters["page_size"] = "(10)"
            parameters["expand"] = "dates,place"
            parameters["order_by"] = "-publication_date"
            parameters["lang"] = "\(lang)"
            parameters["page"] = "\(page)"
            parameters["location"] = "\(location)"
            parameters["fields"] = "id,dates,title,short_title,place,description,body_text,location,categories,images,favorites_count,participants,site_url"
            parameters["text_format"] = "text"
            parameters["actual_since"] = "\(Date().timeIntervalSince1970)"
        case .doSearch(query: let query, location: let location, page: let page, lang: let lang):
            parameters["q"] = "\(query)"
            parameters["location"] = "\(location)"
            parameters["lang"] = "\(lang)"
            parameters["page"] = "\(page)"
            parameters["expand"] = "dates"
            parameters["ctype"] = "event"
        case .getUpcomingEnvents(lang: let lang, category: let category):
            parameters["page_size"] = "10"
            parameters["order_by"] = "-publication_date"
            parameters["expand"] = "dates,place,location,participants"
            parameters["lang"] = "\(lang)"
            parameters["fields"] = "id,dates,title,short_title,place,location,categories,images,favorites_count,participants,body_text,site_url"
            parameters["actual_since"] = "\(Int(Date().timeIntervalSince1970))"
            parameters["text_format"] = "text"
            if let category = category {
                parameters["categories"] = category
            }
        case .getNearbyEnvents(lang: let lang, lat: let lat, lon: let lon, radius: let radius, category: let category):
            parameters["page_size"] = "10"
            parameters["order_by"] = "-publication_date"
            parameters["expand"] = "dates,place,location,participants"
            parameters["lang"] = "\(lang)"
            parameters["fields"] = "id,dates,title,short_title,place,location,categories,images,favorites_count,participants,body_text,site_url"
            parameters["lat"] = "\(lat)"
            parameters["lon"] = "\(lon)"
            parameters["radius"] = "\(radius)"
            parameters["text_format"] = "text"
            if let category = category {
                parameters["categories"] = category
            }
        case .getWeekEvents(lang: let lang, location: let location, page: let page):
            parameters["lang"] = "\(lang)"
            parameters["page"] = "\(page)"
            parameters["page_size"] = "10"
            parameters["location"] = "\(location)"
            parameters["fields"] = "id,dates,title,short_title,place,description,body_text,location,categories,images,favorites_count,participants,site_url"
            parameters["text_format"] = "text"
            parameters["expand"] = "dates,place"
            parameters["order_by"] = "-publication_date"
            parameters["actual_until"] = "\(Int(Date().timeIntervalSince1970))"
        }

        return parameters
    }
    
    func fetchImage(from url: URL, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
    
    func fetch<T: Decodable>(for url: URL, completion: @escaping(Result<T, NetworkError>) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                return completion(.failure(.badResponse))
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let dataModel = try decoder.decode(T.self, from: data)
                completion(.success(dataModel))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
