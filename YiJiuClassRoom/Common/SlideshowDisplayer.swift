//
//  SlideshowDisplayer.swift
//  YiJiuClassRoom
//
//  Created by mac-lulu on 2018/11/16.
//  Copyright © 2018年 mac-lulu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - SlideshowDisplayerDataSource 轮播图数据源协议
protocol SlideshowDisplayerDataSource: NSObjectProtocol {
    
    /// 获取展示图片数
    ///
    /// - Parameter displayer: SlideshowDisplayer 显示器
    /// - Returns: 图片数量
    func numberOfImagesInDisplayer(displayer: SlideshowDisplayer) -> Int
    
    /// 加载图片资源
    ///
    /// - Parameters:
    ///   - dispalyer: SlideshowDisplayer 显示器
    ///   - imageView: imageView
    ///   - index: 索引
    /// - Returns: Void
    func dispalyer(_ dispalyer: SlideshowDisplayer, loadImage imageView: UIImageView,forIndex index:Int ) -> Void
}

// MARK: - SlideshowDisplayerDelegate 轮播图事件代理协议
protocol SlideshowDisplayerDelegate: NSObjectProtocol {
    
    /// 图片切换时触发事件
    ///
    /// - Parameters:
    ///   - dispalyer: SlideshowDisplayer 显示器
    ///   - index: 当前索引
    /// - Returns: Void
    func dispalyer(_ dispalyer: SlideshowDisplayer,didDisplayImage index:Int ) -> Void
    
    /// 图片选中点击时触发事件
    ///
    /// - Parameters:
    ///   - dispalyer: SlideshowDisplayer 显示器
    ///   - index: 当前索引
    /// - Returns: Void
    func dispalyer(_ dispalyer: SlideshowDisplayer,didSelectedImage index:Int ) -> Void
}

// MARK: - 轮播图视图
class SlideshowDisplayer: UIView {
    
    /// 自动切换时间间隔
    public var timeInterVal: CGFloat = 3.0
    /// 是否需要自定义小圆点，默认NO
    public var needCustomDot: Bool = false{
        didSet{
            pageControl.needCustomDot = needCustomDot
        }
    }
    ///  小圆点之间的间距，仅限需要自定义圆点时设置，默认5个点
    public var dotSpace:CGFloat = 5.0{
        didSet{
            pageControl.dotSpace = dotSpace
        }
    }
    
    /// 数据源协议
    weak open var dataSource: SlideshowDisplayerDataSource?
    /// 事件代理
    weak open var delegate: SlideshowDisplayerDelegate?
    
    private lazy var displayer: UIScrollView = {
        let rect = self.bounds;
        let scrollView = UIScrollView(frame: rect)
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        //        scrollView.isPagingEnabled = true
        scrollView.scrollsToTop = false;
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.alwaysBounceVertical = false
        return scrollView
    }()
    
    ///  分页控件 只读
    lazy var pageControl: SlideshowPageControl = {
        let pageControl = SlideshowPageControl()
        pageControl.frame = CGRect(x: 0, y: 180, width: 320, height: 20)
        pageControl.diametter = 4.0;
        pageControl.currentPageIndicatorTintColor = UIColor.white
        pageControl.pageIndicatorTintColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.6)
        return pageControl
    }()
    
    private var imageList:[UIImageView] = []
    private var currentIndex: Int = 0
    var imgCount: Int = 0
    
    var autoTimer: Timer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.displayer)
        self.addSubview(self.pageControl)
        self.layoutDispalyer()
        self.loadAllImageViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutDispalyer() -> Void {
        let width = self.bounds.width
        let height = self.bounds.height
        self.displayer.frame = self.bounds
        self.displayer.contentSize = CGSize(width: CGFloat(3.0)*width, height: 0)
        self.displayer.contentOffset = CGPoint(x: width, y: 0)
        self.pageControl.frame = CGRect(x: 0, y: height-30, width: width, height: 30)
        self.updateFrameForImageViews()
    }
    
    func loadAllImageViews() -> Void {
        self.imageList.removeAll()
        for index in 0..<3 {
            let imageView = UIImageView()
            imageView.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapAction(_:)))
            imageView.addGestureRecognizer(tapGesture)
            imageView.imgIndex = index
            imageView.frame = self.displayer.bounds
            displayer.addSubview(imageView)
            imageList.append(imageView)
        }
    }
    
    /// 重新加载所有图片
    /// 多张图片时，默认开启自动切换模式
    public func reloadImages() -> Void{
        
        stopAutoMode()
        guard self.imageList.count > 0 else {
            return
        }
        
        for index in 0..<3 {
            let imgView = imageList[index]
            imgView.imgIndex = index
            imgView.image = nil
            imgView.setNeedsLayout()
        }
        
        self.updateFrameForImageViews()
        
        imgCount = self.dataSource?.numberOfImagesInDisplayer(displayer: self) ?? 0
        guard imgCount > 0 else {
            return
        }
        
        let width = self.bounds.width
        displayer.contentOffset = CGPoint(x: width, y: 0)
        displayer.isScrollEnabled = imgCount > 1 ? true : false
        pageControl.numberOfPages = imgCount
        pageControl.isHidden = imgCount > 1 ? false : true
        pageControl.currentPage = 0
        currentIndex = 0
        
        if imgCount > 1 {
            for index in -1...1{
                let imgView = self.imageList[index + 1]
                self.dataSource?.dispalyer(self, loadImage: imgView, forIndex: self.autoCorrection(value: index))
            }
        }else{
            let imageView = self.queryImage(withIndex: 1)
            self.dataSource?.dispalyer(self, loadImage: imageView!, forIndex: 0)
        }
        self.displayImageDidChanged()
        self.startAutoMode()
    }
    /// 开启自动切换模式
    /// 通常情况下应该调用方法reloadImages，而不是直接调用本方法
    public func startAutoMode() -> Void{
        stopAutoMode()
        if imgCount > 1 {
            self.autoTimer = Timer(timeInterval: TimeInterval(self.timeInterVal), target: self, selector: #selector(switchImageView), userInfo: nil, repeats: true)
            RunLoop.main.add(self.autoTimer!, forMode: RunLoopMode.commonModes)
        }
    }
    /// 关闭自动切换模式
    public func stopAutoMode() -> Void{
        if let timer = self.autoTimer {
            if timer.isValid {
                timer.invalidate()
            }
            self.autoTimer = nil
        }
    }
    
    func updateFrameForImageViews() -> Void {
        guard self.imageList.count > 0 else {
            return
        }
        var frame = self.displayer.bounds
        let width = frame.width
        for imgView in self.imageList{
            frame.origin.x = CGFloat(imgView.imgIndex ?? 0) * width
            imgView.frame = frame
        }
    }
    
    @objc func imageTapAction(_ tapGesture: UITapGestureRecognizer) -> Void {
        guard self.currentIndex < imgCount else {
            return
        }
        self.delegate?.dispalyer(self, didSelectedImage: self.currentIndex)
    }
    
    @objc func switchImageView() -> Void {
        let width = self.displayer.frame.width
        self.displayer.setContentOffset(CGPoint(x: 2*width, y: 0), animated: true)
    }
    
    func autoCorrection( value: Int) -> Int {
        var rValue = value
        if rValue >= imgCount {
            rValue = 0
        }
        if rValue < 0 {
            rValue = imgCount - 1
        }
        return rValue
    }
    
    func autoLoadNextImage(isNext: Bool) -> Void {
        let offset = isNext ? 1: -1
        currentIndex = self.autoCorrection(value: currentIndex + offset)
        pageControl.currentPage = currentIndex
        let imgIndex = self.autoCorrection(value: currentIndex + offset)
        for imgView in self.imageList {
            if isNext {
                imgView.reduceImageIndex()
            }else{
                imgView.increaseImageIndex()
            }
        }
        autoCopyLeftImage(copyLeft:isNext)
        displayImageDidChanged()
        visualDeception()
        guard imgCount > 3 else {
            return
        }
        
        let index = isNext ? 2 : 0
        if let imgView = self.queryImage(withIndex: index){
            self.dataSource?.dispalyer(self, loadImage: imgView, forIndex: imgIndex)
        }
    }
    
    func displayImageDidChanged() -> Void {
        self.delegate?.dispalyer(self, didDisplayImage: self.currentIndex)
    }
    
    func autoCopyLeftImage(copyLeft: Bool) -> Void {
        guard self.imgCount == 2  else {
            return
        }
        let lefeImgVeiw = self.queryImage(withIndex: 0)
        let rightImgView = self.queryImage(withIndex: 2)
        if copyLeft {
            rightImgView?.image = lefeImgVeiw?.image
        }else{
            lefeImgVeiw?.image = rightImgView?.image
        }
    }
    
    func visualDeception() -> Void {
        let width = self.displayer.frame.width
        self.displayer.setContentOffset( CGPoint(x: width, y: 0), animated: false)
        self.updateFrameForImageViews()
    }
    
    func queryImage(withIndex index: Int) -> UIImageView? {
        
        let array = imageList.filter { (imgView) -> Bool in
            return imgView.imgIndex == index
        }
        guard array.count > 0 else{
            return nil
        }
        
        return array.first
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutDispalyer()
    }
    
}

extension SlideshowDisplayer:UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.stopAutoMode()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        self.startAutoMode()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard self.imgCount > 1 else {
            return
        }
        
        let offSetX = scrollView.contentOffset.x
        let width = scrollView.frame.width
        
        if 2*width <= offSetX {
            self.autoLoadNextImage(isNext: true)
        }else if offSetX <= 0 {
            self.autoLoadNextImage(isNext: false)
        }
    }
}

// MARK: - 轮播分页控件PageControl
class SlideshowPageControl: UIPageControl {
    
    var needCustomDot: Bool = false
    var diametter: CGFloat = 5.0
    var dotSpace: CGFloat = 5.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard self.needCustomDot else {
            return
        }
        let width = self.frame.width
        let dotsWidth = (diametter+dotSpace) * CGFloat(self.numberOfPages)
        var dotImageX = (width - dotsWidth + dotSpace) * 0.5
        var frame = CGRect(x: 0, y: 0, width: diametter, height: diametter)
        
        for dotImage in self.subviews {
            dotImage.layer.cornerRadius = diametter/2.0
            dotImage.layer.masksToBounds = true
            frame.origin.x = dotImageX
            dotImage.frame = frame
            dotImageX += (diametter + dotSpace)
        }
    }
}

// MARK: - 扩展 UIImageView
private var imgIndexKey:UInt8 = 01
extension UIImageView {
    var imgIndex: Int?{
        get {
            return objc_getAssociatedObject(self, &imgIndexKey) as? Int
        }
        set {
            if let value = newValue {
                objc_setAssociatedObject(self, &imgIndexKey, value, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    func increaseImageIndex() -> Void {
        var value = (self.imgIndex ?? 0) + 1
        if value > 2 {
            value = 0
        }
        self.imgIndex = value
    }
    
    func reduceImageIndex() -> Void {
        var value = (self.imgIndex ?? 2) - 1
        if value < 0{
            value = 2
        }
        self.imgIndex = value
    }
}

extension NSObject{
    func associatedObject<ObjType: AnyObject,ValueType:AnyObject>(
        base: ObjType,
        key: UnsafePointer<UInt8>,
        initialiser: () -> ValueType)
        -> ValueType {
            if let associated = objc_getAssociatedObject(base, key)
                as? ValueType { return associated }
            let associated = initialiser()
            objc_setAssociatedObject(base, key, associated,
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return associated
    }
    
    func associateObject<ObjType: AnyObject,ValueType: AnyObject>(
        base: ObjType,
        key: UnsafePointer<UInt8>,
        value: ValueType) {
        objc_setAssociatedObject(base, key, value,
                                 .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}


