//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//

import UIKit
import AVFoundation
import Foundation

class PlaySoundsViewController: UIViewController {

    var audioPlayer:AVAudioPlayer!
    var recieveAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    //MARK: - Override Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()

        audioPlayer = try!AVAudioPlayer(contentsOfURL: recieveAudio.filePathUrl)
        audioPlayer.prepareToPlay()
        audioPlayer.enableRate=true
        
        audioEngine = AVAudioEngine()
        audioFile = try!AVAudioFile(forReading: recieveAudio.filePathUrl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Actions
    
    @IBAction func slowPlayBack(sender:UIButton){
        slowAndFast(0.5)
    }
    
    @IBAction func fastPlayBack(sender:UIButton){
        slowAndFast(1.5)
    }
    
    @IBAction func stopAudio(sender:UIButton){
        audioPlayer.stop()
    }
    
    @IBAction func playChipmonkAudio(sender: UIButton){
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playDarthVaderAudio(sender: UIButton){
        playAudioWithVariablePitch(-1000)
    }
    
    //MARK: - Helper Functions
    
    func slowAndFast(rate: Float){
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.stop()
        audioPlayer.rate = rate
        audioPlayer.play()
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        
        try! audioEngine.start()
        
        audioPlayerNode.play()
    }
}
