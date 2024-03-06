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

        // Dosyanın var olup olmadığını kontrol et
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(at: fileURL)
            } catch {
                print("Error removing existing file: \(error.localizedDescription)")
            }
        }

        do {
            try data.write(to: fileURL)
            print("Data saved to cache: \(fileName)")
        } catch {
            print("Error saving data to cache: \(error.localizedDescription)")
        }
    }

    static func loadDataFromCache(fileName: String) -> Data? {
        let fileURL = cacheDirectory.appendingPathComponent(fileName)

        // Dosyanın var olup olmadığını kontrol et
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            print("File does not exist in cache: \(fileName)")
            return nil
        }

        do {
            let data = try Data(contentsOf: fileURL)
            print("Data loaded from cache: \(fileName)")
            return data
        } catch {
            print("Error loading data from cache: \(error.localizedDescription)")
            return nil
        }
    }
}
