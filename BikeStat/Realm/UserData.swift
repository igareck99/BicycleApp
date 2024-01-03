import Foundation
import RealmSwift

class UserData: Object {

    @Persisted(primaryKey: true) var _id: String
    @Persisted var name: String
    @Persisted var login: String
    @Persisted var password: String
}
