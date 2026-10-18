package mvc.module.marry
{
   import com.pickgliss.ui.core.Disposeable;
   import flash.geom.Point;
   import managers.MarryManager;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   
   public class MarryCarAi implements IEnterFrame, Disposeable
   {
      
      private var _info:MarryCarInfo;
      
      private var _speed:int = 5;
      
      private var _currentFrame:int;
      
      private var _totalFrame:int;
      
      private var _isStand:Boolean;
      
      private var _nowPoint:Point;
      
      private var _nextPoint:Point;
      
      public function MarryCarAi()
      {
         super();
      }
      
      public function get info() : MarryCarInfo
      {
         return _info;
      }
      
      public function set info(param1:MarryCarInfo) : void
      {
         _info = param1;
         initAi();
      }
      
      private function initAi() : void
      {
         _nowPoint = info.pathInfo[0];
         _nextPoint = info.pathInfo[1];
         setState();
         savePos();
         EnterFrameManager.instance.registeEnterFrame(this);
      }
      
      private function setState() : void
      {
         var _loc2_:Point = new Point(_nowPoint.x * 20,_nowPoint.y * 20);
         var _loc3_:Point = new Point(_nextPoint.x * 20,_nextPoint.y * 20);
         var _loc1_:int = Point.distance(_loc2_,_loc3_);
         _currentFrame = 0;
         _totalFrame = Math.floor(_loc1_ / _speed);
      }
      
      private function nextWalk() : void
      {
         if(!_nowPoint || !_nextPoint)
         {
            walkOver();
            return;
         }
         setState();
         info.pathInfo.shift();
      }
      
      private function savePos(param1:int = 0) : void
      {
         if(!_nowPoint || !_nextPoint)
         {
            walkOver();
            return;
         }
         var _loc4_:Point = new Point(_nowPoint.x * 20,_nowPoint.y * 20);
         var _loc5_:Point = new Point(_nextPoint.x * 20,_nextPoint.y * 20);
         var _loc2_:int = Point.distance(_loc4_,_loc5_);
         var _loc3_:Point = Point.interpolate(_loc5_,_loc4_,_speed * param1 / _loc2_);
         info.firstX = _loc3_.x;
         info.firstY = _loc3_.y;
      }
      
      public function enterFrame() : void
      {
         if(info && info.pathInfo && info.pathInfo.length > 1)
         {
            _isStand = false;
            savePos(_currentFrame);
            if(_currentFrame >= _totalFrame)
            {
               _nowPoint = info.pathInfo[0];
               _nextPoint = info.pathInfo[1];
               nextWalk();
            }
            _currentFrame = _currentFrame + 1;
         }
         else
         {
            if(info)
            {
               if(_currentFrame < _totalFrame - 1)
               {
                  _currentFrame = _currentFrame + 1;
                  return;
               }
               _currentFrame = _currentFrame + 1;
            }
            if(!_isStand)
            {
               walkOver();
            }
            _isStand = true;
         }
      }
      
      private function walkOver() : void
      {
         dispose();
      }
      
      public function dispose() : void
      {
         info.isExist = false;
         MarryManager.instance.model.updateCarList(info);
         EnterFrameManager.instance.unRegisteEnterFrame(this);
      }
   }
}

