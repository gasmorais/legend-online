package yishi.view.tips.goods
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class SkillTipItem extends Sprite implements Disposeable
   {
      
      private var _flagImg:Bitmap;
      
      private var _skillTxt:FilterFrameText;
      
      public function SkillTipItem()
      {
         super();
         _flagImg = ComponentFactory.Instance.creatBitmap("asset.tips.attributeFlag");
         _skillTxt = ComponentFactory.Instance.creatComponentByStylename("tips.simpleGoodSkillText");
         _skillTxt.x = 14;
         addChild(_flagImg);
         addChild(_skillTxt);
      }
      
      public function setSkillTxt(param1:String) : void
      {
         _skillTxt.htmlText = param1;
      }
      
      public function setTxtFrame(param1:int) : void
      {
         _skillTxt.setFrame(param1);
      }
      
      public function dispose() : void
      {
         if(_flagImg)
         {
            ObjectUtils.disposeObject(_flagImg);
         }
         _flagImg = null;
         if(_skillTxt)
         {
            ObjectUtils.disposeObject(_skillTxt);
         }
         _skillTxt = null;
      }
   }
}

