package stage3drender.avatar
{
   import events.ObjectsEvent;
   import flash.geom.Point;
   import starling.display.Sprite;
   import yishi.datas.ai.AIBaseInfo;
   import yishi.events.AiEvents;
   
   public class MoveAbleObject extends Sprite
   {
      
      public var restrictMoveCount:int = 0;
      
      protected var _nextPoint:Point;
      
      protected var _prePoint:Point;
      
      protected var _info:AIBaseInfo;
      
      protected var _currentDirection:int = 2;
      
      protected var _currentAction:String = "S";
      
      private var _actionChange:Boolean;
      
      private var _directionChange:Boolean;
      
      protected var _preTime:Number = 0;
      
      private var _angle:Number;
      
      protected var stepX:Number = 0;
      
      protected var stepY:Number = 0;
      
      public function MoveAbleObject()
      {
         super();
      }
      
      public function get isStand() : Boolean
      {
         return _currentAction == "S";
      }
      
      protected function addEvent() : void
      {
         if(_info)
         {
            _info.addEventListener("updatePaths",__newMoveHandler);
         }
      }
      
      protected function removeEvent() : void
      {
         if(_info)
         {
            _info.removeEventListener("updatePaths",__newMoveHandler);
         }
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
      
      private function __newMoveHandler(param1:AiEvents) : void
      {
         newMove();
      }
      
      protected function newMove() : void
      {
      }
      
      public function get aiInfo() : AIBaseInfo
      {
         return _info;
      }
      
      public function get currentDirection() : int
      {
         return _currentDirection;
      }
      
      public function get currentAction() : String
      {
         return _currentAction;
      }
      
      public function execute() : void
      {
         var _loc1_:Point = null;
         if(restrictMoveCount > 0)
         {
            restrictMoveCount = restrictMoveCount - 1;
            if(_currentAction != "S")
            {
               _actionChange = true;
            }
            _currentAction = "S";
            return;
         }
         if(aiInfo && aiInfo.pathInfo && aiInfo.pathInfo.length > aiInfo.walkIndex)
         {
            if(aiInfo.currentFrame >= aiInfo.totalFrame)
            {
               if(_currentAction != "W")
               {
                  _actionChange = true;
                  _currentAction = "W";
               }
               _loc1_ = aiInfo.pathInfo[aiInfo.walkIndexToNext] as Point;
               nextWalk(_loc1_);
               aiInfo.currentFrame++;
               playMovie();
            }
            else
            {
               aiInfo.currentFrame++;
               playMovie();
            }
         }
         else
         {
            if(aiInfo)
            {
               if(aiInfo.currentFrame < aiInfo.totalFrame - 1)
               {
                  aiInfo.currentFrame++;
                  playMovie();
                  return;
               }
               if(aiInfo.currentFrame == aiInfo.totalFrame - 1)
               {
                  aiInfo.currentFrame++;
                  playMovie();
               }
            }
            if(_currentAction == "S")
            {
               return;
            }
            if(_currentAction != "S" && aiInfo && aiInfo.pathInfo && aiInfo.pathInfo.length > 0)
            {
               walkOver();
               _currentAction = "S";
               _actionChange = true;
            }
         }
         if(_actionChange || _directionChange)
         {
            _actionChange = _directionChange = false;
            action(_currentAction,_currentDirection);
         }
      }
      
      public function action(param1:String, param2:int) : void
      {
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
         _nextPoint = param1.clone();
         var _loc2_:Point = new Point(_nextPoint.x * 20 + 10,_nextPoint.y * 20 + 10);
         var _loc5_:Number = Math.atan2(_loc2_.y - this.y,_loc2_.x - this.x);
         var _loc4_:Number = _loc5_ * 180 / 3.141592653589793;
         if(_loc4_ < 0)
         {
            _loc4_ += 360;
         }
         angle = _loc4_;
         this.stepX = aiInfo.speed * Math.cos(_loc5_);
         this.stepY = aiInfo.speed * Math.sin(_loc5_);
         var _loc3_:Number = Point.distance(_loc2_,new Point(this.x,this.y));
         aiInfo.totalFrame = int(_loc3_ / aiInfo.speed);
         var _loc6_:Number = this.x + aiInfo.totalFrame * this.stepX;
         var _loc7_:Number = this.y + aiInfo.totalFrame * this.stepY;
         if(!(_loc6_ >= _nextPoint.x * 20 && _loc6_ < (_nextPoint.x + 1) * 20 && _loc7_ >= _nextPoint.y * 20 && _loc7_ < (_nextPoint.y + 1) * 20))
         {
            aiInfo.currentFrame = aiInfo.totalFrame + 1;
         }
         aiInfo.currentFrame = 0;
         if(aiInfo.totalFrame == 0)
         {
            walkOver();
            return;
         }
      }
      
      public function set angle(param1:Number) : void
      {
         _angle = checkDirection(param1);
      }
      
      protected function checkDirection(param1:Number) : int
      {
         var _loc2_:int = 0;
         var _loc3_:Number = 0;
         if(param1 >= 260 && param1 < 280)
         {
            _loc2_ = 4;
            _loc3_ = 1;
         }
         else if(param1 >= 280 && param1 < 350)
         {
            _loc2_ = 3;
            _loc3_ = 1;
         }
         else if(param1 >= 350 || param1 < 10)
         {
            _loc2_ = 2;
            _loc3_ = 1;
         }
         else if(param1 >= 10 && param1 < 80)
         {
            _loc2_ = 1;
            _loc3_ = 1;
         }
         else if(param1 >= 80 && param1 < 100)
         {
            _loc2_ = 0;
            _loc3_ = 1;
         }
         else if(param1 < 170 && param1 >= 100)
         {
            _loc2_ = 1;
            _loc3_ = -1;
         }
         else if(param1 < 190 && param1 >= 170)
         {
            _loc2_ = 2;
            _loc3_ = -1;
         }
         else if(param1 < 260 && param1 >= 190)
         {
            _loc2_ = 3;
            _loc3_ = -1;
         }
         if(_currentDirection != _loc2_ || _loc3_ != scaleX)
         {
            scaleX = _loc3_;
            _currentDirection = _loc2_;
            _directionChange = true;
         }
         return param1;
      }
      
      protected function playMovie() : void
      {
         var _loc1_:Number = 1;
         x += _loc1_ * stepX;
         y += _loc1_ * stepY;
      }
      
      public function getTilePos() : Point
      {
         return new Point(int(this.x / 20),int(this.y / 20));
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         _info = null;
         _nextPoint = null;
         _prePoint = null;
         if(parent)
         {
            parent.removeChild(this,true);
         }
      }
   }
}

