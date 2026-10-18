package map.internals.view.hero
{
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import events.ObjectsEvent;
   import flash.display.DisplayObjectContainer;
   import flash.geom.Point;
   import flash.utils.getTimer;
   import map.internals.constant.MapGlobal;
   import map.internals.utils.QTree;
   import yishi.datas.ai.AIBaseInfo;
   import yishi.events.AiEvents;
   
   public class AvatarBaseView extends Component
   {
      
      public var restrictMoveCount:int = 0;
      
      protected var _nextPoint:Point;
      
      protected var _prePoint:Point;
      
      protected var _info:AIBaseInfo;
      
      protected var _isStand:Boolean;
      
      private var time:int = 0;
      
      protected var _isPlaying:Boolean = true;
      
      private var mParent:DisplayObjectContainer;
      
      private var _px:Number = 0;
      
      private var _py:Number = 0;
      
      public var qtree:QTree;
      
      public function AvatarBaseView()
      {
         super();
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
      
      public function get info() : AIBaseInfo
      {
         return _info;
      }
      
      public function get isStand() : Boolean
      {
         return _isStand;
      }
      
      public function execute() : void
      {
         var _loc1_:Point = null;
         if(restrictMoveCount > 0)
         {
            restrictMoveCount = restrictMoveCount - 1;
            _isStand = true;
            return;
         }
         if(_info && _info.pathInfo && _info.pathInfo.length > _info.walkIndex)
         {
            _isStand = false;
            time = getTimer();
            if(info.currentFrame >= info.totalFrame)
            {
               _loc1_ = _info.pathInfo[info.walkIndexToNext] as Point;
               nextWalk(_loc1_);
               info.currentFrame++;
               playMovie();
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
         _isStand = true;
         _info.dispatchEvent(new ObjectsEvent("walkOver",this));
         this.dispatchEvent(new ObjectsEvent("walkOver",this));
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
         if(qtree)
         {
            qtree.remove(this,this.x,this.y);
            qtree = null;
         }
         super.dispose();
         removeEvent();
         _nextPoint = null;
         _prePoint = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
      }
      
      public function set isPlaying(param1:Boolean) : void
      {
         _isPlaying = param1;
      }
      
      public function get isPlaying() : Boolean
      {
         return _isPlaying;
      }
      
      public function get speedX() : Number
      {
         return 0;
      }
      
      public function get speedY() : Number
      {
         return 0;
      }
      
      override public function get x() : Number
      {
         return _px;
      }
      
      override public function set x(param1:Number) : void
      {
         _px = param1;
         super.x = param1;
         updateQTree();
      }
      
      override public function get y() : Number
      {
         return _py;
      }
      
      override public function set y(param1:Number) : void
      {
         _py = param1;
         super.y = param1;
         updateQTree();
      }
      
      protected function updateQTree() : void
      {
         if(!MapGlobal.qtree)
         {
            return;
         }
         if(!qtree)
         {
            qtree = MapGlobal.qtree.add(this,this.x,this.y);
         }
         else
         {
            qtree = qtree.readd(this,this.x,this.y);
         }
      }
      
      public function getTilePos() : Point
      {
         return new Point(int(this.x / 20),int(this.y / 20));
      }
      
      public function get nextPoint() : Point
      {
         return _nextPoint;
      }
      
      public function mouseHitTest() : Boolean
      {
         if(!mouseEnabled)
         {
            return false;
         }
         if(!parent)
         {
            return false;
         }
         var _loc1_:Point = this.localToGlobal(new Point(this.mouseX,this.mouseY));
         return this.hitTestPoint(_loc1_.x,_loc1_.y,true);
      }
   }
}

