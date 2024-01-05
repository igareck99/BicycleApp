import Foundation

// MARK: - RequestService

final class RequestService {
    
    static let shared = RequestService()

    func getRequest(_ url: String) async -> [String: Any]? {
        if let url = URL(string: url) {
            do {
                let json: [String: Any] = ["x-access-tokens":"az4fvf7nzi1XPIsYiMEu"]
                var request = URLRequest(url: url)
                request.setValue("az4fvf7nzi1XPIsYiMEu", forHTTPHeaderField: "x-access-tokens")
                request.httpMethod = "GET"
                let(data, response) = try await URLSession.shared.data(for: request)
                let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                print("dlalsals  \(result)")
                return result
            } catch {
                print("GET Request Failed:", error)
            }
        }
        return [:]
    }
}
