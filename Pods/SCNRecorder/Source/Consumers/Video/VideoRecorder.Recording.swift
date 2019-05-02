//
//  VideoRecorder.Recording.swift
//  SCNRecorder
//
//  Created by Vladislav Grigoryev on 11/03/2019.
//  Copyright (c) 2019 GORA Studio. https://gora.studio
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation
import AVFoundation

extension VideoRecorder {
    
    final class Recording {
        
        let notificationQueue: DispatchQueue = DispatchQueue(label: "VideoRecording.NotificationQueue", qos: .userInteractive)
        
        var _duration: TimeInterval = 0.0
        
        var _state: VideoRecording.State = .preparing

        var _error: Swift.Error?

        var onDurationChanged: ((TimeInterval) -> Void)?
        
        var onStateChanged: ((VideoRecording.State) -> Void)?
        
        var onError: ((Swift.Error) -> Void)?
        
        let videoRecorder: VideoRecorder
        
        init(videoRecorder: VideoRecorder) {
            self.videoRecorder = videoRecorder
        }
    }
}

extension VideoRecorder.Recording: VideoRecording {

    var duration: TimeInterval {
        get {
            var duration: TimeInterval = 0.0
            notificationQueue.sync {
                duration = _duration
            }
            return duration
        }
        set {
            notificationQueue.async { [weak self] in
                guard let `self` = self, self._duration != newValue else {
                    return
                }
                
                self._duration = newValue
                self.onDurationChanged?(newValue)
            }
        }
    }
    
    var state: VideoRecording.State {
        get {
            var state: VideoRecording.State = .recording
            notificationQueue.sync {
                state = _state
            }
            return state
        }
        set {
            notificationQueue.async { [weak self] in
                guard let `self` = self, self._state != newValue else {
                    return
                }
                
                self._state = newValue
                self.onStateChanged?(newValue)
            }
        }
    }
    
    var error: Swift.Error? {
        get {
            var error: Swift.Error? = nil
            notificationQueue.sync {
                error = _error
            }
            return error
        }
        set {
            notificationQueue.async { [weak self] in
                guard let `self` = self, let error = newValue else {
                    return
                }
                self._error = error
                self.onError?(error)
            }
        }
    }
    
    var url: URL {
        return videoRecorder.url
    }
    
    var fileType: AVFileType {
        return videoRecorder.fileType
    }
    
    var timeScale: CMTimeScale {
        return videoRecorder.timeScale
    }
    
    func resume() {
        videoRecorder.resume { [weak self] (error) in
            self?.error = error
        }
    }
    
    func pause() {
        videoRecorder.pause()
    }
    
    func finish(completionHandler handler: @escaping (_ recording: VideoRecording) -> Void) {
        videoRecorder.finish { handler(self) }
    }
    
    func cancel() {
        videoRecorder.cancel()
    }
}
