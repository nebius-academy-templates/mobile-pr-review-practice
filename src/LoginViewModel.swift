import SwiftUI

@MainActor
final class LoginViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let authRepository: AuthRepository

    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }

    func logIn(email: String, password: String) async {
        isLoading = true
        defer { isLoading = false }
        do {
            try await authRepository.signIn(email: email, password: password)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}