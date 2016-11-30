import UIKit

class CustomCollectionViewLayout: UICollectionViewLayout {

    let numberOfColumns = 8
    var itemAttributes = [[UICollectionViewLayoutAttributes]]()
    var itemsSize = [CGSize]()
    var contentSize : CGSize!
    
    override func prepare() {
        guard let sectionCount = collectionView?.numberOfSections, sectionCount > 0 else {
            return
        }
        
        if itemAttributes.count > 0 {
            for section in 0..<self.collectionView!.numberOfSections {
                let numberOfItems : Int = self.collectionView!.numberOfItems(inSection: section)
                for index in 0..<numberOfItems {
                    if section != 0 && index != 0 {
                        continue
                    }
                    
                    let attributes = self.layoutAttributesForItem(at: IndexPath(item: index, section: section))!
                    if section == 0 {
                        var frame = attributes.frame
                        frame.origin.y = self.collectionView!.contentOffset.y
                        attributes.frame = frame
                    }
                    
                    if index == 0 {
                        var frame = attributes.frame
                        frame.origin.x = self.collectionView!.contentOffset.x
                        attributes.frame = frame
                    }
                }
            }
            return
        }
        
        if self.itemsSize.count != numberOfColumns {
            self.calculateItemsSize()
        }
        
        var column = 0
        var xOffset : CGFloat = 0
        var yOffset : CGFloat = 0
        var contentWidth : CGFloat = 0
        var contentHeight : CGFloat = 0
        
        for section in 0..<self.collectionView!.numberOfSections {
            var rowAttributes = [UICollectionViewLayoutAttributes]()
            for index in 0..<numberOfColumns {
                let itemSize = (self.itemsSize[index] as AnyObject).cgSizeValue
                let indexPath = IndexPath(item: index, section: section)
                let rowAttribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                rowAttribute.frame = CGRect(x: xOffset, y: yOffset, width: (itemSize?.width)!, height: (itemSize?.height)!).integral
                
                if section == 0 && index == 0 {
                    rowAttribute.zIndex = 1024;
                } else  if section == 0 || index == 0 {
                    rowAttribute.zIndex = 1023
                }
                
                if section == 0 {
                    var frame = rowAttribute.frame
                    frame.origin.y = self.collectionView!.contentOffset.y
                    rowAttribute.frame = frame
                }
                if index == 0 {
                    var frame = rowAttribute.frame
                    frame.origin.x = self.collectionView!.contentOffset.x
                    rowAttribute.frame = frame
                }
                
               rowAttributes.append(rowAttribute)
                
                xOffset += (itemSize?.width)!
                column += 1
                
                if column == numberOfColumns {
                    if xOffset > contentWidth {
                        contentWidth = xOffset
                    }
                    
                    column = 0
                    xOffset = 0
                    yOffset += (itemSize?.height)!
                }
            }
            self.itemAttributes.append(rowAttributes)

        }

        guard let lastAttribute = itemAttributes.last?.last else {
            return
        }
        contentHeight = lastAttribute.frame.origin.y + lastAttribute.frame.size.height
        self.contentSize = CGSize(width: contentWidth, height: contentHeight)
    }
    
    override var collectionViewContentSize : CGSize {
        return self.contentSize
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return self.itemAttributes[indexPath.section][indexPath.row]
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributes = [UICollectionViewLayoutAttributes]()
        for section in self.itemAttributes {
            let filteredArray  = section.filter { rect.intersects($0.frame) }
            attributes.append(contentsOf: filteredArray)
        }

        return attributes
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    func sizeForItemWithColumnIndex(_ columnIndex: Int) -> CGSize {
        var text : String = ""
        switch (columnIndex) {
        case 0:
            text = "Col 0"
        case 1:
            text = "Col 1"
        case 2:
            text = "Col 2"
        case 3:
            text = "Col 3"
        case 4:
            text = "Col 4"
        case 5:
            text = "Col 5"
        case 6:
            text = "Col 6"
        default:
            text = "Col 7"
        }
        
        let size : CGSize = (text as NSString).size(attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 17.0)])
        let width : CGFloat = size.width + 25
        return CGSize(width: width, height: 30)
    }
    
    func calculateItemsSize() {
        for index in 0..<numberOfColumns {
            self.itemsSize.append(self.sizeForItemWithColumnIndex(index))
        }
    }
}
