package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class TheseusAttributeItem extends Sprite
   {
      
      private var _flagImg:Bitmap;
      
      private var _attributeValue:FilterFrameText;
      
      public function TheseusAttributeItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _flagImg = ComponentFactory.Instance.creatBitmap("asset.tips.attributeFlag");
         _attributeValue = ComponentFactory.Instance.creatComponentByStylename("ui.theseusAttribute.tipItemTxt");
         addChild(_flagImg);
         addChild(_attributeValue);
      }
      
      public function setTextValue(param1:String) : void
      {
         _attributeValue.htmlText = param1;
         _attributeValue.height = 20 * _attributeValue.numLines;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_flagImg);
         _flagImg = null;
         ObjectUtils.disposeObject(_attributeValue);
         _attributeValue = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

