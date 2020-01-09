//: A UIKit based Playground for presenting user interface
  
import UIKit

class VViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        let ham = IconCollection(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        ham.tintColor = .black
        ham.iconKind = .hamburger
        self.view.addSubview(ham)
        
        let tab = IconCollection(frame: CGRect(x: 240, y: 40, width: 30, height: 30))
        tab.tintColor = .black
        tab.iconKind = .tab
        tab.backgroundColor = .cyan
        self.view.addSubview(tab)
        
        let add = IconCollection(frame: CGRect(x: 80, y: 0, width: 30, height: 30))
        add.tintColor = .black
        add.iconKind = .add
        self.view.addSubview(add)
        
        let back = IconCollection(frame: CGRect(x: 120, y: 0, width: 30, height: 30))
        back.tintColor = .black
        back.iconKind = .back
        back.backgroundColor = .cyan
        self.view.addSubview(back)
        
        let forward = IconCollection(frame: CGRect(x: 160, y: 0, width: 30, height: 30))
        forward.tintColor = .black
        forward.iconKind = .forward
        forward.backgroundColor = .cyan
        self.view.addSubview(forward)
        
        let up = IconCollection(frame: CGRect(x: 200, y: 0, width: 30, height: 30))
        up.tintColor = .black
        up.iconKind = .up
        up.backgroundColor = .cyan
        self.view.addSubview(up)
        
        
        let down = IconCollection(frame: CGRect(x: 240, y: 0, width: 30, height: 30))
        down.tintColor = .black
        down.iconKind = .down
        down.backgroundColor = .cyan
        self.view.addSubview(down)
    }
}



enum Iconkind {
    case hamburger
    case tab
    case add
    case back
    case forward
    case up
    case down
}

protocol IconDelegate {
    func getIconlinewidth() -> CGFloat
}

extension IconDelegate {
    func getIconlinewidth() -> CGFloat {
        return 1
    }
}

class IconCollection: UIButton, IconDelegate, CAAnimationDelegate {
    
    var iconKind: Iconkind?
    var delegate: IconDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
        switch iconKind {
        case .hamburger:
            drawhamburger(rect)
        case .tab:
            drawtab(rect)
            
        case .add:
            drawadd(rect)
        case .back:
            drawback(rect)
        case .forward:
            drawforward(rect)
        case .up:
            drawup(rect)
        case .down:
            drawdown(rect)
        case .none:
            print("icon is nil")
        }
        
        
//        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.repeat], animations: {
//            self.frame.origin.x -= 50.0
//        }, completion: nil)
        
        
    }
    
    func drawhamburger(_ rect: CGRect) {
        let bz = UIBezierPath()

        let ten = rect.maxX / 10
        let twe = rect.maxX / 5

        
        //ue
        bz.move(to: CGPoint(x: rect.minX + ten, y: rect.minY + twe))
        bz.addLine(to: CGPoint(x: rect.maxX - ten, y: rect.minY + twe))
        bz.close()

        //naka
        bz.move(to: CGPoint(x: rect.minX + ten, y: rect.midY))
        bz.addLine(to: CGPoint(x: rect.maxX - ten, y: rect.midY))
        bz.close()

        //sita
        bz.move(to: CGPoint(x: rect.minX + ten, y: rect.maxY - twe))
        bz.addLine(to: CGPoint(x: rect.maxX - ten, y: rect.maxY - twe))
        bz.close()


        bz.lineWidth = ten
        bz.lineJoinStyle = .round

        bz.bounds.minX

        tintColor.setStroke()
        //bz.stroke()

        let lineLayer = CAShapeLayer()
        lineLayer.strokeColor = UIColor.red.cgColor
        lineLayer.lineWidth = ten//1.0
        lineLayer.path = bz.cgPath

//        let animation = CABasicAnimation(keyPath: "strokeEnd")
//        animation.duration = 1.0
//        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
//        animation.fromValue = -1.0
//        animation.toValue = 1.1
//        animation.fillMode = CAMediaTimingFillMode.forwards
//        animation.isRemovedOnCompletion = false
//        animation.repeatCount = 100
        
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.toValue = M_PI_4
        rotateAnimation.duration = 0.3
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.fillMode = .removed//CAMediaTimingFillMode.forwards
        self.layer.add(rotateAnimation, forKey: nil)
        rotateAnimation.repeatCount = 3

        self.layer.addSublayer(lineLayer)
        lineLayer.add(rotateAnimation, forKey: nil)
        
    }
    
    func drawtab(_ rect: CGRect) {
        let bz = UIBezierPath()
        
        let tenx = rect.maxX / 10
        let teny = rect.maxY / 10

        let lx = (rect.minX + rect.midX) / 2
        let rx = (rect.maxX + rect.midX) / 2
        let ty = (rect.minY + rect.midY) / 2
        let by = (rect.maxY + rect.midY) / 2
        
        //front square
        bz.move(to: CGPoint(x: lx - tenx, y: ty + teny))
        bz.addLine(to: CGPoint(x: lx - tenx, y: by + teny))
        bz.addLine(to: CGPoint(x: rx - tenx, y: by + teny))
        bz.addLine(to: CGPoint(x: rx - tenx, y: ty + teny))
        bz.close()
        
        
        bz.move(to: CGPoint(x: lx + tenx, y: ty))
        bz.addLine(to: CGPoint(x: lx + tenx, y: ty - teny))
        bz.close()
        
        bz.move(to: CGPoint(x: lx + tenx, y: ty - teny))
        bz.addLine(to: CGPoint(x: rx + tenx, y: ty - teny))
        bz.close()
        
        bz.move(to: CGPoint(x: rx + tenx, y: ty - teny))
        bz.addLine(to: CGPoint(x: rx + tenx, y: by - teny))
        bz.close()
        
        //bz.move(to: CGPoint(x: rx + tenx, y: ty - teny))
        bz.move(to: CGPoint(x: rx + tenx, y: by - teny))
        bz.addLine(to: CGPoint(x: rx - tenx, y: by - teny))
        bz.close()
        
        bz.lineWidth = rect.maxX / 10
        bz.lineJoinStyle = .round
            
        tintColor.setStroke()
        bz.stroke()
        
    }
    
    func drawadd(_ rect: CGRect) {
        let bz = UIBezierPath()
        
        let linewidth = rect.maxX / 10
        let padx = rect.maxX / 5
        let pady = rect.maxY / 5
        
        
        //yoko
        bz.move(to: CGPoint(x: rect.minX + padx, y: rect.midY))
        bz.addLine(to: CGPoint(x: rect.maxX - padx, y: rect.midY))
        bz.close()
            
        //tate
        bz.move(to: CGPoint(x: rect.midX, y: rect.minY + pady))
        bz.addLine(to: CGPoint(x: rect.midX, y: rect.maxY - pady))
        bz.close()
        
        bz.lineWidth = linewidth
        bz.lineJoinStyle = .round
            
        tintColor.setStroke()
        bz.stroke()
    }
    
    func drawback(_ rect: CGRect) {
        let bz = UIBezierPath()
        
        let padx = rect.maxX / 10

        let lx = (rect.minX + rect.midX) / 2
        let rx = (rect.maxX + rect.midX) / 2
        let ty = (rect.minY + rect.midY) / 2
        let by = (rect.maxY + rect.midY) / 2
        
        //ue
        bz.move(to: CGPoint(x: rx - padx, y: ty))
        bz.addLine(to: CGPoint(x: lx + padx, y: rect.midY))
        bz.close()
        
        //sita
        bz.move(to: CGPoint(x: rx - padx, y: by))
        bz.addLine(to: CGPoint(x: lx + padx, y: rect.midY))
        bz.close()
        
        
        bz.lineWidth = rect.maxX / 10
        bz.lineJoinStyle = .round
            
        tintColor.setStroke()
        bz.stroke()
        
    }
    
    func drawforward(_ rect: CGRect) {
        let bz = UIBezierPath()
        
        let padx = rect.maxX / 10

        let lx = (rect.minX + rect.midX) / 2
        let rx = (rect.maxX + rect.midX) / 2
        let ty = (rect.minY + rect.midY) / 2
        let by = (rect.maxY + rect.midY) / 2
        
        //ue
        bz.move(to: CGPoint(x: lx + padx, y: ty))
        bz.addLine(to: CGPoint(x: rx - padx, y: rect.midY))
        bz.close()
        
        //sita
        bz.move(to: CGPoint(x: lx + padx, y: by))
        bz.addLine(to: CGPoint(x: rx - padx, y: rect.midY))
        bz.close()
        
        
        bz.lineWidth = rect.maxX / 10
        bz.lineJoinStyle = .round
            
        tintColor.setStroke()
        bz.stroke()
    }
    
    func drawup(_ rect: CGRect) {
        let bz = UIBezierPath()
        
        let pady = rect.maxY / 10

        let lx = (rect.minX + rect.midX) / 2
        let rx = (rect.maxX + rect.midX) / 2
        let ty = (rect.minY + rect.midY) / 2
        let by = (rect.maxY + rect.midY) / 2
        
        //ue
        bz.move(to: CGPoint(x: lx, y: by - pady))
        bz.addLine(to: CGPoint(x: rect.midX, y: ty + pady))
        bz.close()
        
        //sita
        bz.move(to: CGPoint(x: rx, y: by - pady))
        bz.addLine(to: CGPoint(x: rect.midX, y: ty + pady))
        bz.close()
        
        
        bz.lineWidth = rect.maxX / 10
        bz.lineJoinStyle = .round
            
        tintColor.setStroke()
        bz.stroke()
    }
    
    func drawdown(_ rect: CGRect) {
        let bz = UIBezierPath()
        
        let pady = rect.maxY / 10

        let lx = (rect.minX + rect.midX) / 2
        let rx = (rect.maxX + rect.midX) / 2
        let ty = (rect.minY + rect.midY) / 2
        let by = (rect.maxY + rect.midY) / 2
        
        //ue
        bz.move(to: CGPoint(x: lx, y: ty + pady))
        bz.addLine(to: CGPoint(x: rect.midX, y: by - pady))
        bz.close()
        
        //sita
        bz.move(to: CGPoint(x: rx, y: ty + pady))
        bz.addLine(to: CGPoint(x: rect.midX, y: by - pady))
        bz.close()
        
        
        bz.lineWidth = rect.maxX / 10
        bz.lineJoinStyle = .round
            
        tintColor.setStroke()
        bz.stroke()
//        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.repeat], animations: {
//            self.frame.origin.x -= 50.0
//        }, completion: nil)
    }
}
