import Combine
import Foundation

// MARK: - LoginViewModel

final class LoginViewModel: ObservableObject {
    
    @Published var login = ""
    @Published var password = ""
    @Published var isError = false
    
    var coordinator: MainCoordinatorProtocol?
    let userDefaults: UserDefaults
    let realmService: RealmServiceProtocol
    var rightlogin = "UserLogin"
    var rightpassword = "UserPassword"

    private var subscriptions = Set<AnyCancellable>()
    
    init(userDefaults: UserDefaults = UserDefaults.standard,
         realmService: RealmServiceProtocol = RealmService.shared) {
        self.userDefaults = userDefaults
        self.realmService = realmService
        self.initData()
    }
    
    // MARK: - Private Methods
    
    private func initData() {
        print("initData")
        UserDefaults.standard.set(false, forKey: "isAuth")
    }
    
    // MARK: - Internal Methods
    
    func checkPassword() {
        let user = realmService.filterUser(login, password)
        if user == 1 {
            self.isError = false
            UserDefaults.standard.set(true, forKey: "isAuth")
            UserDefaults.standard.synchronize() 
            coordinator?.onMainTabScreen()
        } else {
            self.isError = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.isError = false
            }
        }
    }
}
