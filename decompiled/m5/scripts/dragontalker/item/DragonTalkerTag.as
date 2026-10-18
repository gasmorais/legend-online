package dragontalker.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class DragonTalkerTag extends Sprite
   {
      
      private var _idxBitBack:Bitmap;
      
      private var _idxBit:Bitmap;
      
      private var _idx:int;
      
      public function DragonTalkerTag(param1:int)
      {
         super();
         _idx = param1;
         initView();
      }
      
      private function initView() : void
      {
         _idxBitBack = ComponentFactory.Instance.creatBitmap("asset.DragonTalkerSkillItemView.cvTag");
         _idxBit = ComponentFactory.Instance.creatBitmap("asset.DragonTalkerSkillItemView.c" + _idx);
         _idxBit.x = 18;
         _idxBit.y = 70;
         addChild(_idxBitBack);
         addChild(_idxBit);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_idxBitBack);
         _idxBitBack = null;
         ObjectUtils.disposeObject(_idxBit);
         _idxBit = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

