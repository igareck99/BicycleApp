import Foundation
import RealmSwift

protocol RealmServiceProtocol {
    
    func getUsers() -> Results<UserData>?
    
    func filterUser(_ login: String,
                    _ password: String) -> Int
}

class RealmService: RealmServiceProtocol {
    
    static let shared = RealmService()
    
    func filterUser(_ login: String,
                    _ password: String) -> Int {
        let realm = try! Realm()
        var users = realm.objects(UserData.self)
        users = users.filter("login = '\(login)' AND password = '\(password)'")
        return users.count
    }
    
    func getUsers() -> Results<UserData>? {
        let realm = try! Realm()
        var users = realm.objects(UserData.self)
        if users.count == 0 {
            let user = UserData()
            user._id = UUID().uuidString
            user.login = "login"
            user.password = "password"
            user.name = "name"
            try! realm.write {
                realm.add(user)
            }
        } else {
            return users
        }
        users = realm.objects(UserData.self)
        return users
    }
    
    func saveRideData() {
        
    }
}
