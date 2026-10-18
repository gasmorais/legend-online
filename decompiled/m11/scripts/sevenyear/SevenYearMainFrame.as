package sevenyear
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.SevenYearEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.GloryGameManager;
   import managers.SevenYearManager;
   import mvc.module.gloryGame.event.GloryGameEvent;
   import mvc.module.sevenyear.SevenYearModel;
   import sevenyear.view.SevenYearAchievementView;
   import sevenyear.view.SevenYearBattleFlagView;
   import sevenyear.view.SevenYearGloryGameView;
   import sevenyear.view.SevenYearShopView;
   import sevenyear.view.SevenYearStarAreaView;
   import yishi.utils.DateFormatter;
   import yishi.view.base.TabPageUtil;
   import yishi.view.tips.MessageTipManager;
   
   public class SevenYearMainFrame extends Frame implements IManualSize
   {
      
      private var _titleBg:Image;
      
      private var _titleTxtImg:Image;
      
      private var _tabPageUtil:TabPageUtil;
      
      private var _battleFlagBtn:SelectedIconButton;
      
      private var _starAreaBtn:SelectedIconButton;
      
      private var _gloryGameBtn:SelectedIconButton;
      
      private var _achievementBtn:SelectedIconButton;
      
      private var _shopBtn:SelectedIconButton;
      
      private var _btnHbox:HBox;
      
      private var _border:ScaleBitmapImage;
      
      private var _txtTime:FilterFrameText;
      
      public function SevenYearMainFrame()
      {
         super();
         initView();
         initBtnView();
         initEvent();
         refreshView();
         SevenYearManager.instance.sendOp(0);
      }
      
      private function initView() : void
      {
         _titleBg = ComponentFactory.Instance.creatComponentByStylename("SevenYearMainFrame.titleBg");
         _titleTxtImg = ComponentFactory.Instance.creatComponentByStylename("SevenYearMainFrame.titleTxt");
         _battleFlagBtn = ComponentFactory.Instance.creatComponentByStylename("SevenYearMainFrame.battleFlagBtn");
         _starAreaBtn = ComponentFactory.Instance.creatComponentByStylename("SevenYearMainFrame.starAreaBtn");
         _gloryGameBtn = ComponentFactory.Instance.creatComponentByStylename("SevenYearMainFrame.gloryGameBtn");
         _achievementBtn = ComponentFactory.Instance.creatComponentByStylename("SevenYearMainFrame.achievementBtn");
         _shopBtn = ComponentFactory.Instance.creatComponentByStylename("SevenYearMainFrame.shopBtn");
         _btnHbox = ComponentFactory.Instance.creatComponentByStylename("SevenYearMainFrame.btnHbox");
         _border = ComponentFactory.Instance.creatComponentByStylename("SevenYearMainFrame.border");
         addToContent(_titleBg);
         addToContent(_titleTxtImg);
         addToContent(_border);
         addToContent(_btnHbox);
         _btnHbox.addChild(_battleFlagBtn);
         _btnHbox.addChild(_starAreaBtn);
         _btnHbox.addChild(_gloryGameBtn);
         _btnHbox.addChild(_shopBtn);
         _btnHbox.addChild(_achievementBtn);
         _txtTime = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.txtMainTime");
         addToContent(_txtTime);
         _txtTime.text = LanguageMgr.GetTranslation("SevenYear.time",DateFormatter.timeFormat1(model.beginTime),DateFormatter.timeFormat1(model.endTime));
      }
      
      private function initBtnView() : void
      {
         _tabPageUtil = new TabPageUtil();
         _tabPageUtil.addItemPage(_battleFlagBtn,creatBattleFlagPage);
         _tabPageUtil.addItemPage(_starAreaBtn,creatStarAreaPage);
         _tabPageUtil.addItemPage(_gloryGameBtn,creatGloryGamePage);
         _tabPageUtil.addItemPage(_achievementBtn,creatAchievementPage);
         _tabPageUtil.addItemPage(_shopBtn,creatShopPage);
         _tabPageUtil.selectIndex = 0;
      }
      
      private function creatBattleFlagPage() : SevenYearBattleFlagView
      {
         var _loc1_:SevenYearBattleFlagView = ComponentFactory.Instance.creatCustomObject("SevenYearMainFrame.battleFlagView");
         addToContent(_loc1_);
         return _loc1_;
      }
      
      private function creatStarAreaPage() : SevenYearStarAreaView
      {
         var _loc1_:SevenYearStarAreaView = ComponentFactory.Instance.creatCustomObject("SevenYearMainFrame.starAreaView");
         addToContent(_loc1_);
         addToContent(_btnHbox);
         return _loc1_;
      }
      
      private function creatGloryGamePage() : SevenYearGloryGameView
      {
         var _loc1_:SevenYearGloryGameView = ComponentFactory.Instance.creatCustomObject("SevenYearMainFrame.gloryGameView");
         addToContent(_loc1_);
         return _loc1_;
      }
      
      private function creatAchievementPage() : SevenYearAchievementView
      {
         var _loc1_:SevenYearAchievementView = ComponentFactory.Instance.creatCustomObject("SevenYearMainFrame.achievementView");
         addToContent(_loc1_);
         return _loc1_;
      }
      
      private function creatShopPage() : SevenYearShopView
      {
         var _loc1_:SevenYearShopView = ComponentFactory.Instance.creatCustomObject("SevenYearMainFrame.shopView");
         addToContent(_loc1_);
         addToContent(_btnHbox);
         return _loc1_;
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_titleBg);
         _titleBg = null;
         ObjectUtils.disposeObject(_titleTxtImg);
         _titleTxtImg = null;
         ObjectUtils.disposeObject(_battleFlagBtn);
         _battleFlagBtn = null;
         ObjectUtils.disposeObject(_starAreaBtn);
         _starAreaBtn = null;
         ObjectUtils.disposeObject(_gloryGameBtn);
         _gloryGameBtn = null;
         ObjectUtils.disposeObject(_achievementBtn);
         _achievementBtn = null;
         ObjectUtils.disposeObject(_shopBtn);
         _shopBtn = null;
         ObjectUtils.disposeObject(_btnHbox);
         _btnHbox = null;
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_txtTime);
         _txtTime = null;
         ObjectUtils.disposeObject(_tabPageUtil);
         _tabPageUtil = null;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         model.addEventListener("UPDATE_ACTIVE_INFO",__updateActiveInfoHandler);
         GloryGameManager.instance.addEventListener("JUMP_TO_BET",jumpToBet);
         GloryGameManager.instance.addEventListener("JUMP_TO_SCHEDULE",jumpToSchedule);
         _gloryGameBtn.addEventListener("click",clickHandler,false,100);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         model.removeEventListener("UPDATE_ACTIVE_INFO",__updateActiveInfoHandler);
         GloryGameManager.instance.removeEventListener("JUMP_TO_BET",jumpToBet);
         GloryGameManager.instance.removeEventListener("JUMP_TO_SCHEDULE",jumpToSchedule);
         if(_gloryGameBtn)
         {
            _gloryGameBtn.removeEventListener("click",clickHandler);
         }
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         if(!GloryGameManager.instance.model.isOpen)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("SevenYearGloryGame.sign.str9"));
            param1.stopPropagation();
            param1.stopImmediatePropagation();
         }
      }
      
      private function jumpToBet(param1:GloryGameEvent) : void
      {
         GloryGameManager.instance.model.isJumpToBet = true;
         _tabPageUtil.selectIndex = 2;
      }
      
      private function jumpToSchedule(param1:GloryGameEvent) : void
      {
         GloryGameManager.instance.model.isJumpToSchedule = true;
         _tabPageUtil.selectIndex = 2;
      }
      
      private function __updateActiveInfoHandler(param1:SevenYearEvent) : void
      {
         if(!model.isOpen)
         {
            dispose();
         }
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show(param1:int = -1) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2);
         if(param1 == 1)
         {
            _tabPageUtil.selectIndex = 1;
         }
      }
      
      private function refreshView() : void
      {
      }
      
      private function get model() : SevenYearModel
      {
         return SevenYearManager.instance.model;
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,950,640);
      }
      
      override public function dispose() : void
      {
         SevenYearManager.instance.sendOp(8);
         removeEvent();
         uninitView();
         super.dispose();
      }
   }
}

