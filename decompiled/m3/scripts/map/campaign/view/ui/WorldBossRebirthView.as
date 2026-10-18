package map.campaign.view.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import managers.KingContractManager;
   import managers.WorldBossSocketOutManager;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class WorldBossRebirthView extends Sprite implements Disposeable
   {
      
      private var _bg:MutipleImage;
      
      private var _txt:FilterFrameText;
      
      private var _downTime:DownTimeView;
      
      private var _immediaBtn:IconButton;
      
      private var _autoBtn:IconButton;
      
      private var _stopAutoBtn:IconButton;
      
      private var _riverPay:int;
      
      private var _battlePoint:int = 3;
      
      private var _state:Boolean;
      
      private var _tipRiver:Boolean = false;
      
      private var _isDispose:Boolean = false;
      
      private var _mapView:Object;
      
      private var _timeId:int;
      
      public function WorldBossRebirthView(param1:Object)
      {
         super();
         _mapView = param1;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("xmlui.WorldBossRebirthView.Bg");
         _txt = ComponentFactory.Instance.creatComponentByStylename("worldboss.WorldBossRebirthView.txt");
         _immediaBtn = ComponentFactory.Instance.creatComponentByStylename("worldboss.WorldBossRebirthView.ImmediaBtn");
         _autoBtn = ComponentFactory.Instance.creatComponentByStylename("worldboss.WorldBossRebirthView.AutoBtn");
         _stopAutoBtn = ComponentFactory.Instance.creatComponentByStylename("worldboss.WorldBossRebirthView.StopAutoBtn");
         _downTime = new DownTimeView();
         _downTime.x = 95;
         _downTime.y = 23;
         addChild(_bg);
         addChild(_txt);
         addChild(_downTime);
         addChild(_immediaBtn);
         addChild(_autoBtn);
         addChild(_stopAutoBtn);
         _stopAutoBtn.visible = false;
         _autoBtn.enable = kingContract ? true : false;
         _stopAutoBtn.enable = kingContract ? true : false;
         _txt.text = LanguageMgr.GetTranslation("map.campaign.view.ui.WorldBossRebirthView.txt");
         var _loc1_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("Live_Pay");
         if(_loc1_)
         {
            _riverPay = parseInt(_loc1_.ConfigValue);
         }
         _loc1_ = TempleteManager.instance.getConfigInfoByConfigName("Live_Fight_Pay");
         if(_loc1_)
         {
            _battlePoint = parseInt(_loc1_.ConfigValue);
         }
      }
      
      private function initEvent() : void
      {
         _immediaBtn.addEventListener("click",__immediaBtnClickHandler);
         _autoBtn.addEventListener("click",__stateChangeHandler);
         _stopAutoBtn.addEventListener("click",__stateChangeHandler);
         if(kingContract)
         {
            _timeId = setTimeout(function():void
            {
               clearTimeout(_timeId);
               __stateChangeHandler(null);
            },2000);
         }
      }
      
      private function removeEvent() : void
      {
         _immediaBtn.removeEventListener("click",__immediaBtnClickHandler);
         _autoBtn.removeEventListener("click",__stateChangeHandler);
         _stopAutoBtn.removeEventListener("click",__stateChangeHandler);
      }
      
      protected function __stateChangeHandler(param1:MouseEvent) : void
      {
         var _loc2_:Boolean = _state ? false : true;
         setAutoState(_loc2_);
      }
      
      protected function __cancelHandler(param1:MouseEvent) : void
      {
         setAutoState(false);
      }
      
      public function setAutoState(param1:Boolean) : void
      {
         if(_state == param1 || _isDispose)
         {
            return;
         }
         _state = param1;
         _autoBtn.visible = _state ? false : true;
         _stopAutoBtn.visible = _state ? true : false;
         _autoBtn.enable = kingContract ? true : false;
         _stopAutoBtn.enable = kingContract ? true : false;
         this.dispatchEvent(new Event("change"));
      }
      
      protected function get kingContract() : Boolean
      {
         return KingContractManager.Instance.checkHasBuffById(11);
      }
      
      protected function __immediaBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc4_:Date = null;
         var _loc7_:TodayNotAlertFrame = null;
         var _loc6_:String = null;
         var _loc3_:String = null;
         if(_tipRiver)
         {
            return;
         }
         var _loc5_:Boolean = true;
         var _loc2_:Date = SharedManager.instance.worldBossRiverTodayNeedAlertCheckDate_enterBattle;
         if(_loc2_)
         {
            _loc4_ = new Date();
            if(_loc4_.fullYear == _loc2_.fullYear && _loc4_.month == _loc2_.month && _loc4_.date == _loc2_.date)
            {
               _loc5_ = false;
            }
         }
         if(_loc5_)
         {
            _loc7_ = ComponentFactory.Instance.creatComponentByStylename("worldboss.RiverNotAlert2");
            _loc6_ = LanguageMgr.GetTranslation("map.campaign.view.ui.RiverView.content_battle",_battlePoint);
            _loc3_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc7_.show(_loc6_,_loc3_,__todayNotAlert2,__closeHandler2,"center",2);
         }
         else
         {
            sendEnterBattle(true);
         }
      }
      
      private function __todayNotAlert2(param1:Boolean) : void
      {
         if(param1)
         {
            SharedManager.instance.worldBossRiverTodayNeedAlertCheckDate_enterBattle = new Date();
            SharedManager.instance.saveWorldBossRiverTodayNeedAlertCheckDate_enterBattle();
         }
         sendEnterBattle(true);
      }
      
      private function __closeHandler2() : void
      {
         sendEnterBattle(false);
      }
      
      private function sendEnterBattle(param1:Boolean, param2:Boolean = true) : void
      {
         var _loc3_:int = 0;
         _tipRiver = false;
         if(param1)
         {
            _loc3_ = int(playerInfo.point);
            if(param2)
            {
               _loc3_ = playerInfo.giftToken + playerInfo.point;
            }
            if(_loc3_ < _battlePoint)
            {
               RechargeAlertMannager.show();
               return;
            }
            _tipRiver = true;
            hide();
            if(selfMemberData.isDie == 1)
            {
               WorldBossSocketOutManager.sendEnterBattle();
            }
            else
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("riverView.notDieState"));
            }
         }
      }
      
      public function set count(param1:int) : void
      {
         if(param1 <= 0)
         {
            hide();
            return;
         }
         _downTime.addEventListener("complete",__timeCompleteHandler);
         _downTime.count = param1;
      }
      
      private function __timeCompleteHandler(param1:Event) : void
      {
         hide();
      }
      
      public function hide() : void
      {
         if(_state)
         {
            NotificationManager.instance.dispatchEvent(new NotificationEvent("WORK_NEXT_NODE",null));
         }
         dispose();
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get selfMemberData() : CampaignArmy
      {
         return CampaignManager.instance.mapModel.selfMemberData;
      }
      
      public function dispose() : void
      {
         if(_isDispose)
         {
            return;
         }
         _isDispose = true;
         removeEvent();
         if(_downTime)
         {
            _downTime.stop();
            _downTime.removeEventListener("complete",__timeCompleteHandler);
            _downTime.dispose();
         }
         _downTime = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         ObjectUtils.disposeObject(_immediaBtn);
         _immediaBtn = null;
         ObjectUtils.disposeObject(_autoBtn);
         _autoBtn = null;
         ObjectUtils.disposeObject(_stopAutoBtn);
         _stopAutoBtn = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,4);
      }
      
      public function get autoBtn() : BaseButton
      {
         return _autoBtn;
      }
      
      public function get state() : Boolean
      {
         return _state;
      }
   }
}

