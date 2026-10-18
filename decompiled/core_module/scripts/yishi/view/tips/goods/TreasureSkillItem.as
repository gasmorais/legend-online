package yishi.view.tips.goods
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import yishi.datas.templates.SkillTempInfo;
   
   public class TreasureSkillItem extends Sprite implements Disposeable
   {
      
      private var _flagImg:Bitmap;
      
      private var _txt:FilterFrameText;
      
      public function TreasureSkillItem()
      {
         super();
         _flagImg = ComponentFactory.Instance.creatBitmap("asset.tips.attributeFlag");
         _txt = ComponentFactory.Instance.creatComponentByStylename("tips.treasureSkillItem.txt");
         addChild(_flagImg);
         addChild(_txt);
      }
      
      public function set data(param1:SkillTempInfo) : void
      {
         _txt.text = param1.Description;
         _txt.setFrame(param1.ProperType);
      }
      
      public function dispose() : void
      {
         if(_flagImg)
         {
            ObjectUtils.disposeObject(_flagImg);
         }
         _flagImg = null;
         if(_txt)
         {
            _txt.dispose();
         }
         _txt = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

