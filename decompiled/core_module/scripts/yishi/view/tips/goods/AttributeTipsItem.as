package yishi.view.tips.goods
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class AttributeTipsItem extends Sprite implements Disposeable
   {
      
      private var _flagImg:Bitmap;
      
      private var _attributeTxt:FilterFrameText;
      
      public function AttributeTipsItem()
      {
         super();
         _flagImg = ComponentFactory.Instance.creatBitmap("asset.tips.attributeFlag");
         _attributeTxt = ComponentFactory.Instance.creatComponentByStylename("tips.attributeTxt");
         addChild(_flagImg);
         addChild(_attributeTxt);
      }
      
      public function setData(param1:String, param2:int) : void
      {
         _attributeTxt.htmlText = param1;
         _attributeTxt.setFrame(param2);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_flagImg);
         _flagImg = null;
         ObjectUtils.disposeObject(_attributeTxt);
         _attributeTxt = null;
      }
   }
}

