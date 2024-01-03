//
//  RazorpayView.swift
//  FashionStore
//
//  Created by MUNAVAR PM on 25/12/23.
//
/*
//import Razorpay
//import SwiftUI
//import UIKit
//
////View that conforms to UIViewControllerRepresentable
//struct RazorPayView: UIViewControllerRepresentable {
//    @EnvironmentObject var cartVm: ProductManagerViewModel
//     let totalPrie: Int
//     let name: String
//    typealias UIViewControllerType = ViewController
//    
//    func makeUIViewController(context: Context) -> ViewController {
//        let vc = ViewController(amount: cartVm.cartTotal, name: name)
//        return vc
//    }
//    
//    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
//        
//    }
//}
//
//
//class ViewController: UIViewController, RazorpayPaymentCompletionProtocol {
//    
//    var amount: Int
//    var name: String
//    
//    init(amount: Int, name: String) {
//        self.amount = amount
//        self.name = name
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func onPaymentSuccess(_ payment_id: String) {
//        let alert = UIAlertController(title: "Paid", message: "Payment Success", preferredStyle: .alert)
//        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//        alert.addAction(action)
//        self.present(alert, animated: true, completion: nil)
//    }
//
//    func onPaymentError(_ code: Int32, description str: String) {
//        let alert = UIAlertController(title: "Error", message: "\(code)\n\(str)", preferredStyle: .alert)
//        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//        alert.addAction(action)
//        self.present(alert, animated: true, completion: nil)
//    }
//
//    var razorpay: RazorpayCheckout!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        razorpay = RazorpayCheckout.initWithKey("rzp_test_as8Qsyvi6jv8By", andDelegate: self)
//    }
//    override func viewWillAppear(_ animated: Bool) {
//    super.viewWillAppear(animated)
//            self.showPaymentForm()
//    }
//    internal func showPaymentForm(){
////        let options: [String:Any] = [
////                    "amount": "1000", //This is in currency subunits. 100 = 100 paise= INR 1.
////                    "currency": "INR",//We support more that 92 international currencies.
////                    "description": "purchase description",
////                    "order_id": "order_DBJOWzybf0sJbb",
////                    "image": "https://url-to-image.jpg",
////                    "name": "business or product name",
////                    "prefill": [
////                        "contact": "9797979797",
////                        "email": "foo@bar.com"
////                    ],
////                    "theme": [
////                        "color": "#F37254"
////                    ]
////        ]
//        let options: [String:Any] = [
//                    "amount": "\(100 * amount)", //This is in currency subunits. 100 = 100 paise= INR 1.
//                    "currency": "INR",//We support more that 92 international currencies.
//                    "name": "\(name)",
//        ]
//        razorpay.open(options)
//    }
//}
//------------------------------------------------------------------------------------------------------------------------------------
//import Razorpay
//import SwiftUI
//import UIKit
//
//////View that conforms to UIViewControllerRepresentable
//struct RazorPayView: UIViewControllerRepresentable {
//    @State var totalPrie: Int
//    typealias UIViewControllerType = ViewController
//    
//    func makeUIViewController(context: Context) -> ViewController {
//        let vc = ViewController(amount: totalPrie, name: "cartVmcartProducts")
//        return vc
//    }
//    
//    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
//        
//    }
//}
////
////
//////UIViewController
////class ViewController: UIViewController, RazorpayPaymentCompletionProtocol {
//////    @EnvironmentObject var cartVm:CartViewModel
////    var razorpay: RazorpayCheckout!
////    override func viewDidLoad(){
////        super.viewDidLoad()
////        razorpay = RazorpayCheckout.initWithKey("rzp_test_9W7zQFNgaqRf8X", andDelegate: self)
////    }
////
////    override func viewWillAppear(_ animated: Bool) {
////        super.viewWillAppear(animated)
////        self.showPaymentForm()
////        print("view appeared ...fkdsflsdf")
////    }
////
////
////    //working code
////
//////    func showPaymentForm() {
//////        let options: [String:Any] = [
//////            "amount": "1000", //This is in currency subunits. 100 = 100 paise= INR 1.
//////            "currency": "INR",//We support more that 92 international currencies.
//////            "description": "purchase description",
//////            //"order_id": "order_DBJOWzybf0sJbb",
////////            "image": "https://url-to-image.jpg",
//////            "name": "business or product name",
//////            "profile": [
//////                "contact": "9797979797",
//////                "email": "foo@bar.com"
//////            ],
//////            "theme": [
//////                "color": "#F37254"
//////            ],
//////            "key": "rzp_test_PROiD30HBjQzGT"
//////        ]
//////        print(options)
//////        razorpay.open(options)
//////    }
////
////
////
////    func showPaymentForm() {
////        let options: [String:Any] = [
////            "amount": "\(100 * 100)", //This is in currency subunits. 100 = 100 paise= INR 1.
////            "currency": "INR",//We support more that 92 international currencies.
////            "description": " one and only app you need",
////            "name": "Juicifer Products",
////            "profile": [
////                "contact": "9797979797",
////                "email": "foo@bar.com"
////            ],
////            "theme": [
////                "color": "#F37254"
////            ],
////            "key": "rzp_test_PROiD30HBjQzGT"
////        ]
////        print(options)
////        razorpay.open(options)
////    }
////
////
////    func onPaymentError(_ code: Int32, description str: String) {
////        print("error: ", code, str)
////        self.presentAlert(withTitle: "Alert", message: str)
////    }
////
////    func onPaymentSuccess(_ payment_id: String) {
////        print("success: ", payment_id)
////        self.presentAlert(withTitle: "Success", message: "Payment Succeeded")
////    }
////
////    func presentAlert(withTitle title: String, message: String) {
////        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
////        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
////        alertController.addAction(okAction)
////        self.present(alertController, animated: true, completion: nil)
////    }
////
////}
////
//
//
//class ViewController: UIViewController, RazorpayPaymentCompletionProtocol {
//    
//    var amount: Int
//    var name: String
//    
//    init(amount: Int, name: String) {
//        self.amount = amount
//        self.name = name
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func onPaymentSuccess(_ payment_id: String) {
//        let alert = UIAlertController(title: "Paid", message: "Payment Success", preferredStyle: .alert)
//        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//        alert.addAction(action)
//        self.present(alert, animated: true, completion: nil)
//    }
//
//    func onPaymentError(_ code: Int32, description str: String) {
//        let alert = UIAlertController(title: "Error", message: "\(code)\n\(str)", preferredStyle: .alert)
//        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//        alert.addAction(action)
//        self.present(alert, animated: true, completion: nil)
//    }
////    func onPaymentError(_ code: Int32, description str: String) {
////
////    }
//    
////    func onPaymentSuccess(_ payment_id: String) {
////
////    }
//
//
//// typealias Razorpay = RazorpayCheckout
//
//    var razorpay: RazorpayCheckout!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        razorpay = RazorpayCheckout.initWithKey("rzp_test_9W7zQFNgaqRf8X", andDelegate: self)
//    }
//    override func viewWillAppear(_ animated: Bool) {
//    super.viewWillAppear(animated)
//            self.showPaymentForm()
//    }
//    internal func showPaymentForm(){
////        let options: [String:Any] = [
////                    "amount": "1000", //This is in currency subunits. 100 = 100 paise= INR 1.
////                    "currency": "INR",//We support more that 92 international currencies.
////                    "description": "purchase description",
////                    "order_id": "order_DBJOWzybf0sJbb",
////                    "image": "https://url-to-image.jpg",
////                    "name": "business or product name",
////                    "prefill": [
////                        "contact": "9797979797",
////                        "email": "foo@bar.com"
////                    ],
////                    "theme": [
////                        "color": "#F37254"
////                    ]
////        ]
//        let options: [String:Any] = [
//                    "amount": "\(100 * amount)", //This is in currency subunits. 100 = 100 paise= INR 1.
//                    "currency": "INR",//We support more that 92 international currencies.
//                    "image": "https://url-to-image.jpg",
//                    "name": name,
//        ]
//        razorpay.open(options)
//    }
//}
////extension ViewController: RazorpayPaymentCompletionProtocol {
////            func onPaymentSuccess(_ payment_id: String) {
////                let alert = UIAlertController(title: "Paid", message: "Payment Success", preferredStyle: .alert)
////                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
////                alert.addAction(action)
////                self.present(alert, animated: true, completion: nil)
////            }
////
////            func onPaymentError(_ code: Int32, description str: String) {
////                let alert = UIAlertController(title: "Error", message: "\(code)\n\(str)", preferredStyle: .alert)
////                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
////                alert.addAction(action)
////                self.present(alert, animated: true, completion: nil)
////            }
////    }
*/

import Razorpay
import UIKit
import Foundation
import SwiftUI

struct RazorPayView:UIViewControllerRepresentable {
    
    
    
    @StateObject var productManagerViewModel: ProductManagerViewModel
    @State var totalPrice:Int
    typealias UIViewControllerType = ViewController
    
    
    func makeUIViewController(context: Context) -> ViewController {
        let vc = ViewController()
        vc.totalPrice = totalPrice
        vc.view.backgroundColor = .white
        vc.productManagerViewModel = productManagerViewModel
        return vc
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {}
}

class ViewController: UIViewController, RazorpayPaymentCompletionProtocol {
    @AppStorage ("TabSelection1") var TabSelection = -1
    var razorpay: RazorpayCheckout!
    var totalPrice: Int = 0
    var gotoHome = false
    var productManagerViewModel: ProductManagerViewModel!
    override func viewDidLoad(){
        super.viewDidLoad()
        razorpay = RazorpayCheckout.initWithKey("rzp_test_as8Qsyvi6jv8By", andDelegate: self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showPaymentForm()
        print("view appeared ...fkdsflsdf")
    }
    
    
    func showPaymentForm() {
        let options: [String:Any] = [
            "amount": "\(totalPrice * 100)", //This is in currency subunits. 100 = 100 paise= INR 1.
            "currency": "INR",//We support more that 92 international currencies.
            "description": " one and only app you need",
            "name": "FashionStore Products",
            "profile": [
                "contact": "9797979797",
                "email": "foo@bar.com"
            ],
            "theme": [
                "color": "#000000"
            ],
            "key": "rzp_test_as8Qsyvi6jv8By"
        ]
        print(options)
        razorpay.open(options)
    }
    

    func onPaymentError(_ code: Int32, description str: String) {
        print("error: ", code, str)
        self.presentAlert(withTitle: "Alert", message: str)
    }

    func onPaymentSuccess(_ payment_id: String) {
        print("success: ", payment_id)
        self.presentAlert(withTitle: "Success", message: "Payment Succeeded")
        productManagerViewModel.removeAllFromCart()
    }

    func presentAlert(withTitle title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {_ in 
            print("Ok action tapped")
            self.TabSelection = 0
            self.navigationController?.popToRootViewController(animated: true)
        })
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
