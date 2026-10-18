package yishi.datas.ai
{
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import events.ObjectsEvent;
   import flash.display.DisplayObject;
   import flash.geom.Point;
   
   public class AIPhysicsBase extends Component
   {
      
      private var _actionMovie:Object;
      
      protected var _nextPoint:Point;
      
      protected var _prePoint:Point;
      
      protected var _info:AIBaseInfo;
      
      protected var _isStand:Boolean;
      
      protected var _isPlaying:Boolean = true;
      
      public function AIPhysicsBase()
      {
         super();
      }
      
      public function set info(param1:AIBaseInfo) : void
      {
         if(!_info)
         {
            _info = param1;
         }
         else
         {
            _info.sysInfo(param1);
         }
      }
      
      public function get info() : AIBaseInfo
      {
         return _info;
      }
      
      public function set movieClip(param1:DisplayObject) : void
      {
         if(_actionMovie == param1)
         {
            return;
         }
         if(_actionMovie)
         {
            _actionMovie.stop();
            if(_actionMovie.parent)
            {
               _actionMovie.parent.removeChild(_actionMovie);
            }
         }
         _actionMovie = param1;
         this.addChildAt(_actionMovie as DisplayObject,0);
         _actionMovie.play();
      }
      
      public function get movieClip() : DisplayObject
      {
         return _actionMovie as DisplayObject;
      }
      
      public function searchPath(param1:Point, param2:Point, param3:int = 0, param4:int = 0) : Array
      {
         var _loc7_:* = 0;
         var _loc5_:int = Point.distance(param1,param2) / 20;
         var _loc6_:Array = [];
         _loc7_ = 0;
         while(_loc7_ < _loc5_)
         {
            _loc6_.push(Point.interpolate(param1,param2,_loc7_ / _loc5_));
            _loc7_++;
         }
         return _loc6_.reverse();
      }
      
      public function execute() : void
      {
         var _loc1_:Point = null;
         if(_info && _info.pathInfo && _info.pathInfo.length > _info.walkIndex)
         {
            _isStand = false;
            if(info.currentFrame >= info.totalFrame)
            {
               _loc1_ = _info.pathInfo[info.walkIndexToNext] as Point;
               nextWalk(_loc1_);
            }
            else
            {
               info.currentFrame++;
               playMovie();
            }
         }
         else
         {
            if(info)
            {
               if(info.currentFrame < info.totalFrame - 1)
               {
                  info.currentFrame++;
                  playMovie();
                  return;
               }
               if(info.currentFrame == info.totalFrame - 1)
               {
                  info.currentFrame++;
                  playMovie();
               }
            }
            if(!_isStand)
            {
               walkOver();
            }
            _isStand = true;
         }
      }
      
      protected function walkOver() : void
      {
         if(_info)
         {
            _info.dispatchEvent(new ObjectsEvent("walkOver",this));
         }
      }
      
      protected function nextWalk(param1:Point) : void
      {
         checkDirection(param1);
         _prePoint = new Point(this.x,this.y);
         _nextPoint = new Point(param1.x,param1.y);
         var _loc2_:int = Point.distance(_prePoint,_nextPoint);
         info.currentFrame = 0;
         info.totalFrame = Math.floor(_loc2_ / _info.speed);
      }
      
      protected function checkDirection(param1:Point, param2:int = 1) : int
      {
         return 0;
      }
      
      protected function playMovie() : void
      {
         if(!_prePoint)
         {
            return;
         }
         var _loc1_:Point = Point.interpolate(_nextPoint,_prePoint,info.currentFrame / info.totalFrame);
         this.x = _loc1_.x;
         this.y = _loc1_.y;
      }
      
      public function get isLiving() : Boolean
      {
         if(!_info)
         {
            return false;
         }
         return _info.isLiving;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_actionMovie)
         {
            _actionMovie.stop();
            ObjectUtils.disposeObject(_actionMovie);
            _actionMovie = null;
         }
         _info = null;
         _nextPoint = null;
         _prePoint = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function set isPlaying(param1:Boolean) : void
      {
         _isPlaying = param1;
      }
      
      public function get isPlaying() : Boolean
      {
         return _isPlaying;
      }
   }
}

