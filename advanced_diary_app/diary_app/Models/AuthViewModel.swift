//
//  AuthViewModel.swift
//  diary_app
//
//  Created by Quentin Banet on 10/03/2025.
//

import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import SwiftUICore

class AuthViewModel: ObservableObject {
    @EnvironmentObject var diary: Diary
    @Published var user: User?
    @Published var isLoggedIn: Bool = false
    @Published var authError: String?

    init() {
        self.user = Auth.auth().currentUser
        self.isLoggedIn = (self.user != nil)
    }

    
    func signInTestUser() {
        Auth.auth().signIn(withEmail: "teeeeeeeeeeeeest@example.com", password: "password123") { authResult, error in
            if let error = error {
                print("❌ Erreur de connexion : \(error.localizedDescription)")
            } else {
                print("✅ Connexion réussie ! Utilisateur : \(authResult?.user.displayName ?? "Inconnu")")
                DispatchQueue.main.async {
                    self.user = authResult?.user
                    self.isLoggedIn = true
                }
            }
        }
    }
    
    func updateProfilePicture(url: String) {
        guard let currentUser = Auth.auth().currentUser else { return }

        let changeRequest = currentUser.createProfileChangeRequest()
        changeRequest.photoURL = URL(string: url)
        
        changeRequest.commitChanges { error in
            if let error = error {
                print("❌ Erreur lors de la mise à jour de la PP : \(error.localizedDescription)")
            } else {
                print("✅ PP mise à jour avec succès !")
                DispatchQueue.main.async {
                    self.user = Auth.auth().currentUser
                }
            }
        }
    }
    
    private func handleSignIn(authResult: AuthDataResult?, error: Error?) {
        DispatchQueue.main.async {
            if let error = error {
                self.authError = error.localizedDescription
                return
            }
            guard
                let user = authResult?.user
            else {
                self.authError = "Impossible de récupérer l'utilisateur après connexion."
                return
            }
            self.user = user
            self.isLoggedIn = true
        }
    }

    func signInWithGoogle(presentingViewController: UIViewController) {
        guard
            let clientID = FirebaseApp.app()?.options.clientID
        else {
            return
        }

        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { result, error in
            if let error = error {
                self.handleSignIn(authResult: nil, error: error)
                return
            }

            guard
                let user = result?.user,
                let idToken = user.idToken?.tokenString
            else {
                self.handleSignIn(authResult: nil, error: NSError(domain: "GoogleAuth", code: 0, userInfo: [NSLocalizedDescriptionKey: "Impossible de récupérer les informations de l'utilisateur Google."]))
                return
            }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)

            Auth.auth().signIn(with: credential) { authResult, error in
                self.handleSignIn(authResult: authResult, error: error)
            }
        }
    }

    func signInWithGitHub() async {
        let provider = OAuthProvider(providerID: "github.com")
        do {
            let credential: AuthCredential = try await withCheckedThrowingContinuation { continuation in
                provider.getCredentialWith(nil) { credential, error in
                    if let error = error {
                        continuation.resume(throwing: error)
                        return
                    }
                    guard let credential = credential else {
                        let error = NSError(domain: "Auth", code: -1, userInfo: [NSLocalizedDescriptionKey: "Aucune credential GitHub récupérée."])
                        continuation.resume(throwing: error)
                        return
                    }
                    continuation.resume(returning: credential)
                }
            }

            let authResult = try await Auth.auth().signIn(with: credential)
            await MainActor.run {
                self.user = authResult.user
                self.isLoggedIn = true
            }
        } catch {
            await MainActor.run {
                self.authError = error.localizedDescription
            }
        }
    }
    
    func signUp(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.authError = error.localizedDescription
                    completion(.failure(error))
                } else if let user = result?.user {
                    self.user = user
                    self.isLoggedIn = true
                    completion(.success(user))
                }
            }
        }
    }

    func signIn(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.authError = error.localizedDescription
                    completion(.failure(error))
                } else if let user = result?.user {
                    self.user = user
                    self.isLoggedIn = true
                    completion(.success(user))
                }
            }
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            GIDSignIn.sharedInstance.signOut()
            self.user = nil
            self.isLoggedIn = false
            print("✅ Déconnexion réussie. Utilisateur : \(String(describing: Auth.auth().currentUser))")
        } catch let error {
            self.authError = error.localizedDescription
            print("❌ Erreur lors de la déconnexion : \(error.localizedDescription)")
        }
    }
}
