package yishi.datas.ai
{
   import flash.events.EventDispatcher;
   import map.campaign.CampaignManager;
   import yishi.events.AiEvents;
   import yishi.utils.WorldBossHelper;
   
   public class AIBaseInfo extends EventDispatcher
   {
      
      private var _pathInfo:Array;
      
      private var _walkIndex:int;
      
      private var _nextIndex:int;
      
      private var _moveState:int;
      
      private var _speed:Number = 5;
      
      private var _isLiving:Boolean = true;
      
      private var _willWalkDis:Number = 0;
      
      public var moveOverState:int;
      
      public var totalFrame:uint;
      
      public var currentFrame:uint;
      
      public function AIBaseInfo()
      {
         super();
      }
      
      public function get isLiving() : Boolean
      {
         return _isLiving;
      }
      
      public function set isLiving(param1:Boolean) : void
      {
         if(_isLiving == param1)
         {
            return;
         }
         _isLiving = param1;
         dispatchEvent(new AiEvents("isLiving",param1));
      }
      
      public function get speed() : Number
      {
         return _speed;
      }
      
      public function set speed(param1:Number) : void
      {
         if(WorldBossHelper.checkIsNoviceMap(CampaignManager.instance.mapId))
         {
            param1 = 10;
         }
         if(_speed == param1)
         {
            return;
         }
         _speed = param1;
         dispatchEvent(new AiEvents("updateSpeed",_speed));
      }
      
      public function get nextIndex() : int
      {
         return _nextIndex;
      }
      
      public function get walkIndex() : int
      {
         return _walkIndex;
      }
      
      public function set walkIndex(param1:int) : void
      {
         if(_walkIndex == param1)
         {
            return;
         }
         _walkIndex = param1;
      }
      
      public function get walkIndexToNext() : int
      {
         _walkIndex = _walkIndex + 1;
         _nextIndex = _walkIndex - 1;
         dispatchEvent(new AiEvents("nextPoint",_nextIndex));
         return _nextIndex;
      }
      
      private function resetFrame() : void
      {
         this.currentFrame = 0;
         this.totalFrame = 0;
      }
      
      public function sysInfo(param1:AIBaseInfo) : void
      {
         this.isLiving = param1.isLiving;
         this._pathInfo = param1.pathInfo;
         this.speed = param1.speed;
         this._walkIndex = param1.walkIndex;
         this.moveState = param1.moveState;
         this.currentFrame = param1.currentFrame;
         this.totalFrame = param1.totalFrame;
      }
      
      public function get willWalkDis() : Number
      {
         return _willWalkDis;
      }
      
      public function set willWalkDis(param1:Number) : void
      {
         _willWalkDis = param1;
      }
      
      public function get pathInfo() : Array
      {
         return _pathInfo;
      }
      
      public function set pathInfo(param1:Array) : void
      {
         _walkIndex = 1;
         _willWalkDis = 0;
         resetFrame();
         _pathInfo = param1;
         dispatchEvent(new AiEvents("updatePaths",_pathInfo));
      }
      
      public function get moveState() : int
      {
         return _moveState;
      }
      
      public function set moveState(param1:int) : void
      {
         _moveState = param1;
         dispatchEvent(new AiEvents("moveState",_moveState));
      }
   }
}

