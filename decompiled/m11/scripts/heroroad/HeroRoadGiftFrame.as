package heroroad
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import mvc.module.heroroad.AchievementTaskInfo;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.AchievementTaskBuyDropTemplateInfo;
   import yishi.datas.templates.AchievementTaskTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.HeroRoadManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseItemView;
   import yishi.view.community.TimeDownView;
   import yishi.view.tips.MessageTipManager;
   
   public class HeroRoadGiftFrame extends Frame implements IManualSize
   {
      
      private var _bg:MutipleImage;
      
      private var _hbox:HBox;
      
      private var _packageNameTxt:FilterFrameText;
      
      private var _countTime:TimeDownView;
      
      private var _descTxt:FilterFrameText;
      
      private var _getBtn:IconButton;
      
      private var _priceTxt:FilterFrameText;
      
      private var _data:AchievementTaskInfo;
      
      private var _priceNumber:int;
      
      private var _isOverTime:Boolean;
      
      public function HeroRoadGiftFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("heroroad.HeroRoadGiftFrame.bg");
         _hbox = ComponentFactory.Instance.creatComponentByStylename("heroRoadAchievementItemView.rewardHbox");
         _packageNameTxt = ComponentFactory.Instance.creatComponentByStylename("heroRoadGiftFrame.packageNameTxt");
         _priceTxt = ComponentFactory.Instance.creatComponentByStylename("heroRoadGiftFrame.priceTxt");
         _descTxt = ComponentFactory.Instance.creatComponentByStylename("heroRoadGiftFrame.descTxt");
         _getBtn = ComponentFactory.Instance.creatComponentByStylename("heroRoadGiftFrame.getBtn");
         _countTime = ComponentFactory.Instance.creatComponentByStylename("heroRoadGiftFrame.countTime");
         addToContent(_bg);
         addToContent(_hbox);
         _hbox.x = 95;
         _hbox.y = 220;
         addToContent(_packageNameTxt);
         addToContent(_descTxt);
         _descTxt.text = LanguageMgr.GetTranslation("HeroRoadGiftFrame.descTxt");
         addToContent(_getBtn);
         addToContent(_priceTxt);
         addToContent(_countTime);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         if(_getBtn)
         {
            _getBtn.addEventListener("click",__getBtnHandler);
         }
         if(_countTime)
         {
            _countTime.addEventListener("timerDown_complete",_timerCompleteHandler);
         }
         NotificationManager.instance.addEventListener("HEROROAD_ACHIEVEMENT_LIST_UPDATE",__updateViewHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_getBtn)
         {
            _getBtn.removeEventListener("click",__getBtnHandler);
         }
         if(_countTime)
         {
            _countTime.removeEventListener("timerDown_complete",_timerCompleteHandler);
         }
         NotificationManager.instance.removeEventListener("HEROROAD_ACHIEVEMENT_LIST_UPDATE",__updateViewHandler);
      }
      
      private function __updateViewHandler(param1:NotificationEvent) : void
      {
         _countTime.timeCount = HeroRoadManager.instance.currentLeftSecond;
      }
      
      private function __getBtnHandler(param1:MouseEvent) : void
      {
         SimpleAlertHelper.instance.data = [buyOperate];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("heroroad.HeroRoadGiftFrame.isBuy",_priceNumber);
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,false,false,2);
      }
      
      private function buyOperate(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            if(_data)
            {
               if(_isOverTime)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTip.timeStr02"));
                  return;
               }
               if(playerInfo.point < _priceNumber)
               {
                  RechargeAlertMannager.show();
                  return;
               }
               if(getTimer() - HeroRoadManager.instance.intervalTime < 3000)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.view.ActivityItem.command01"));
                  return;
               }
               HeroRoadManager.instance.buyPackage(_data.templateId);
               clearData();
               HeroRoadManager.instance.popTaskArr.shift();
               dispose();
            }
         }
      }
      
      private function _timerCompleteHandler(param1:Event) : void
      {
         _countTime.visible = false;
         _isOverTime = true;
         _descTxt.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTip.timeStr02");
         _descTxt.x = 225;
         HeroRoadManager.instance.popTaskArr.shift();
         clearData();
         NotificationManager.instance.dispatchEvent(new NotificationEvent("HEROROAD_ACHIEVEMENT_CLOSE_GIFTFRAME"));
      }
      
      private function clearData() : void
      {
         HeroRoadManager.instance.currentPopTemplateId = 0;
         HeroRoadManager.instance.currentLeftSecond = 0;
         HeroRoadManager.instance.count = 0;
      }
      
      public function set data(param1:AchievementTaskInfo) : void
      {
         var _loc8_:AchievementTaskTemplateInfo = null;
         var _loc2_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:AchievementTaskBuyDropTemplateInfo = null;
         var _loc3_:BaseItemView = null;
         var _loc6_:int = 0;
         var _loc7_:GoodsInfo = null;
         _data = param1;
         if(!_data)
         {
            clear();
         }
         else
         {
            if(_hbox)
            {
               _hbox.disposeAllChildren();
            }
            _countTime.visible = true;
            _getBtn.visible = true;
            _descTxt.visible = true;
            _loc8_ = TempleteManager.instance.achievementTaskTemplateCate.getTemplateByID(_data.templateId);
            if(_loc8_)
            {
               _packageNameTxt.text = _loc8_.PackageName;
            }
            _loc2_ = TempleteManager.instance.achievementTaskBuyDropTemplateCate.getTemplatesByTaskId(_data.templateId);
            _loc4_ = int(_loc2_.length);
            if(_loc4_ > 0)
            {
               _loc6_ = 0;
               while(_loc6_ < _loc4_)
               {
                  _loc5_ = _loc2_[_loc6_] as AchievementTaskBuyDropTemplateInfo;
                  _loc3_ = ComponentFactory.Instance.creatCustomObject("heroRoadAchievementItemView.ItemBaseItemView");
                  _loc7_ = new GoodsInfo();
                  if(_loc5_)
                  {
                     _loc7_.templateId = _loc5_.itemId;
                     _loc7_.count = _loc5_.count;
                     _loc3_.data = _loc7_;
                     _hbox.addChild(_loc3_);
                     _priceTxt.text = _loc5_.para2.toString();
                     _priceNumber = _loc5_.para2;
                  }
                  _loc6_++;
               }
            }
         }
      }
      
      private function clear() : void
      {
         if(_hbox)
         {
            _hbox.disposeAllChildren();
         }
         _packageNameTxt.text = "";
         _countTime.visible = false;
         _descTxt.visible = false;
         _getBtn.visible = false;
         _priceTxt.text = "";
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,551,406);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show(param1:AchievementTaskInfo) : void
      {
         data = param1;
         LayerManager.Instance.addToLayer(this,2,true,true,1,0,true);
         if(_data)
         {
            HeroRoadManager.instance.popBuyFrame(_data.templateId);
         }
         HeroRoadManager.instance.giftFrameHasOpen = true;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         HeroRoadManager.instance.giftFrameHasOpen = false;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_hbox);
         _hbox = null;
         ObjectUtils.disposeObject(_packageNameTxt);
         _packageNameTxt = null;
         ObjectUtils.disposeObject(_descTxt);
         _descTxt = null;
         ObjectUtils.disposeObject(_priceTxt);
         _priceTxt = null;
         ObjectUtils.disposeObject(_getBtn);
         _getBtn = null;
         ObjectUtils.disposeObject(_countTime);
         _countTime = null;
         super.dispose();
      }
   }
}

