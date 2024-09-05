//
//  NetworkManager.swift
//  Rosental
//
//  Created by Артем Петрюк on 02.09.2024.
//

import Foundation

struct NetworkManager {
    
    // TODO: Handle errors thrown
    static func authenticate(username: String, password: String) async throws {
        guard let url = URL(string: "https://test.rozentalgroup.ru/version2/entry.php") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let credentials = "\(username):\(password)"
        guard let credentialData = credentials.data(using: .utf8) else { throw URLError(.unknown) }
        let base64EncodedCredentials = credentialData.base64EncodedString()
        request.setValue("Basic \(base64EncodedCredentials)", forHTTPHeaderField: "Authorization")
        
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var body = Data()
        let parameters = [
            ("service[0][name]", "login"),
            ("service[0][attributes][login]", username),
            ("service[0][attributes][password]", password),
            ("service[1][name]", "customer_navbar")
        ]
        
        for (key, value) in parameters {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(value)\r\n".data(using: .utf8)!)
        }
        
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        request.httpBody = body
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
    }
    
    static func loadApiResponse() async throws -> ApiResponse {
        guard let url = URL(string: "https://test.rozentalgroup.ru/version2/entry.php") else { throw URLError(.badURL) }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var body = Data()
        let parameters = [
            ("service[0][name]", "customer_dashboard"),
            ("service[1][name]", "my_profile"),
            ("service[2][name]", "my_new_notifications"),
            ("service[2][attributes][mode]", "private")
        ]
        
        for (key, value) in parameters {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(value)\r\n".data(using: .utf8)!)
        }
        
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        request.httpBody = body
        let (data, response) = try await URLSession.shared.data(for: request)
        

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let apiresponse = try decoder.decode(ApiResponse.self, from: data)
        
        return apiresponse
    }
}
