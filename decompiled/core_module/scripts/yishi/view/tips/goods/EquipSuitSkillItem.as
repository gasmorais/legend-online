package yishi.view.tips.goods
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class EquipSuitSkillItem extends Sprite implements Disposeable
   {
      
      private var _flagImg:Bitmap;
      
      private var _skillItem:FilterFrameText;
      
      public function EquipSuitSkillItem()
      {
         super();
         _flagImg = ComponentFactory.Instance.creatBitmap("asset.tips.attributeFlag");
         _skillItem = ComponentFactory.Instance.creatComponentByStylename("tips.GoodSkillText");
         addChild(_flagImg);
         addChild(_skillItem);
         _skillItem.x = 13;
         _skillItem.width = 310;
      }
      
      public function setData(param1:String) : void
      {
         _skillItem.htmlText = param1;
         _skillItem.height = _skillItem.textHeight + _skillItem.numLines * 2;
         if(_skillItem.height <= 18)
         {
            _skillItem.height = 18;
         }
      }
      
      public function setFrame(param1:int = 1) : void
      {
         _skillItem.setFrame(param1);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_flagImg);
         ObjectUtils.disposeObject(_skillItem);
      }
   }
}

