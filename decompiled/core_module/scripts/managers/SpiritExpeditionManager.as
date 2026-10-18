package managers
{
   import com.road.yishi.proto.expedition.ExpeditionAreaMsg;
   import com.road.yishi.proto.expedition.ExpeditionEditMsg;
   import com.road.yishi.proto.expedition.ExpeditionMsg;
   import com.road.yishi.proto.player.PlayerOpMsg;
   import mvc.module.childspiritexpedition.SpiritExpeditionChapterInfo;
   import mvc.module.childspiritexpedition.SpiritExpeditionChildInfo;
   import mvc.module.childspiritexpedition.SpiritExpeditionModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.MsgMan;
   
   public class SpiritExpeditionManager
   {
      
      private static var _instance:SpiritExpeditionManager;
      
      private var _model:SpiritExpeditionModel;
      
      private var posSortAry:Array = [3,1,6,4,9,7,12,10];
      
      public function SpiritExpeditionManager()
      {
         super();
         if(!_model)
         {
            _model = new SpiritExpeditionModel();
         }
      }
      
      public static function get instance() : SpiritExpeditionManager
      {
         if(!_instance)
         {
            _instance = new SpiritExpeditionManager();
         }
         return _instance;
      }
      
      public function get model() : SpiritExpeditionModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4274,__expeditionMsgHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4275,__expeditionFormationMsgHandler);
      }
      
      private function __expeditionMsgHandler(param1:SLGSocketEvent) : void
      {
         var _loc7_:SpiritExpeditionChapterInfo = null;
         var _loc3_:SpiritExpeditionChildInfo = null;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:ExpeditionMsg = new ExpeditionMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as ExpeditionMsg;
         if(_loc2_.hasOpenAreaId)
         {
            model.openMaxAreaId = _loc2_.openAreaId;
         }
         if(_loc2_.hasRewards)
         {
            model.rewardState = _loc2_.rewards;
         }
         model.areaInfoList = [];
         for each(var _loc4_:ExpeditionAreaMsg in _loc2_.areas)
         {
            _loc7_ = new SpiritExpeditionChapterInfo();
            _loc7_.areaId = _loc4_.areaId;
            _loc7_.passNodeId = _loc4_.passNodeId;
            model.areaInfoList.push(_loc7_);
         }
         model.areaInfoList.sortOn("areaId",16);
         model.childList = [];
         model.enterWarList = [];
         for each(var _loc5_:ExpeditionEditMsg in _loc2_.edits)
         {
            _loc3_ = new SpiritExpeditionChildInfo();
            _loc3_.childId = _loc5_.childId;
            _loc3_.energy = _loc5_.energy;
            _loc3_.pos = _loc5_.pos;
            _loc3_.sort = posSortAry.indexOf(_loc5_.pos);
            _loc3_.skills = _loc5_.skills;
            _loc3_.cdTime = DateFormatter.parse(_loc5_.cdTime,"YYYY-MM-DD hh:mm:ss");
            model.childList.push(_loc3_);
            if(_loc3_.pos > 0)
            {
               model.enterWarList.push(_loc3_);
            }
         }
         model.childList.sort(sortByChildTemp);
         model.enterWarList.sortOn("sort",16);
         MsgMan.notifyObserver("EXPEDITION_INFO_UPDATE");
      }
      
      private function sortByChildTemp(param1:SpiritExpeditionChildInfo, param2:SpiritExpeditionChildInfo) : int
      {
         var _loc4_:ChildTempInfo = param1.childData.childTempInfo;
         var _loc3_:ChildTempInfo = param2.childData.childTempInfo;
         if(!_loc4_ || !_loc3_)
         {
            return -1;
         }
         return _loc4_.JobType < _loc3_.JobType ? -1 : 1;
      }
      
      private function __expeditionFormationMsgHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:SpiritExpeditionChildInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:ExpeditionMsg = new ExpeditionMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as ExpeditionMsg;
         model.childList = [];
         model.enterWarList = [];
         for each(var _loc4_:ExpeditionEditMsg in _loc2_.edits)
         {
            _loc3_ = new SpiritExpeditionChildInfo();
            _loc3_.childId = _loc4_.childId;
            _loc3_.energy = _loc4_.energy;
            _loc3_.pos = _loc4_.pos;
            _loc3_.sort = posSortAry.indexOf(_loc4_.pos);
            _loc3_.skills = _loc4_.skills;
            _loc3_.cdTime = DateFormatter.parse(_loc4_.cdTime,"YYYY-MM-DD hh:mm:ss");
            model.childList.push(_loc3_);
            if(_loc3_.pos > 0)
            {
               model.enterWarList.push(_loc3_);
            }
         }
         model.childList.sort(sortByChildTemp);
         model.enterWarList.sortOn("sort",16);
         MsgMan.notifyObserver("FORMATION_INFO_UPDATE");
      }
      
      public function sendExpeditionDataRequest() : void
      {
         var _loc2_:PackageOut = new PackageOut(8661);
         var _loc1_:PlayerOpMsg = new PlayerOpMsg();
         _loc1_.op = 1;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function sendExpeditionFight(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(8661);
         var _loc3_:PlayerOpMsg = new PlayerOpMsg();
         _loc3_.op = 2;
         _loc3_.chapterId = param1;
         _loc3_.nodeId = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function sendExpeditionEditFormation(param1:String) : void
      {
         var _loc3_:PackageOut = new PackageOut(8661);
         var _loc2_:PlayerOpMsg = new PlayerOpMsg();
         _loc2_.op = 3;
         _loc2_.param1 = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function sendExpeditionEditSkills(param1:int, param2:String) : void
      {
         var _loc4_:PackageOut = new PackageOut(8661);
         var _loc3_:PlayerOpMsg = new PlayerOpMsg();
         _loc3_.op = 4;
         _loc3_.id = param1;
         _loc3_.param1 = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function sendExpeditionGetReward(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8661);
         var _loc2_:PlayerOpMsg = new PlayerOpMsg();
         _loc2_.op = 5;
         _loc2_.index = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function sendExpeditionClearCd(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8661);
         var _loc2_:PlayerOpMsg = new PlayerOpMsg();
         _loc2_.op = 6;
         _loc2_.id = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
   }
}

