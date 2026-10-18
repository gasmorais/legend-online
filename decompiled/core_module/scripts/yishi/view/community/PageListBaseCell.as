package yishi.view.community
{
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class PageListBaseCell extends Sprite implements Disposeable
   {
      
      public var index:int = -1;
      
      private var _data:Object;
      
      public function PageListBaseCell()
      {
         super();
      }
      
      public function set data(param1:Object) : void
      {
         this._data = param1;
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      public function get selected() : Boolean
      {
         return false;
      }
      
      public function set selected(param1:Boolean) : void
      {
      }
      
      public function mouseOverHandler(param1:Event) : void
      {
      }
      
      public function mouseOutHandler(param1:Event) : void
      {
      }
      
      public function dispose() : void
      {
         _data = null;
      }
   }
}

