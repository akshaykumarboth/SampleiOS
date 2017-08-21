
import UIKit

class TasksVC: UIViewController{
    
    var tasks: Array<Tasks> = []

    @IBOutlet var cards: UICollectionView!
    let cellScaling: CGFloat = 0.75
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = floor(screenSize.width * cellScaling)
        let cellHeight = floor(screenSize.height * cellScaling)
        
        let insetX = (view.bounds.width - cellWidth)/2.0
        let insetY = (view.bounds.height - cellHeight)/2.0
        
        let layout = cards.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        cards.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
        
        self.cards.delegate = self
        self.cards.dataSource = self
        
        var profileImgUrl: String = ""
        var xp: Int = 0
        var coins: Int = 0
        
        if let complexCache = DataCache.sharedInstance.cache["complexObject"] {
            tasks = (ComplexObject(JSONString: complexCache).tasks)!
            profileImgUrl = (ComplexObject(JSONString: complexCache).studentProfile?.profileImage)!
            xp = (ComplexObject(JSONString: complexCache).studentProfile?.experiencePoints)!
            coins = (ComplexObject(JSONString: complexCache).studentProfile?.coins)!
        }
        
        //inserting image from url async
        let url = URL(string: profileImgUrl)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                if data != nil {
                    self.profileBtn.setBackgroundImage(UIImage(data: data!), for: .normal)
                } else {
                    self.profileBtn.setBackgroundImage(UIImage(named: "coins"), for: .normal)
                }
                
            }
        }
        profileBtn = makeButtonRound(button: profileBtn, borderWidth: 2, color: UIColor.white)
        
        //set userpoints in toolbar
        coinsBtn.setTitle(" " + String(coins), for: .normal)
        experiencePoints.text = String(xp)
        
           }
    
    func makeButtonRound(button: UIButton, borderWidth: CGFloat, color: UIColor)-> UIButton{
        button.layer.cornerRadius = button.frame.width/2
        button.layer.masksToBounds = true
        button.layer.borderWidth = borderWidth
        button.layer.borderColor = color.cgColor
        
        return button
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if tasks[indexPath.row].itemType == "LESSON_PRESENTATION" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "presentationCell", for: indexPath) as! PresentationCell
            
            cell.headerLabel.text = tasks[indexPath.row].header
            cell.titleLabel.text = tasks[indexPath.row].title
            cell.descriptionLabel.text = tasks[indexPath.row].description
            loadImageAsync(url: tasks[indexPath.row].imageURL!, imgView: cell.lessonImage)
            cell.videoImg.isHidden = true
            
            
            return cell
        } else if tasks[indexPath.row].itemType == "CLASSROOM_SESSION_STUDENT" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "assessmentCell", for: indexPath) as! AssessmentCell
            
            cell.headerLabel.text = tasks[indexPath.row].header
            cell.titleLabel.text = tasks[indexPath.row].title
            loadImageAsync(url: tasks[indexPath.row].imageURL!, imgView: cell.assessmentImg)
            cell.descriptionLabel.text = tasks[indexPath.row].classRoomName
            
            if let hrs = tasks[indexPath.row].durationHours {
                
                cell.numOfQuesLabel.text = String(hrs) + " hrs"
            }
            cell.quesText.text = "Duration"
            if let y = tasks[indexPath.row].classRoomId {
                cell.pointsLabel.text = "#" + String(y)
            }
            cell.xpText.text = "classRoom Id"
            cell.durationLabel.text = getSubstring(str: tasks[indexPath.row].time!, startOffest: 0, endOffset: -3)
            cell.timeText.text = "Time"
            
            cell.startBtn.setTitle("START CLASS", for: .normal)
            
            
            return cell
        } else if tasks[indexPath.row].itemType == "ASSESSMENT" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "assessmentCell", for: indexPath) as! AssessmentCell
            
            cell.headerLabel.text = tasks[indexPath.row].header
            cell.titleLabel.text = tasks[indexPath.row].title
            if tasks[indexPath.row].imageURL != nil {
                loadImageAsync(url: tasks[indexPath.row].imageURL!, imgView: cell.assessmentImg)
            }
            cell.descriptionLabel.text = tasks[indexPath.row].description
            
            if let ques = tasks[indexPath.row].numberOfQuestions {
                
                cell.numOfQuesLabel.text = String(ques)
            }
            cell.quesText.text = "Questions"
            if let y = tasks[indexPath.row].itemPoints {
                cell.pointsLabel.text = String(y)
            }
            cell.xpText.text = "Experience"
            if let dur = tasks[indexPath.row].duration {
                cell.durationLabel.text = String(dur)
            }
            
            cell.timeText.text = "Duration"
            
            cell.startBtn.setTitle("START ASSESSMENT", for: .normal)
            
            return cell
            
        }else if tasks[indexPath.row].itemType == "LESSON_VIDEO"{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "presentationCell", for: indexPath) as! PresentationCell
            
            cell.headerLabel.text = tasks[indexPath.row].header
            cell.titleLabel.text = tasks[indexPath.row].title
            cell.descriptionLabel.text = tasks[indexPath.row].description
            loadImageAsync(url: tasks[indexPath.row].imageURL!, imgView: cell.lessonImage)
            
            cell.videoImg.isHidden = false
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "presentationCell", for: indexPath) as! PresentationCell
            
            return cell
        }
        
        
    }

}
extension TasksVC: UICollectionViewDelegate, UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = cards.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left)/cellWidthIncludingSpacing
        
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
        
        
    }
    
    
}


