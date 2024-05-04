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
        
        // Check if the result is already cached
        if let cachedResult = computationCache[postId] {
            completion(cachedResult)
            return
        }
        
        // Perform heavy computation asynchronously
        DispatchQueue.global().async {
            let startTime = CFAbsoluteTimeGetCurrent() // Record start time
            
            // Simulate heavy computation
            Thread.sleep(forTimeInterval: 2) // Simulate a 2-second computation
            let result = "Additional details for post \(postId)"
            
            // Cache the result
            self.computationCache[postId] = result
            
            let endTime = CFAbsoluteTimeGetCurrent() // Record end time
            let duration = endTime - startTime // Calculate duration
            
            print("Heavy computation took \(duration) seconds")
            
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
