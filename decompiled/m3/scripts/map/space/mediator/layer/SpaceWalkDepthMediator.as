package map.space.mediator.layer
{
   import yishi.interfaces.IEnterFrame;
   import yishi.interfaces.IMediator;
   import yishi.manager.EnterFrameManager;
   
   public class SpaceWalkDepthMediator implements IMediator, IEnterFrame
   {
      
      private var _target:Object;
      
      private var _tempArr:Array = [];
      
      private var _count:int;
      
      public function SpaceWalkDepthMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _target = param1;
         EnterFrameManager.instance.registeEnterFrame(this);
      }
      
      public function unregister(param1:Object) : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
      }
      
      public function enterFrame() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Object = null;
         var _loc3_:int = 0;
         _tempArr = [];
         _loc2_ = 0;
         while(_loc2_ < _target.numChildren)
         {
            _loc1_ = _target.getChildAt(_loc2_);
            _tempArr.push({
               "obj":_loc1_,
               "x":_loc1_.x,
               "y":_loc1_.y,
               "index":_loc2_
            });
            _loc2_++;
         }
         _tempArr = _tempArr.sortOn(["y","x","index"],[16,16,16]);
         _loc3_ = 0;
         while(_loc3_ < _target.numChildren)
         {
            _target.setChildIndex(_tempArr[_loc3_].obj,_loc3_);
            _loc3_++;
         }
      }
      
      private function checkDepth(param1:Object, param2:Object) : int
      {
         if(param1.y > param2.y)
         {
            return 1;
         }
         if(param1.y == param2.y)
         {
            if(param1.x < param2.x)
            {
               return -1;
            }
            if(param1.x > param2.x)
            {
               return 1;
            }
            return param1.index > param2.index ? 1 : -1;
         }
         return -1;
      }
   }
}

