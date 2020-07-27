//
//  ViewController1.swift
//  Sample
//
//  Created by rajnikant.hole on 21/07/20.
//  Copyright © 2020 rajnikant. All rights reserved.
//

import UIKit

// 🔴 # barrier - called after complettion all queue tasks

class ViewController1: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //customQueuesWithQOS()
        // Uncomment the following method call to test
        
        //simpleQueues()
        
        // queuesWithQoS()
        
        
         //concurrentQueues()
         if let queue = inactiveQueue {
           // queue.activate()
         }
         
        
        // queueWithDelay()
        
        // fetchImage()
        
         //useWorkItem()
         testDispatchGroup()
       // testSemaphoreDepedanci()
       // do2TasksAtATime()
    }
    
    func customQueues(){
        /*
        userInteractive
        userInitiated
        default
        utility
        background
        unspecified
 */
        
        let que = DispatchQueue(label: "abc")
        
        que.async {
            for i in 0 ..< 1000 {
                print("🔴Async customQueues \(i+1)")
            }
        }
        
        
            for i in 0 ..< 10 {
                print("Ⓜ️ customQueues \(i+1)")
            }
        
    }
    
    func customQueuesWithQOS(){
   
           
        let que1 = DispatchQueue(label: "abc1",qos: .userInitiated,attributes: .concurrent)
        let que2 = DispatchQueue(label: "abc2",qos: .background)
           
        
           que1.async {
               for i in 0 ..< 10 {
                   print("🔴Async customQueues \(i+1)")
               }
           }
           
          que1.async {
               for i in 0 ..< 10 {
                   print("Ⓜ️Async customQueues \(i+1)")
               }
           }
        
           for i in 0 ..< 10 {
              //print("🔴🔴🔴Ⓜ️Async customQueues \(i+1)")
           }
       }
    
    func simpleQueues() {
        let queue = DispatchQueue(label: "com.appcoda.myqueue")
        
        queue.async {
            for i in 0..<10 {
                print("🔴", i)
            }
        }
        
        for i in 100..<110 {
            print("Ⓜ️", i)
        }
    }
    
    
    func queuesWithQoS() {
        let queue1 = DispatchQueue(label: "com.appcoda.queue1", qos: DispatchQoS.userInitiated)
        // let queue1 = DispatchQueue(label: "com.appcoda.queue1", qos: DispatchQoS.background)
        // let queue2 = DispatchQueue(label: "com.appcoda.queue2", qos: DispatchQoS.userInitiated)
        let queue2 = DispatchQueue(label: "com.appcoda.queue2", qos: DispatchQoS.utility)
        
        queue1.async {
            for i in 0..<10 {
                print("🔴", i)
            }
        }
        
        queue2.async {
            for i in 100..<110 {
                print("🔵", i)
            }
        }
        
        for i in 1000..<1010 {
            print("Ⓜ️", i)
        }
    }
    
    
    var inactiveQueue: DispatchQueue!
    func concurrentQueues() {
        // let anotherQueue = DispatchQueue(label: "com.appcoda.anotherQueue", qos: .utility)
        // let anotherQueue = DispatchQueue(label: "com.appcoda.anotherQueue", qos: .utility, attributes: .concurrent)
        // let anotherQueue = DispatchQueue(label: "com.appcoda.anotherQueue", qos: .utility, attributes: .initiallyInactive)
        let anotherQueue = DispatchQueue(label: "com.appcoda.anotherQueue", qos: .userInitiated, attributes: [ .initiallyInactive])
        inactiveQueue = anotherQueue
        
        anotherQueue.async {
            for i in 0..<10 {
                print("🔴", i)
            }
        }
        
        
        anotherQueue.async {
            for i in 100..<110 {
                print("🔵", i)
            }
        }
        
        
        anotherQueue.async {
            for i in 1000..<1010 {
                print("⚫️", i)
            }
        }
    }
    
    
    func queueWithDelay() {
        let delayQueue = DispatchQueue(label: "com.appcoda.delayqueue", qos: .userInitiated)
        
        print(Date())
        let additionalTime: DispatchTimeInterval = .seconds(2)
        
        delayQueue.asyncAfter(deadline: .now() + additionalTime) {
            print(Date())
        }
    }
    
    
    func fetchImage() {
        let imageURL: URL = URL(string: "http://www.appcoda.com/wp-content/uploads/2015/12/blog-logo-dark-400.png")!
        
        (URLSession(configuration: URLSessionConfiguration.default)).dataTask(with: imageURL, completionHandler: { (imageData, response, error) in
            
            if let data = imageData {
                print("Did download image data")
                
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            }
        }).resume()
    }
    
    
    func useWorkItem() {
        var value = 10
        
        let workItem = DispatchWorkItem {
            //print("DispatchWorkItem  \(value)")
            value += 5
        }
        
        workItem.perform()
        
        let queue = DispatchQueue.global(qos: .utility)
        /*
         queue.async {
            workItem.perform()
         }
         */
        
       // queue.async(execute: workItem)
        //queue.async(execute: workItem)
        
        
        workItem.notify(queue: DispatchQueue.main) {
            print("value = ", value)
        }
    }
    
    func testGroupFinalBarrier(){
        
        let queue = DispatchQueue(label: "com.appcoda.delayqueue", attributes: .concurrent)
        
        queue.async {
            print("start one!\n");
            sleep(4);
            print("end one!\n");
        }

        queue.async {
                   print("start two!\n");
                   sleep(2);
                   print("end two!\n");
        }
        
        queue.async(flags: .barrier, execute: {
            print("the END!\n");
        })
        // 🔴 # barrier - called after complettion all queue tasks
    }
    
    //Semaphore Syncronise
    func testSemaphoreDepedanci(){
        let semaphore = DispatchSemaphore(value: 1)
       DispatchQueue.global().async {
//print("Kid 1 - wait")//
           semaphore.wait()
          // print("Kid 1 - wait finished")
           sleep(3) // Kid 1 playing with iPad
           semaphore.signal()
           print("Kid 1 - done with iPad")
        }
        DispatchQueue.global().async {
          // print("Kid 2 - wait")
           semaphore.wait()
          // print("Kid 2 - wait finished")
           sleep(3) // Kid 1 playing with iPad
           semaphore.signal()
           print("Kid 2 - done with iPad")
        }
        DispatchQueue.global().async {
           //print("Kid 3 - wait")
           semaphore.wait()
          // print("Kid 3 - wait finished")
           sleep(3) // Kid 1 playing with iPad
           semaphore.signal()
           print("Kid 3 - done with iPad")
        }

    }
   func testDispatchGroup() {
       let group = DispatchGroup()

       let queueA = DispatchQueue(label: "Q1")
       let queueB = DispatchQueue(label: "Q2")
       let queueC = DispatchQueue(label: "Q3")

       queueB.async(group: group) {
           print("QueueB gonna sleep")
           sleep(10)
           print("QueueB woke up")
       }

       queueC.async(group: group) {
           print("QueueC gonna sleep")
           sleep(3)
           print("QueueC wake up")
       }

       group.notify(queue: queueA) {
           print("notify QueueA gonna sleep")
           sleep(3)
           print("notify QueueA woke up")
       }
    
   }
    
    func do2TasksAtATime () {
        let queue = DispatchQueue(label: "com.gcd.myQueue", attributes: .concurrent)
        let semaphore = DispatchSemaphore(value: 1)
        for i in 0 ..< 15 {
           queue.async {
              let songNumber = i + 1
              queue.suspend()
              semaphore.wait()
              print("Downloading song", songNumber)
              sleep(2) // Download take ~2 sec each
              print("signal Downloaded song", songNumber)
              semaphore.signal()
             
           }
        }
    }
    
}


struct Operation{
    
    
    func testOperation(){
            let queue = DispatchQueue(label: "com.gcd.myQueue", attributes: .concurrent)
            let semaphore = DispatchSemaphore(value: 1)
            for i in 0 ..< 15 {
               queue.async {
                  let songNumber = i + 1
                  queue.suspend()
                  semaphore.wait()
                  print("Downloading song", songNumber)
                  sleep(2) // Download take ~2 sec each
                  print("signal Downloaded song", songNumber)
                  semaphore.signal()
                 
               }
            }
        
    }
}
class BlockOperationViewController: UIViewController {
    
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    @IBOutlet weak var sliderValueLabel: UILabel!
    
    var queue: OperationQueue?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func didClickOnStart(sender: Any) {
        queue = OperationQueue()
        
        let operation1 = BlockOperation(block: {
           print(" operation1 staeted ")
        })
        
        operation1.completionBlock = {
            print("Operation 1 completed, cancelled:\(operation1.isCancelled)")
        }
        queue?.addOperation(operation1)
        
        let operation2 = BlockOperation(block: {
            print(" operation2 staeted ")
        })
        operation2.addDependency(operation1)
        operation2.completionBlock = {
            print("Operation 2 completed, cancelled:\(operation2.isCancelled)")
        }
        queue?.addOperation(operation2)
        
        let operation3 = BlockOperation(block: {
            print(" operatio3 staeted ")
        })
        operation3.addDependency(operation2)
        operation3.completionBlock = {
            print("Operation 3 completed, cancelled:\(operation3.isCancelled)")
        }
        queue?.addOperation(operation3)
        
        let operation4 = BlockOperation(block: {
            print(" operation4  staeted ")
        })
        operation4.completionBlock = {
            print("Operation 4 completed, cancelled:\(operation4.isCancelled)")
        }
        queue?.addOperation(operation4)
        
    }
    
    
    
}

