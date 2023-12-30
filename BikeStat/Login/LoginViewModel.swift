import Combine
import Foundation

// MARK: - LoginViewModel

final class LoginViewModel: ObservableObject {
    
    @Published var login = ""
    @Published var password = ""
    @Published var isError = false
    
    var coordinator: MainCoordinatorProtocol?
    let userDefaults: UserDefaults
    var rightlogin = "UserLogin"
    var rightpassword = "UserPassword"

    private var subscriptions = Set<AnyCancellable>()
    
    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
        self.initData()
    }
    
    // MARK: - Private Methods
    
    private func initData() {
        UserDefaults.standard.set(false, forKey: "isAuth")
    }
    
    // MARK: - Internal Methods
    
    func checkPassword() {
        if login == rightlogin && password == rightpassword {
            self.isError = false
            UserDefaults.standard.set(true, forKey: "isAuth")
            coordinator?.onMainTabScreen()
        } else {
            self.isError = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.isError = false
            }
        }
    }
}
