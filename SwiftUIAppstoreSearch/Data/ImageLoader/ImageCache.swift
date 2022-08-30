//
//  ImageCache.swift
//  SwiftUIAppstoreSearch
//
//

import SwiftUI

final class ImageCache {
    struct Config {
        let countLimit: Int
        let memoryLimit: Int

        // default = Max 128 files and Memory limit 128MB
        static let defaultConfig = Config(countLimit: 128, memoryLimit: 1024 * 1024 * 128)
    }
    
    private lazy var imageCache: NSCache<AnyObject, AnyObject> = {
        let cache = NSCache<AnyObject, AnyObject>()
        cache.countLimit = config.countLimit
    
        return cache
    }()
    
    private lazy var decodedImageCache: NSCache<AnyObject, AnyObject> = {
        let cache = NSCache<AnyObject, AnyObject>()
        cache.totalCostLimit = config.memoryLimit
        return cache
    }()
    
    private let lock = NSLock()
    private let config: Config
    private let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    
    init(config: Config = Config.defaultConfig) {
        self.config = config
    }
}

extension ImageCache {
    func image(for url: URL) -> UIImage? {
        lock.lock(); defer { lock.unlock() }
        if let decodedImage = decodedImageCache.object(forKey: url.path as AnyObject) as? UIImage {
            return decodedImage
        }

        if let image = imageCache.object(forKey: url.path as AnyObject) as? UIImage {
            let decodedImage = image.decodeToRGBImage()
            decodedImageCache.setObject(image as AnyObject,
                                        forKey: url.path as AnyObject,
                                        cost: decodedImage.diskSize)
            return decodedImage
        }
        return nil
    }
    
    func insertImage(_ image: UIImage?, for key: URL) {
        guard let image = image else {  return removeImage(for: key) }
        
        let decodedImage = image.decodeToRGBImage()

        lock.lock(); defer { lock.unlock() }
        
        imageCache.setObject(decodedImage, forKey: key.path as AnyObject)
        decodedImageCache.setObject(image as AnyObject, forKey: key.path as AnyObject, cost: decodedImage.diskSize)
        
        // Save image file to local path
        let path = documents.appendingPathComponent(key.path.replacingOccurrences(of: "/", with: "_"), isDirectory: false)

        if let data = image.pngData() {
            do {
                try data.write(to: path)
            } catch {
                print("Unable to Write Image Data to Disk")
            }
        }
    }

    func removeImage(for url: URL) {
        lock.lock(); defer { lock.unlock() }
        imageCache.removeObject(forKey: url.path as AnyObject)
        decodedImageCache.removeObject(forKey: url.path as AnyObject)
        
        // Remove image file to local path
        if FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.removeItem(at: url)
            } catch {
                print("Unable to remove exist file.\n>>>\(url.path)")
            }
        }
    }
    
    subscript(_ key: URL) -> UIImage? {
        get {
            return image(for: key)
        }
        set {
            insertImage(newValue, for: key)
        }
    }
}
