package managers
{
   import chat.datas.ChatData;
   import com.pickgliss.utils.ObjectPool;
   import com.road.yishi.proto.campaign.CampaignNodeInfoMsg;
   import com.road.yishi.proto.campaign.NodeMsg;
   import com.road.yishi.proto.campaign.RollDiceMsg;
   import com.road.yishi.proto.campaign.TempMsg;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.internals.data.CampaignNode;
   import monopoly.view.MonopolyDiceRollView;
   import mvc.module.monopoly.MonopolyItemInfo;
   import mvc.module.monopoly.MonopolyModel;
   import mvc.module.monopoly.MonopolyNodeInfo;
   import yishi.comm.PackageIn;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.SocketSceneBufferManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   import yishi.view.tips.MessageTipManager;
   
   public class MonopolyManager
   {
      
      private static var _instance:MonopolyManager;
      
      private var _model:MonopolyModel;
      
      private var _monopolyDiceRollView:MonopolyDiceRollView;
      
      public function MonopolyManager()
      {
         super();
         _model = new MonopolyModel();
      }
      
      public static function get instance() : MonopolyManager
      {
         if(!_instance)
         {
            _instance = new MonopolyManager();
         }
         return _instance;
      }
      
      public function get model() : MonopolyModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4711,__enterMonopolyCampaignResHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4712,__monopolyCampaignOverHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4710,__rollDiceResHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4713,__rollDiceConfirmHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4720,__buyRollDiceHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4721,__slotMachineHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4722,__sysDiceHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 259,onFightLoss);
      }
      
      private function readRollDiceMsg(param1:RollDiceMsg) : void
      {
         if(param1.hasNormalPoint)
         {
            _model.normalPoint = param1.normalPoint;
         }
         if(param1.hasSpecialPoint)
         {
            _model.specialPoint = param1.specialPoint;
         }
         if(param1.hasWarFlag)
         {
            _model.warFlag = param1.warFlag;
         }
         if(param1.hasResultPoint)
         {
            _model.resultPoint = param1.resultPoint;
         }
         if(param1.hasPosition)
         {
            _model.lastPosition = _model.position;
            _model.position = param1.position;
            if(_model.lastPosition == 0)
            {
               _model.lastPosition = _model.position;
            }
         }
         if(param1.hasLastBuySpecialPoint)
         {
            _model.lastBuySpecialPoint = param1.lastBuySpecialPoint;
         }
         if(param1.hasLastBuyWarFlag)
         {
            _model.lastBuyWarFlag = param1.lastBuyWarFlag;
         }
         if(param1.hasCampaignCount)
         {
            _model.campaignCount = param1.campaignCount;
         }
      }
      
      private function onFightLoss(param1:SLGSocketEvent) : void
      {
         var _loc2_:PackageIn = param1.data as PackageIn;
         var _loc3_:String = "CAMPAIGN_MAP_SCENE";
         SocketSceneBufferManager.instance.addPkgToBuffer(_loc2_,_loc3_,__onRollDiceResHandler);
      }
      
      private function readCampaignNodeInfoMsg(param1:CampaignNodeInfoMsg) : void
      {
         if(param1.hasNormalTimes)
         {
            _model.normalTimes = param1.normalTimes;
         }
         if(param1.hasMagicTimes)
         {
            _model.magicTimes = param1.magicTimes;
         }
         if(param1.hasSlotMachineTimes)
         {
            _model.slotMachineTimes = param1.slotMachineTimes;
         }
         if(param1.hasIsMail)
         {
            _model.isMail = param1.isMail;
         }
      }
      
      private function __rollDiceResHandler(param1:SLGSocketEvent) : void
      {
         var _loc2_:PackageIn = param1.data as PackageIn;
         __onRollDiceResHandler(_loc2_);
      }
      
      private function __onRollDiceResHandler(param1:PackageIn) : void
      {
         var _loc2_:RollDiceMsg = new RollDiceMsg();
         _loc2_ = param1.readBody(_loc2_) as RollDiceMsg;
         readRollDiceMsg(_loc2_);
         _model.commit();
         if(_loc2_.type == 0)
         {
            _monopolyDiceRollView = new MonopolyDiceRollView(diceRollCallBack);
            _monopolyDiceRollView.show();
         }
         else
         {
            diceRollCallBack();
         }
      }
      
      private function diceRollCallBack() : void
      {
         var _loc1_:Array = null;
         if(CampaignManager.instance.controller)
         {
            _loc1_ = _model.getPath();
            CampaignManager.instance.controller.moveArmyByPath(_loc1_);
         }
         _monopolyDiceRollView = null;
      }
      
      private function __rollDiceConfirmHandler(param1:SLGSocketEvent) : void
      {
         var _loc2_:PackageIn = param1.data as PackageIn;
         SocketSceneBufferManager.instance.addPkgToBuffer(_loc2_,"CAMPAIGN_MAP_SCENE",rollDiceConfirmCallBack);
      }
      
      private function rollDiceConfirmCallBack(param1:PackageIn) : void
      {
         var _loc2_:CampaignNodeInfoMsg = new CampaignNodeInfoMsg();
         _loc2_ = param1.readBody(_loc2_) as CampaignNodeInfoMsg;
         if(_loc2_.type == 100)
         {
            FrameControllerManager.instance.closeControllerByInfo("monopoly");
         }
         else if(_loc2_.type == 10)
         {
            readCampaignNodeInfoMsg(_loc2_);
            FrameControllerManager.instance.openControllerByInfo("monopoly",4,_loc2_);
         }
         else if(_loc2_.type == 8)
         {
            FrameControllerManager.instance.openControllerByInfo("monopoly",6,_loc2_);
         }
         else if(_loc2_.type == 7)
         {
            if(_loc2_.nodeInfo.length > 0)
            {
               showBattleRewardMsg(_loc2_.nodeInfo);
            }
            hideBoss();
         }
         else if(_loc2_.type == 12)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("MonopolyManager.GameTip01"));
            if(_loc2_.gameType == 1)
            {
               FrameControllerManager.instance.openControllerByInfo("monopoly",8);
            }
            else
            {
               FrameControllerManager.instance.openControllerByInfo("monopoly",7);
            }
         }
         else
         {
            FrameControllerManager.instance.openControllerByInfo("monopoly",2,_loc2_);
         }
      }
      
      public function hideBoss() : void
      {
         var _loc1_:MonopolyNodeInfo = _model.nodeInfos[_model.position - 1] as MonopolyNodeInfo;
         if(_loc1_ && _loc1_.campaignNode && _loc1_.campaignNode.info)
         {
            _loc1_.campaignNode.info.state = 8;
         }
      }
      
      public function hideChest() : void
      {
         var _loc1_:MonopolyNodeInfo = _model.nodeInfos[_model.position - 1] as MonopolyNodeInfo;
         if(_loc1_ && _loc1_.campaignNode && _loc1_.campaignNode.info)
         {
            _loc1_.campaignNode.info.state = 8;
            _loc1_.campaignNode.commit();
         }
      }
      
      private function showBattleRewardMsg(param1:Array) : void
      {
         var _loc4_:ChatData = null;
         var _loc3_:GoodsTemplateInfo = null;
         var _loc6_:String = "";
         var _loc2_:String = "";
         for each(var _loc5_:TempMsg in param1)
         {
            _loc3_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc5_.templateId);
            if(_loc3_)
            {
               _loc6_ += LanguageMgr.GetTranslation("MonopolyManager.BattleGetTip02",_loc3_.TemplateName,_loc5_.count);
            }
         }
         if(_loc6_ != "")
         {
            _loc6_ = _loc6_.substring(0,_loc6_.length - 1);
         }
         _loc2_ = LanguageMgr.GetTranslation("MonopolyManager.BattleGetTip01",_loc6_);
         _loc4_ = ObjectPool.getObject(ChatData) as ChatData;
         if(_loc4_)
         {
            _loc4_.channel = 3;
            _loc4_.msg = _loc2_;
            _loc4_.commit();
            NotificationManager.instance.sendNotification("ADD_CHAT",_loc4_);
            MessageTipManager.instance().show(_loc2_);
         }
      }
      
      private function __buyRollDiceHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:RollDiceMsg = new RollDiceMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as RollDiceMsg;
         readRollDiceMsg(_loc2_);
         _model.commit();
      }
      
      private function __slotMachineHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:MonopolyItemInfo = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:CampaignNodeInfoMsg = new CampaignNodeInfoMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as CampaignNodeInfoMsg;
         readCampaignNodeInfoMsg(_loc2_);
         _model.itemInfos = [];
         for each(var _loc5_:TempMsg in _loc2_.nodeInfo)
         {
            _loc3_ = new MonopolyItemInfo();
            _loc3_.templateId = _loc5_.templateId;
            _loc3_.count = _loc5_.count;
            _model.itemInfos.push(_loc3_);
         }
         _model.commit();
      }
      
      private function __sysDiceHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:RollDiceMsg = new RollDiceMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as RollDiceMsg;
         readRollDiceMsg(_loc2_);
         _model.commit();
      }
      
      private function __enterMonopolyCampaignResHandler(param1:SLGSocketEvent) : void
      {
         var _loc9_:Array = null;
         var _loc10_:CampaignArmy = null;
         var _loc3_:CampaignNode = null;
         var _loc7_:MonopolyNodeInfo = null;
         var _loc4_:NodeMsg = null;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc8_:PackageIn = param1.data as PackageIn;
         var _loc2_:RollDiceMsg = new RollDiceMsg();
         _loc2_ = _loc8_.readBody(_loc2_) as RollDiceMsg;
         readRollDiceMsg(_loc2_);
         if(CampaignManager.instance.mapModel && CampaignManager.instance.mapModel.mapNodesData && _loc2_.nodeInfo.length > 0)
         {
            _model.nodeInfos = [];
            _loc9_ = CampaignManager.instance.mapModel.mapNodesData;
            _loc9_.sort(sortMapNodes);
            _loc6_ = int(_loc2_.nodeInfo.length);
            _loc2_.nodeInfo.sort(sortNodeInfos);
            _loc5_ = 0;
            while(_loc5_ < _loc6_)
            {
               _loc4_ = _loc2_.nodeInfo[_loc5_] as NodeMsg;
               _loc3_ = _loc9_[_loc5_] as CampaignNode;
               if(_loc4_ && _loc3_)
               {
                  _loc7_ = new MonopolyNodeInfo();
                  _loc7_.position = _loc4_.position;
                  _loc7_.type = _loc4_.type;
                  _loc7_.templateId = _loc4_.templateId;
                  _loc7_.x = _loc3_.curPosX;
                  _loc7_.y = _loc3_.curPosY;
                  _loc7_.nodeId = _loc3_.nodeId;
                  _loc3_.info.id = _loc4_.position;
                  _loc3_.info.names = "";
                  _loc7_.campaignNode = _loc3_;
                  _model.nodeInfos.push(_loc7_);
                  if(_loc7_.position == _model.position)
                  {
                     _loc10_ = CampaignManager.instance.mapModel.selfMemberData;
                     _loc10_.curPosX = _loc3_.curPosX;
                     _loc10_.curPosY = _loc3_.curPosY;
                  }
                  else if(_loc7_.position - 1 == _model.position)
                  {
                     CampaignManager.instance.mapModel.currentDieNodeId = _loc3_.info.id;
                  }
               }
               _loc5_++;
            }
         }
         _model.commit();
      }
      
      private function sortMapNodes(param1:CampaignNode, param2:CampaignNode) : Number
      {
         if(param1.nodeId < param2.nodeId)
         {
            return -1;
         }
         if(param1.nodeId > param2.nodeId)
         {
            return 1;
         }
         return 0;
      }
      
      private function sortNodeInfos(param1:NodeMsg, param2:NodeMsg) : Number
      {
         if(param1.position < param2.position)
         {
            return -1;
         }
         if(param1.position > param2.position)
         {
            return 1;
         }
         return 0;
      }
      
      private function __monopolyCampaignOverHandler(param1:SLGSocketEvent) : void
      {
         var _loc2_:PackageIn = param1.data as PackageIn;
         SocketSceneBufferManager.instance.addPkgToBuffer(_loc2_,"SPACE_SCENE",monopolyCampaignOverCallBack);
      }
      
      private function monopolyCampaignOverCallBack(param1:PackageIn) : void
      {
         var _loc2_:CampaignNodeInfoMsg = new CampaignNodeInfoMsg();
         _loc2_ = param1.readBody(_loc2_) as CampaignNodeInfoMsg;
         FrameControllerManager.instance.openControllerByInfo("monopoly",5,_loc2_);
      }
   }
}

