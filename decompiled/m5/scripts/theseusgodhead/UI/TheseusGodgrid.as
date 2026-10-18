package theseusgodhead.UI
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Graphics;
   import flash.display.Sprite;
   
   public class TheseusGodgrid extends Sprite
   {
      
      protected var _TheseusGodHeadviewicon1:Bitmap;
      
      protected var _TheseusGodHeadviewicon2:Bitmap;
      
      protected var _stoneBitmap:Bitmap;
      
      protected var _highlightMask:Sprite;
      
      private var _pos:int = -1;
      
      private var _selected:Boolean = false;
      
      private var _unlocked:Boolean = true;
      
      private var _highlight:Boolean = false;
      
      public function TheseusGodgrid()
      {
         super();
         initView();
         buttonMode = true;
         mouseChildren = false;
      }
      
      protected function initView() : void
      {
         _TheseusGodHeadviewicon1 = ComponentFactory.Instance.creatBitmap("TheseusGodHeadviewicon1");
         _TheseusGodHeadviewicon2 = ComponentFactory.Instance.creatBitmap("TheseusGodHeadviewicon2");
         _highlightMask = new Sprite();
         var _loc1_:Graphics = _highlightMask.graphics;
         _loc1_.beginFill(65280,0.5);
         _loc1_.drawRect(0,0,60,60);
         _loc1_.endFill();
         _highlightMask.visible = false;
         addChild(_TheseusGodHeadviewicon1);
         addChild(_TheseusGodHeadviewicon2);
         addChild(_highlightMask);
         updateDisplay();
      }
      
      public function set unlocked(param1:Boolean) : void
      {
         _unlocked = param1;
         updateDisplay();
      }
      
      public function get unlocked() : Boolean
      {
         return _unlocked;
      }
      
      public function set highlight(param1:Boolean) : void
      {
         _highlight = param1;
         if(_highlightMask)
         {
            _highlightMask.visible = param1 && _unlocked;
         }
      }
      
      public function get highlight() : Boolean
      {
         return _highlight;
      }
      
      protected function updateDisplay() : void
      {
         if(_TheseusGodHeadviewicon1)
         {
            _TheseusGodHeadviewicon1.visible = _unlocked;
         }
         if(_TheseusGodHeadviewicon2)
         {
            _TheseusGodHeadviewicon2.visible = !_unlocked;
         }
         this.buttonMode = _unlocked;
         this.alpha = _unlocked ? 1 : 0.5;
      }
      
      public function set pos(param1:int) : void
      {
         _pos = param1;
      }
      
      public function get pos() : int
      {
         return _pos;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_TheseusGodHeadviewicon1);
         _TheseusGodHeadviewicon1 = null;
         ObjectUtils.disposeObject(_TheseusGodHeadviewicon2);
         _TheseusGodHeadviewicon2 = null;
         _stoneBitmap = null;
         if(_highlightMask)
         {
            if(_highlightMask.parent)
            {
               removeChild(_highlightMask);
            }
            _highlightMask = null;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

