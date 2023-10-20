//
//  StoreViewModel.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 07/10/23.
//

//import SwiftUI
//import Combine
//import CoreGraphics
//
//
////@MainActor
//class AuthViewModel: ObservableObject {
//    @Published var isAuthenticated: Bool = false
//    @Published var errorMessage: String = ""
//    @Published private var showError: Bool = false
//
//        func signIn(email: String, password: String) async throws {
//            let signInRequest = SignInRequestModel(login_cred: email, password: password)
//
//            guard let url = URL(string: ApiEndpoints.signInUrl) else {
//                self.errorMessage = "Invalid URL"
//                return
//            }
//
//            var request = URLRequest(url: url)
//            request.httpMethod = "POST"
//            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//            do {
//                request.httpBody = try JSONEncoder().encode(signInRequest)
//            } catch {
//                self.errorMessage = "Error encoding request ⚠️"
//                return
//            }
//
//            URLSession.shared.dataTask(with: request) { data, response, error in
//                if let error = error {
//                    self.errorMessage = error.localizedDescription
//                    return
//                }
//
//                guard let data = data else {
//                    DispatchQueue.main.async {
//                        self.errorMessage = "No Data found ⚠️"
//                    }
//                    return
//                }
//
//                do {
//                    let responseModel = try JSONDecoder().decode(SignUpResponseModel.self, from: data)
//                    // Handle the response as needed
//                    DispatchQueue.main.async {
//                        self.isAuthenticated = true
//                        print("Authentication completed🚀🚀🚀")
//                    }
//                } catch {
//                    DispatchQueue.main.async {
//                        self.errorMessage = "Error decoding response ⚠️"
//                    }
//                }
//            }.resume()
//        }
    /*
//    @Published var isAuthenticated: Bool = false
//    @Published var errorMessage: String = ""
//    @Published private var shwoError: Bool = false
    
    
//    func signIn(email: String, password: String) async throws { /// user check
//        let signInRequest = SignInRequestModel(login_cred: email, password: password)
//        print("\(password)✅")
//        
//        guard let url = URL(string: ApiEndpoints.signInUrl) else { 
//            self.errorMessage = "Invalid URL"
//        return
//        }
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        do {
//            request.httpBody = try JSONEncoder().encode(signInRequest)
//            print("\(signInRequest)✅")
//        } catch {
//            self.errorMessage = "Error endconding request ⚠️"
//            return
//        }
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                self.errorMessage = error.localizedDescription
//                return
//            }
//            
//            guard let data = data else {
//                self.errorMessage = "No Data founded ⚠️"
//                return
//            }
//            
//            do {
//                let responseModel = try JSONDecoder().decode(SignUpResponseModel.self, from: data)
//                // Handle the response as needed
//                DispatchQueue.main.async {
//                    self.isAuthenticated = true
//                    print("The Authentication was completed🚀🚀🚀")
//                }
//            } catch {
//                self.errorMessage = "Error decoding response ⚠️"
//            }
//        }.resume()
//    }
    
//    func signUp(signUpData: SignUpDataModel) async throws { /// Creating
//        func signUp(signUpDataModel: SignUpDataModel) {
//            let url = URL(string: ApiEndpoints.signUpUrl)!
//            
//            var request = URLRequest(url: url)
//            request.httpMethod = "POST"
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//            
//            do {
//                let jsonData = try JSONEncoder().encode(signUpDataModel)
//                request.httpBody = jsonData
//            } catch {
//                self.errorMessage = "Error endconding request ⚠️"
//                return
//            }
//            
//            URLSession.shared.dataTask(with: request) { data, response, error in
//                if let error = error {
//                    print(error.localizedDescription)
//                    return
//                }
//                
//                if let httpResponse = response as? HTTPURLResponse {
//                    if httpResponse.statusCode == 201 {
//                        // Successfully signed up
//                    } else {
//                        self.errorMessage = "Error endconding request ⚠️"
//                    }
//                }
//            }.resume()
//        }
//    }
    
//    func logout() {
//        guard let url = URL(string: ApiEndpoints.logoutUrl) else { return }
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        
//        URLSession.shared.dataTask(with: request) { _, response, error in
//            if let error = error {
//                self.errorMessage = error.localizedDescription
//                return
//            }
//            
//            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
//                // Successfully logged out
//            } else {
//                self.errorMessage = "Error endconding request ⚠️"
//            }
//        }.resume()
//    }*/
//    func signUp(signUpData: SignUpDataModel) async throws {
//           let url = URL(string: ApiEndpoints.signUpUrl)!
//           var request = URLRequest(url: url)
//           request.httpMethod = "POST"
//           request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//           do {
//               let jsonData = try JSONEncoder().encode(signUpData)
//               request.httpBody = jsonData
//           } catch {
//               self.errorMessage = "Error encoding request ⚠️"
//               return
//           }
//
//           URLSession.shared.dataTask(with: request) { data, response, error in
//               if let error = error {
//                   self.errorMessage = error.localizedDescription
//                   return
//               }
//
//               if let httpResponse = response as? HTTPURLResponse {
//                   if httpResponse.statusCode == 201 {
//                       // Successfully signed up
//                       DispatchQueue.main.async {
//                           self.isAuthenticated = true
//                           print("Sign up completed🚀🚀🚀")
//                       }
//                   } else {
//                       self.errorMessage = "Error signing up ⚠️"
//                   }
//               }
//           }.resume()
//       }
//
//       func logout() {
//           guard let url = URL(string: ApiEndpoints.logoutUrl) else { return }
//
//           var request = URLRequest(url: url)
//           request.httpMethod = "GET"
//
//           URLSession.shared.dataTask(with: request) { _, response, error in
//               if let error = error {
//                   self.errorMessage = error.localizedDescription
//                   return
//               }
//
//               if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
//                   // Successfully logged out
//                   DispatchQueue.main.async {
//                       self.isAuthenticated = false
//                       print("Logged out🚀🚀🚀")
//                   }
//               } else {
//                   self.errorMessage = "Error logging out ⚠️"
//               }
//           }.resume()
//       }
//}
//
//enum ApiEndpoints {
//    static let signInUrl = "http://\(APIKey)/api/accounts/signin"
//    static let signUpUrl = "http://\(APIKey)/api/accounts/signup"
//    static let logoutUrl = "http://\(APIKey)/logout"
//}
