package customizedvip
{
   import battle.utils.Helpers;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.CustomizedVipManager;
   import managers.VIPManager;
   import mvc.ModuleFrameInfo;
   import mvc.module.customizedvip.CustomizedVipBoxInfo;
   import mvc.module.customizedvip.CustomizedVipModel;
   import mvc.module.vip.VIPModel;
   import utils.LogicUtils;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.events.NotificationEvent;
   import yishi.events.PlayerEvent;
   import yishi.filter.UIFilter;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.GoodsHelp;
   import yishi.utils.MsgMan;
   
   public class CustomizedVipMainFrame extends Frame implements IManualSize
   {
      
      private var _border:ScaleBitmapImage;
      
      private var _leftBg:MutipleImage;
      
      private var _vipChargeBtn:IconButton;
      
      private var _alertText:FilterFrameText;
      
      private var _timeText:FilterFrameText;
      
      private var _levelPanel:ScrollPanel;
      
      private var _levelBox:VBox;
      
      private var _openedMc:MovieClip;
      
      private var _noOpenMc:MovieClip;
      
      private var _rewardMcCon:Component;
      
      private var itemList:Vector.<CustomizedVipRightItem>;
      
      private var vipBoxState:int;
      
      public function CustomizedVipMainFrame()
      {
         super();
         initView();
         addEvent();
         CustomizedVipManager.instance.sendCustomizedVipReq(0);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,758,576);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _border = ComponentFactory.Instance.creatComponentByStylename("CustomizedVipMainFrame.border");
         _leftBg = ComponentFactory.Instance.creatComponentByStylename("CustomizedVipMainFrame.leftBg");
         _vipChargeBtn = ComponentFactory.Instance.creatComponentByStylename("CustomizedVipMainFrame.vipChargeBtn");
         _alertText = ComponentFactory.Instance.creatComponentByStylename("CustomizedVipMainFrame.alertText");
         _timeText = ComponentFactory.Instance.creatComponentByStylename("CustomizedVipMainFrame.timeText");
         _levelPanel = ComponentFactory.Instance.creatComponentByStylename("CustomizedVipMainFrame.levelPanel");
         _levelBox = ComponentFactory.Instance.creatComponentByStylename("CustomizedVipMainFrame.levelBox");
         _openedMc = ComponentFactory.Instance.creatCustomObject("CustomizedVipMainFrame.openedMc");
         _noOpenMc = ComponentFactory.Instance.creatCustomObject("CustomizedVipMainFrame.noOpenMc");
         _rewardMcCon = ComponentFactory.Instance.creatComponentByStylename("CustomizedVipMainFrame.rewardMcCon");
         addToContent(_border);
         addToContent(_leftBg);
         addToContent(_alertText);
         addToContent(_rewardMcCon);
         addToContent(_vipChargeBtn);
         addToContent(_timeText);
         addToContent(_levelPanel);
         _levelPanel.setView(_levelBox);
         _rewardMcCon.addChild(_noOpenMc);
         _rewardMcCon.addChild(_openedMc);
         _noOpenMc.gotoAndStop(1);
         _noOpenMc.visible = false;
         _openedMc.gotoAndStop(1);
         _openedMc.visible = false;
         _alertText.text = LanguageMgr.GetTranslation("CustomizedVipMainFrame.alertText.text");
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         if(_vipChargeBtn)
         {
            _vipChargeBtn.addEventListener("click",__openVipHandler);
         }
         if(_rewardMcCon)
         {
            _rewardMcCon.addEventListener("click",__getVipRewardHandler);
         }
         NotificationManager.instance.addEventListener("REFRESH_TOPTOOLS",__updateTimeHandler);
         MsgMan.addObserver("REWARD_ITEM_SELECT",this,__openCustomizedFrame);
         MsgMan.addObserver("CUSTOMIZED_INFO_CHANGE",this,__updateCustomizedInfoHandler);
         playerModel.addEventListener("SYSTIME_UPGRADE_SECOND",__leftTimeHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_vipChargeBtn)
         {
            _vipChargeBtn.removeEventListener("click",__openVipHandler);
         }
         if(_rewardMcCon)
         {
            _rewardMcCon.removeEventListener("click",__getVipRewardHandler);
         }
         NotificationManager.instance.removeEventListener("REFRESH_TOPTOOLS",__updateTimeHandler);
         MsgMan.removeObserver("REWARD_ITEM_SELECT",this,__openCustomizedFrame);
         MsgMan.removeObserver("CUSTOMIZED_INFO_CHANGE",this,__updateCustomizedInfoHandler);
         playerModel.removeEventListener("SYSTIME_UPGRADE_SECOND",__leftTimeHandler);
      }
      
      private function __leftTimeHandler(param1:PlayerEvent) : void
      {
         refreshLeftTime();
      }
      
      private function __updateTimeHandler(param1:NotificationEvent) : void
      {
         refreshLeftTime();
      }
      
      private function __openVipHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("vip");
      }
      
      private function __getVipRewardHandler(param1:MouseEvent) : void
      {
         if(vipBoxState != 1)
         {
            return;
         }
         CustomizedVipManager.instance.sendCustomizedVipReq(1);
      }
      
      private function __openCustomizedFrame(param1:String, param2:Object) : void
      {
         if(!param2 || param2.type != 1)
         {
            return;
         }
         var _loc3_:CustomizedVipBoxInfo = param2.boxInfo as CustomizedVipBoxInfo;
         FrameControllerManager.instance.openControllerByInfo("customizedvip","CUSTOMIZED_FRAME",_loc3_);
      }
      
      private function __updateCustomizedInfoHandler(param1:String, param2:Object) : void
      {
         var _loc3_:int = param2 as int;
         if(_loc3_ == 0)
         {
            if(vipModel.vipInfo.IsVipAndNoExpirt && vipModel.vipInfo.VipType != 2)
            {
               vipBoxState = model.vipFreeCount;
            }
            else
            {
               vipBoxState = -1;
            }
            refreshLeftTime();
            refreshVipBoxView();
            refreshListView();
            _rewardMcCon.tipData = LanguageMgr.GetTranslation("SpiritExpeditionRewardItem.rewardItem.tip") + "\n" + GoodsHelp.getRewardDesc(vipRewardArys);
         }
         else if(_loc3_ == 1)
         {
            if(vipBoxState == 1 && model.vipFreeCount == 0)
            {
               _openedMc.visible = true;
               _openedMc.gotoAndPlay(1);
               _noOpenMc.visible = false;
               _noOpenMc.gotoAndStop(1);
            }
            else
            {
               refreshVipBoxView();
            }
            vipBoxState = model.vipFreeCount;
         }
         else if(_loc3_ == 2)
         {
            refreshListView();
         }
      }
      
      private function refreshLeftTime() : void
      {
         if(model.isOpen == false)
         {
            dispose();
            return;
         }
         var _loc2_:int = (model.endDate.time - playerModel.sysCurtime.time) / 1000;
         var _loc1_:String = LanguageMgr.GetTranslation("warlords.WarlordsBetFrame.str02");
         if(_loc2_ > 0)
         {
            _loc1_ = DateFormatter.getDefaultFullDateString(_loc2_);
         }
         _timeText.htmlText = LanguageMgr.GetTranslation("CustomizedVipMainFrame.timeText.text",_loc1_);
      }
      
      private function refreshVipBoxView() : void
      {
         _rewardMcCon.buttonMode = false;
         if(vipBoxState == -1)
         {
            _rewardMcCon.filters = [UIFilter.getGrayFilter()];
            _noOpenMc.visible = true;
            _noOpenMc.gotoAndStop(1);
            _openedMc.visible = false;
            _openedMc.gotoAndStop(1);
         }
         else
         {
            _rewardMcCon.filters = [];
            if(vipBoxState == 1)
            {
               _rewardMcCon.buttonMode = true;
               _noOpenMc.visible = true;
               _noOpenMc.gotoAndPlay(1);
               _openedMc.visible = false;
               _openedMc.gotoAndStop(1);
            }
            else
            {
               _noOpenMc.visible = false;
               _noOpenMc.gotoAndStop(1);
               _openedMc.visible = true;
               _openedMc.gotoAndStop(_openedMc.totalFrames);
            }
         }
      }
      
      private function get vipRewardArys() : Array
      {
         var _loc2_:int = 0;
         var _loc1_:Array = [];
         if(!model.vipBoxRewardInfo)
         {
            return _loc1_;
         }
         for each(var _loc3_:Array in model.vipBoxRewardInfo.customizedItemDic)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc3_.length)
            {
               _loc1_.push(_loc3_[_loc2_]);
               _loc2_++;
            }
         }
         return _loc1_;
      }
      
      private function refreshListView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:CustomizedVipRightItem = null;
         LogicUtils.disposeDisplayCollection(itemList);
         itemList = null;
         itemList = new Vector.<CustomizedVipRightItem>();
         var _loc2_:Array = Helpers.getKeyList(model.customizedBoxDic);
         _levelPanel.beginChanges();
         _levelBox.removeAllChild();
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc1_ = new CustomizedVipRightItem();
            _loc1_.data = model.customizedBoxDic[_loc2_[_loc3_].toString()];
            _levelBox.addChild(_loc1_);
            itemList.push(_loc1_);
            _loc3_++;
         }
         _levelBox.commitChanges();
         _levelPanel.invalidateViewport();
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
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         titleText = LanguageMgr.GetTranslation("ui.toptoolbar.TopToolsBar.tipData_customizedvip");
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      private function get model() : CustomizedVipModel
      {
         return CustomizedVipManager.instance.model;
      }
      
      private function get vipModel() : VIPModel
      {
         return VIPManager.Instance.model;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         KeyBoardRegister.instance.keyEnable = true;
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_leftBg);
         _leftBg = null;
         ObjectUtils.disposeObject(_alertText);
         _alertText = null;
         ObjectUtils.disposeObject(_vipChargeBtn);
         _vipChargeBtn = null;
         ObjectUtils.disposeObject(_timeText);
         _timeText = null;
         ObjectUtils.disposeObject(_levelPanel);
         _levelPanel = null;
         ObjectUtils.disposeObject(_levelBox);
         _levelBox = null;
         ObjectUtils.disposeObject(_rewardMcCon);
         _rewardMcCon = null;
         ObjectUtils.disposeViolentMc(_noOpenMc);
         _noOpenMc = null;
         ObjectUtils.disposeViolentMc(_openedMc);
         _openedMc = null;
         LogicUtils.disposeDisplayCollection(itemList);
         itemList = null;
         super.dispose();
      }
   }
}

