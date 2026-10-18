package mvc.module.secretary.acts
{
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.campaign.CampaignSweepRsp;
   import com.road.yishi.proto.campaign.TowerInfoReqMsg;
   import com.road.yishi.proto.shop.ShopCarListMsg;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import managers.MopupManager;
   import managers.ShopManager;
   import mvc.module.mopup.MopupModel;
   import mvc.module.secretary.SecretaryItemData;
   import mvc.module.shop.ShopGoodsInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   
   public class SyAction extends ILitteAction
   {
      
      private var _moneyState:Boolean = true;
      
      private var _type:int;
      
      private var _isExe:Boolean = false;
      
      private var _data:SecretaryItemData;
      
      private var _countTime:Timer;
      
      private var _mazeCostTime:int;
      
      public var mazeCostGold:int;
      
      public function SyAction(param1:SecretaryItemData)
      {
         _moneyState = param1.moneyState;
         _type = param1.type;
         _data = param1;
         super();
      }
      
      public static function resetTowerInfo(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8299);
         var _loc2_:TowerInfoReqMsg = new TowerInfoReqMsg();
         _loc2_.index = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      private function __succeedHandler(param1:SLGSocketEvent) : void
      {
         if(!_isExe)
         {
            return;
         }
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:ShopCarListMsg = new ShopCarListMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as ShopCarListMsg;
         var _loc3_:int = _loc2_.result;
         if(_loc3_ != 1 || _loc2_.isMail)
         {
            isFinish = true;
            return;
         }
         var _loc5_:int = playerModel.towerInfo2.maxIndex;
         MopupManager.instance.sendMopupInfo(2,1,8101,0,_loc5_,2);
         mazeCostGold = int(TempleteManager.instance.getConfigInfoByConfigName("Tower_Sweep_Gold").ConfigValue);
         _mazeCostTime = int(TempleteManager.instance.getConfigInfoByConfigName("Tower_Sweep_Time").ConfigValue);
         _countTime = new Timer(_mazeCostTime * 1000);
         _countTime.addEventListener("timer",__timeCompleteHandler);
         _countTime.start();
      }
      
      override public function exc() : void
      {
         if(!_isExe)
         {
            openBuyKeyFrame(208008,3,8101);
            SocketManager.instance.addEventListener("SLGSocketEvent" + 4425,__refreshMopupInfoHandler);
            SocketManager.instance.addEventListener("SLGSocketEvent" + 4783,__succeedHandler);
            _isExe = true;
         }
      }
      
      private function __refreshMopupInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:String = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:CampaignSweepRsp = new CampaignSweepRsp();
         _loc2_ = _loc4_.readBody(_loc2_) as CampaignSweepRsp;
         if(_loc2_.status)
         {
            _loc3_ = "";
            switch(_loc2_.status - 1)
            {
               case 0:
                  break;
               default:
                  isFinish = true;
            }
         }
      }
      
      private function openBuyKeyFrame(param1:int = 208008, param2:int = 1, param3:int = 8001) : void
      {
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc4_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1);
         var _loc6_:ShopGoodsInfo = TempleteManager.instance.getShopTempInfoByItemId(param1);
         if(_moneyState)
         {
            _loc5_ = 2;
         }
         else
         {
            _loc5_ = 1;
         }
         modelMaze.mopupEnd = false;
         if(_data.moneyNum > 0)
         {
            resetTowerInfo(_type - 2);
            ShopManager.Instance.buyOne(_loc6_.Id,param2,playerInfo.userId,_loc5_,false);
         }
         else
         {
            _loc7_ = playerModel.towerInfo2.maxIndex;
            MopupManager.instance.sendMopupInfo(2,1,8101,0,_loc7_,2);
            mazeCostGold = int(TempleteManager.instance.getConfigInfoByConfigName("Tower_Sweep_Gold").ConfigValue);
            _mazeCostTime = int(TempleteManager.instance.getConfigInfoByConfigName("Tower_Sweep_Time").ConfigValue);
            _countTime = new Timer(_mazeCostTime * 1000);
            _countTime.addEventListener("timer",__timeCompleteHandler);
            _countTime.start();
         }
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function __timeCompleteHandler(param1:TimerEvent) : void
      {
         if(!_countTime)
         {
            return;
         }
         _countTime.removeEventListener("timerComplete",__timeCompleteHandler);
         MopupManager.instance.sendMopupInfo(2,3);
         _countTime.stop();
         _countTime = null;
         _countTime = new Timer(_mazeCostTime * 1000);
         _countTime.reset();
         _countTime.addEventListener("timer",__timeCompleteHandler);
         _countTime.start();
         if(modelMaze.campaignId == 8101 && modelMaze.mopupEnd)
         {
            if(_countTime)
            {
               _countTime.removeEventListener("timerComplete",__timeCompleteHandler);
               ObjectUtils.disposeObject(_countTime);
               _countTime = null;
            }
            isFinish = true;
         }
      }
      
      private function get modelMaze() : MopupModel
      {
         return MopupManager.instance.model;
      }
      
      override public function dispose() : void
      {
         if(_countTime)
         {
            _countTime.removeEventListener("timerComplete",__timeCompleteHandler);
            ObjectUtils.disposeObject(_countTime);
            _countTime = null;
         }
         if(_isExe)
         {
            MopupManager.instance.sendMopupInfo(2,4);
            SocketManager.instance.removeEventListener("SLGSocketEvent" + 4425,__refreshMopupInfoHandler);
            SocketManager.instance.removeEventListener("SLGSocketEvent" + 4783,__succeedHandler);
         }
      }
   }
}

