//
//  DetailContentViewController.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/08.
//

import UIKit

class DetailContentViewController: UIViewController {
    
    lazy var profileView = ProfileView(width: 42, height: 42, fontsize: 15)
    
    lazy var titleLabel: UILabel = UILabel()
    lazy var contentTextView: UITextView = UITextView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        setProfileVeiw()
        setTitleLabel()
        setContentTextView()
    }
    
    func setProfileVeiw() {
        view.addSubview(profileView)
        
        profileView.translatesAutoresizingMaskIntoConstraints = false
        profileView.topAnchor.constraint(equalTo: view.topAnchor, constant: 113)
        .isActive = true
        profileView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
    }
    
    func setTitleLabel() {
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.text = "언젠가는"
        view.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.topAnchor.constraint(equalTo: profileView.bottomAnchor, constant: 28).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        
    }
    
    func setContentTextView() {
        contentTextView.textColor = .white
        contentTextView.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        contentTextView.text = StringType.dummyContents
        contentTextView.backgroundColor = .black
        view.addSubview(contentTextView)
        
        contentTextView.translatesAutoresizingMaskIntoConstraints = false
        contentTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 21).isActive = true
        contentTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        contentTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
        contentTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
       
    }
    
}
