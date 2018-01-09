

import UIKit

protocol CustomLayoutDelegate: class {
  func collectionView(_ collectionView:UICollectionView, sizeForPhotoAtIndexPath indexPath:IndexPath) -> CGSize
}

class CustomLayout: UICollectionViewLayout {
  weak var delegate: CustomLayoutDelegate!
  
    fileprivate var numberOfColumns = (Display.typeIsLike == .iphone7) ? 2 : 3
  fileprivate var cellPadding: CGFloat = 10
  
  fileprivate var cache = [UICollectionViewLayoutAttributes]()
  
  fileprivate var contentHeight: CGFloat = 0
  
  fileprivate var contentWidth: CGFloat {
    guard let collectionView = collectionView else {
      return 0
    }
    let insets = collectionView.contentInset
    return collectionView.bounds.width - (insets.left + insets.right)
  }
  
  override var collectionViewContentSize: CGSize {
    return CGSize(width: contentWidth, height: contentHeight)
  }
  
  override func prepare() {
    guard cache.isEmpty == true, let collectionView = collectionView else {
      return
    }
    let columnWidth = CGFloat(Utils.cellWidth)
    var xOffset = [CGFloat]()
    let spaceBetCells = (Int(contentWidth - (collectionView.contentInset.left )) - Int(columnWidth * CGFloat(numberOfColumns))) / (numberOfColumns - 1)
    for column in 0 ..< numberOfColumns {
        xOffset.append(CGFloat(column) * (columnWidth + CGFloat(spaceBetCells) + collectionView.contentInset.left))
    }
    
    var column = 0
    var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)

    for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
      
      let indexPath = IndexPath(item: item, section: 0)
       
        var  height = delegate.collectionView(collectionView, sizeForPhotoAtIndexPath: indexPath).height
        var width = delegate.collectionView(collectionView, sizeForPhotoAtIndexPath: indexPath).width

        if(indexPath.row == Utils.ad1Position)
        {
            width =  contentWidth
        }
         height = cellPadding * 2 + height
        
        let frame = CGRect(x: xOffset[column], y: yOffset[column], width: width, height: height)
        let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
        
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attributes.frame = insetFrame
        cache.append(attributes)
        contentHeight = max(contentHeight, frame.maxY)
        yOffset[column] = yOffset[column] + height
        
        column = column < (numberOfColumns - 1) ? (column + 1) : 0

        if(numberOfColumns == 3)
        {
            if(indexPath.row == Utils.ad1Position ||  indexPath.row == Utils.ad1Position + 1 )
            {
                yOffset[column] = yOffset[column] + 50 + (cellPadding*2)
            }
        }
        else
        {
            if(indexPath.row == Utils.ad1Position )
            {
                yOffset[column] = yOffset[column] + 50 + (cellPadding*2)
            }
        }
    
    }
  }
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    
    var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
    
    for attributes in cache {
      if attributes.frame.intersects(rect) {
        visibleLayoutAttributes.append(attributes)
      }
    }
    return visibleLayoutAttributes
  }
  
  override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    return cache[indexPath.item]
  }
  
}
