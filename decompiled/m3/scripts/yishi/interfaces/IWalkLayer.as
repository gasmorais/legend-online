package yishi.interfaces
{
   import flash.display.DisplayObject;
   import map.internals.view.hero.AvatarBaseView;
   
   public interface IWalkLayer extends IEnterFrame
   {
      
      function getWalkable(param1:int, param2:int) : Boolean;
      
      function getWalkLayerHeight() : int;
      
      function getWalkLayerWidth() : int;
      
      function set walkLayerHeight(param1:int) : void;
      
      function set walkLayerWidth(param1:int) : void;
      
      function addChild(param1:DisplayObject) : DisplayObject;
      
      function removeItem(param1:AvatarBaseView) : void;
      
      function addItem(param1:AvatarBaseView) : void;
   }
}

