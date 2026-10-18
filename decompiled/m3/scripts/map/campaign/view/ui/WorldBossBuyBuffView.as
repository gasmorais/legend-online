package map.campaign.view.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.CampaignMapController;
   import map.campaign.data.WorldBossBuyBuffModel;
   import yishi.datas.playerinfo.PlayerBufferInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.CampaignBufferTemp;
   import yishi.events.PlayerBufferEvent;
   import yishi.manager.PlayerBufferManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManager;
   import yishi.utils.StringHelper;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class WorldBossBuyBuffView extends Sprite
   {
      
      private var _model:WorldBossBuyBuffModel;
      
      private var _control:CampaignMapController;
      
      private var _btnUsePoint:SimpleBitmapButton;
      
      private var _confirmTitle:String;
      
      private var _confirmContent1:String;
      
      private var _confirm:String;
      
      private var _cancel:String;
      
      private var _point:String;
      
      private var _giftToken:String;
      
      public function WorldBossBuyBuffView(param1:WorldBossBuyBuffModel)
      {
         super();
         _model = param1;
         _control = CampaignManager.instance.controller as CampaignMapController;
         init();
         addEvent();
         __refreshTips(null);
      }
      
      protected function init() : void
      {
         _btnUsePoint = ComponentFactory.Instance.creatComponentByStylename("campaign.worldboss.pointBtn");
         addChild(_btnUsePoint);
         updateTips();
         _confirm = LanguageMgr.GetTranslation("public.confirm");
         _cancel = LanguageMgr.GetTranslation("public.cancel");
         _confirmTitle = LanguageMgr.GetTranslation("mainBar.WorldBossBuyBuffBar.confirmTitle");
         _confirmContent1 = LanguageMgr.GetTranslation("mainBar.WorldBossBuyBuffBar.confirmContent1");
         _point = LanguageMgr.GetTranslation("mainBar.WorldBossBuyBuffBar.point");
         _giftToken = LanguageMgr.GetTranslation("mainBar.WorldBossBuyBuffBar.giftToken");
      }
      
      protected function addEvent() : void
      {
         _btnUsePoint.addEventListener("click",__onClickHandler);
         PlayerBufferManager.instance.addEventListener("CAMPAIGN_BUFFER_UPDATE",__refreshTips);
         this.addEventListener("addedToStage",onStage);
      }
      
      protected function removeEvent() : void
      {
         _btnUsePoint && _btnUsePoint.removeEventListener("click",__onClickHandler);
         PlayerBufferManager.instance.removeEventListener("CAMPAIGN_BUFFER_UPDATE",__refreshTips);
         this.removeEventListener("addedToStage",onStage);
      }
      
      private function __refreshTips(param1:PlayerBufferEvent) : void
      {
         var _loc4_:CampaignBufferTemp = null;
         var _loc5_:CampaignBufferTemp = null;
         var _loc3_:Vector.<PlayerBufferInfo> = PlayerBufferManager.instance.campaignBufferList;
         for each(var _loc2_:PlayerBufferInfo in _loc3_)
         {
            if(_loc2_.template.Types == 4)
            {
               _loc4_ = CampaignBufferTemp(_loc2_.template);
               break;
            }
         }
         if(_loc4_)
         {
            _loc5_ = _model.bufferList[_loc4_.Grades + 1];
            if(_loc5_)
            {
               _model.currentPrecent = _loc5_.Live - _loc4_.Live;
            }
            else
            {
               _model.currentPrecent = _loc4_.Live - _model.bufferList[_loc4_.Grades - 1].Live;
               _model.isLimit = true;
            }
         }
         else
         {
            _model.currentPrecent = _model.bufferList[1].Live;
         }
         this.updateTips();
      }
      
      protected function onStage(param1:Event) : void
      {
         this.removeEventListener("addedToStage",onStage);
         this.x = 0;
         this.y = 200;
      }
      
      private function __onClickHandler(param1:MouseEvent) : void
      {
         if(param1.currentTarget == _btnUsePoint)
         {
            _model.currentType = 1;
            SoundManager.instance.play("022");
            showConfirm();
            return;
         }
      }
      
      public function showConfirm() : void
      {
         var _loc4_:Date = null;
         var _loc7_:String = null;
         var _loc2_:TodayNotAlertFrame = null;
         var _loc3_:String = null;
         var _loc5_:Date = new Date();
         var _loc6_:Boolean = true;
         var _loc1_:Boolean = false;
         if(_model.currentType == 1 && _model.usePointCount == 0)
         {
            _loc1_ = true;
            _loc7_ = StringHelper.format(_confirmContent1,_model.currentPointCost,_point,_model.currentPrecent);
            _loc4_ = SharedManager.instance.worldBossPointTodayNeedAlertCheckDate;
         }
         else if(_model.currentType == 2 && _model.useGiftCount == 0)
         {
            _loc1_ = true;
            _loc7_ = StringHelper.format(_confirmContent1,_model.currentGiftCost,_giftToken,_model.currentPrecent);
            _loc4_ = SharedManager.instance.worldBossGifttokenTodayNeedAlertCheckDate;
         }
         if(!_loc1_)
         {
            confirmBuyBuff();
         }
         else
         {
            if(_loc4_ && _loc4_.fullYear == _loc5_.fullYear && _loc4_.month == _loc5_.month && _loc4_.date == _loc5_.date)
            {
               _loc6_ = false;
            }
            if(_loc6_)
            {
               _loc2_ = ComponentFactory.Instance.creatComponentByStylename("worldboss.BuffNotAlert");
               _loc3_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
               _loc2_.titleText = _confirmTitle;
               _loc2_.show(_loc7_,_loc3_,notAlert,null,"center",2,false);
            }
            else
            {
               confirmBuyBuff();
            }
         }
      }
      
      private function notAlert(param1:Boolean) : void
      {
         if(param1)
         {
            if(_model.currentType == 1)
            {
               SharedManager.instance.worldBossPointTodayNeedAlertCheckDate = new Date();
               SharedManager.instance.saveWorldBossPointTodayNeedAlert();
               _model.usePointCount++;
            }
            else
            {
               SharedManager.instance.worldBossGifttokenTodayNeedAlertCheckDate = new Date();
               SharedManager.instance.saveWorldBossGifttokenTodayNeedAlert();
               _model.useGiftCount++;
            }
         }
         confirmBuyBuff();
      }
      
      public function confirmBuyBuff() : void
      {
         var _loc1_:String = null;
         var _loc2_:PlayerInfo = playerInfo;
         if(_model.currentType == 1 && _loc2_.point < _model.currentPointCost)
         {
            RechargeAlertMannager.show();
            _loc2_ = null;
            return;
         }
         if(_model.currentType == 2 && _loc2_.giftToken < _model.currentGiftCost)
         {
            _loc1_ = LanguageMgr.GetTranslation("mainBar.view.ChoosePayTypeFrame.command01");
            MessageTipManager.instance().show(_loc1_);
            _loc2_ = null;
            return;
         }
         if(_model.isLimit)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("worldboss.command01"));
            return;
         }
         _control.buyWorldBossBufferWithPointOrGiftToken(_model.currentType);
      }
      
      protected function showConfirmCallBack(param1:Boolean) : void
      {
         if(param1)
         {
            this.confirmBuyBuff();
         }
      }
      
      public function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(parent)
         {
            parent.removeChild(this);
         }
         _btnUsePoint && _btnUsePoint.dispose();
         _btnUsePoint = null;
         _control = null;
      }
      
      public function updateTips() : void
      {
         var _loc1_:String = LanguageMgr.GetTranslation("mainBar.WorldBossBuyBuffBar.diamondBtnTipData");
         var _loc2_:String = LanguageMgr.GetTranslation("mainBar.WorldBossBuyBuffBar.giftsBtnTipData");
         _loc1_ = StringHelper.format(_loc1_,_model.currentPointCost,_model.currentPrecent);
         _loc2_ = StringHelper.format(_loc2_,_model.currentGiftCost,_model.currentPrecent);
         _btnUsePoint.tipData = _loc1_;
      }
   }
}

