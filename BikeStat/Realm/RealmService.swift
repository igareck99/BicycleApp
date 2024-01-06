import Foundation
import RealmSwift

protocol RealmServiceProtocol {
    
    func getUsers() -> Results<UserData>?
    
    func filterUser(_ login: String,
                    _ password: String) -> Int
    
    func saveRideData(_ data: RideData) -> Results<RideRealmData>?
    
    func getRideData() -> [RideRealmData]
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
    
    func saveRideData(_ data: RideData) -> Results<RideRealmData>? {
        let realm = try! Realm()
        var object = RideRealmData()
        object._id = data.id
        object.distance = data.distance
        object.duration = data.duration
        object.middleSpeed = data.middleSpeed
        object.minPulse = data.minPulse
        object.middlePulse = data.middlePulse
        object.maxPulse = data.maxPulse
        object.countedDiff = data.countedDiff
        object.realDiff = data.realDiff
        object.startLongtitude = data.startLongtitued
        object.startLattitude = data.startLattitude
        object.endLongtitude = data.endLongtitude
        object.endLattitude = data.endLattitude
        try! realm.write {
            realm.add(object)
        }
        let result = realm.objects(RideRealmData.self)
        return result
    }
    
    func getRideData() -> [RideRealmData] {
        let realm = try! Realm()
        let result = realm.objects(RideRealmData.self)
        return Array(result)
    }
}
