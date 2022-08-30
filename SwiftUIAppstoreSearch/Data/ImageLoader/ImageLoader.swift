//
//  ImageLoader.swift
//  SwiftUIAppstoreSearch
//
//

import SwiftUI
import Combine
import CoreData

final class ImageLoader {
    public static let shared = ImageLoader()
    
    private let cache = ImageCache()
    private let container = NSPersistentContainer(name: "ImageStorage")
    private let dataQueue = DispatchQueue(label: "imageloader.data.queue", attributes: .concurrent)
    private let loaderQueue = DispatchQueue(label: "imageloader.queue", attributes: .concurrent)
    private let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    private func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("❗️Unresolved Error \(nserror.localizedDescription)\n\(nserror.userInfo)")
            }
        }
    }
}

extension ImageLoader {
    func loadImage(from string: String, date:Date) -> AnyPublisher< UIImage?, Never > {
        return loadImage(from: URL(string: string)!, date:date)
    }
    
    func loadImage(from url: URL, date:Date) -> AnyPublisher< UIImage?, Never > {
        // Check from image cache!
        if let image = cache[url] {
            return Just(image).eraseToAnyPublisher()
        }
        
        let request = LocalImage.fetchRequest()
        request.predicate = NSPredicate(format: "url = %@", url.path)
        
        let context = container.viewContext
        
        do {
            let localImageInfos = try context.fetch(request)
            
            if localImageInfos.count > 0 {
                let imageInfo = localImageInfos[0]
                
                if let diff = imageInfo.datetime?.diffHours(date), diff < 12 {
                    /// If previous download image is less than 12 hours? load from local
                    let path = documents.appendingPathExtension(url.path.replacingOccurrences(of: "/", with: "_"))
                    self.cache[url] = loadImageFromLocal(from: path)
                    
                    if let image = cache[url] {
                        return Just(image).eraseToAnyPublisher()
                    }
                } else {
                    self.dataQueue.sync(flags:.barrier) {
                        context.delete(imageInfo)
                        saveContext()
                    }
                }
            }
            
            return loadImageFromRemote(from: url)
        } catch {
            let nserror = error as NSError
            fatalError("❗️Unresolved Error \(nserror.localizedDescription)\n\(nserror.userInfo)")
        }
    }
}

extension ImageLoader {
    func saveImageInfo(from url: URL, date:Date) {
        self.dataQueue.sync(flags:.barrier) {
            let localImageInfo = LocalImage(context: container.viewContext)
            localImageInfo.url = url.path
            localImageInfo.datetime = date
            
            self.saveContext()
        }
    }
}


extension ImageLoader {
    func loadImageFromLocal(from url: URL) -> UIImage? {
        if let data = try? Data(contentsOf: url), let loaded = UIImage(data: data){
            return loaded
        }
        
        return nil
    }
    
    private func loadImageFromRemote(from url: URL) -> AnyPublisher< UIImage?, Never > {
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { (data, response) -> UIImage? in return UIImage(data: data) }
            .catch { error in return Just(nil) }
            .handleEvents(receiveOutput: {[unowned self] image in
                guard let image = image else { return }
                self.cache[url] = image
            })
            .subscribe(on: loaderQueue)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
