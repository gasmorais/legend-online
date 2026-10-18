package dragontalker.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Shape;
   
   public class DragonTalkerTab extends Component
   {
      
      private var _selecteBit:Bitmap;
      
      private var _idxBit:Bitmap;
      
      private var _shape:Shape;
      
      private var _idx:int;
      
      private var _selected:Boolean;
      
      public function DragonTalkerTab(param1:int)
      {
         super();
         _idx = param1;
         initView();
      }
      
      private function initView() : void
      {
         _selecteBit = ComponentFactory.Instance.creatBitmap("asset.DragonTalkerSkillItemView.ctab");
         _idxBit = ComponentFactory.Instance.creatBitmap("asset.DragonTalkerSkillItemView.c" + _idx);
         _shape = new Shape();
         _shape.graphics.beginFill(16711680,0);
         _shape.graphics.drawRect(0,0,_selecteBit.width,_selecteBit.height);
         _shape.graphics.endFill();
         addChild(_selecteBit);
         _selecteBit.visible = false;
         addChild(_idxBit);
         addChild(_shape);
         buttonMode = true;
         if(_idx == 6)
         {
            _idxBit.x = 8;
         }
         else
         {
            _idxBit.x = 23;
         }
         _idxBit.y = 10;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_selecteBit);
         _selecteBit = null;
         ObjectUtils.disposeObject(_idxBit);
         _idxBit = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         _selecteBit.visible = _selected;
      }
      
      public function get idx() : int
      {
         return _idx;
      }
   }
}

