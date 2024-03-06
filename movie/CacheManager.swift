//
//  CacheManager.swift
//  movie
//
//  Created by Seda Şahin on 6.03.2024.
//

import Foundation
struct CacheManager {
    static let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!

    static func saveDataToCache(data: Data, fileName: String) {
        let fileURL = cacheDirectory.appendingPathComponent(fileName)
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(at: fileURL)
            } catch {
                print("Error removing existing file: \(error.localizedDescription)")
            }
        }
        do {
            try data.write(to: fileURL)
        } catch {
            print("Error saving data to cache: \(error.localizedDescription)")
        }
    }

    static func loadDataFromCache(fileName: String) -> Data? {
        let fileURL = cacheDirectory.appendingPathComponent(fileName)
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            return nil
        }
        do {
            let data = try Data(contentsOf: fileURL)
            return data
        } catch {
            return nil
        }
    }
}
