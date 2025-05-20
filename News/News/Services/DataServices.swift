//
//  DataServices.swift
//  News
//
//  Created by Даша Волошина on 18.05.25.
//

import Foundation
import CoreData

class DataServices: ObservableObject {
    
    private let context = PersistenceController.shared.context
    
    @Published var favorites: [FavoriteItem] = []
    @Published var blocked: [FavoriteItem] = []
    
    init() {
        fetchNews()
    }
    
//MARK: fetch news
    func fetchNews() {
        let request: NSFetchRequest<FavoriteItem> = FavoriteItem.fetchRequest()
        
        do {
            let allNews = try context.fetch(request)
            favorites = allNews.filter { !$0.isBlocked }
            blocked = allNews.filter { $0.isBlocked }
        } catch {
            DataError.failedFetch
        }
    }
    
    //MARK: add news
    func addNews(id: String, title: String, url: String, image: String, isBlocked: Bool, publishedDate: String, section:String, abstract: String) {
        let news = FavoriteItem(context: context)
        news.id = id
        news.title = title
        news.url = url
        news.image = image
        news.isBlocked = isBlocked
        news.publishedDate = publishedDate
        news.section = section
        news.abstract = abstract
        
        saveContext()
        fetchNews()
    }
    
    //MARK: add favorite news  to block
    func removeNews(id: String) {
        let request: NSFetchRequest<FavoriteItem> = FavoriteItem.fetchRequest()
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
            NSPredicate(format: "id == %@", id),
            NSPredicate(format: "isBlocked == NO")
        ])
        
        do {
            let results = try context.fetch(request)
            results.forEach { context.delete($0) }
            saveContext()
            fetchNews()
        } catch {
            DataError.failedRemove
        }
    }
    
    //MARK: unblock news
    func removeBlockedNews(id: String) {
        let request: NSFetchRequest<FavoriteItem> = FavoriteItem.fetchRequest()
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
            NSPredicate(format: "id == %@", id),
            NSPredicate(format: "isBlocked == YES")
        ])
        
        do {
            let results = try context.fetch(request)
            results.forEach { context.delete($0) }
            saveContext()
            fetchNews()
        } catch {
            DataError.failedRemove
        }
    }
    
    //MARK: save context
    private func saveContext() {
        do {
            try context.save()
        } catch {
            DataError.failedSaved
        }
    }    
}

