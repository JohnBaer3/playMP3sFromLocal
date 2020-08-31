//
//  ViewController.swift
//  LinkToMp3s
//
//  Created by John Baer on 8/29/20.
//  Copyright © 2020 John Baer. All rights reserved.
//

import UIKit
import CoreServices

import AVKit

class ViewController: UIViewController {
    let engine = AVAudioEngine()
    let speedControl = AVAudioUnitVarispeed()
    let pitchControl = AVAudioUnitTimePitch()
    
    var songURL: [URL]? = []
    var count = 0
    
    @IBAction func writeFileClick(_ sender: Any) {
        do{
            try play(songURL![count])
            count+=1
        }
        catch{
            print(error)
            count+=1
            //play next song
        }
    }
    
    func play(_ url: URL) throws {
        // 1: load the file
        let file = try AVAudioFile(forReading: url)

        // 2: create the audio player
        let audioPlayer = AVAudioPlayerNode()

        // 3: connect the components to our playback engine
        engine.attach(audioPlayer)
        engine.attach(pitchControl)
        engine.attach(speedControl)
        
        // 4: arrange the parts so that output from one is input to another
        engine.connect(audioPlayer, to: speedControl, format: nil)
        engine.connect(speedControl, to: pitchControl, format: nil)
        engine.connect(pitchControl, to: engine.mainMixerNode, format: nil)

        // 5: prepare the player to play its file from the beginning
        audioPlayer.scheduleFile(file, at: nil)
        
        // 6: start the engine and player
        try engine.start()
        audioPlayer.play()
    }
    
    
    @IBAction func importFileClick(_ sender: Any) {
         let documentPicker = UIDocumentPickerViewController(documentTypes: [String(kUTTypeMP3)], in: .import)
         documentPicker.delegate = self
         if #available(iOS 11.0, *) {
            documentPicker.allowsMultipleSelection = true
         }
         self.present(documentPicker, animated: false) {
        
         }
        
    }
}


extension ViewController: UIDocumentPickerDelegate{
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        let selectedFileURL = urls
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        songURL!.append(urls[0])
    }
}
