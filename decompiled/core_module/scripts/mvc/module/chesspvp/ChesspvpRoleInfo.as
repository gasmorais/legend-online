package mvc.module.chesspvp
{
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   
   public class ChesspvpRoleInfo
   {
      
      public var livingID:int;
      
      public var userID:int;
      
      public var servername:String;
      
      public var nikeName:String;
      
      public var team:int;
      
      public var currPos:int;
      
      public var targetPos:int;
      
      public var chessType:int;
      
      public var reiverTime:int;
      
      public var firstMove:Boolean = false;
      
      public var movePassTime:int;
      
      public var needMoveTime:int;
      
      public var color:int;
      
      private var _movePassTimeUid:int;
      
      private var _currMoveTimeUid:int;
      
      private var _reiverCdUid:int;
      
      private var _waitCdUid:int;
      
      private var _state:int;
      
      private var _hasMoveTime:int;
      
      private var _currMoveTime:int;
      
      private var _reiverCd:int;
      
      private var _waitCd:int;
      
      private var _lvKey:String;
      
      public var totalFrame:int = 0;
      
      public var currFrame:int = 0;
      
      public function ChesspvpRoleInfo()
      {
         super();
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function set state(param1:int) : void
      {
         if(_state == param1)
         {
            return;
         }
         _state = param1;
         if(_state == 1)
         {
            currMoveTime = needMoveTime - movePassTime;
            _hasMoveTime = movePassTime;
            updateMovePassTime();
         }
         else
         {
            clearInterval(_movePassTimeUid);
            clearInterval(_currMoveTimeUid);
            _hasMoveTime = 0;
            _currMoveTime = 0;
         }
      }
      
      public function get hasMoveTime() : int
      {
         return _hasMoveTime;
      }
      
      public function updateMovePassTime() : void
      {
         if(_hasMoveTime >= needMoveTime)
         {
            clearInterval(_movePassTimeUid);
         }
         else
         {
            clearInterval(_movePassTimeUid);
            _movePassTimeUid = setInterval(autoMovePassCd,1000);
         }
      }
      
      private function autoMovePassCd() : void
      {
         _hasMoveTime += 1000;
         if(_hasMoveTime >= needMoveTime)
         {
            clearInterval(_movePassTimeUid);
         }
      }
      
      public function get currMoveTime() : int
      {
         return _currMoveTime / 1000;
      }
      
      public function set currMoveTime(param1:int) : void
      {
         if(_currMoveTime == param1)
         {
            return;
         }
         _currMoveTime = param1;
         if(_currMoveTime <= 0)
         {
            clearInterval(_currMoveTimeUid);
         }
         else
         {
            clearInterval(_currMoveTimeUid);
            _currMoveTimeUid = setInterval(autoCurrMoveCd,1000);
         }
      }
      
      private function autoCurrMoveCd() : void
      {
         _currMoveTime -= 1000;
         if(_currMoveTime < 0)
         {
            _currMoveTime = 0;
            clearInterval(_currMoveTimeUid);
         }
      }
      
      public function get reiverCd() : int
      {
         return _reiverCd / 1000;
      }
      
      public function set reiverCd(param1:int) : void
      {
         if(_reiverCd == param1)
         {
            return;
         }
         _reiverCd = param1;
         if(_reiverCd <= 0)
         {
            clearInterval(_reiverCdUid);
         }
         else
         {
            clearInterval(_reiverCdUid);
            _reiverCdUid = setInterval(autoReiverCd,1000);
         }
      }
      
      private function autoReiverCd() : void
      {
         _reiverCd -= 1000;
         if(_reiverCd < 0)
         {
            _reiverCd = 0;
            clearInterval(_reiverCdUid);
         }
      }
      
      public function get waitCd() : int
      {
         return _waitCd / 1000;
      }
      
      public function set waitCd(param1:int) : void
      {
         if(_waitCd == param1)
         {
            return;
         }
         _waitCd = param1;
         if(_waitCd <= 0)
         {
            clearInterval(_waitCdUid);
         }
         else
         {
            clearInterval(_waitCdUid);
            _waitCdUid = setInterval(autoWaitCd,1000);
         }
      }
      
      private function autoWaitCd() : void
      {
         _waitCd -= 1000;
         if(_waitCd < 0)
         {
            _waitCd = 0;
            clearInterval(_waitCdUid);
         }
      }
      
      public function get lvKey() : String
      {
         if(_lvKey == null)
         {
            _lvKey = userID + "_" + servername;
         }
         return _lvKey;
      }
      
      public function clean() : void
      {
         clearInterval(_movePassTimeUid);
         clearInterval(_currMoveTimeUid);
         clearInterval(_reiverCdUid);
         clearInterval(_waitCdUid);
      }
   }
}

