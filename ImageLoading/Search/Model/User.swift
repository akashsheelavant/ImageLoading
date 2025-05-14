//
//  User.swift
//  ImageLoading
//
//  Created by Akash Sheelavant on 2/18/25.
//

struct UserResult: Decodable {
    
    let users: [User]?
    
    enum CodingKeys: String, CodingKey {
        case results
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.users = try container.decode([User].self, forKey: .results)
    }
}

struct User: Decodable {
    let title: String?
    let first: String?
    let last: String?
    
    let number: Int?
    let name: String?
    let city: String?
    let state: String?
    let country: String?
    let postcode: String?
    
    let imageURL: String?
    
    
    
    
    enum ResultsCodingKeys: CodingKey {
        case name
        case location
        case picture
    }
    
    enum NameCodingKeys: CodingKey {
        case title
        case first
        case last
    }
    
    enum LocationCodingKeys: CodingKey {
        case street
        case city
        case state
        case country
        case postcode
    }
    
    enum StreetCodingKeys: CodingKey {
        case number
        case name
    }
    
    enum PictureCodingKeys: CodingKey {
        case large
        case medium
        case thumbnail
    }
    
    
    
    init(from decoder: any Decoder) throws {
        // get results container
        let resultsContainer = try decoder.container(keyedBy: ResultsCodingKeys.self)
        
        // get name container
        let nameContainer = try resultsContainer.nestedContainer(keyedBy: NameCodingKeys.self, forKey: .name)
        
        title = try nameContainer.decode(String.self, forKey: .title)
        first = try nameContainer.decode(String.self, forKey: .first)
        last = try nameContainer.decode(String.self, forKey: .last)
        
        //self.name = [title, first, last].compactMap{ $0 }.joined(separator: " ")
        
        // get location container
        let locationContainer = try resultsContainer.nestedContainer(keyedBy: LocationCodingKeys.self, forKey: .location)
        let streetContainer = try locationContainer.nestedContainer(keyedBy: StreetCodingKeys.self, forKey: .street)
        number =  try streetContainer.decode(Int.self, forKey: .number)
        name = try streetContainer.decode(String.self, forKey: .name)
        city = try locationContainer.decode(String.self, forKey: .city)
        state = try locationContainer.decode(String.self, forKey: .state)
        country = try locationContainer.decode(String.self, forKey: .country)
                
        if let code = try? locationContainer.decode(String.self, forKey: .postcode) {
            postcode = code
        } else if let code = try? locationContainer.decode(Int.self, forKey: .postcode) {
            postcode = String(code)
        } else {
            postcode = nil
        }
        
        
        
        
        let pictureContainer = try resultsContainer.nestedContainer(keyedBy: PictureCodingKeys.self, forKey: .picture)
        self.imageURL = try pictureContainer.decode(String.self, forKey: .medium)
    }
}
