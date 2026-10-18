package gamehall.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.GameHallEvent;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import gamehall.room.GameHallBuyBufferView;
   import gamehall.room.GameHallSceneEastBlessItem;
   import manager.LanguageMgr;
   import managers.GameHallManager;
   import managers.PlayerCurrencyManager;
   import mvc.module.currency.PlayerCurrencyInfo;
   import mvc.module.gamehall.GameHallModel;
   import mvc.module.gamehall.GameHallUserInfo;
   import utils.LogicUtils;
   import yishi.datas.templates.GameHallEasterTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.scene.SceneManager;
   import yishi.utils.DateFormatter;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class GameHallActiveEastView extends Sprite
   {
      
      private var _centerBg:MovieClip;
      
      private var _acvityTimeTxt:FilterFrameText;
      
      private var _eggsNumTxt:FilterFrameText;
      
      private var _ticksNumTxt:FilterFrameText;
      
      private var _helpBtn:BaseButton;
      
      private var _buyTicksBtn:BaseButton;
      
      private var _goOuterCityBtn:BaseButton;
      
      private var _openShopBtn:BaseButton;
      
      private var _goCampaignRoomBtn:BaseButton;
      
      private var _tipMuliteImage:MutipleImage;
      
      private var _tipsTxt1:FilterFrameText;
      
      private var _tipsTxt2:FilterFrameText;
      
      private var _tipsTxt3:FilterFrameText;
      
      private var _vbox:VBox;
      
      private var _itemList:Vector.<GameHallActiveEastItemView>;
      
      private var _callBack:Function;
      
      private var _model:GameHallModel;
      
      private var _timer:Timer;
      
      private var _count:int;
      
      private var _pageNumber:FilterFrameText;
      
      private var _pageBg:Image;
      
      private var _nextBtn:BaseButton;
      
      private var _preBtn:BaseButton;
      
      private var _firstPageBtn:BaseButton;
      
      private var _lastPageBtn:BaseButton;
      
      private var _selfBufferBg:Image;
      
      private var _buyBufferBg:Image;
      
      private var _item:GameHallSceneEastBlessItem;
      
      private var _gameHallBuyBufferView:GameHallBuyBufferView;
      
      public function GameHallActiveEastView(param1:Function = null)
      {
         super();
         _callBack = param1;
         _model = GameHallManager.instance.model;
         GameHallManager.instance.opEastFrame(0);
         _model.setCurrentPage();
         initView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _centerBg = ComponentFactory.Instance.creatCustomObject("gamehall.GameHallEastView.centerBg");
         _acvityTimeTxt = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastView.acvityTimeTxt");
         _eggsNumTxt = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastView.eggsNumTxt");
         _ticksNumTxt = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastView.ticksNumTxt");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastView.helpBtn");
         _buyTicksBtn = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastView.buyTicksBtn");
         _goOuterCityBtn = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastView.goOuterCityBtn");
         _openShopBtn = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastView.openShopBtn");
         _goCampaignRoomBtn = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastView.goCampaignRoomBtn");
         _vbox = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastView.vbox");
         _tipMuliteImage = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastView.tipMuliteImage");
         _tipsTxt1 = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastView.tipsTxt1");
         _tipsTxt2 = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastView.tipsTxt2");
         _tipsTxt3 = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallEastView.tipsTxt3");
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallTeamEastLeftView.pageBg");
         _pageNumber = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallTeamEastLeftView.pageNumber");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallTeamEastLeftView.nextBtn");
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallTeamEastLeftView.preBtn");
         _firstPageBtn = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallTeamEastLeftView.firstPageBtn");
         _lastPageBtn = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallTeamEastLeftView.lastPageBtn");
         _buyBufferBg = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallTeamEastLeftView.buyBufferBg");
         _selfBufferBg = ComponentFactory.Instance.creatComponentByStylename("gamehall.GameHallTeamEastLeftView.selfBufferBg");
         _gameHallBuyBufferView = new GameHallBuyBufferView();
         _gameHallBuyBufferView.x = 470;
         _gameHallBuyBufferView.y = 340;
         addChild(_centerBg);
         addChild(_tipMuliteImage);
         addChild(_acvityTimeTxt);
         addChild(_eggsNumTxt);
         addChild(_ticksNumTxt);
         addChild(_helpBtn);
         addChild(_buyTicksBtn);
         addChild(_goOuterCityBtn);
         addChild(_openShopBtn);
         addChild(_goCampaignRoomBtn);
         addChild(_tipsTxt1);
         addChild(_tipsTxt2);
         addChild(_tipsTxt3);
         addChild(_pageBg);
         addChild(_pageNumber);
         addChild(_nextBtn);
         addChild(_preBtn);
         addChild(_firstPageBtn);
         addChild(_lastPageBtn);
         addChild(_vbox);
         _vbox.x = 687;
         _vbox.y = 35;
         addChild(_buyBufferBg);
         _buyBufferBg.visible = false;
         addChild(_selfBufferBg);
         addChild(_gameHallBuyBufferView);
         _pageBg.x = 780;
         _pageBg.y = 458;
         _pageNumber.x = 783;
         _pageNumber.y = 463;
         _nextBtn.x = 845;
         _lastPageBtn.x = 885;
         _preBtn.x = 745;
         _firstPageBtn.x = 700;
         _nextBtn.y = _lastPageBtn.y = _preBtn.y = _firstPageBtn.y = 460;
         _tipsTxt1.text = LanguageMgr.GetTranslation("gamehall.view.GameHallActiveEastView.tipsTxt1");
         _tipsTxt2.text = LanguageMgr.GetTranslation("gamehall.view.GameHallActiveEastView.tipsTxt2");
         _tipsTxt3.text = LanguageMgr.GetTranslation("gamehall.view.GameHallActiveEastView.tipsTxt3");
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeViolentMc(_centerBg);
         _centerBg = null;
         ObjectUtils.disposeObject(_acvityTimeTxt);
         _acvityTimeTxt = null;
         ObjectUtils.disposeObject(_eggsNumTxt);
         _eggsNumTxt = null;
         ObjectUtils.disposeObject(_ticksNumTxt);
         _ticksNumTxt = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_buyTicksBtn);
         _buyTicksBtn = null;
         ObjectUtils.disposeObject(_goOuterCityBtn);
         _goOuterCityBtn = null;
         ObjectUtils.disposeObject(_openShopBtn);
         _openShopBtn = null;
         ObjectUtils.disposeObject(_goCampaignRoomBtn);
         _goCampaignRoomBtn = null;
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
         ObjectUtils.disposeObject(_tipMuliteImage);
         _tipMuliteImage = null;
         ObjectUtils.disposeObject(_tipsTxt1);
         _tipsTxt1 = null;
         ObjectUtils.disposeObject(_tipsTxt2);
         _tipsTxt2 = null;
         ObjectUtils.disposeObject(_tipsTxt3);
         _tipsTxt3 = null;
         ObjectUtils.disposeObject(_pageBg);
         _pageBg = null;
         ObjectUtils.disposeObject(_pageNumber);
         _pageNumber = null;
         ObjectUtils.disposeObject(_nextBtn);
         _nextBtn = null;
         ObjectUtils.disposeObject(_preBtn);
         _preBtn = null;
         ObjectUtils.disposeObject(_firstPageBtn);
         _firstPageBtn = null;
         ObjectUtils.disposeObject(_lastPageBtn);
         _lastPageBtn = null;
         ObjectUtils.disposeObject(_buyBufferBg);
         _buyBufferBg = null;
         ObjectUtils.disposeObject(_selfBufferBg);
         _selfBufferBg = null;
         ObjectUtils.disposeObject(_item);
         _item = null;
         ObjectUtils.disposeObject(_gameHallBuyBufferView);
         _gameHallBuyBufferView = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__onTimer);
            _timer = null;
         }
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
         _callBack = null;
         _model = null;
      }
      
      private function addEvent() : void
      {
         if(_helpBtn)
         {
            _helpBtn.addEventListener("click",__helpBtnHandler);
         }
         if(_buyTicksBtn)
         {
            _buyTicksBtn.addEventListener("click",__buyTicksBtnHandler);
         }
         if(_goOuterCityBtn)
         {
            _goOuterCityBtn.addEventListener("click",__goOuterCityBtnHandler);
         }
         if(_openShopBtn)
         {
            _openShopBtn.addEventListener("click",__openShopBtnHandler);
         }
         if(_goCampaignRoomBtn)
         {
            _goCampaignRoomBtn.addEventListener("click",__goCampaignRoomBtnHandler);
         }
         if(model)
         {
            model.addEventListener("SELECTED_GAME_INFO_UPDATE",__gameInfoUpdateHandler);
         }
         if(model)
         {
            model.addEventListener("UPDATE_EAST_TEAMLEFTVIEW",__refreshViewHandler);
         }
         if(model)
         {
            model.addEventListener("UPDATE_WISHINFO",__refreshViewHandler);
         }
         if(_preBtn)
         {
            _preBtn.addEventListener("click",__onPageBtnHandler);
         }
         if(_nextBtn)
         {
            _nextBtn.addEventListener("click",__onPageBtnHandler);
         }
         if(_firstPageBtn)
         {
            _firstPageBtn.addEventListener("click",__firstPageBtnHandler);
         }
         if(_lastPageBtn)
         {
            _lastPageBtn.addEventListener("click",__lastPageBtnHandler);
         }
         if(_model)
         {
            _model.addEventListener("PAGE_UPDATE",__refreshPage);
         }
         if(_model)
         {
            _model.addEventListener("UPDATE_WISHINFO",__refreshBufferInfo);
         }
         NotificationManager.instance.addEventListener("CURRENCYREFRESH",__updateGodwinerPoint);
      }
      
      private function removeEvent() : void
      {
         if(_helpBtn)
         {
            _helpBtn.removeEventListener("click",__helpBtnHandler);
         }
         if(_buyTicksBtn)
         {
            _buyTicksBtn.removeEventListener("click",__buyTicksBtnHandler);
         }
         if(_goOuterCityBtn)
         {
            _goOuterCityBtn.removeEventListener("click",__goOuterCityBtnHandler);
         }
         if(_openShopBtn)
         {
            _openShopBtn.removeEventListener("click",__openShopBtnHandler);
         }
         if(_goCampaignRoomBtn)
         {
            _goCampaignRoomBtn.removeEventListener("click",__goCampaignRoomBtnHandler);
         }
         if(model)
         {
            model.removeEventListener("SELECTED_GAME_INFO_UPDATE",__gameInfoUpdateHandler);
         }
         if(model)
         {
            model.removeEventListener("UPDATE_EAST_TEAMLEFTVIEW",__refreshViewHandler);
         }
         if(model)
         {
            model.removeEventListener("UPDATE_WISHINFO",__refreshViewHandler);
         }
         if(_preBtn)
         {
            _preBtn.removeEventListener("click",__onPageBtnHandler);
         }
         if(_nextBtn)
         {
            _nextBtn.removeEventListener("click",__onPageBtnHandler);
         }
         if(_firstPageBtn)
         {
            _firstPageBtn.removeEventListener("click",__firstPageBtnHandler);
         }
         if(_lastPageBtn)
         {
            _lastPageBtn.removeEventListener("click",__lastPageBtnHandler);
         }
         if(_model)
         {
            _model.removeEventListener("PAGE_UPDATE",__refreshPage);
         }
         if(_model)
         {
            _model.removeEventListener("UPDATE_WISHINFO",__refreshBufferInfo);
         }
         NotificationManager.instance.removeEventListener("CURRENCYREFRESH",__updateGodwinerPoint);
      }
      
      private function __helpBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("gamehall.HelpFrame4");
         _loc2_.show();
      }
      
      private function __buyTicksBtnHandler(param1:MouseEvent) : void
      {
         _model.buyTicks();
      }
      
      private function __goOuterCityBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         SoundManager.instance.play("035",true);
         if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE")
         {
            _loc2_ = LanguageMgr.GetTranslation("mainBar.MainToolBar.command01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         SceneManager.instance.setScene("OUTER_CITY_SCENE");
      }
      
      private function __openShopBtnHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("gamehall","OPEN_EAST_SHOP");
      }
      
      private function __goCampaignRoomBtnHandler(param1:MouseEvent) : void
      {
         _timer = new Timer(150,4);
         _timer.addEventListener("timer",__onTimer);
         _timer.start();
      }
      
      private function __onTimer(param1:TimerEvent) : void
      {
         var _loc2_:GameHallActiveEastItemView = null;
         var _loc4_:int = 0;
         var _loc3_:int = int(_itemList.length);
         _count = _count + 1;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = _itemList[_loc4_] as GameHallActiveEastItemView;
            if(_loc2_ && _loc2_.data)
            {
               if(_count % 2 == 0)
               {
                  _loc2_.__mouseOutHandler(null);
               }
               else
               {
                  _loc2_.__mouseOverHandler(null);
               }
            }
            _loc4_++;
         }
      }
      
      private function __gameInfoUpdateHandler(param1:GameHallEvent) : void
      {
         var _loc2_:GameHallActiveEastItemView = null;
         var _loc4_:int = 0;
         var _loc3_:int = int(model.selectedDifficulty);
         _loc4_ = 0;
         while(_loc4_ < _itemList.length)
         {
            _loc2_ = _itemList[_loc4_] as GameHallActiveEastItemView;
            if(!_loc2_)
            {
               return;
            }
            if(_loc2_.data && _loc3_ == _loc2_.data.TemplateId)
            {
               _loc2_.selected = true;
            }
            else
            {
               _loc2_.selected = false;
            }
            _loc4_++;
         }
      }
      
      private function __onPageBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _model.pageBtnHandler(param1.currentTarget == _preBtn);
      }
      
      private function __firstPageBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _model.currentPage = 1;
         _model.commitChange();
      }
      
      private function __lastPageBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _model.currentPage = _model.totalPage;
         _model.commitChange();
      }
      
      private function __refreshPage(param1:GameHallEvent) : void
      {
         _pageNumber.text = _model.currentPage + "/" + _model.totalPage;
         refreshView();
         setPageBtnEnable();
      }
      
      private function __refreshBufferInfo(param1:GameHallEvent) : void
      {
         _gameHallBuyBufferView.refrehView();
         refreshWishInfo();
      }
      
      private function refreshWishInfo() : void
      {
         if(_item && _item.parent)
         {
            _item.parent.removeChild(_item);
         }
         var _loc1_:GameHallUserInfo = new GameHallUserInfo();
         _loc1_.buffs = model.wishArray;
         if(model.wishLevelAllZero)
         {
            _buyBufferBg.visible = false;
         }
         else
         {
            _buyBufferBg.visible = true;
            _item = new GameHallSceneEastBlessItem();
            _item.x = 470;
            _item.y = 400;
            _item.tipsType = 1;
            _item.data = _loc1_;
            addChild(_item);
         }
      }
      
      private function setPageBtnEnable() : void
      {
         if(_preBtn)
         {
            _preBtn.enable = _model.currentPage > 1;
         }
         if(_preBtn)
         {
            _nextBtn.enable = _model.currentPage < _model.totalPage;
         }
         if(_firstPageBtn)
         {
            _firstPageBtn.enable = _model.currentPage > 1;
         }
         if(_lastPageBtn)
         {
            _lastPageBtn.enable = _model.currentPage < _model.totalPage;
         }
      }
      
      public function refreshView() : void
      {
         var _loc4_:int = 0;
         var _loc2_:GameHallActiveEastItemView = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:GameHallEasterTemplateInfo = null;
         _acvityTimeTxt.text = DateFormatter.timeFormat1(_model.eastOpenDate) + " -- " + DateFormatter.timeFormat1(_model.eastEndDate);
         if(_gameHallBuyBufferView)
         {
            _gameHallBuyBufferView.refrehView();
         }
         refreshCurrentInfo();
         refreshWishInfo();
         if(_vbox)
         {
            _vbox.disposeAllChildren();
         }
         _itemList = new Vector.<GameHallActiveEastItemView>();
         _loc4_ = 0;
         while(_loc4_ < 5)
         {
            _loc2_ = new GameHallActiveEastItemView(_callBack);
            _loc2_.data = null;
            _itemList.push(_loc2_);
            if(_vbox)
            {
               _vbox.addChild(_loc2_);
            }
            _loc4_++;
         }
         var _loc1_:Array = _model.eastOpenTemplateIdArr;
         _loc6_ = 0;
         while(_loc6_ < _itemList.length)
         {
            _loc5_ = _loc6_ + (_model.currentPage - 1) * 5;
            _loc3_ = new GameHallEasterTemplateInfo();
            if(_loc5_ < _loc1_.length)
            {
               _loc3_ = TempleteManager.instance.gameHallEastTemplateCate.getTemplateByID(_loc1_[_loc5_]);
               _itemList[_loc6_].data = _loc3_;
            }
            else
            {
               _itemList[_loc6_].data = null;
            }
            _loc6_++;
         }
         if(_pageNumber)
         {
            _pageNumber.text = _model.currentPage + "/" + _model.totalPage;
         }
         setPageBtnEnable();
      }
      
      private function __refreshViewHandler(param1:GameHallEvent) : void
      {
         refreshView();
      }
      
      private function __updateGodwinerPoint(param1:NotificationEvent) : void
      {
         refreshCurrentInfo();
      }
      
      private function refreshCurrentInfo() : void
      {
         if(currencyInfo.eastEggCoin)
         {
            _eggsNumTxt.text = currencyInfo.eastEggCoin.amount.toString();
         }
         if(currencyInfo.eastTickesCoin)
         {
            _ticksNumTxt.text = currencyInfo.eastTickesCoin.amount.toString();
         }
      }
      
      private function get currencyInfo() : PlayerCurrencyInfo
      {
         return PlayerCurrencyManager.instance.currencyInfo;
      }
      
      private function get model() : GameHallModel
      {
         return GameHallManager.instance.model;
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
      }
   }
}

