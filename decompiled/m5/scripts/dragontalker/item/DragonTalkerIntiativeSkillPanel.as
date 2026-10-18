package dragontalker.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   
   public class DragonTalkerIntiativeSkillPanel extends Sprite
   {
      
      private var _item:DragonTalkerSkillGroupItem;
      
      private var _tag:DragonTalkerTag;
      
      private var _hLineBit:Bitmap;
      
      private var _idx:int;
      
      public function DragonTalkerIntiativeSkillPanel(param1:int)
      {
         super();
         _idx = param1;
         initView();
      }
      
      private function initView() : void
      {
         _item = new DragonTalkerSkillGroupItem();
         _tag = new DragonTalkerTag(_idx);
         _hLineBit = ComponentFactory.Instance.creatBitmap("asset.DragonTalkerSkillItemView.cline");
         addChild(_tag);
         addChild(_item);
         addChild(_hLineBit);
      }
      
      public function refreshViewByList(param1:Array) : void
      {
         _item.creatItems(param1);
         var _loc2_:Rectangle = _item.getBounds(_item);
         _hLineBit.y = _loc2_.y + _loc2_.height + 15;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_hLineBit);
         _hLineBit = null;
         ObjectUtils.disposeObject(_tag);
         _tag = null;
         ObjectUtils.disposeObject(_item);
         _item = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

