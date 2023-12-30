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
                print("slasl  \(data)  \(response)")
            } catch {
                print("GET Request Failed:", error)
            }
        }
        return [:]
    }
}
