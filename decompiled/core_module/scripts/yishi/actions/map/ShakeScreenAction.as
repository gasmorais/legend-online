package yishi.actions.map
{
   import flash.display.DisplayObject;
   import flash.geom.Point;
   import yishi.scene.SceneManager;
   
   public class ShakeScreenAction extends MapBaseAction
   {
      
      private var _obj:DisplayObject;
      
      private var _currentFrame:int;
      
      private var _prePoint:Point;
      
      public function ShakeScreenAction(param1:DisplayObject)
      {
         super();
         _obj = param1;
         _prePoint = new Point(param1.x,param1.y);
      }
      
      override public function prepare() : void
      {
         SceneManager.instance.lockScene = false;
      }
      
      override public function update() : void
      {
         if(!_obj)
         {
            dispose();
            return;
         }
         if(_currentFrame % 2 == 0)
         {
            _obj.x += 10;
            _obj.y -= 10;
         }
         else
         {
            _obj.x -= 10;
            _obj.y += 10;
         }
         _currentFrame = _currentFrame + 1;
         if(_currentFrame > 3)
         {
            dispose();
         }
      }
      
      override public function dispose() : void
      {
         _obj.x = _prePoint.x;
         _obj.y = _prePoint.y;
         _prePoint = null;
         _obj = null;
         super.dispose();
      }
   }
}

