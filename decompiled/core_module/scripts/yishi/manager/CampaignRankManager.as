package yishi.manager
{
   import com.road.yishi.proto.campaign.RankListRspMsg;
   import com.road.yishi.proto.campaign.RankMsg;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import yishi.comm.PackageIn;
   import yishi.datas.playerinfo.RankInfo;
   import yishi.datas.templates.CampaignTemplate;
   import yishi.events.PlayerEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.utils.SimpleDictionary;
   
   public class CampaignRankManager extends EventDispatcher
   {
      
      private static var _instance:CampaignRankManager;
      
      private var _rankDic:SimpleDictionary;
      
      private var _singleRankDic:SimpleDictionary;
      
      private var _timeVortexRankDic:SimpleDictionary;
      
      private var _timeVortexInited:Boolean = false;
      
      public function CampaignRankManager()
      {
         super();
      }
      
      public static function get instance() : CampaignRankManager
      {
         if(!_instance)
         {
            _instance = new CampaignRankManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         _rankDic = new SimpleDictionary(true);
         _singleRankDic = new SimpleDictionary(true);
         _timeVortexRankDic = new SimpleDictionary(true);
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4151,__rankListHandler);
         PlayerManager.instance.currentPlayerModel.playerInfo.addEventListener("TIME_VORTEX_NODE_CHANGE",__timeVortexNodeChangeHandler);
      }
      
      private function __rankListHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:RankInfo = null;
         var _loc3_:CampaignTemplate = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:RankListRspMsg = new RankListRspMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as RankListRspMsg;
         for each(var _loc7_:RankMsg in _loc2_.rankInfo)
         {
            _loc5_ = new RankInfo();
            _loc5_.campaignId = _loc7_.campaignId;
            _loc3_ = TempleteManager.instance.getCampaignTemplateById(_loc7_.campaignId);
            if(_loc3_)
            {
               _loc5_.areaId = _loc3_.AreaId;
               _loc5_.rank = _loc7_.rank;
               _rankDic.add(_loc5_.campaignId,_loc5_);
               if(_singleRankDic[_loc5_.areaId])
               {
                  if(_singleRankDic[_loc5_.areaId].rank < _loc5_.rank)
                  {
                     _singleRankDic.add(_loc5_.areaId,_loc5_);
                  }
               }
               else
               {
                  _singleRankDic.add(_loc5_.areaId,_loc5_);
               }
            }
         }
         var _loc4_:int = int(_rankDic.getList().length);
         CampaignTemplateManager.instance.checkCanChoose();
      }
      
      private function __timeVortexNodeChangeHandler(param1:PlayerEvent) : void
      {
         var _loc3_:RankInfo = null;
         var _loc4_:Dictionary = TempleteManager.instance.timeVortexDic;
         var _loc2_:int = PlayerManager.instance.currentPlayerModel.playerInfo.timeVortexNode;
         var _loc5_:CampaignTemplate = _loc4_[_loc2_];
         if(_loc5_)
         {
            _loc3_ = new RankInfo();
            _loc3_.campaignId = _loc5_.CampaignId;
            _timeVortexRankDic.add(_loc3_.campaignId,_loc3_);
            while(_loc5_ && _loc5_.PreCampaignId != 0)
            {
               _loc2_ = _loc5_.PreCampaignId;
               _loc5_ = _loc4_[_loc2_];
               _loc3_ = new RankInfo();
               _loc3_.campaignId = _loc5_.CampaignId;
               _timeVortexRankDic.add(_loc3_.campaignId,_loc3_);
            }
         }
         CampaignTemplateManager.instance.checkTimeVortexCanChoose();
         _timeVortexInited = true;
      }
      
      public function initTimeVortexRankDic() : void
      {
         __timeVortexNodeChangeHandler(null);
      }
      
      public function get rankDic() : SimpleDictionary
      {
         return _rankDic;
      }
      
      public function get singleRankDic() : SimpleDictionary
      {
         return _singleRankDic;
      }
      
      public function get timeVortexRankDic() : SimpleDictionary
      {
         return _timeVortexRankDic;
      }
      
      public function get timeVortexInited() : Boolean
      {
         return _timeVortexInited;
      }
   }
}

