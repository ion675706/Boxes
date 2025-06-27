
import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .systemRed
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()

        view.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
//        let onboardingScreen = ContentView()
//        let hostingController = UIHostingController(rootView: onboardingScreen)
//        
//        addChild(hostingController)
//        view.addSubview(hostingController.view)
//        hostingController.didMove(toParent: self)
//        
//        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
//            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//        ])
    }
    
    func openApp() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            print("open app")
            let onboardingScreen = ContentView()
            let hostingController = UIHostingController(rootView: onboardingScreen)
            self.setRootViewController(hostingController)
        }
    }
    
    func openWeb(stringURL: String) {
        DispatchQueue.main.async {
            print("open web")
            let webView = SecViewController(url: stringURL)
            self.setRootViewController(webView)
        }
    }
    
    func setRootViewController(_ viewController: UIViewController) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.window?.rootViewController = viewController
        }
    }
    
    func createURL(mainURL: String, deviceID: String, advertiseID: String) -> (String) {
        var url = ""
        
        url = "\(mainURL)?sdsd=\(deviceID)&gght=\(advertiseID)"
        
        return url
    }
}

