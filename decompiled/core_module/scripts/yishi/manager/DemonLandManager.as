package yishi.manager
{
   import com.pickgliss.toplevel.StageReferance;
   import com.road.yishi.proto.campaign.CampaignSweepReq;
   import com.road.yishi.proto.gameplot.PlotInfoMsg;
   import com.road.yishi.proto.gameplot.PlotMsg;
   import com.road.yishi.proto.module.EvilLandMsg;
   import com.road.yishi.proto.module.EvilLandNodeMsg;
   import com.road.yishi.proto.player.PlayerOpMsg;
   import dialog.DialogControl;
   import dialog.DialogModel;
   import dialog.data.DialogMessageInfo;
   import manager.LanguageMgr;
   import mvc.module.demonland.DemonLandModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.templates.DemonLandTemplate;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.scene.SceneType;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   
   public class DemonLandManager
   {
      
      private static var _instance:DemonLandManager;
      
      private var _model:DemonLandModel;
      
      public function DemonLandManager()
      {
         super();
         _model = new DemonLandModel();
      }
      
      public static function get instance() : DemonLandManager
      {
         if(!_instance)
         {
            _instance = new DemonLandManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4879,onReceiveEvilLandData);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4878,onReceiveDialogData);
      }
      
      private function onReceiveEvilLandData(param1:SLGSocketEvent) : void
      {
         var _loc6_:EvilLandNodeMsg = null;
         var _loc4_:Boolean = false;
         var _loc3_:int = 0;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:EvilLandMsg = new EvilLandMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as EvilLandMsg;
         if(_loc2_.type == 0)
         {
            model.maxChapterId = _loc2_.chapterId;
            model.maxNodeId = _loc2_.nodeId + 1;
            model.myStar = _loc2_.star;
            model.myTear = _loc2_.goddessTear;
            model.tearBuyCount = _loc2_.buyCount;
            model.nodeList = _loc2_.nodeList;
            model.boxState = _loc2_.boxState;
         }
         else if(_loc2_.type == 1)
         {
            model.maxChapterId = _loc2_.chapterId;
            model.maxNodeId = _loc2_.nodeId + 1;
            model.myStar = _loc2_.star;
            model.myTear = _loc2_.goddessTear;
            model.tearBuyCount = _loc2_.buyCount;
            model.boxState = _loc2_.boxState;
         }
         else if(_loc2_.type == 2)
         {
            _loc4_ = true;
            _loc3_ = 0;
            while(_loc3_ < model.nodeList.length)
            {
               _loc6_ = model.nodeList[_loc3_];
               if(_loc6_.chapterId == _loc2_.nodeUpdate.chapterId && _loc6_.nodeId == _loc2_.nodeUpdate.nodeId)
               {
                  model.nodeList[_loc3_] = _loc2_.nodeUpdate;
                  _loc4_ = false;
               }
               _loc3_++;
            }
            if(_loc4_)
            {
               model.nodeList.push(_loc2_.nodeUpdate);
            }
         }
         NotificationManager.instance.dispatchEvent(new NotificationEvent("DEMON_LAND_DATA",_loc2_));
      }
      
      public function getNodeMsg(param1:int = -1, param2:int = -1) : EvilLandNodeMsg
      {
         var _loc4_:EvilLandNodeMsg = null;
         var _loc3_:int = 0;
         if(param1 == -1 && param2 == -1)
         {
            param1 = model.selectedChapter;
            param2 = model.selectedNode;
         }
         _loc3_ = 0;
         while(_loc3_ < model.nodeList.length)
         {
            _loc4_ = model.nodeList[_loc3_];
            if(_loc4_.chapterId == param1 && _loc4_.nodeId == param2)
            {
               return _loc4_;
            }
            _loc3_++;
         }
         return new EvilLandNodeMsg();
      }
      
      public function getLandTemplate(param1:int = -1, param2:int = -1) : DemonLandTemplate
      {
         var _loc3_:* = null;
         if(param1 == -1 && param2 == -1)
         {
            param1 = model.selectedChapter;
            param2 = model.selectedNode;
         }
         return TempleteManager.instance.demonLandTemplateCate.getTemplateByChapterAndNodeId(param1,param2);
      }
      
      private function onReceiveDialogData(param1:SLGSocketEvent) : void
      {
         var _loc3_:DialogControl = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:PlotMsg = new PlotMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as PlotMsg;
         if(_loc2_.loop)
         {
            _loc3_ = new DialogControl(reOpenModule,StageReferance.stage);
            _loc3_.model = readPackage(_loc4_);
         }
         else if(model.isOpenSelectFrame)
         {
            NotificationManager.instance.dispatchEvent(new NotificationEvent("DEMON_LAND_PAGE_REFRESH"));
         }
         else
         {
            FrameControllerManager.instance.openControllerByInfo("demonland",2);
         }
      }
      
      private function reOpenModule() : void
      {
         FrameControllerManager.instance.openControllerByInfo("demonland",1);
         FrameControllerManager.instance.openControllerByInfo("demonland",2);
      }
      
      private function readPackage(param1:PackageIn) : DialogModel
      {
         var _loc5_:int = 0;
         var _loc3_:DialogMessageInfo = null;
         var _loc4_:RegExp = null;
         var _loc6_:DialogModel = new DialogModel();
         var _loc2_:PlotMsg = new PlotMsg();
         _loc2_ = param1.readBody(_loc2_) as PlotMsg;
         _loc6_.isLoop = _loc2_.loop;
         _loc6_.scene = SceneType.getSceneTypeById(_loc2_.sceneType);
         _loc5_ = 0;
         while(_loc5_ < _loc2_.info.length)
         {
            _loc3_ = new DialogMessageInfo();
            _loc3_.index = (_loc2_.info[_loc5_] as PlotInfoMsg).index;
            _loc3_.direction = (_loc2_.info[_loc5_] as PlotInfoMsg).direction;
            _loc3_.roleId = (_loc2_.info[_loc5_] as PlotInfoMsg).roleId;
            if(_loc3_.roleId == 0)
            {
               _loc3_.roleId = PlayerManager.instance.currentPlayerModel.playerInfo.pics;
            }
            if((_loc2_.info[_loc5_] as PlotInfoMsg).roleName == "%s")
            {
               (_loc2_.info[_loc5_] as PlotInfoMsg).roleName = PlayerManager.instance.currentPlayerModel.playerInfo.nickName;
            }
            if((_loc2_.info[_loc5_] as PlotInfoMsg).roleName == PlayerManager.instance.currentPlayerModel.userInfo.userId + "$")
            {
               _loc3_.roleName = LanguageMgr.GetTranslation("public.nickName");
            }
            else
            {
               _loc3_.roleName = (_loc2_.info[_loc5_] as PlotInfoMsg).roleName;
            }
            _loc3_.event = (_loc2_.info[_loc5_] as PlotInfoMsg).event;
            _loc3_.param = (_loc2_.info[_loc5_] as PlotInfoMsg).param;
            _loc3_.txt = (_loc2_.info[_loc5_] as PlotInfoMsg).text;
            _loc3_.delayTime = (_loc2_.info[_loc5_] as PlotInfoMsg).delayTime;
            _loc4_ = /%s/g;
            _loc3_.txt = _loc3_.txt.replace(_loc4_,_loc3_.roleName);
            _loc6_.addInfo(_loc3_);
            _loc5_++;
         }
         return _loc6_;
      }
      
      public function sendGetDemonLandData() : void
      {
         var _loc2_:PackageOut = new PackageOut(9676);
         var _loc1_:PlayerOpMsg = new PlayerOpMsg();
         _loc1_.op = 0;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function sendEnterDemonLandChapter(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9676);
         var _loc2_:PlayerOpMsg = new PlayerOpMsg();
         _loc2_.op = 1;
         _loc2_.chapterId = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function sendEnterDemonLandNode(param1:int, param2:int, param3:Boolean = false) : void
      {
         var _loc5_:PackageOut = new PackageOut(9676);
         var _loc4_:PlayerOpMsg = new PlayerOpMsg();
         _loc4_.op = 2;
         _loc4_.chapterId = param1;
         _loc4_.nodeId = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc5_,_loc4_);
      }
      
      public function sendOpenAwardBox(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9676);
         var _loc2_:PlayerOpMsg = new PlayerOpMsg();
         _loc2_.op = 3;
         _loc2_.index = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function sendBuyTear() : void
      {
         var _loc2_:PackageOut = new PackageOut(9676);
         var _loc1_:PlayerOpMsg = new PlayerOpMsg();
         _loc1_.op = 4;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function sendBuyAttackCount(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(9676);
         var _loc3_:PlayerOpMsg = new PlayerOpMsg();
         _loc3_.op = 5;
         _loc3_.chapterId = param1;
         _loc3_.nodeId = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function sendMopupInfo(param1:int, param2:int, param3:int = 0, param4:int = 0, param5:int = 0, param6:int = 1, param7:Boolean = false, param8:Boolean = false, param9:int = 2) : void
      {
         var _loc11_:PackageOut = new PackageOut(8528);
         var _loc10_:CampaignSweepReq = new CampaignSweepReq();
         _loc10_.sweepType = param1;
         _loc10_.opType = param2;
         _loc10_.campaignId = param3;
         _loc10_.count = param4;
         _loc10_.eIndex = param5;
         _loc10_.enterType = param6;
         _loc10_.openSilverBox = param7;
         _loc10_.openSecretBox = param8;
         _loc10_.payType = param9;
         SocketSendManager.instance.sendProtoBuffer(_loc11_,_loc10_);
      }
      
      public function get model() : DemonLandModel
      {
         return _model;
      }
      
      public function set model(param1:DemonLandModel) : void
      {
         _model = param1;
      }
      
      public function battleOverHandlerView() : void
      {
         FrameControllerManager.instance.openControllerByInfo("demonland",1);
         if(model.isChapterEndBoss && model.maxChapterId == model.preMaxChapterId + 1)
         {
            model.selectedChapter++;
            sendEnterDemonLandChapter(model.selectedChapter);
         }
         else
         {
            FrameControllerManager.instance.openControllerByInfo("demonland",2);
         }
      }
   }
}

