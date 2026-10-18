package wishpool
{
   import bottle.BottleNotic;
   import chat.datas.ChatData;
   import chat.utils.ChatFormat;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectPool;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import managers.WishPoolManager;
   import mvc.module.wishpool.WishPoolInfoVO;
   import mvc.module.wishpool.WishPoolModel;
   import utils.LogicUtils;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManagerHelper;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.view.community.BaseItemView;
   import yishi.view.community.TimeDownView;
   import yishi.view.tips.MessageTipManager;
   
   public class WishPoolFrame extends Frame implements Disposeable, IManualSize
   {
      
      private var _bg:MutipleImage;
      
      private var _refreshBtn:IconButton;
      
      private var _wishBtn:IconButton;
      
      private var _freeRefreshBtn:IconButton;
      
      private var _shopBtn:IconButton;
      
      private var _rewardShowPanel:ScrollPanel;
      
      private var _hasGetGoodsPanel:ScrollPanel;
      
      private var _hasGetGoodsVBox:VBox;
      
      private var _refreshCostTxt:FilterFrameText;
      
      private var _wishCostTxt:FilterFrameText;
      
      private var _descTxt:FilterFrameText;
      
      private var _timeDownView:TimeDownView;
      
      private var _centerContainer:Sprite;
      
      private var _itemList:Vector.<WishPoolItemView>;
      
      private var _refreshNeedPoint:int;
      
      private var _wishNeedPoint:int;
      
      private var _refreshLastClickTime:int = 0;
      
      private var _wishLastClickTime:int;
      
      private var _count:int;
      
      private var _successMovie:MovieClip;
      
      private var _failureMovie:MovieClip;
      
      private var _rewardGoodsList:Sprite;
      
      private var _hasGetGoodsList:Sprite;
      
      private var _leftTimeTxt:FilterFrameText;
      
      private var _countDownTime:Timer;
      
      private var _totalSecond:int;
      
      private var _upImage:ScaleFrameImage;
      
      private var _checkBtn:SelectedCheckButton;
      
      private var _checkBtnTxt:FilterFrameText;
      
      private var _hasPropText:FilterFrameText;
      
      private var _propNumBg:Bitmap;
      
      private var _pointImg:Image;
      
      private var _propIcon:Image;
      
      private const PROP_ID:int = 208524;
      
      public function WishPoolFrame()
      {
         super();
         WishPoolManager.instance.frameOperation(WishPoolManager.OPENFRAME,[]);
         initView();
         initEvent();
         initData();
         initRewardShowPanel();
         initHasGetGoodsPanel();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("wishpoolFrame.bg");
         _refreshBtn = ComponentFactory.Instance.creatComponentByStylename("wishpoolFrame.refreshBtn");
         _wishBtn = ComponentFactory.Instance.creatComponentByStylename("wishpoolFrame.wishBtn");
         _freeRefreshBtn = ComponentFactory.Instance.creatComponentByStylename("wishpoolFrame.freeRefreshBtn");
         _shopBtn = ComponentFactory.Instance.creatComponentByStylename("wishpoolFrame.shopBtn");
         _rewardShowPanel = ComponentFactory.Instance.creatComponentByStylename("wishpoolFrame.rewardShowPanel");
         _hasGetGoodsPanel = ComponentFactory.Instance.creatComponentByStylename("wishpoolFrame.hasGetGoodsPanel");
         _refreshCostTxt = ComponentFactory.Instance.creatComponentByStylename("wishpoolFrame.refreshCostTxt");
         _wishCostTxt = ComponentFactory.Instance.creatComponentByStylename("wishpoolFrame.wishCostTxt");
         _descTxt = ComponentFactory.Instance.creatComponentByStylename("wishpoolFrame.descTxt");
         _timeDownView = ComponentFactory.Instance.creatComponentByStylename("wishpoolFrame.timeDownView");
         _successMovie = ComponentFactory.Instance.creatCustomObject("wishpoolFrame.successMovie");
         _successMovie.visible = false;
         _failureMovie = ComponentFactory.Instance.creatCustomObject("wishpoolFrame.failureMovie");
         _failureMovie.visible = false;
         _centerContainer = new Sprite();
         _centerContainer.x = 195;
         _centerContainer.y = 65;
         _hasGetGoodsList = new Sprite();
         _rewardGoodsList = new Sprite();
         _hasGetGoodsVBox = ComponentFactory.Instance.creatComponentByStylename("wishpoolFrame.hasGetGoodsVBox");
         _upImage = ComponentFactory.Instance.creatComponentByStylename("wishpoolFrame.upImage");
         _leftTimeTxt = ComponentFactory.Instance.creatComponentByStylename("wishpoolFrame.leftTimeTxt");
         _checkBtnTxt = ComponentFactory.Instance.creatComponentByStylename("wishpool.checkBtnTxt");
         _checkBtn = ComponentFactory.Instance.creatComponentByStylename("wishpool.checkBtn");
         _propNumBg = ComponentFactory.Instance.creatBitmap("asset.wishpool.propBg");
         _propIcon = ComponentFactory.Instance.creatComponentByStylename("ui.wishpool.propIcon");
         _hasPropText = ComponentFactory.Instance.creatComponentByStylename("ui.wishpool.prophasTxt");
         _pointImg = ComponentFactory.Instance.creatComponentByStylename("ui.wishpool.pointImg");
         addToContent(_bg);
         addToContent(_refreshBtn);
         addToContent(_wishBtn);
         addToContent(_freeRefreshBtn);
         addToContent(_shopBtn);
         addToContent(_rewardShowPanel);
         addToContent(_hasGetGoodsPanel);
         addToContent(_refreshCostTxt);
         addToContent(_wishCostTxt);
         addToContent(_descTxt);
         addToContent(_timeDownView);
         addToContent(_centerContainer);
         addToContent(_successMovie);
         addToContent(_failureMovie);
         addToContent(_upImage);
         addToContent(_leftTimeTxt);
         addToContent(_checkBtnTxt);
         addToContent(_checkBtn);
         addToContent(_propNumBg);
         addToContent(_propIcon);
         addToContent(_hasPropText);
         addToContent(_pointImg);
         refreshPropIcons();
         refreshPropNums();
         _upImage.visible = false;
         _hasGetGoodsPanel.setView(_hasGetGoodsVBox);
         _freeRefreshBtn.visible = false;
         _descTxt.text = LanguageMgr.GetTranslation("wishpool.wishPoolFrame.descTxt");
         var _loc2_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(208524);
         var _loc1_:String = _loc2_ ? _loc2_.TemplateName : "";
         _checkBtnTxt.text = LanguageMgr.GetTranslation("wishpool.checkBtnTip",_loc1_);
         var _loc3_:GoodsInfo = new GoodsInfo();
         _loc3_.templateId = 208524;
         _propIcon.tipData = _loc3_;
      }
      
      private function uninitView() : void
      {
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_refreshBtn)
         {
            ObjectUtils.disposeObject(_refreshBtn);
         }
         _refreshBtn = null;
         if(_freeRefreshBtn)
         {
            ObjectUtils.disposeObject(_freeRefreshBtn);
         }
         _freeRefreshBtn = null;
         if(_wishBtn)
         {
            ObjectUtils.disposeObject(_wishBtn);
         }
         _wishBtn = null;
         if(_rewardShowPanel)
         {
            ObjectUtils.disposeObject(_rewardShowPanel);
         }
         _rewardShowPanel = null;
         if(_hasGetGoodsPanel)
         {
            ObjectUtils.disposeObject(_hasGetGoodsPanel);
         }
         _hasGetGoodsPanel = null;
         if(_refreshCostTxt)
         {
            ObjectUtils.disposeObject(_refreshCostTxt);
         }
         _refreshCostTxt = null;
         if(_wishCostTxt)
         {
            ObjectUtils.disposeObject(_wishCostTxt);
         }
         _wishCostTxt = null;
         if(_descTxt)
         {
            ObjectUtils.disposeObject(_descTxt);
         }
         _descTxt = null;
         if(_timeDownView)
         {
            ObjectUtils.disposeObject(_timeDownView);
         }
         _timeDownView = null;
         if(_shopBtn)
         {
            ObjectUtils.disposeObject(_shopBtn);
         }
         _shopBtn = null;
         if(_successMovie)
         {
            ObjectUtils.disposeViolentMc(_successMovie);
         }
         _successMovie = null;
         if(_failureMovie)
         {
            ObjectUtils.disposeViolentMc(_failureMovie);
         }
         _failureMovie = null;
         if(_hasGetGoodsList)
         {
            ObjectUtils.disposeObject(_hasGetGoodsList);
         }
         _hasGetGoodsList = null;
         if(_rewardGoodsList)
         {
            ObjectUtils.disposeObject(_rewardGoodsList);
         }
         _rewardGoodsList = null;
         if(_centerContainer)
         {
            ObjectUtils.disposeObject(_centerContainer);
         }
         _centerContainer = null;
         if(_upImage)
         {
            ObjectUtils.disposeObject(_upImage);
         }
         _upImage = null;
         if(_leftTimeTxt)
         {
            ObjectUtils.disposeObject(_leftTimeTxt);
         }
         _leftTimeTxt = null;
         if(_checkBtnTxt)
         {
            ObjectUtils.disposeObject(_checkBtnTxt);
         }
         _checkBtnTxt = null;
         if(_checkBtn)
         {
            ObjectUtils.disposeObject(_checkBtn);
         }
         _checkBtn = null;
         ObjectUtils.disposeObject(_propNumBg);
         _propNumBg = null;
         ObjectUtils.disposeObject(_propIcon);
         _propIcon = null;
         ObjectUtils.disposeObject(_hasPropText);
         _hasPropText = null;
         ObjectUtils.disposeObject(_pointImg);
         _pointImg = null;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         if(_refreshBtn)
         {
            _refreshBtn.addEventListener("click",__refreshBtnHandler);
         }
         if(_freeRefreshBtn)
         {
            _freeRefreshBtn.addEventListener("click",__freeRefreshBtnHandler);
         }
         if(_wishBtn)
         {
            _wishBtn.addEventListener("click",__wishBtnHandler);
         }
         if(_shopBtn)
         {
            _shopBtn.addEventListener("click",__shopBtnHandler);
         }
         if(_timeDownView)
         {
            _timeDownView.addEventListener("timerDown_complete",__timeCompleteHandler);
         }
         NotificationManager.instance.addEventListener("WISH_POOL_UPDATE_SELECTED",__updateSelectedHandler);
         NotificationManager.instance.addEventListener("WISH_POOL_WINDOW_INFO_UPDATE",__refreshWindowInfoHandler);
         NotificationManager.instance.addEventListener("WISH_POOL_COUNTDOWN_REFRESH",__countDownRefreshHandler);
         NotificationManager.instance.addEventListener("WISH_POOL_REFRESH",__wishPoolRefreshHandler);
         NotificationManager.instance.addEventListener("WISH_POOL_WISH",__wishPoolWishHandler);
         if(_checkBtn)
         {
            _checkBtn.addEventListener("select",_checkSelectHandler);
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_refreshBtn)
         {
            _refreshBtn.removeEventListener("click",__refreshBtnHandler);
         }
         if(_freeRefreshBtn)
         {
            _freeRefreshBtn.removeEventListener("click",__freeRefreshBtnHandler);
         }
         if(_wishBtn)
         {
            _wishBtn.removeEventListener("click",__wishBtnHandler);
         }
         if(_shopBtn)
         {
            _shopBtn.removeEventListener("click",__shopBtnHandler);
         }
         if(_timeDownView)
         {
            _timeDownView.removeEventListener("timerDown_complete",__timeCompleteHandler);
         }
         NotificationManager.instance.removeEventListener("WISH_POOL_UPDATE_SELECTED",__updateSelectedHandler);
         NotificationManager.instance.removeEventListener("WISH_POOL_WINDOW_INFO_UPDATE",__refreshWindowInfoHandler);
         NotificationManager.instance.removeEventListener("WISH_POOL_COUNTDOWN_REFRESH",__countDownRefreshHandler);
         NotificationManager.instance.removeEventListener("WISH_POOL_REFRESH",__wishPoolRefreshHandler);
         NotificationManager.instance.removeEventListener("WISH_POOL_WISH",__wishPoolWishHandler);
         if(_checkBtn)
         {
            _checkBtn.removeEventListener("select",_checkSelectHandler);
         }
         if(_countDownTime)
         {
            _countDownTime.stop();
            _countDownTime.removeEventListener("timer",__onTimer);
            _countDownTime = null;
         }
      }
      
      private function _checkSelectHandler(param1:Event) : void
      {
         refreshPropIcons();
      }
      
      private function initData() : void
      {
         var _loc1_:WishPoolItemView = null;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         _itemList = new Vector.<WishPoolItemView>();
         var _loc3_:Array = model.wishpoolArray;
         if(_loc3_)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               _loc1_ = new WishPoolItemView();
               _loc1_.x = 0 + _loc4_ % 5 * 73;
               _loc1_.y = int(_loc4_ / 5) * 76;
               _loc5_ = int(_loc3_[_loc4_]);
               _loc1_.data = model.totalWishDic[_loc5_];
               _centerContainer.addChild(_loc1_);
               _itemList.push(_loc1_);
               _loc4_++;
            }
         }
         _refreshCostTxt.text = model.refreshPrice.toString();
         resetWishBtnInfo();
         __countDownRefreshHandler(null);
         var _loc2_:Boolean = Boolean(model.isInActiveTime());
         if(!_loc2_)
         {
            _refreshBtn.enable = false;
            _freeRefreshBtn.enable = false;
         }
         else
         {
            _refreshBtn.enable = true;
            _freeRefreshBtn.enable = true;
         }
         if(model.endDate.time > playerModel.nowDate)
         {
            _totalSecond = (model.endDate.time - playerModel.nowDate) / 1000;
            _countDownTime = new Timer(1000,_totalSecond);
            _countDownTime.addEventListener("timer",__onTimer);
            _countDownTime.start();
         }
         else
         {
            _leftTimeTxt.text = LanguageMgr.GetTranslation("mainBar.TopToolsBar.rechargeBtn.click04");
         }
      }
      
      private function __onTimer(param1:TimerEvent) : void
      {
         var _loc2_:String = null;
         if(_totalSecond > 0)
         {
            _loc2_ = DateFormatter.getDefaultFullDateString(_totalSecond);
            _leftTimeTxt.text = LanguageMgr.GetTranslation("funny.FunnyRightView.active.remainTime",_loc2_);
            _totalSecond = _totalSecond - 1;
         }
         else
         {
            _leftTimeTxt.text = LanguageMgr.GetTranslation("mainBar.TopToolsBar.rechargeBtn.click04");
         }
      }
      
      private function initRewardShowPanel() : void
      {
         var _loc1_:BaseItemView = null;
         var _loc2_:WishPoolInfoVO = null;
         var _loc3_:int = 0;
         var _loc4_:MovieImage = null;
         if(!model.totalWishDic)
         {
            return;
         }
         if(_rewardGoodsList.numChildren > 0)
         {
            _rewardGoodsList.removeChildren(0,_rewardGoodsList.numChildren - 1);
         }
         _rewardShowPanel.beginChanges();
         _loc3_ = 0;
         while(_loc3_ < model.totalWishArray.length)
         {
            _loc2_ = model.totalWishArray[_loc3_];
            _loc1_ = ComponentFactory.Instance.creatCustomObject("wishpool.rightGoodsItemView");
            _loc1_.x = _loc3_ % 3 * 50;
            _loc1_.y = int(_loc3_ / 3) * 50;
            _loc1_.data = getGoodsInfo(_loc2_);
            _rewardGoodsList.addChild(_loc1_);
            if(_loc2_.isRare)
            {
               _loc4_ = ComponentFactory.Instance.creatComponentByStylename("funny.LightEffect");
               _loc4_.mouseEnabled = false;
               _loc4_.mouseChildren = false;
               _loc4_.x = _loc1_.x + 21;
               _loc4_.y = _loc1_.y - 29;
               _rewardGoodsList.addChild(_loc4_);
            }
            _loc3_++;
         }
         var _loc5_:int = Math.ceil(_loc3_ / 3);
         if(_loc5_ > 0)
         {
            _rewardGoodsList.scrollRect = new Rectangle(-8,0,155,_loc5_ * 50);
         }
         _rewardShowPanel.setView(_rewardGoodsList);
         _rewardShowPanel.invalidateViewport();
         _rewardShowPanel.commitChanges();
      }
      
      private function getGoodsInfo(param1:WishPoolInfoVO) : GoodsInfo
      {
         var _loc2_:GoodsInfo = new GoodsInfo();
         _loc2_.templateId = param1.tempalteId;
         _loc2_.count = param1.count;
         return _loc2_;
      }
      
      private function initHasGetGoodsPanel() : void
      {
         var _loc3_:int = 0;
         var _loc4_:BottleNotic = null;
         var _loc2_:ChatData = null;
         _hasGetGoodsVBox.removeAllChild();
         _hasGetGoodsVBox.disposeAllChildren();
         _hasGetGoodsVBox.beginChanges();
         var _loc1_:Array = model.successWishArray;
         if(_loc1_)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc1_.length)
            {
               _loc4_ = new BottleNotic();
               _loc2_ = ObjectPool.getObject(ChatData) as ChatData;
               _loc2_.channel = 111;
               _loc2_.msg = _loc1_[_loc3_];
               _loc2_.chatItemData.cellVector = ChatFormat.getContentCellData(_loc2_);
               _loc4_.lineWidth = 160;
               _loc4_.data = _loc2_;
               _hasGetGoodsVBox.addChild(_loc4_);
               _loc3_++;
            }
         }
         _hasGetGoodsVBox.commitChanges();
         _hasGetGoodsPanel.invalidateViewport(true);
      }
      
      private function __refreshBtnHandler(param1:MouseEvent) : void
      {
         var _loc3_:int = getTimer();
         if(_loc3_ - _refreshLastClickTime < 400)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.view.ActivityItem.command01"));
            return;
         }
         _refreshLastClickTime = _loc3_;
         SoundManager.instance.play("022");
         var _loc2_:String = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
         var _loc4_:String = LanguageMgr.GetTranslation("wishpool.wishpoolFrame.refreshTips",model.refreshPrice);
         SharedManagerHelper.ins.needAlert("wishpool.WishPoolFrame.refreshBtn",confirmResultHandler,_loc2_,_loc4_);
      }
      
      private function confirmResultHandler() : void
      {
         if(model.refreshPrice > playerModel.playerInfo.point)
         {
            RechargeAlertMannager.show();
            return;
         }
         freshGoods();
      }
      
      private function __freeRefreshBtnHandler(param1:MouseEvent) : void
      {
         freshGoods();
      }
      
      private function freshGoods() : void
      {
         setIsFreeFreshAble(false);
         WishPoolManager.instance.frameOperation(WishPoolManager.REFRESH,[]);
      }
      
      private function __wishBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc4_:String = null;
         var _loc3_:int = getTimer();
         if(_loc3_ - _wishLastClickTime < 400)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.view.ActivityItem.command01"));
            return;
         }
         _wishLastClickTime = _loc3_;
         SoundManager.instance.play("022");
         if(_wishNeedPoint <= 0)
         {
            WishPoolManager.instance.frameOperation(WishPoolManager.WISH,model.selectedWishArray,_checkBtn.selected);
            _wishBtn.enable = false;
         }
         else
         {
            _loc2_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc4_ = LanguageMgr.GetTranslation("wishpool.wishpoolFrame.wishBtnTips",_wishNeedPoint);
            SharedManagerHelper.ins.needAlert("wishpool.WishPoolFrame.wishBtn",wishBtnConfirmHandler,_loc2_,_loc4_);
         }
      }
      
      private function wishBtnConfirmHandler() : void
      {
         if(_wishNeedPoint > playerModel.playerInfo.point)
         {
            RechargeAlertMannager.show();
            return;
         }
         WishPoolManager.instance.frameOperation(WishPoolManager.WISH,model.selectedWishArray,_checkBtn.selected);
         _wishBtn.enable = false;
      }
      
      private function __shopBtnHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("shop",1019);
      }
      
      private function __timeCompleteHandler(param1:Event) : void
      {
         _timeDownView.timeCount = model.countDown;
         _timeDownView.visible = false;
         setIsFreeFreshAble(true);
      }
      
      private function setIsFreeFreshAble(param1:Boolean) : void
      {
         if(param1)
         {
            _freeRefreshBtn.visible = true;
            _refreshBtn.visible = false;
         }
         else
         {
            _freeRefreshBtn.visible = false;
            _refreshBtn.visible = true;
         }
      }
      
      private function __updateSelectedHandler(param1:NotificationEvent = null) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         if(model.selectedWishArray.length == 0)
         {
            resetWishBtnInfo();
         }
         else if(model.selectedWishArray.length > 0)
         {
            _loc4_ = int(model.selectedWishArray.length);
            if(_checkBtn.selected)
            {
               _loc2_ = int(GoodsManager.instance.getGoodsNumByTempId(208524));
               _loc3_ = _loc4_ - _loc2_;
               if(_loc3_ < 0)
               {
                  _loc3_ = 0;
               }
            }
            else
            {
               _loc3_ = _loc4_;
            }
            _wishNeedPoint = _loc3_ * model.wishOnePrice;
            _wishBtn.enable = true;
            _wishCostTxt.text = _wishNeedPoint.toString();
            _upImage.visible = true;
            _upImage.setFrame(model.selectedWishArray.length);
         }
      }
      
      private function resetWishBtnInfo() : void
      {
         _wishBtn.enable = false;
         _wishCostTxt.text = "0";
         _upImage.visible = false;
      }
      
      private function __refreshWindowInfoHandler(param1:NotificationEvent) : void
      {
         _refreshCostTxt.text = model.refreshPrice.toString();
         __countDownRefreshHandler(null);
         initRewardShowPanel();
         __wishPoolRefreshHandler(null);
      }
      
      private function __countDownRefreshHandler(param1:NotificationEvent) : void
      {
         if(model.countDown > 0)
         {
            _timeDownView.visible = true;
            _timeDownView.timeCount = model.countDown;
            setIsFreeFreshAble(false);
         }
         else
         {
            __timeCompleteHandler(null);
         }
      }
      
      private function __wishPoolRefreshHandler(param1:NotificationEvent) : void
      {
         var _loc2_:WishPoolItemView = null;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         resetWishBtnInfo();
         __countDownRefreshHandler(null);
         var _loc3_:Array = model.wishpoolArray;
         if(_loc3_)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               _loc2_ = _itemList[_loc4_];
               if(_loc2_)
               {
                  _loc5_ = int(_loc3_[_loc4_]);
                  _loc2_.data = model.totalWishDic[_loc5_];
               }
               _loc4_++;
            }
         }
      }
      
      private function refreshPropNums() : void
      {
         var _loc1_:int = int(GoodsManager.instance.getGoodsNumByTempId(208524));
         _hasPropText.text = "" + _loc1_;
      }
      
      private function refreshPropIcons() : void
      {
         __updateSelectedHandler();
      }
      
      private function __wishPoolWishHandler(param1:NotificationEvent) : void
      {
         refreshPropNums();
         if(model.wishResult)
         {
            if(_successMovie)
            {
               _successMovie.visible = true;
               _successMovie.gotoAndPlay(1);
               _successMovie.addFrameScript(_successMovie.totalFrames - 1,successEndFunction);
            }
            _upImage.visible = false;
            _wishNeedPoint = 0;
            __wishPoolRefreshHandler(null);
            initHasGetGoodsPanel();
            resetWishBtnInfo();
         }
         else
         {
            if(_failureMovie)
            {
               _failureMovie.visible = true;
               _failureMovie.gotoAndPlay(1);
               _failureMovie.addFrameScript(_failureMovie.totalFrames - 1,failureEndFunction);
            }
            _wishBtn.enable = true;
         }
         refreshPropIcons();
      }
      
      private function successEndFunction() : void
      {
         _successMovie.gotoAndStop(1);
         _successMovie.visible = false;
      }
      
      private function failureEndFunction() : void
      {
         _failureMovie.gotoAndStop(1);
         _failureMovie.visible = false;
      }
      
      private function useKeyFindGoods(param1:int) : GoodsInfo
      {
         var _loc3_:GoodsInfo = null;
         if(!model.totalWishDic)
         {
            return null;
         }
         var _loc2_:WishPoolInfoVO = model.totalWishDic[param1];
         if(_loc2_)
         {
            _loc3_ = new GoodsInfo();
            _loc3_.templateId = _loc2_.tempalteId;
            _loc3_.count = _loc2_.count;
         }
         return _loc3_;
      }
      
      private function sortFun(param1:GoodsInfo, param2:GoodsInfo) : Number
      {
         var _loc3_:int = int(param1.templateInfo.SonType);
         var _loc4_:int = int(param2.templateInfo.SonType);
         if(param1.templateInfo.Profile > param2.templateInfo.Profile)
         {
            return -1;
         }
         if(param1.templateInfo.Profile < param2.templateInfo.Profile)
         {
            return 1;
         }
         if(_loc3_ < _loc4_)
         {
            return -1;
         }
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         if(param1.templateId < param2.templateId)
         {
            return 1;
         }
         if(param1.templateId > param2.templateId)
         {
            return -1;
         }
         return 0;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function get model() : WishPoolModel
      {
         return WishPoolManager.instance.model;
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
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("WishPoolFrame.title");
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,980,675);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninitView();
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

