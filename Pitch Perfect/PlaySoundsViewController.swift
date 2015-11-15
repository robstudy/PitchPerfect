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
    let audioEngine = AVAudioEngine()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        audioPlayer = try!AVAudioPlayer(contentsOfURL: recieveAudio.filePathUrl)
        audioPlayer.prepareToPlay()
        audioPlayer.enableRate=true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func slowPlayBack(sender:UIButton){
        audioPlayer.stop()
        audioPlayer.rate=0.5
        audioPlayer.play()
    }
    
    @IBAction func fastPlayBack(sender:UIButton){
        audioPlayer.stop()
        audioPlayer.rate=1.5
        audioPlayer.play()
    }
    
    @IBAction func stopAudio(sender:UIButton){
        audioPlayer.stop()
    }
    
    @IBAction func playChipmonkAudio(sender: UIButton){
        let audioNode = AVAudioPlayerNode()
        let audioPitch = AVAudioUnitTimePitch()
        audioPitch.pitch = 1000
        
        audioEngine.attachNode(audioNode)
        audioEngine.attachNode(audioPitch)
        
        
        
        audioPlayer.play()
    }
    /*r
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
