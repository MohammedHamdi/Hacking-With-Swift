//
//  ViewController.swift
//  Project10
//
//  Created by Mohammed Hamdi on 8/28/19.
//  Copyright © 2019 Mohammed Hamdi. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var people = [Person]()
    var peopleSecure = [Person]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(saveApp), name: UIApplication.willResignActiveNotification, object: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Authenticate", style: .done, target: self, action: #selector(authenticateTapped))
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else {
            fatalError("Unable to dequeue PersonCell.")
        }
        
        let person = people[indexPath.item]
        
        cell.name.text = person.name
        
        let path = getDocumentsDirectory().appendingPathComponent(person.image)
        cell.imageView.image = UIImage(contentsOfFile: path.path)
        
        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let person = people[indexPath.item]
        
        let ac = UIAlertController(title: "Rename or Delete?", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Delete", style: .destructive) {
            [weak self] _ in
            self?.people.remove(at: indexPath.item)
            self?.collectionView.reloadData()
            })
        
        ac.addAction(UIAlertAction(title: "Rename", style: .default) {
            [weak self] _ in
            self?.rename(person: person)
        })
        
        present(ac, animated: true)
    }
    
    func rename(person: Person) {
        let ac = UIAlertController(title: "Rename person", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        ac.addAction(UIAlertAction(title: "OK", style: .default) {
            [weak self, weak ac] _ in
            guard let newName = ac?.textFields?[0].text else { return }
            person.name = newName
            
            self?.collectionView.reloadData()
        })
        
        present(ac, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        let person = Person(name: "Unkown", image: imageName)
        people.append(person)
        peopleSecure.append(person)
        collectionView.reloadData()
        
        dismiss(animated: true)
    }

    @objc func addNewPerson() {
        let picker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        }
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    @objc func authenticateTapped() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [weak self] success, authenticationError in
                
                DispatchQueue.main.async {
                    if success {
                        self?.unlockApp()
                    } else {
                        let ac = UIAlertController(title: "Authentication failed", message: "You could not be verified; please try again.", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        self?.present(ac, animated:true)
                    }
                }
            }
        } else {
            if KeychainWrapper.standard.string(forKey: "Password") != nil {
                let ac = UIAlertController(title: "Password", message: "Please enter your password.", preferredStyle: .alert)
                ac.addTextField()
                ac.addAction(UIAlertAction(title: "Login", style: .default) {
                    [weak self, weak ac] _ in
                    guard let password = ac?.textFields?[0].text else {return}
                    if password == KeychainWrapper.standard.string(forKey: "Password") {
                        self?.unlockApp()
                    }
                })
                present(ac, animated: true)
            } else {
                let ac = UIAlertController(title: "Set password", message: "Set a password to protect your secret.", preferredStyle: .alert)
                ac.addTextField()
                ac.addAction(UIAlertAction(title: "Set", style: .default){
                    [weak ac] _ in
                    guard let password = ac?.textFields?[0].text else {return}
                    KeychainWrapper.standard.set(password, forKey: "Password")
                })
                present(ac, animated: true)
            }
        }
    }
    
    func unlockApp() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Signout", style: .done, target: self, action: #selector(saveApp))
        people = peopleSecure
        collectionView.reloadData()
    }
    
    @objc func saveApp() {
        navigationItem.leftBarButtonItem = nil
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Authenticate", style: .done, target: self, action: #selector(authenticateTapped))
        
        people = [Person]()
        collectionView.reloadData()
    }
}

