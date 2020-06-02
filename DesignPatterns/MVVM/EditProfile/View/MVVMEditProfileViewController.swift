//
//  MVVMEditProfileViewController.swift
//  DesignPatterns
//
//  Created by d.kuznetsov4 on 02.06.2020.
//  Copyright © 2020 Daniel. All rights reserved.
//

import Foundation
import UIKit

protocol MVVMEditProfileView: AnyObject {
    var userName: ((String) -> Void)? { get set }
    var didTapMainButton: (() -> Void)? { get set }
    var didTapCloseButton: (() -> Void)? { get set }
}

final class MVVMEditProfileViewController: UIViewController, MVVMEditProfileView {
    var viewModel: MVVMEditProfileViewModel!
    
    var userName: ((String) -> Void)?
    var didTapMainButton: (() -> Void)?
    var didTapCloseButton: (() -> Void)?
    
    @IBOutlet private var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameTextField.addTarget(self, action: #selector(textFieldDidChangeText), for: .editingChanged)
    }
    
    @IBAction func didTapMainButton(_ sender: Any) {
        self.didTapMainButton?()
    }
    @IBAction func didTapCloseButton(_ sender: UIBarButtonItem) {
        self.didTapCloseButton?()
    }
    
    @objc func textFieldDidChangeText() {
        self.userName?(nameTextField.text ?? "")
    }
}
