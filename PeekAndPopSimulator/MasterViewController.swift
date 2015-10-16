/*
    Copyright (C) 2015 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    The master view controller.
*/

import UIKit

class MasterViewController: UITableViewController {
    
    // MARK: Types 
    
    /// A simple data structure to populate the table view.
    struct PreviewDetail {
        let title: String
        let preferredHeight: Double
    }
    
    // MARK: Properties
    
    let sampleData = [
        PreviewDetail(title: "Small", preferredHeight: 160.0),
        PreviewDetail(title: "Medium", preferredHeight: 320.0),
        PreviewDetail(title: "Large", preferredHeight: 0.0) // 0.0 to get the default height.
    ]

    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        previewer = registerForPreviewingWithDelegate(self, sourceView: view)
        
    }
    
    

    override func viewWillAppear(animated: Bool) {
        // Clear the selection if the split view is only showing one view controller.
        clearsSelectionOnViewWillAppear = splitViewController!.collapsed
        
        super.viewWillAppear(animated)
    }
    

    
    // MARK: UIStoryboardSegue Handling

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail", let indexPath = tableView.indexPathForSelectedRow {
            let previewDetail = sampleData[indexPath.row]
            
            let detailViewController = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
            
            // Pass the `title` to the `detailViewController`.
            detailViewController.detailItemTitle = previewDetail.title
        }
    }

    // MARK: Table View

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of items in the sample data structure.
        return sampleData.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let previewDetail = sampleData[indexPath.row]
        cell.textLabel!.text = previewDetail.title
        
        return cell
    }
    
    
}

