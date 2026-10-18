package map.outercity.mediator.layer
{
   import com.pickgliss.toplevel.StageReferance;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import map.internals.data.MapPhysics;
   import map.internals.event.OuterCityEvent;
   import yishi.interfaces.IMediator;
   
   public class OutercityNpcActivationMediator implements IMediator
   {
      
      private var _target:Object;
      
      public function OutercityNpcActivationMediator()
      {
         super();
      }
      
      public static function checkOutScene(param1:Object, param2:Rectangle, param3:Object) : Boolean
      {
         var _loc4_:Point = null;
         var _loc5_:Boolean = false;
         if(!param1)
         {
            return _loc5_;
         }
         if(param2)
         {
            if(param2.x > 5000 || param2.y > 5000)
            {
               _loc4_ = param3.localToGlobal(new Point(param1.x,param1.y));
               param2.x = _loc4_.x;
               param2.y = _loc4_.y;
               _loc4_ = null;
            }
            if(param2.x - param2.width <= StageReferance.stageWidth)
            {
               if(param2.y - param2.height <= StageReferance.stageHeight)
               {
                  if(param2.x + param2.width >= 0)
                  {
                     if(param2.y + param2.height >= 0)
                     {
                        _loc5_ = true;
                     }
                  }
               }
            }
         }
         return _loc5_;
      }
      
      public function register(param1:Object) : void
      {
         _target = param1;
         param1.addEventListener("DRAG_SCENE_END",__dragScneHandler);
      }
      
      public function unregister(param1:Object) : void
      {
         param1.removeEventListener("DRAG_SCENE_END",__dragScneHandler);
      }
      
      private function __dragScneHandler(param1:OuterCityEvent) : void
      {
         var _loc3_:* = param1.data;
         for each(var _loc2_ in _loc3_)
         {
            outSceneMoviesImp(_loc2_);
         }
      }
      
      private function outSceneMoviesImp(param1:*) : void
      {
         var _loc7_:* = null;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:DisplayObject = null;
         var _loc6_:Boolean = false;
         for each(var _loc5_:Object in param1)
         {
            if(_loc5_ is MapPhysics)
            {
               if(!_loc5_ || !_loc5_.nodeView)
               {
                  continue;
               }
               _loc4_ = _loc5_.nodeView;
            }
            else
            {
               _loc4_ = _loc5_ as Sprite;
            }
            _loc6_ = checkOutScene(_loc4_,_loc4_.getBounds(StageReferance.stage),_target);
            _loc4_["isPlaying"] = _loc6_;
            if(_loc6_)
            {
               _loc2_++;
            }
         }
      }
   }
}

