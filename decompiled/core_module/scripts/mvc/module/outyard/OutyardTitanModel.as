package mvc.module.outyard
{
   import com.road.yishi.proto.titanland.TitanlandBoosMsg;
   import com.road.yishi.proto.titanland.TitanlandOpMsg;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   
   public class OutyardTitanModel
   {
      
      public static const ResetSkill:int = 41101001;
      
      private var _titanlandMsg:TitanlandOpMsg;
      
      public function OutyardTitanModel()
      {
         super();
      }
      
      public function titanHandler(param1:TitanlandOpMsg) : void
      {
         var _loc2_:TitanlandBoosMsg = null;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         if(!_titanlandMsg)
         {
            _titanlandMsg = param1;
         }
         _titanlandMsg.op = param1.op;
         _titanlandMsg.payType = param1.payType;
         _titanlandMsg.skillIndex = param1.skillIndex;
         _titanlandMsg.fightLeftCount = param1.fightLeftCount;
         _titanlandMsg.fightAddCount = param1.fightAddCount;
         _titanlandMsg.skillCount1 = param1.skillCount1;
         _titanlandMsg.skillCount2 = param1.skillCount2;
         _titanlandMsg.skillCount3 = param1.skillCount3;
         _titanlandMsg.bossHp1 = param1.bossHp1;
         _titanlandMsg.bossHp2 = param1.bossHp2;
         _titanlandMsg.bossHp3 = param1.bossHp3;
         _titanlandMsg.bossHp4 = param1.bossHp4;
         _titanlandMsg.status = param1.status;
         _titanlandMsg.curLevel = param1.curLevel;
         _titanlandMsg.bossInfo = param1.bossInfo;
         if(param1.bossInfo)
         {
            _loc3_ = 0;
            while(_loc3_ < _titanlandMsg.bossInfo.length)
            {
               _loc2_ = _titanlandMsg.bossInfo[_loc3_];
               if(_loc2_.level == param1.curLevel)
               {
                  _loc4_++;
                  _loc2_.bossHp = param1["bossHp" + _loc4_];
               }
               else if(_loc2_.level > param1.curLevel)
               {
                  _loc2_.bossHp = 1;
               }
               else if(_loc2_.level < param1.curLevel)
               {
                  _loc2_.bossHp = 100;
               }
               _loc3_++;
            }
         }
         if(param1.op == 0)
         {
            NotificationManager.instance.dispatchEvent(new NotificationEvent("CLICK_TITAN_VIEW"));
         }
         else
         {
            NotificationManager.instance.dispatchEvent(new NotificationEvent("UPDATE_TITAN_VIEW"));
         }
      }
      
      public function getBossInfoByType(param1:int) : Array
      {
         var _loc3_:int = 0;
         var _loc2_:Array = [];
         if(!_titanlandMsg || !_titanlandMsg.bossInfo)
         {
            return _loc2_;
         }
         _loc3_ = 0;
         while(_loc3_ < _titanlandMsg.bossInfo.length)
         {
            if(_titanlandMsg.bossInfo[_loc3_].level == param1)
            {
               _loc2_.push(_titanlandMsg.bossInfo[_loc3_]);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function get titanlandMsg() : TitanlandOpMsg
      {
         return _titanlandMsg;
      }
      
      public function set titanlandMsg(param1:TitanlandOpMsg) : void
      {
         _titanlandMsg = param1;
      }
   }
}

