//
//  XMLDownloader.swift
//  XMLNewsReader
//
//  Created by Sudeepth Dharavasthu on 8/1/16.
//  Copyright © 2016 Sudeepth Dharavasthu. All rights reserved.


import Foundation
import CoreData
import UIKit

class XMLDownloader: NSObject,NSXMLParserDelegate{

    var xmlparser:NSXMLParser!
    var parser = NSXMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var title1 = NSMutableString()
    var date = NSMutableString()
    var content = NSMutableString()
   
    
    func beginParsing()
    {
        posts = []
        parser = NSXMLParser(contentsOfURL:(NSURL(string:"https://news.google.com/?output=rss"))!)!
        parser.delegate = self
        parser.parse()
    }
    
    //XMLParser Methods
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        element = elementName
        if (elementName as NSString).isEqualToString("item")
        {
            elements = NSMutableDictionary()
            elements = [:]
            title1 = NSMutableString()
            title1 = ""
            date = NSMutableString()
            date = ""
            content = NSMutableString()
            content = ""
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        let appDelegae: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDelegae.managedObjectContext
        
        if (elementName as NSString).isEqualToString("item") {
            let newsEntity = NSEntityDescription.insertNewObjectForEntityForName("News", inManagedObjectContext: context)
            if !title1.isEqual(nil) {
                elements.setObject(title1, forKey: "title")
                newsEntity.setValue(title1, forKey: "title")
            }
            if !date.isEqual(nil) {
                elements.setObject(date, forKey: "date")
                newsEntity.setValue(date, forKey: "date")
            }
            if !content.isEqual(nil){
                elements.setObject(content, forKey: "description")
                newsEntity.setValue(content, forKey: "content")
            }
            
            posts.addObject(elements)
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String)
    {
//        let appDelegae: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        let context:NSManagedObjectContext = appDelegae.managedObjectContext
//        let newsEntity = NSEntityDescription.insertNewObjectForEntityForName("News", inManagedObjectContext: context)
        if element.isEqualToString("title") {
            title1.appendString(string)
           // newsEntity.setValue(string, forKey: "title")
        } else if element.isEqualToString("pubDate") {
            date.appendString(string)
            //newsEntity.setValue(string, forKey: "date")
        }else if element.isEqualToString("description"){
            content.appendString(string)
            //newsEntity.setValue(string, forKey: "content")
        }
    }
   
}