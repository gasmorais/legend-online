package dragontalker.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import yishi.filter.UIFilter;
   
   public class DragonTalkerLine extends Sprite
   {
      
      private var _type:int;
      
      private var _bit1:Bitmap;
      
      private var _bit2:Bitmap;
      
      private var _arrow:Bitmap;
      
      private var _lineWidth:int;
      
      private var _light:Boolean;
      
      private var _gray:Array;
      
      public function DragonTalkerLine()
      {
         super();
         _gray = [UIFilter.getGrayFilter()];
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
         switch(_type - 1)
         {
            case 0:
               _bit1 = ComponentFactory.Instance.creatBitmap("asset.DragonTalkerSkillItemView.chbar");
               _arrow = ComponentFactory.Instance.creatBitmap("asset.DragonTalkerSkillItemView.cArrow");
               addChild(_bit1);
               addChild(_arrow);
               break;
            case 1:
               _bit1 = ComponentFactory.Instance.creatBitmap("asset.DragonTalkerSkillItemView.czg");
               _bit2 = ComponentFactory.Instance.creatBitmap("asset.DragonTalkerSkillItemView.cvbar");
               _arrow = ComponentFactory.Instance.creatBitmap("asset.DragonTalkerSkillItemView.cArrow");
               addChild(_bit1);
               addChild(_bit2);
               addChild(_arrow);
         }
      }
      
      public function set lineWidth(param1:int) : void
      {
         _lineWidth = param1;
         _arrow.x = _lineWidth - _arrow.width;
         switch(_type - 1)
         {
            case 0:
               _bit1.width = _lineWidth - _arrow.width;
               _arrow.y = _bit1.y;
               break;
            case 1:
               _bit2.width = _lineWidth - _bit1.width - _arrow.width;
               _arrow.y = _bit2.y;
         }
      }
      
      public function set light(param1:Boolean) : void
      {
         _light = param1;
         filters = _light ? null : _gray;
         alpha = _light ? 1 : 0.15;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bit1);
         _bit1 = null;
         ObjectUtils.disposeObject(_bit2);
         _bit2 = null;
         ObjectUtils.disposeObject(_arrow);
         _arrow = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _gray = null;
      }
   }
}

