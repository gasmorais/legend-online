package managers
{
   import com.road.yishi.proto.campaign.CampaignReqMsg;
   import com.road.yishi.proto.campaign.PassInfoMsg;
   import com.road.yishi.proto.campaign.QuickPassInfoMsg;
   import com.road.yishi.proto.campaign.QuickPassRankMsg;
   import events.RapidInfoEvent;
   import manager.LanguageMgr;
   import mvc.module.rapidThrough.RapidPassInfo;
   import mvc.module.rapidThrough.RapidThroughModel;
   import mvc.module.rapidThrough.RapidThroughRankItemInfo;
   import yishi.GlobalConfig;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class RapidThroughPassManager
   {
      
      private static var _instance:RapidThroughPassManager;
      
      public var rapidThroughInfo:RapidThroughModel;
      
      public var startTime:String;
      
      public var enterTime:String;
      
      public function RapidThroughPassManager()
      {
         super();
         rapidThroughInfo = new RapidThroughModel();
      }
      
      public static function get instance() : RapidThroughPassManager
      {
         if(!_instance)
         {
            _instance = new RapidThroughPassManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         addEvent();
      }
      
      public function requestRapidStart(param1:int = 1) : void
      {
         var _loc3_:PackageOut = new PackageOut(9633);
         var _loc2_:CampaignReqMsg = new CampaignReqMsg();
         _loc2_.paraInt1 = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public function requestEnterRapidPass() : void
      {
         if(!FreedomTeamManager.instance.hasTeam)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("rapid.createCopy.needTeam"));
            return;
         }
         if(FreedomTeamManager.instance.getTeamNum() < 2)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("rapid.createCopy.teamNum"));
            return;
         }
         if(!FreedomTeamManager.instance.isCaptain)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("rapid.createCopy.limitTeamLeader"));
            return;
         }
         var _loc1_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc3_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc4_:String = LanguageMgr.GetTranslation("rapid.createCopy.enterRapid");
         SimpleAlertHelper.instance.data = [createMolongCampaign];
         if(PlayerManager.instance.currentPlayerModel.playerInfo.rapidPassNum <= 0)
         {
            SimpleAlertHelper.instance.popAlerFrame(_loc3_,_loc4_,_loc1_,_loc2_,true,true,false);
         }
         else
         {
            SimpleAlertHelper.instance.popAlerFrame(_loc3_,_loc4_,_loc1_,_loc2_,true,true,false,2,"CHATINVIE_ALERT");
         }
      }
      
      public function createMolongCampaign(param1:Boolean, param2:Boolean = false) : void
      {
         var _loc4_:PackageOut = null;
         if(!param1)
         {
            return;
         }
         var _loc3_:CampaignReqMsg = new CampaignReqMsg();
         _loc4_ = new PackageOut(9633);
         if(PlayerManager.instance.currentPlayerModel.playerInfo.rapidPassNum <= 0)
         {
            _loc3_.paraBool1 = true;
         }
         else
         {
            _loc3_.paraBool1 = !param2;
         }
         _loc3_.paraInt1 = 0;
         GlobalConfig.isGet = !_loc3_.paraBool1;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public function get model() : RapidThroughModel
      {
         return rapidThroughInfo;
      }
      
      protected function returnUCQuickPassinfo(param1:SLGSocketEvent) : void
      {
         var _loc3_:RapidPassInfo = null;
         var _loc5_:int = 0;
         var _loc4_:PassInfoMsg = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:QuickPassInfoMsg = new QuickPassInfoMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as QuickPassInfoMsg;
         rapidThroughInfo.isStart = _loc2_.hasBeginDate;
         rapidThroughInfo.beginDate = _loc2_.beginDate;
         rapidThroughInfo.pass = _loc2_.turn;
         rapidThroughInfo.passTime = _loc2_.saveDate / 1000;
         if(!rapidThroughInfo.isStart || rapidThroughInfo.passInfos.length == 0)
         {
            initModel();
         }
         _loc5_ = 0;
         while(_loc5_ < _loc2_.pass.length)
         {
            if(_loc5_ >= 9)
            {
               return;
            }
            _loc4_ = _loc2_.pass[_loc5_];
            _loc3_ = rapidThroughInfo.passInfos[_loc5_];
            _loc3_.process = _loc4_.process;
            _loc3_.total = _loc4_.total;
            _loc3_.hasProcess = _loc4_.hasProcess;
            _loc3_.hasTotal = _loc4_.hasTotal;
            _loc5_++;
         }
         NotificationManager.instance.dispatchEvent(new RapidInfoEvent("rapid_update",null));
      }
      
      protected function returnUCQuickRankinfo(param1:SLGSocketEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:RapidThroughRankItemInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:QuickPassRankMsg = new QuickPassRankMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as QuickPassRankMsg;
         rapidThroughInfo.rankList.updateTime = _loc2_.updateTime;
         rapidThroughInfo.rankList.myOrder = _loc2_.myOrder;
         rapidThroughInfo.rankList.pass.length = 0;
         rapidThroughInfo.totalPage = _loc2_.pass.length / 8 + 1;
         _loc3_ = 0;
         while(_loc3_ < _loc2_.pass.length)
         {
            _loc4_ = new RapidThroughRankItemInfo();
            _loc4_.nickName = _loc2_.pass[_loc3_].nickName;
            _loc4_.order = _loc2_.pass[_loc3_].order;
            _loc4_.setPassTime(_loc2_.pass[_loc3_].passTime);
            _loc4_.job = _loc2_.pass[_loc3_].job;
            rapidThroughInfo.rankList.pass.push(_loc4_);
            _loc3_++;
         }
         rapidThroughInfo.updateRankList();
      }
      
      private function initModel() : void
      {
         var _loc1_:RapidPassInfo = null;
         var _loc2_:int = 0;
         rapidThroughInfo.passInfos = [];
         _loc2_ = 0;
         while(_loc2_ < 9)
         {
            _loc1_ = new RapidPassInfo();
            rapidThroughInfo.passInfos.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 405,returnUCQuickPassinfo);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 406,returnUCQuickRankinfo);
      }
   }
}

