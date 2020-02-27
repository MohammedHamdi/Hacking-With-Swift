//
//  ViewController.swift
//  Project2
//
//  Created by Mohammed Hamdi on 8/24/19.
//  Copyright © 2019 Mohammed Hamdi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var correctAnswer = 0
    var score = 0
    var questionsAsked = 0
    var highScore = 0
    var hasShownMessage = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        let defaults = UserDefaults.standard
        highScore = defaults.object(forKey: "highScore") as? Int ?? 0
        
       /*if let savedHighScore = defaults.object(forKey: "highScore") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                highScore = try Int(jsonDecoder.decode(Int.self, from: savedHighScore))
                print(highScore)
            } catch {
                print("Couldn't load the high score.")
            }
        }*/
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }

    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        correctAnswer = Int.random(in: 0...2)
        title = "\(countries[correctAnswer].uppercased()), Score:\(score)"
        questionsAsked += 1
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        var message: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            message = "Your score is \(score)."
            score += 1
            if score > highScore {
                setHighScore()
            }
        } else {
            title = "Wrong"
            message = "Wrong! That’s the flag of \(countries[sender.tag].uppercased())"
            score -= 1
        }
        
        if questionsAsked < 10 {
            let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Finished!", message: "Your final score is \(score)!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(ac, animated: true)
        }
    }
    
    @objc func shareTapped() {
        let vc = UIActivityViewController(activityItems: ["My score is \(score)!"], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    func setHighScore() {
        highScore = score
        save()
        
        if !hasShownMessage {
            hasShownMessage = true
            let ac = UIAlertController(title: "Congratulations", message: "You broke your old high score!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    func save() {
        let defaults = UserDefaults.standard
        defaults.set(highScore, forKey: "highScore")
        /*
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode("\(highScore)") {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "highScore")
        } else {
            print("Couldn't save the high score.")
        }*/
    }
}

