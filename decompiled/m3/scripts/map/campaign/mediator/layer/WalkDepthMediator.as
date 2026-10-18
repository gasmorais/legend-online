package map.campaign.mediator.layer
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import yishi.interfaces.IEnterFrame;
   import yishi.interfaces.IMediator;
   import yishi.manager.EnterFrameManager;
   
   public class WalkDepthMediator implements IMediator, IEnterFrame
   {
      
      private var _target:Sprite;
      
      private var _tempArr:Array = [];
      
      private var _count:int;
      
      public function WalkDepthMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _target = param1 as Sprite;
         EnterFrameManager.instance.registeEnterFrame(this);
      }
      
      public function unregister(param1:Object) : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
      }
      
      public function enterFrame() : void
      {
         var _loc2_:int = 0;
         var _loc1_:DisplayObject = null;
         var _loc3_:int = 0;
         _count = _count + 1;
         if(_count % 20 != 0)
         {
            return;
         }
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
         _tempArr = _tempArr.sort(checkDepth);
         _loc3_ = 0;
         while(_loc3_ < _tempArr.length)
         {
            if(_tempArr[_loc3_].index != _loc3_)
            {
               if(_target.numChildren > _loc3_)
               {
                  _target.addChildAt(_tempArr[_loc3_].obj as DisplayObject,_loc3_);
               }
               else
               {
                  _target.addChild(_tempArr[_loc3_].obj as DisplayObject);
               }
            }
            _loc3_++;
         }
         while(_tempArr.length > 0)
         {
            _tempArr.pop();
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

