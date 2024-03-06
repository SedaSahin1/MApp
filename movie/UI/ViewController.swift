//
//  ViewController.swift
//  movie
//
//  Created by Seda Şahin on 1.03.2024.
//

import UIKit

protocol ViewControllerProtocol: AnyObject {
    associatedtype T
    init(viewModel: T)
}

public class ViewController<U>: UIViewController, UIGestureRecognizerDelegate {
    typealias T = U
    var viewModel: T?
    var spinner = UIActivityIndicatorView(style: .large)
    var loadingView = UIView()
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadingView.backgroundColor = .white
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.isUserInteractionEnabled = true
        
        view.addSubview(loadingView)
        
        loadingView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true

        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.color = .black
        spinner.startAnimating()
        loadingView.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor).isActive = true
        
        loadingView.isHidden = true
    }
    
    func startLoading(){
        DispatchQueue.main.async {
            self.loadingView.isHidden = false
        }
    }
    
    func stopLoading(){
        DispatchQueue.main.async {
            self.loadingView.isHidden = true
        }
    }
    
    func alert(title: String, message:String?){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
