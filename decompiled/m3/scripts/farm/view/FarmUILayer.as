package farm.view
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import farm.FarmManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import mainBar.effects.MainToolBtnGlowEffect;
   import manager.LanguageMgr;
   import managers.KingContractManager;
   import map.campaign.CampaignManager;
   import mvc.module.kingcontract.KingContractInfo;
   import water.view.FarmFriendListView;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SharedManagerHelper;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class FarmUILayer extends Sprite
   {
      
      private var _farmInfoView:FarmInfoView;
      
      private var _friendListView:FarmFriendListView;
      
      private var _farmToolbar:FarmToolbar;
      
      private var _effect:MainToolBtnGlowEffect;
      
      private var _invideBtn:BaseButton;
      
      private var _diceBtn:BaseButton;
      
      private var _sitDownBtn:BaseButton;
      
      private var _autoPickBtn:BaseButton;
      
      private var _cdTime:FarmBonCdTimeView;
      
      private var _pickMediator:FarmAutoMediator;
      
      private var _cdTimeBg:Bitmap;
      
      private var _uint:uint;
      
      public function FarmUILayer()
      {
         super();
         initView();
         initevent();
         __resizeHandler(null);
         onBonfireStatus();
      }
      
      private function initView() : void
      {
         _farmInfoView = new FarmInfoView();
         _friendListView = new FarmFriendListView();
         _farmToolbar = new FarmToolbar();
         _diceBtn = ComponentFactory.Instance.creatComponentByStylename("farm.DiceNormalBtn");
         _diceBtn.tipData = LanguageMgr.GetTranslation("farm.farmuilayer.diceBtnTips");
         _sitDownBtn = ComponentFactory.Instance.creatComponentByStylename("farm.SitDownBtn");
         _sitDownBtn.tipData = LanguageMgr.GetTranslation("farm.farmuilayer.sitDownBtnTips");
         _autoPickBtn = ComponentFactory.Instance.creatComponentByStylename("farm.autoPickBtn");
         _cdTime = new FarmBonCdTimeView();
         _pickMediator = new FarmAutoMediator();
         addChild(_friendListView);
         addChild(_farmInfoView);
         addChild(_farmToolbar);
         addChild(_diceBtn);
         addChild(_sitDownBtn);
         addChild(_autoPickBtn);
         addChild(_cdTime);
      }
      
      private function onBonfireStatus(param1:Event = null) : void
      {
         var _loc2_:Boolean = false;
         try
         {
            _loc2_ = Boolean(FarmManager.instance.model.bigBonFireIsOpen);
         }
         catch(e:Error)
         {
         }
         if(_loc2_)
         {
            showInvideBtn();
         }
         else
         {
            if(_effect)
            {
               _effect.stop();
            }
            if(_invideBtn && this.contains(_invideBtn))
            {
               this.removeChild(_invideBtn);
            }
         }
      }
      
      private function initevent() : void
      {
         StageReferance.stage.addEventListener("resize",__resizeHandler);
         FarmManager.instance.model.addEventListener("FARM_BIGBONFIRE_STATUS",onBonfireStatus);
         FarmManager.instance.model.addEventListener("FARM_SELECTED_CHANGE",onBonfireStatus);
         _diceBtn.addEventListener("click",onDiceClick);
         _sitDownBtn.addEventListener("click",onSitDownClick);
         _autoPickBtn.addEventListener("click",onAutoPickClick);
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("resize",__resizeHandler);
         if(_invideBtn != null)
         {
            _invideBtn.removeEventListener("click",onInvideBtnClick);
         }
         FarmManager.instance.model.removeEventListener("FARM_BIGBONFIRE_STATUS",onBonfireStatus);
         FarmManager.instance.model.removeEventListener("FARM_SELECTED_CHANGE",onBonfireStatus);
         if(_diceBtn)
         {
            _diceBtn.removeEventListener("click",onDiceClick);
         }
         if(_sitDownBtn)
         {
            _sitDownBtn.removeEventListener("click",onSitDownClick);
         }
         if(_autoPickBtn)
         {
            _autoPickBtn.removeEventListener("click",onAutoPickClick);
         }
      }
      
      private function onDiceClick(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         FarmManager.instance.randomNum();
         _diceBtn.mouseEnabled = false;
         clearTimeout(_uint);
         _uint = setTimeout(function():void
         {
            _diceBtn.mouseEnabled = true;
         },3000);
      }
      
      private function onSitDownClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc4_:String = null;
         if(CampaignManager.instance.mapModel.selfMemberData.isSitDown)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("farm.farmuilayer.sitDowned"));
            return;
         }
         var _loc3_:int = int(FarmManager.instance.thane.changeShapeId);
         if(_loc3_ != 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("active.expback.frame.selectbtntxt");
            _loc4_ = LanguageMgr.GetTranslation("farm.farmuilayer.sitdownContent");
            SharedManagerHelper.ins.needAlert("farm.view.FarmUILayer.onSitDownClick",sitDownCallBack,_loc2_,_loc4_);
            return;
         }
         FarmManager.instance.sitDown();
      }
      
      private function sitDownCallBack() : void
      {
         FarmManager.instance.sitDown();
      }
      
      private function showInvideBtn() : void
      {
         if(FarmManager.instance.model.masterId != thane.userId)
         {
            return;
         }
         if(_invideBtn == null)
         {
            _invideBtn = ComponentFactory.Instance.creatComponentByStylename("farm.invide.InvideFirendBtn");
            _invideBtn.tipData = LanguageMgr.GetTranslation("farm.farmUILayer.InvideBtn");
            _invideBtn.addEventListener("click",onInvideBtnClick);
         }
         if(_effect == null)
         {
            _effect = new MainToolBtnGlowEffect(_invideBtn);
         }
         _effect.play();
      }
      
      private function onInvideBtnClick(param1:MouseEvent) : void
      {
         FarmManager.instance.openFarmInvideFrame();
         _effect.stop();
      }
      
      private function onAutoPickClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         SoundManager.instance.play("022");
         if(!KingContractManager.Instance.checkHasBuffById(8))
         {
            SimpleAlertHelper.instance.data = [__alertBackHandler];
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc4_ = LanguageMgr.GetTranslation("public.prompt");
            _loc5_ = LanguageMgr.GetTranslation("kingcontract.view.allBuyFrontAlert");
            SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,false,true);
         }
      }
      
      private function __alertBackHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            FrameControllerManager.instance.openControllerByInfo("kingcontract");
         }
      }
      
      private function get day() : int
      {
         return (KingContractManager.Instance.model.kingContractInfos[2] as KingContractInfo).template.Duration / 1440;
      }
      
      private function get point() : int
      {
         return int(TempleteManager.instance.getConfigInfoByConfigName("All_KingContract").ConfigValue);
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function __resizeHandler(param1:Event) : void
      {
         if(_friendListView)
         {
            _friendListView.x = StageReferance.stageWidth - _friendListView.width;
            _friendListView.y = (StageReferance.stageHeight - _friendListView.height) / 4;
         }
         if(_farmToolbar)
         {
            _farmToolbar.x = StageReferance.stageWidth - _farmToolbar.width - 40;
            _farmToolbar.y = _friendListView.y + _friendListView.height - 0;
         }
         if(_invideBtn)
         {
            _invideBtn.x = (StageReferance.stageWidth - _invideBtn.width) / 2;
            _invideBtn.y = StageReferance.stageHeight - 200;
         }
         if(_diceBtn)
         {
            _diceBtn.x = StageReferance.stageWidth - _farmToolbar.width - 30;
            _diceBtn.y = _friendListView.y + _friendListView.height + 90;
         }
         if(_sitDownBtn)
         {
            _sitDownBtn.x = StageReferance.stageWidth - _farmToolbar.width + 60;
            _sitDownBtn.y = _friendListView.y + _friendListView.height + 90;
         }
         if(_autoPickBtn)
         {
            _autoPickBtn.x = StageReferance.stageWidth - _farmToolbar.width - 40;
            _autoPickBtn.y = _friendListView.y + _friendListView.height + 45;
         }
         if(_cdTime)
         {
            _cdTime.x = (StageReferance.gameStageWidth - _cdTime.bgWidth) / 2;
            _cdTime.y = StageReferance.gameStageHeight * 0.78;
         }
      }
      
      public function dispose() : void
      {
         clearTimeout(_uint);
         removeEvent();
         ObjectUtils.disposeObject(_friendListView);
         _friendListView = null;
         ObjectUtils.disposeObject(_farmToolbar);
         _farmToolbar = null;
         ObjectUtils.disposeObject(_farmInfoView);
         _farmInfoView = null;
         ObjectUtils.disposeObject(_effect);
         _effect = null;
         ObjectUtils.disposeObject(_invideBtn);
         _invideBtn = null;
         ObjectUtils.disposeObject(_diceBtn);
         _diceBtn = null;
         ObjectUtils.disposeObject(_sitDownBtn);
         _sitDownBtn = null;
         ObjectUtils.disposeObject(_cdTime);
         _cdTime = null;
         ObjectUtils.disposeObject(_pickMediator);
         _pickMediator = null;
         FarmManager.instance.model.leftTime = -1;
         FarmManager.instance.model.beginLeftTime = -1;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

