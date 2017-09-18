
import UIKit
import AnimatedCollectionViewLayout

class TasksVC: UIViewController{
    
    var tasks: Array<Tasks> = []
    var visibleCellIndex: IndexPath!
    var userID: Int = -1
    var currentPage = 0
    let dotsCount = 5

    let cellWidthScaling: CGFloat = 0.85
    let cellHeightScaling: CGFloat = 0.76
    @IBOutlet var cards: UICollectionView!
    
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var topActionBarHeight: NSLayoutConstraint!
    
    @IBOutlet var topActionBar: UIView!
    @IBOutlet var coinsBtn: UIButton!
    @IBOutlet var experiencePoints: UILabel!
    @IBOutlet var profileBtn: UIButton!
   
    @IBAction func onCoinsPressed(_ sender: UIButton) {
        goto(storyBoardName: "Profile", storyBoardID: "LeaderboardVC")
    }
    
    @IBAction func onNotificationPressed(_ sender: UIButton) {
        goto(storyBoardName: "Modules", storyBoardID: "NotificationsVC")
        
    }
    
    @IBAction func onProfilePressed(_ sender: UIButton) {
        goto(storyBoardName: "Profile", storyBoardID: "ProfileTBC")
    }
    
    func setCollectionCellSize(){
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = floor(screenSize.width * cellWidthScaling)
        let cellHeight = floor(screenSize.height * cellHeightScaling)
        
        let insetX = (view.bounds.width - cellWidth)/2.0
        let insetY = (view.bounds.height - cellHeight)/2.0
        
        let layout = AnimatedCollectionViewLayout()
        layout.animator = LinearCardAttributesAnimator( minAlpha: 0.5, itemSpacing: 0.1, scaleRate: 1.0)
        
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        cards.collectionViewLayout = layout
        cards.contentInset = UIEdgeInsets(top: (1 * insetY), left: insetX, bottom: ( insetY + 15), right: insetX)
        
        self.cards.delegate = self
        self.cards.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if tasks.count < dotsCount {
            self.pageControl.numberOfPages = tasks.count
        } else {
            self.pageControl.numberOfPages = dotsCount
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //self.pageControl.numberOfPages = dotsCount
        topActionBar.backgroundColor = UIColor.Custom.themeColor
        pageControl.currentPageIndicatorTintColor = UIColor(red:0.14, green:0.71, blue:0.98, alpha:1.0)
        pageControl.pageIndicatorTintColor = UIColor(red:0.88, green:0.88, blue:0.88, alpha:1.0)
        pageControl.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        //topActionBarHeight.constant = CGFloat.Custom.topActionBarHeight
        
        setCollectionCellSize()
        
        var profileImgUrl: String = ""
        var xp: Int = 0
        var coins: Int = 0
        
        if let complexCache = DataCache.sharedInstance.cache["complexObject"] {
            tasks = (ComplexObject(JSONString: complexCache).tasks)!
            userID = (ComplexObject(JSONString: complexCache).studentProfile?.id!)!
            profileImgUrl = (ComplexObject(JSONString: complexCache).studentProfile?.profileImage)!
            xp = (ComplexObject(JSONString: complexCache).studentProfile?.experiencePoints)!
            coins = (ComplexObject(JSONString: complexCache).studentProfile?.coins)!
        }
        
        //inserting image from url async
        let url = URL(string: profileImgUrl)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            
            DispatchQueue.main.async {
                if data != nil {
                    self.profileBtn.setBackgroundImage(UIImage(data: data!), for: .normal)
                } else {
                    self.profileBtn.setBackgroundImage(UIImage(named: "coins"), for: .normal)
                }
            }
        }
        profileBtn.makeButtonRound(borderWidth: 2.5, borderColor: UIColor.white)
        
        //set userpoints in toolbar
        coinsBtn.setTitle(" " + String(coins), for: .normal)
        experiencePoints.text = String(xp)
    
        
        
    }

    func goto(storyBoardName: String, storyBoardID: String) {
        let storyBoard : UIStoryboard = UIStoryboard(name: storyBoardName, bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: storyBoardID)
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    /*func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let screenSize = UIScreen.main.bounds.size
        
        return CGSize(width: (screenSize.width * 0.75), height: screenSize.height * 0.75); //use height whatever you wants.
    }*/
    
    
    override var prefersStatusBarHidden : Bool {
        return false
    }

    func loadImageAsync(url: String, imgView: UIImageView){
        do {
            let url = URL(string: url)
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
                    if data != nil {
                        imgView.image = UIImage(data: data!)

                    } else {
                        imgView.image = UIImage(named: "info")
                    }
                                    }
            }
        }catch let error as NSError {
            print(" Error \(error)")
        }
    }
    
    
    func getSubstring (str: String, startOffest: Int, endOffset: Int)-> String {
        let start = str.index(str.startIndex, offsetBy: startOffest)
        let end = str.index(str.endIndex, offsetBy: endOffset)
        let range = start..<end
        
        return str[range]
    }
    
}

extension TasksVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasks.count
    }
    
    
    @IBAction func startBtnTapped(_ sender: UIButton) -> Void {
        print(tasks[sender.tag].title)
        let task = tasks[sender.tag]
        /*
        var storyBoardName: String = ""
        var storyBoardID: String = ""*/
        
        if task.itemType == "LESSON_PRESENTATION" {//LessonsPageVC
            let storyBoard : UIStoryboard = UIStoryboard(name: "Lesson", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LessonsPageVC") as! LessonsPageVC
            nextViewController.lessonID = tasks[sender.tag].itemId
            self.present(nextViewController, animated:true, completion:nil)
        } else if (task.itemType == "CLASSROOM_SESSION_STUDENT" || task.itemType == "CLASSROOM_SESSION") {
            
        } else if (task.itemType == "ASSESSMENT" || task.itemType == "LESSON_ASSESSMENT") {
            let storyBoard : UIStoryboard = UIStoryboard(name: "assessment", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AssessmentVC") as! AssessmentVC
            nextViewController.taskID = tasks[sender.tag].id!
            nextViewController.userID = userID
            self.present(nextViewController, animated:true, completion:nil)
            
        } else if task.itemType == "LESSON_VIDEO" { //
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        if tasks[indexPath.row].itemType == "LESSON_PRESENTATION" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "presentationCell", for: indexPath) as! PresentationCell
            
            cell.headerLabel.text = tasks[indexPath.row].header?.uppercased()
            
            cell.titleLabel.text = tasks[indexPath.row].title
            cell.descriptionLabel.text = tasks[indexPath.row].description
            loadImageAsync(url: tasks[indexPath.row].imageURL!, imgView: cell.lessonImage)
            cell.videoImg.isHidden = true
            cell.watchBtn.tag = indexPath.row
            cell.watchBtn.backgroundColor = UIColor.Custom.themeColor
            cell.watchBtn.setImage(UIImage(named: "presentation"), for: .normal)
            cell.watchBtn.tintColor = UIColor.white
            cell.watchBtn.imageEdgeInsets = UIEdgeInsets(top: 9, left: 10, bottom: 9, right: 20)
            cell.watchBtn.addTarget(self, action: #selector(startBtnTapped), for: UIControlEvents.touchUpInside)
            
            return cell
        } else if (tasks[indexPath.row].itemType == "CLASSROOM_SESSION_STUDENT" || tasks[indexPath.row].itemType == "CLASSROOM_SESSION") {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "assessmentCell", for: indexPath) as! AssessmentCell
            
            
            cell.headerLabel.text = tasks[indexPath.row].header?.uppercased()
            cell.titleLabel.text = tasks[indexPath.row].title
            loadImageAsync(url: tasks[indexPath.row].imageURL!, imgView: cell.assessmentImg)
            cell.descriptionLabel.text = tasks[indexPath.row].classRoomName
            
            if let hrs = tasks[indexPath.row].durationHours {
                cell.numOfQuesLabel.text = String(hrs) + " hrs"
            }
            
            if let y = tasks[indexPath.row].classRoomId {
                cell.pointsLabel.text = "#" + String(y)
            }
            cell.quesText.text = "Duration"
            cell.xpText.text = "classRoom Id"
            cell.durationLabel.text = getSubstring(str: tasks[indexPath.row].time!, startOffest: 0, endOffset: -3)
            cell.timeText.text = "Time"
            cell.startBtn.setTitle("START CLASS", for: .normal)
            cell.startBtn.tag = indexPath.row
            cell.startBtn.backgroundColor = UIColor.Custom.themeColor
            cell.startBtn.setImage(UIImage(named: "play_icon"), for: .normal)
            cell.startBtn.tintColor = UIColor.white
            cell.startBtn.imageEdgeInsets = UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 20)
            cell.startBtn.addTarget(self, action: #selector(startBtnTapped), for: UIControlEvents.touchUpInside)
            
            return cell
        } else if (tasks[indexPath.row].itemType == "ASSESSMENT" || tasks[indexPath.row].itemType == "LESSON_ASSESSMENT") {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "assessmentCell", for: indexPath) as! AssessmentCell
           
            cell.headerLabel.text = tasks[indexPath.row].header?.uppercased()
            cell.titleLabel.text = tasks[indexPath.row].title
            cell.descriptionLabel.text = tasks[indexPath.row].description
            if tasks[indexPath.row].imageURL != nil {
                loadImageAsync(url: tasks[indexPath.row].imageURL!, imgView: cell.assessmentImg)
            }
            
            if let ques = tasks[indexPath.row].numberOfQuestions {
                cell.numOfQuesLabel.text = String(ques)
            }
            
            if let y = tasks[indexPath.row].itemPoints {
                cell.pointsLabel.text = String(y)
            }
            
            if let dur = tasks[indexPath.row].duration {
                cell.durationLabel.text = String(dur)
            }
            cell.xpText.text = "Experience"
            cell.quesText.text = "Questions"
            cell.timeText.text = "Duration"
            cell.startBtn.setTitle("START ASSESSMENT", for: .normal)
            cell.startBtn.tag = indexPath.row
            cell.startBtn.backgroundColor = UIColor.Custom.themeColor
            cell.startBtn.setImage(UIImage(named: "assessment_icon"), for: .normal)
            cell.startBtn.tintColor = UIColor.white
            cell.startBtn.imageEdgeInsets = UIEdgeInsets(top: 9, left: 10, bottom: 9, right: 20)
            cell.startBtn.addTarget(self, action: #selector(startBtnTapped), for: UIControlEvents.touchUpInside)
            
            return cell
            
        }else if tasks[indexPath.row].itemType == "LESSON_VIDEO"{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "presentationCell", for: indexPath) as! PresentationCell
            
            cell.headerLabel.text = tasks[indexPath.row].header?.uppercased()
            cell.titleLabel.text = tasks[indexPath.row].title
            cell.descriptionLabel.text = tasks[indexPath.row].description
            loadImageAsync(url: tasks[indexPath.row].imageURL!, imgView: cell.lessonImage)
            
            cell.videoImg.isHidden = false
            cell.watchBtn.tag = indexPath.row
            cell.watchBtn.backgroundColor = UIColor.Custom.themeColor
            cell.watchBtn.addTarget(self, action: #selector(startBtnTapped), for: UIControlEvents.touchUpInside)
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "presentationCell", for: indexPath) as! PresentationCell
            
            cell.headerLabel.text = tasks[indexPath.row].header?.uppercased()
            cell.titleLabel.text = tasks[indexPath.row].title
            cell.watchBtn.tag = indexPath.row
            cell.watchBtn.backgroundColor = UIColor.Custom.themeColor
            cell.watchBtn.addTarget(self, action: #selector(startBtnTapped), for: UIControlEvents.touchUpInside)
            
            return cell
        }
        
    }

}
extension TasksVC: UICollectionViewDelegate, UIScrollViewDelegate {
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let layout = cards.collectionViewLayout as! AnimatedCollectionViewLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        var index = (offset.x + scrollView.contentInset.left)/cellWidthIncludingSpacing
        
        let roundedIndex = round(index)
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
     
     
    }
    
    /*
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        // Simulate "Page" Function
        let layout = cards.collectionViewLayout as! UICollectionViewFlowLayout
        let pageWidth: Float = Float(layout.itemSize.width + layout.minimumLineSpacing)
        //let pageWidth: Float = Float(UIScreen.main.bounds.size.width * 1)
        let currentOffset: Float = Float(scrollView.contentOffset.x)
        let targetOffset: Float = Float(targetContentOffset.pointee.x)
        var newTargetOffset: Float = 0
        if targetOffset > currentOffset {
            newTargetOffset = ceilf(currentOffset / pageWidth) * pageWidth
        }
        else {
            newTargetOffset = floorf(currentOffset / pageWidth) * pageWidth
        }
        if newTargetOffset < 0 {
            newTargetOffset = 0
        }
        else if (newTargetOffset > Float(scrollView.contentSize.width)){
            newTargetOffset = Float(Float(scrollView.contentSize.width))
        }
        
        targetContentOffset.pointee.x = CGFloat(currentOffset)
        scrollView.setContentOffset(CGPoint(x: CGFloat(newTargetOffset), y: scrollView.contentOffset.y), animated: true)
        
        // Make Transition Effects for cells
        let duration = 0.2
        var index = newTargetOffset / pageWidth;
        var cell:UICollectionViewCell = self.cards.cellForItem(at: IndexPath(row: Int(index), section: 0))!
        if (index == 0) { // If first index
            UIView.animate(withDuration: duration, delay: 0.0, options: [ .curveEaseOut], animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            index += 1
            if let cell = self.cards.cellForItem(at: IndexPath(row: Int(index), section: 0)) {
                UIView.animate(withDuration: duration, delay: 0.0, options: [ .curveEaseOut], animations: {
                    cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                }, completion: nil)
            }
            
        }else{
            UIView.animate(withDuration: duration, delay: 0.0, options: [ .curveEaseOut], animations: {
                cell.transform = CGAffineTransform.identity;
            }, completion: nil)
            
            index -= 1 // left
            if let cell = self.cards.cellForItem(at: IndexPath(row: Int(index), section: 0)) {
                UIView.animate(withDuration: duration, delay: 0.0, options: [ .curveEaseOut], animations: {
                    cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8);
                }, completion: nil)
            }
            
            index += 1
            index += 1 // right
            if let cell = self.cards.cellForItem(at: IndexPath(row: Int(index), section: 0)) {
                UIView.animate(withDuration: duration, delay: 0.0, options: [ .curveEaseOut], animations: {
                    cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8);
                }, completion: nil)
            }
        }
        
    }*/
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        let pageWidth = scrollView.frame.width
        self.currentPage = Int((scrollView.contentOffset.x + pageWidth / 2) / pageWidth)
        self.pageControl.currentPage = self.currentPage % dotsCount
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        var visibleRect = CGRect()
        visibleRect.origin = cards.contentOffset
        visibleRect.size = cards.bounds.size
        
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let visibleIndexPath: IndexPath = cards.indexPathForItem(at: visiblePoint)!
        
        print(visibleIndexPath.row)
        self.visibleCellIndex = visibleIndexPath
        //self.visibleCellIndex = collectionView.indexPathsForVisibleItems.first!
        //print(self.visibleCellIndex.row)
    }
    
}


