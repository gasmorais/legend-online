package map.internals.view.layer
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import map.internals.view.hero.AvatarBaseView;
   import yishi.interfaces.IWalkLayer;
   
   public class WalkLayerBase extends Sprite implements IWalkLayer
   {
      
      private var _items:Dictionary = new Dictionary(true);
      
      public function WalkLayerBase()
      {
         super();
      }
      
      public function removeItem(param1:AvatarBaseView) : void
      {
         _items[param1] = null;
         delete _items[param1];
         var _loc2_:DisplayObject = param1 as DisplayObject;
         if(_loc2_)
         {
            if(_loc2_.parent)
            {
               _loc2_.parent.removeChild(_loc2_);
            }
         }
      }
      
      public function addItem(param1:AvatarBaseView) : void
      {
         _items[param1] = param1;
      }
      
      public function get items() : Dictionary
      {
         return _items;
      }
      
      public function getWalkable(param1:int, param2:int) : Boolean
      {
         return true;
      }
      
      public function getWalkLayerHeight() : int
      {
         return 150;
      }
      
      public function getWalkLayerWidth() : int
      {
         return 150;
      }
      
      public function set walkLayerHeight(param1:int) : void
      {
      }
      
      public function set walkLayerWidth(param1:int) : void
      {
      }
      
      public function enterFrame() : void
      {
         for each(var _loc1_:AvatarBaseView in _items)
         {
            _loc1_.execute();
         }
      }
      
      public function dispose() : void
      {
         for each(var _loc1_:AvatarBaseView in _items)
         {
            _loc1_.dispose();
            _items[_loc1_] = null;
            delete _items[_loc1_];
            _loc1_ = null;
         }
         _items = null;
      }
   }
}

