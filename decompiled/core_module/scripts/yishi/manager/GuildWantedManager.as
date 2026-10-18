package yishi.manager
{
   import com.road.yishi.proto.consortiawant.ConsortiaWantBoxStateMsg;
   import com.road.yishi.proto.consortiawant.ConsortiaWantMsg;
   import com.road.yishi.proto.consortiawant.ConsortiaWantRankMsg;
   import mvc.module.guildwanted.GuildWantedModel;
   import mvc.module.guildwanted.GuildWantedRankInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.MsgMan;
   
   public class GuildWantedManager
   {
      
      private static var _instance:GuildWantedManager;
      
      public static const SELF:int = 1;
      
      public static const GUILD:int = 2;
      
      public static const REWARD:int = 3;
      
      public static const REFRESHTIME:int = 2;
      
      public static const REFRESH:int = 3;
      
      public static const RECEVIE:int = 4;
      
      public static const FIGHT:int = 5;
      
      public static const WANTED_COUNT:int = 10;
      
      private var _model:GuildWantedModel;
      
      public function GuildWantedManager()
      {
         super();
      }
      
      public static function get instance() : GuildWantedManager
      {
         if(!_instance)
         {
            _instance = new GuildWantedManager();
         }
         return _instance;
      }
      
      public function get model() : GuildWantedModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         _model = new GuildWantedModel();
         addEvent();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 199,__updateConsortiaWantMsg);
      }
      
      private function __updateConsortiaWantMsg(param1:SLGSocketEvent) : void
      {
         var _loc4_:GuildWantedRankInfo = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:ConsortiaWantMsg = new ConsortiaWantMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as ConsortiaWantMsg;
         if(_loc2_.hasPersonalScore)
         {
            model.personalScore = _loc2_.personalScore;
         }
         if(_loc2_.hasConsortiaScore)
         {
            model.consortiaScore = _loc2_.consortiaScore;
         }
         if(_loc2_.hasLeftCount)
         {
            model.leftCount = _loc2_.leftCount;
         }
         if(_loc2_.hasWantGoal)
         {
            model.targetInfo.Id = _loc2_.wantGoal.id;
            model.targetInfo.starLevel = _loc2_.wantGoal.starLevel;
            model.targetInfo.score = _loc2_.wantGoal.score;
            model.targetInfo.nickName = _loc2_.wantGoal.nickName;
            model.targetInfo.consortiaName = _loc2_.wantGoal.consortiaName;
            model.targetInfo.fashion = _loc2_.wantGoal.fashion;
            model.targetInfo.isHiden = _loc2_.wantGoal.isHiden;
            model.targetInfo.job = _loc2_.wantGoal.job;
         }
         if(_loc2_.hasMyRank)
         {
            model.myRank = _loc2_.myRank;
         }
         if(_loc2_.hasTotalScore)
         {
            model.totalScore = _loc2_.totalScore;
         }
         if(_loc2_.hasLeftFreeRefreshCD)
         {
            model.leftFreeRefreshCD = _loc2_.leftFreeRefreshCD;
         }
         if(_loc2_.receiveState && _loc2_.receiveState.length > 0)
         {
            for each(var _loc3_:ConsortiaWantBoxStateMsg in _loc2_.receiveState)
            {
               if(_loc3_.type == 1)
               {
                  model.selfBoxState.add(_loc3_.index,_loc3_.state);
               }
               else
               {
                  model.guildBoxState.add(_loc3_.index,_loc3_.state);
               }
            }
         }
         if(_loc2_.rankInfos && _loc2_.rankInfos.length > 0)
         {
            model.rankInfoList.clear();
            for each(var _loc5_:ConsortiaWantRankMsg in _loc2_.rankInfos)
            {
               _loc4_ = new GuildWantedRankInfo();
               _loc4_.rank = _loc5_.rank;
               _loc4_.score = _loc5_.score;
               _loc4_.nickName = _loc5_.nickName;
               model.rankInfoList.add(_loc4_.rank,_loc4_);
            }
         }
         MsgMan.notifyObserver("GUILD_WANTED_INFO_CHANGE");
      }
      
      public function sendRequest(param1:int, param2:int = 0, param3:int = 0) : void
      {
         var _loc5_:PackageOut = new PackageOut(8365);
         var _loc4_:ConsortiaWantMsg = new ConsortiaWantMsg();
         _loc4_.opType = param1;
         _loc4_.drawIndex = param2;
         _loc4_.drawType = param3;
         SocketSendManager.instance.sendProtoBuffer(_loc5_,_loc4_);
      }
   }
}

