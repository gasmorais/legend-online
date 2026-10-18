package mvc.module.outyard
{
   import com.road.yishi.proto.shuttle.ArcaneZoneMsg;
   import com.road.yishi.proto.shuttle.ShuttleInfoMsg;
   import flash.utils.Dictionary;
   import yishi.datas.templates.OutyardShuttleRewardTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   
   public class OutyardShuttleModel
   {
      
      private var _shuttleMsg:ShuttleInfoMsg;
      
      private var _arcaneMsg:ArcaneZoneMsg;
      
      public function OutyardShuttleModel()
      {
         super();
      }
      
      public function shuttleHandler(param1:ShuttleInfoMsg) : void
      {
         if(!_shuttleMsg)
         {
            _shuttleMsg = param1;
         }
         _shuttleMsg.op = param1.op;
         _shuttleMsg.currentDifficulty = param1.currentDifficulty;
         _shuttleMsg.petList = param1.petList;
         _shuttleMsg.petHpPercent = param1.petHpPercent;
         _shuttleMsg.fightPet = param1.fightPet;
         _shuttleMsg.areaLeftCount = param1.areaLeftCount;
         _shuttleMsg.rewardState = param1.rewardState;
         _shuttleMsg.arcaneZoneCount = param1.arcaneZoneCount;
         _shuttleMsg.shuttleScore = param1.shuttleScore;
         _shuttleMsg.resetCount = param1.resetCount;
         _shuttleMsg.refreshCount = param1.refreshCount;
         if(param1.op == 1)
         {
            NotificationManager.instance.dispatchEvent(new NotificationEvent("CLICK_SHUTTLE_VIEW"));
         }
         else
         {
            NotificationManager.instance.dispatchEvent(new NotificationEvent("UPDATE_SHUTTLE_VIEW"));
         }
      }
      
      public function arcaneHandler(param1:ArcaneZoneMsg) : void
      {
         if(!_arcaneMsg)
         {
            _arcaneMsg = param1;
         }
         _arcaneMsg.op = param1.op;
         _arcaneMsg.bossList = param1.bossList;
         _arcaneMsg.arcaneZoneCount = param1.arcaneZoneCount;
         _arcaneMsg.arcaneZoneBuyCount = param1.arcaneZoneBuyCount;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("UPDATE_ARCANE_VIEW"));
      }
      
      public function get shuttleMsg() : ShuttleInfoMsg
      {
         return _shuttleMsg;
      }
      
      public function set shuttleMsg(param1:ShuttleInfoMsg) : void
      {
         _shuttleMsg = param1;
      }
      
      public function get chestList() : Array
      {
         var _loc1_:Array = [];
         var _loc3_:Dictionary = TempleteManager.instance.outyardShuttleRewardTemplateCate.getTemplates();
         for each(var _loc2_:OutyardShuttleRewardTemplateInfo in _loc3_)
         {
            if(_loc2_.Difficulty == _shuttleMsg.currentDifficulty)
            {
               _loc1_.push(_loc2_);
            }
         }
         _loc1_.sortOn("ShuttleScore",16);
         return _loc1_;
      }
      
      public function getRemoteHpById(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = -1;
         _loc2_ = 0;
         while(_loc2_ < _shuttleMsg.petList.length)
         {
            if(_shuttleMsg.petList[_loc2_] == param1)
            {
               _loc3_ = _loc2_;
            }
            _loc2_++;
         }
         return _shuttleMsg.petHpPercent[_loc3_];
      }
      
      public function get maxShuttleScore() : int
      {
         var _loc2_:Array = chestList;
         var _loc1_:OutyardShuttleRewardTemplateInfo = chestList[chestList.length - 1];
         return _loc1_.ShuttleScore;
      }
      
      public function get fightPetHp() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = -1;
         _loc1_ = 0;
         while(_loc1_ < _shuttleMsg.petList.length)
         {
            if(_shuttleMsg.petList[_loc1_] == _shuttleMsg.fightPet)
            {
               _loc2_ = _loc1_;
            }
            _loc1_++;
         }
         return _shuttleMsg.petHpPercent[_loc2_];
      }
      
      public function get arcaneMsg() : ArcaneZoneMsg
      {
         return _arcaneMsg;
      }
      
      public function set arcaneMsg(param1:ArcaneZoneMsg) : void
      {
         _arcaneMsg = param1;
      }
   }
}

