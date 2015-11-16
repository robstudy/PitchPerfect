//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//

import UIKit
import AVFoundation
import Foundation

class PlaySoundsViewController: UIViewController {

    var audioPlayer:AVAudioPlayer!
    var audioPlayer2:AVAudioPlayer!
    var recieveAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    @IBOutlet weak var echoButton: UIButton!
    
    //MARK: - Override Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()

        audioPlayer = try!AVAudioPlayer(contentsOfURL: recieveAudio.filePathUrl)
        audioPlayer.prepareToPlay()
        audioPlayer.enableRate=true
        
        /*
        For echoAudio article on subject can be found
        http://sandmemory.blogspot.com/2014/12/how-would-you-add-reverbecho-to-audio.html
        */
        audioPlayer2 = try!AVAudioPlayer(contentsOfURL: recieveAudio.filePathUrl)
        audioPlayer2.prepareToPlay()
        audioPlayer2.enableRate=true
        
        echoButton.layer.borderWidth = 2
        echoButton.layer.cornerRadius = 10
        echoButton.layer.borderColor = UIColor.blackColor().CGColor
        
        audioEngine = AVAudioEngine()
        audioFile = try!AVAudioFile(forReading: recieveAudio.filePathUrl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Actions
    
    @IBAction func echoAudio(sender: AnyObject) {
        stop()
        audioPlayer.play()
        
        let delayTime:NSTimeInterval = 0.08
        var playTime:NSTimeInterval
        playTime = audioPlayer2.deviceCurrentTime + delayTime
        audioPlayer2.stop()
        audioPlayer2.currentTime = 0
        audioPlayer2.volume = 0.9
        audioPlayer2.playAtTime(playTime)
        print("echo")
    }
    
    @IBAction func slowPlayBack(sender:UIButton){
        slowAndFast(0.5)
    }
    
    @IBAction func fastPlayBack(sender:UIButton){
        slowAndFast(1.5)
    }
    
    @IBAction func stopAudio(sender:UIButton){
        stop()
    }
    
    @IBAction func playChipmonkAudio(sender: UIButton){
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playDarthVaderAudio(sender: UIButton){
        playAudioWithVariablePitch(-1000)
    }
    
    //MARK: - Helper Functions
    
    func slowAndFast(rate: Float){
        stop()
        audioPlayer.rate = rate
        audioPlayer.play()
    }
    
    func stop(){
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.stop()
        audioPlayer2.stop()
        audioPlayer.currentTime = 0
        audioPlayer2.currentTime = 0
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        stop()
        
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
