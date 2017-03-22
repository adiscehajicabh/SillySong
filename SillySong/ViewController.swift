//
//  ViewController.swift
//  SillySong
//
//  Created by Adis Cehajic on 22/03/2017.
//  Copyright © 2017 Adis Cehajic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Declare an array of strings and join them into a single SillySong string.
    let bananaFanaTemplate = [
        "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
        "Banana Fana Fo F<SHORT_NAME>",
        "Me My Mo M<SHORT_NAME>",
        "<FULL_NAME>"].joined(separator: "\n")
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set UITextField delegate.
        nameField.delegate = self
        
        // Change keyboard key from Return to Done
        nameField.returnKeyType = .done
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Method which is called when editing begins on the nameField. It cleares text in nameField and lyricsView.
    @IBAction func reset(_ sender: Any) {
        nameField.text = String()
        lyricsView.text = String()
    }
    
    // Method which is called when editing ends on the nameField, and afther that it generates SillySong lyrics based on the inputed name.
    @IBAction func displayLyrics(_ sender: Any) {
        lyricsView.text = nameField.text != String() ? lyricsForName(lyricsTemplate: bananaFanaTemplate, fullName: nameField.text!) : ""
    }
    
    // Method which returns the inputed name all in lowercase and with any consonants before the first vowel removed.
    func shortNameFromName(name: String) -> String {
        
        let vowels = CharacterSet(charactersIn: "aeiouöäü")
        let inputedName = name.lowercased();
        
        if let range = inputedName.rangeOfCharacter(from: vowels, options: [], range: inputedName.startIndex..<inputedName.endIndex) {
            return inputedName.substring(from: range.lowerBound)
        }
        return String()
    }
    
    // Method that generates SillySong lyrics based on the inputed name.
    func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
        let shortName = shortNameFromName(name: fullName)
        
        let lyricsTemplate = lyricsTemplate.replacingOccurrences(of: "<FULL_NAME>", with: fullName).replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
        
        return lyricsTemplate
    }

}

extension ViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

