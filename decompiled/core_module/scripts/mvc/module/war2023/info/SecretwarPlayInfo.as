package mvc.module.war2023.info
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   import mvc.module.war2023.SecretWarModel;
   import yishi.manager.SecretWarManager;
   
   public class SecretwarPlayInfo extends EventDispatcher
   {
      
      public var userId:int;
      
      public var serverName:String;
      
      public var nickName:String;
      
      public var camp:int;
      
      public var curNodeId:int;
      
      public var toNodeId:int;
      
      public var moveStep:int;
      
      public var headId:int;
      
      public var job:int;
      
      public var fightUserId:int;
      
      public var fightNickName:String;
      
      public var fightServerName:String;
      
      private var _state:int = -1;
      
      private var _cdTime:int;
      
      private var _cdTimeUID:int;
      
      public var currmoveFrame:int;
      
      public var totalmoveFrame:int;
      
      public var x:Number;
      
      public var y:Number;
      
      public var currPoint:Point = new Point();
      
      public var nextPoint:Point = new Point();
      
      public var startPos:Point = new Point();
      
      public var isMoving:Boolean;
      
      private var _key:String;
      
      public function SecretwarPlayInfo()
      {
         super();
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function set state(param1:int) : void
      {
         var _loc2_:SecretWarNodeInfo = null;
         var _loc3_:Number = NaN;
         var _loc5_:int = 0;
         if(_state == param1)
         {
            return;
         }
         _state = param1;
         dispatchEvent(new Event("secretwarStateEvent"));
         if(_state == 1)
         {
            delete model.playerList[key];
            return;
         }
         var _loc4_:SecretWarNodeInfo = model.nodeInfos[curNodeId];
         currPoint.x = _loc4_.x;
         currPoint.y = _loc4_.y;
         startPos.x = _loc4_.x;
         startPos.y = _loc4_.y;
         x = currPoint.x;
         y = currPoint.y;
         if(toNodeId > 0)
         {
            _loc2_ = model.nodeInfos[toNodeId];
            nextPoint.x = _loc2_.x;
            nextPoint.y = _loc2_.y;
         }
         isMoving = false;
         if(state == 3 || state == 4 && toNodeId > 0 && moveStep > 0)
         {
            _loc3_ = moveStep / model.moveMaxStep;
            if(moveStep > 0)
            {
               startPos = Point.interpolate(nextPoint,currPoint,_loc3_);
               x = startPos.x;
               y = startPos.y;
            }
            if(state == 3)
            {
               isMoving = true;
               _loc5_ = (1 - _loc3_) * model.moveTime / 40;
               currmoveFrame = 0;
               totalmoveFrame = _loc5_;
            }
         }
      }
      
      private function get model() : SecretWarModel
      {
         return SecretWarManager.Instance.model;
      }
      
      public function set cdTime(param1:int) : void
      {
         if(_cdTime == param1)
         {
            return;
         }
         _cdTime = param1;
         if(_cdTime <= 0)
         {
            clearInterval(_cdTimeUID);
         }
         else
         {
            clearInterval(_cdTimeUID);
            if(_state != 5)
            {
               _cdTimeUID = setInterval(autoUpdateCd,1000);
            }
         }
      }
      
      private function autoUpdateCd() : void
      {
         _cdTime -= 1000;
         if(_cdTime < 0)
         {
            _cdTime = 0;
            clearInterval(_cdTimeUID);
         }
      }
      
      public function get cdTime() : int
      {
         return _cdTime / 1000;
      }
      
      public function get key() : String
      {
         _key = userId + "_" + serverName;
         return _key;
      }
      
      public function get fightKey() : String
      {
         return fightUserId + "_" + fightServerName;
      }
   }
}

