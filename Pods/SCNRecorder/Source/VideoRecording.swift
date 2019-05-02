//
//  VideoRecording.swift
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

public protocol VideoRecording: AnyObject {
    
    typealias State = VideoRecordingState
    
    var url: URL { get }
    
    var fileType: AVFileType { get }
    
    var timeScale: CMTimeScale { get }
    
    var duration: TimeInterval { get }
    
    var onDurationChanged: ((_ duration: TimeInterval) -> Void)? { get set }
    
    var state: State { get }
    
    var onStateChanged: ((_ state: State) -> Void)? { get set }
    
    var error: Swift.Error? { get }
    
    var onError: ((_ error: Swift.Error) -> Void)? { get set }
    
    func resume()
    
    func pause()
    
    func finish(completionHandler handler: @escaping (_ recording: VideoRecording) -> Void)
    
    func cancel()
}

public enum VideoRecordingState {
    
    case ready
    
    case preparing
    
    case recording
    
    case paused
    
    case canceled
    
    case finished
}
