package thessTower.view
{
   import com.pickgliss.ui.controls.ISelectable;
   import flash.display.DisplayObject;
   import manager.LanguageMgr;
   import thessTower.UI.ThessTowerCardItemUI;
   
   public class ThesstowerCardItem extends ThessTowerCardItemUI implements ISelectable
   {
      
      private var _state:int = -1;
      
      private var _idxNum:int = -1;
      
      private var _selected:Boolean;
      
      public function ThesstowerCardItem()
      {
         super();
         _cardBg.setFrame(2);
      }
      
      public function set idxNum(param1:int) : void
      {
         if(_idxNum == param1)
         {
            return;
         }
         _idxNum = param1;
         _idx.text = LanguageMgr.GetTranslation("thesstower.idx",_idxNum);
      }
      
      public function get idxNum() : int
      {
         return this._idxNum;
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function set state(param1:int) : void
      {
         if(_state == param1)
         {
            return;
         }
         _cardPass.visible = false;
         _lock.visible = false;
         _in.visible = false;
         _state = param1;
         mouseEnabled = false;
         mouseChildren = false;
         switch(_state)
         {
            case 0:
               _lock.visible = true;
               break;
            case 1:
               _in.visible = true;
               mouseEnabled = true;
               mouseChildren = true;
               break;
            case 2:
               _in.visible = true;
               _cardPass.visible = true;
               mouseEnabled = true;
               mouseChildren = true;
         }
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         if(_selected == param1)
         {
            return;
         }
         _selected = param1;
         _cardBg.setFrame(_selected ? 1 : 2);
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}

