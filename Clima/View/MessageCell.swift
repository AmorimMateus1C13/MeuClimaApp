import UIKit

class MessageCell: UITableViewCell {
    
    @IBOutlet weak var OutView: UIView!
    
    @IBOutlet weak var infoView: UIView!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var bubbleHour: UIView!
    
    
    @IBOutlet weak var bubbleHumidity: UIView!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var humidityImage: UIImageView!
    

    @IBOutlet weak var bubbleMin: UIView!
    @IBOutlet weak var tempMInLabel: UILabel!
    @IBOutlet weak var minImage: UIImageView!
    
    
    @IBOutlet weak var bubbleMax: UIView!
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var maxImage: UIImageView!
    
    @IBOutlet weak var solView: UIView!
    @IBOutlet weak var sunRaiseLabel: UILabel!
    @IBOutlet weak var sunSetLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        infoView.layer.cornerRadius = infoView.frame.size.height / 5
        infoView.backgroundColor = .systemFill

        solView.layer.cornerRadius = solView.frame.size.height / 5
        solView.backgroundColor = .systemFill
        
        OutView.backgroundColor = UIColor(named: "Background")
        bubbleHour.backgroundColor = .clear
        bubbleMax.backgroundColor = .clear
        bubbleMin.backgroundColor = .clear
        bubbleHumidity.backgroundColor = .clear
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
