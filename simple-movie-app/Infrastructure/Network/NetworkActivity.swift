//
//  NetworkActivity.swift
//  test
//
//  Created by Behnam on 12/20/21.
//

import Foundation

// Types

typealias ResultCallback<T> = (Result<T, NetworkStackError>) -> Void

enum NetworkStackError: Error {
    case invalidRequest
    case dataMissing
    case faceError(error: String)
    case responseError(error: Error)
    case parserError(error: Error)
    
    var localizedDescription: String {
        switch self {
        case .invalidRequest:
            return "A user-friendly description of the error."
        case .faceError(let error):
            return error
        case .responseError(let error):
            return error.localizedDescription
        case .parserError(let error):
            return error.localizedDescription
        case .dataMissing:
            return ""
        }
    }
    
}

// Network Activity

enum NetworkActivityState {
    case show
    case hide
}

protocol NetworkActivityProtocol {
    func increment()
    func decrement()
    func observe(using closure: @escaping (NetworkActivityState) -> Void)
}

class NetworkActivity: NetworkActivityProtocol {
    private var observations = [(NetworkActivityState) -> Void]()
    
    private var activityCount: Int = 0 {
        didSet {
            
            if (activityCount < 0) {
                activityCount = 0
            }
            
            if (oldValue > 0 && activityCount > 0) {
                return
            }
            
            stateDidChange()
        }
    }
    
    private func stateDidChange() {
        
        let state = activityCount > 0 ? NetworkActivityState.show : NetworkActivityState.hide
        observations.forEach { closure in
             OperationQueue.main.addOperation({ closure(state) })
        }
    }
    
    func increment() {
        self.activityCount += 1
    }
    
    func decrement() {
        self.activityCount -= 1
    }
    
    func observe(using closure: @escaping (NetworkActivityState) -> Void) {
        observations.append(closure)
    }
}
