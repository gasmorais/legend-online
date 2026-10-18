package yishi.view.tips.goods
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class FashionAttItem extends Sprite implements Disposeable
   {
      
      private var _flagImg:Bitmap;
      
      private var _descTxt:FilterFrameText;
      
      public function FashionAttItem()
      {
         super();
         _flagImg = ComponentFactory.Instance.creatBitmap("asset.tips.attributeFlag");
         _descTxt = ComponentFactory.Instance.creatComponentByStylename("tips.simpleGoodSkillText");
         _descTxt.x = 14;
         addChild(_flagImg);
         addChild(_descTxt);
      }
      
      public function setData(param1:String) : void
      {
         if(param1 == "")
         {
            return;
         }
         _descTxt.htmlText = param1;
      }
      
      public function setDescWidth(param1:int) : void
      {
         _descTxt.width = param1;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_flagImg);
         ObjectUtils.disposeObject(_descTxt);
      }
   }
}

