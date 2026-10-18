package yishi.view.tips.goods
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class TreasureAttributeItem extends Sprite implements Disposeable
   {
      
      private var _flagImg:Bitmap;
      
      private var _attributeName:FilterFrameText;
      
      private var _attributeValue:FilterFrameText;
      
      public function TreasureAttributeItem()
      {
         super();
         _flagImg = ComponentFactory.Instance.creatBitmap("asset.tips.attributeFlag");
         _attributeName = ComponentFactory.Instance.creatComponentByStylename("tips.treasureAttributeItem.name");
         _attributeValue = ComponentFactory.Instance.creatComponentByStylename("tips.treasureAttributeItem.value");
         addChild(_flagImg);
         addChild(_attributeName);
         addChild(_attributeValue);
      }
      
      public function updateText(param1:String, param2:String) : void
      {
         _attributeName.text = param1;
         _attributeValue.text = param2;
         _attributeValue.x = _attributeName.x + _attributeName.textWidth + 15;
      }
      
      public function dispose() : void
      {
         if(_flagImg)
         {
            ObjectUtils.disposeObject(_flagImg);
         }
         _flagImg = null;
         if(_attributeName)
         {
            _attributeName.dispose();
         }
         _attributeName = null;
         if(_attributeValue)
         {
            _attributeValue.dispose();
         }
         _attributeValue = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

