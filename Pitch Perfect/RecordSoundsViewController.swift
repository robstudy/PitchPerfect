//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//

import UIKit
import AVFoundation
//import QuartzCore


class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordLabel: UILabel!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var resumeButton: UIButton!
    
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    
    //MARK: - Override Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resumeButton.layer.borderWidth = 2
        resumeButton.layer.cornerRadius = 10
        resumeButton.layer.borderColor = UIColor.whiteColor().CGColor
        
        pauseButton.layer.borderWidth = 2
        pauseButton.layer.cornerRadius = 10
        pauseButton.layer.borderColor = UIColor.whiteColor().CGColor
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        recordButton.enabled = true
        resumeButton.enabled = false
        
        stopButton.hidden = true
        pauseButton.hidden = true
        resumeButton.hidden = true
        
        recordLabel.text = "Tap to Record"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "stopRecording"){
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundsVC.recieveAudio = data
        }
    }
    
    //MARK: - Actions

    @IBAction func recordAudio(sender: UIButton) {
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let recordingName = ("my_audio.wav")
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        
        try! audioRecorder = AVAudioRecorder(URL:filePath!, settings:[:])
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
        recordButton.enabled = false
        
        stopButton.hidden = false
        resumeButton.hidden = false
        pauseButton.hidden = false
        
        recordLabel.text = "Recording..."
        print("in recordAudio")
    }
    
    @IBAction func pauseRecording(sender: AnyObject) {
        recordLabel.text = "Paused"
        audioRecorder.pause()
        resumeButton.enabled = true
    }
    
    
    @IBAction func resumeRecording(sender: AnyObject) {
        audioRecorder.record()
        recordLabel.text = "Recording..."
        resumeButton.enabled = false
    }
    
    @IBAction func stopRecord(sender: UIButton) {
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try!audioSession.setActive(false)
        
        print("stop recording")
    }
    
    //Mark: - Helper Function
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if(flag){
            recordedAudio = RecordedAudio(filePath: recorder.url, title: recorder.url.lastPathComponent!)
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }else{
            print("Recording was not successful")
            recordButton.enabled = true
            stopButton.hidden = true
        }
    }
}

