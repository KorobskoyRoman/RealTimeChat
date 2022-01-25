//
//  SetupProfileViewController.swift
//  RealTimeChat
//
//  Created by Roman Korobskoy on 25.01.2022.
//

import UIKit

class SetupProfileViewController: UIViewController {
    
    let fullImageView = AddPhotoView()
    
    let welcomeLabel = UILabel(text: "Set up profile!", font: .avenir26())
    
    let fullNameLabel = UILabel(text: "Full name")
    let aboutmeLabel = UILabel(text: "About me")
    let sexLabel = UILabel(text: "Sex")
    
    let fullNameTf = OneLineTextField(font: .avenir20())
    let aboutmeTf = OneLineTextField(font: .avenir20())
    let sexSegmentedControl = UISegmentedControl(first: "Male", second: "Female")
    
    let goToCharsButton = UIButton(title: "Go to chats!", titleColor: .white, backgroundColor: .mainBlack(), cornerRadius: 4)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setConstraints()
    }
}

// MARK: - setConstraints()

extension SetupProfileViewController {
    
    private func setConstraints() {
        
        let nameStackView = UIStackView(arrangedSubviews: [fullNameLabel, fullNameTf], axis: .vertical, spacing: 0)
        let aboutmeStackView = UIStackView(arrangedSubviews: [aboutmeLabel, aboutmeTf], axis: .vertical, spacing: 0)
        let sexStackView = UIStackView(arrangedSubviews: [sexLabel, sexSegmentedControl], axis: .vertical, spacing: 12)
        
        let stackView = UIStackView(arrangedSubviews: [nameStackView, aboutmeStackView, sexStackView], axis: .vertical, spacing: 40)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        fullImageView.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        goToCharsButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(fullImageView)
        view.addSubview(welcomeLabel)
        view.addSubview(stackView)
        view.addSubview(goToCharsButton)
        
        NSLayoutConstraint.activate([
            fullImageView.topAnchor.constraint(equalTo: welcomeLabel.topAnchor, constant: 60),
            fullImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: fullImageView.bottomAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        NSLayoutConstraint.activate([
            goToCharsButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 40),
            goToCharsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            goToCharsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            goToCharsButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}

// MARK: - SwiftUI
// Для отображения контроллера через Canvas

import SwiftUI

struct SetupProfileViewControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all).previewInterfaceOrientation(.portrait)
    }
    
    struct ContainerView: UIViewControllerRepresentable {

        let setupProfileViewController = SetupProfileViewController()
        
        func makeUIViewController(context: Context) -> SetupProfileViewController {
            return setupProfileViewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
