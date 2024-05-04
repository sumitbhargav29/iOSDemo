//
//  HeavyComputationOptimizer.swift
//  SumitiOSDemo
//
//  Created by SamMac on 03/05/24.
//

import Foundation

class HeavyComputationOptimizer {
    private var computationCache: [Int: String] = [:] // Cache for heavy computation results
    
    func optimizeHeavyComputation(for post: PostModel, completion: @escaping (String) -> Void) {
        guard let postId = post.id else {
            completion("Invalid post id")
            return
        }
        
        let startTime = CFAbsoluteTimeGetCurrent() // Record start time
        
        let semaphore = DispatchSemaphore(value: 1) // Initialize semaphore
        
        DispatchQueue.global().async {
            semaphore.wait() // Wait for access
            
            defer {
                semaphore.signal() // Always release access when done
            }
            
            if let cachedResult = self.computationCache[postId] {
                DispatchQueue.main.async {
                    completion(cachedResult)
                }
            } else {
                // Simulate heavy computation
                Thread.sleep(forTimeInterval: 2) // Simulate a 2-second computation
                let result = "Additional details for post \(postId)"
                
                semaphore.wait() // Wait for access to update cache
                self.computationCache[postId] = result // Cache the result
                semaphore.signal() // Release access
                
                let endTime = CFAbsoluteTimeGetCurrent() // Record end time
                let duration = endTime - startTime // Calculate duration
                
                print("Heavy computation took \(duration) seconds")
                
                DispatchQueue.main.async {
                    completion(result)
                }
            }
        }
    }
}
