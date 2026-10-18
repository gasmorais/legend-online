package bottle
{
   import bag.events.BagEvent;
   import chat.datas.ChatData;
   import chat.utils.ChatFormat;
   import com.greensock.TweenMax;
   import com.greensock.easing.Quart;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectPool;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.BottleEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import managers.BottleManager;
   import mvc.module.bottle.BottleModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.community.BaseItemView;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class BottleFrame extends Frame implements IManualSize
   {
      
      private static const COLUMN_NUM:int = 8;
      
      private static const ROW_NUM:int = 5;
      
      private static const HAMMER_ID:int = 208022;
      
      private var _bottleFrameBg1:Scale9CornerImage;
      
      private var _bottleFrameBg2:Scale9CornerImage;
      
      private var _bottleFrameBg3:ScaleBitmapImage;
      
      private var _titleBg1:MutipleImage;
      
      private var _titleBg2:MutipleImage;
      
      private var _titleBg3:MutipleImage;
      
      private var _bottleBg:MutipleImage;
      
      private var _countdownBack:Image;
      
      private var _countdownIcon:Image;
      
      private var _bottleAnime:MovieClip;
      
      private var _openBtn1:TextButton;
      
      private var _openBtn2:TextButton;
      
      private var _openBtn3:TextButton;
      
      private var _fallItemsBtn:BaseButton;
      
      private var _storageButton:BaseButton;
      
      private var _helpBtn:BaseButton;
      
      private var _rewardsListScroll:ScrollPanel;
      
      private var _luckShowListScroll:ScrollPanel;
      
      private var _rewardsVBox:VBox;
      
      private var _luckShowVBox:VBox;
      
      private var _hammerTitleText:FilterFrameText;
      
      private var _hammerNumText:FilterFrameText;
      
      private var _remainTimeText:FilterFrameText;
      
      private var _remainTime:String;
      
      private var _hammerNum:int;
      
      private var _openType:int;
      
      private var _openNum:int;
      
      private var _openCost1:int;
      
      private var _openCost2:int;
      
      private var _openCost3:int;
      
      private var _openCost:int;
      
      private var _animeCount:int = 0;
      
      private var _tempId:int;
      
      private var _tempIdArr:Array = [];
      
      private var _bottlePriceArr:Array;
      
      private var _bottleShowIdArr:Array;
      
      private var _boxView:BottleBoxView;
      
      private var _checkBtn:SelectedCheckButton;
      
      private var _bottleBottomView:BottleBottomView;
      
      private var _rewardsIconArr:Array;
      
      private var _timer:Timer;
      
      private var _treeShakeEnd:Boolean;
      
      private var _serverDataOk:Boolean;
      
      private var _delayId:uint = 0;
      
      public function BottleFrame()
      {
         super();
         initView();
         addEvent();
         __refreshRewardsInfo(null);
         __refreshLuckShowInfo(null);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,910,620);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         var _loc4_:int = 0;
         var _loc5_:Image = null;
         var _loc6_:GoodsInfo = null;
         var _loc2_:BaseItemView = null;
         var _loc3_:Bitmap = null;
         var _loc1_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("Bottle_Price");
         _bottlePriceArr = _loc1_.ConfigValue.split("|");
         titleText = LanguageMgr.GetTranslation("bottle.view.BottleFrame.titleText");
         _bottleFrameBg1 = ComponentFactory.Instance.creatComponentByStylename("bottle.BottleFrameBack1");
         _bottleFrameBg2 = ComponentFactory.Instance.creatComponentByStylename("bottle.BottleFrameBack2");
         _bottleFrameBg3 = ComponentFactory.Instance.creatComponentByStylename("bottle.BottleFrameBack3");
         _titleBg1 = ComponentFactory.Instance.creatComponentByStylename("bottle.TitleBack1");
         _titleBg2 = ComponentFactory.Instance.creatComponentByStylename("bottle.TitleBack2");
         _titleBg3 = ComponentFactory.Instance.creatComponentByStylename("bottle.TitleBack3");
         _bottleBg = ComponentFactory.Instance.creatComponentByStylename("bottle.BottleBack");
         _countdownIcon = ComponentFactory.Instance.creatComponentByStylename("bottle.CountdownBugleIcon");
         _countdownBack = ComponentFactory.Instance.creatComponentByStylename("bottle.CountdownBack");
         _bottleAnime = ComponentFactory.Instance.creat("asset.bottle.BottleAnime");
         _openBtn1 = ComponentFactory.Instance.creatComponentByStylename("bottle.openBtn1");
         _openBtn2 = ComponentFactory.Instance.creatComponentByStylename("bottle.openBtn2");
         _openBtn3 = ComponentFactory.Instance.creatComponentByStylename("bottle.openBtn3");
         _storageButton = ComponentFactory.Instance.creatComponentByStylename("bottle.StorageButton");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("bottle.BottleHelpBtn");
         _rewardsListScroll = ComponentFactory.Instance.creatComponentByStylename("bottle.RewardsListScrollPanel");
         _luckShowListScroll = ComponentFactory.Instance.creatComponentByStylename("bottle.LuckShowListScrollPanel");
         _rewardsVBox = ComponentFactory.Instance.creatComponentByStylename("bottle.RewardsVBox");
         _luckShowVBox = ComponentFactory.Instance.creatComponentByStylename("bottle.LuckShowVBox");
         _hammerTitleText = ComponentFactory.Instance.creatComponentByStylename("bottle.hammerTitleText");
         _hammerNumText = ComponentFactory.Instance.creatComponentByStylename("bottle.hammerNumText");
         _remainTimeText = ComponentFactory.Instance.creatComponentByStylename("bottle.RemainTimeText");
         _fallItemsBtn = ComponentFactory.Instance.creatComponentByStylename("bottle.fallItemsBtn");
         _boxView = ComponentFactory.Instance.creatCustomObject("bottle.BottleBoxView");
         _bottleBottomView = ComponentFactory.Instance.creatCustomObject("bottle.BottleBottomBoxView");
         _checkBtn = ComponentFactory.Instance.creatComponentByStylename("bottle.UseStick.CheckBtn");
         _openCost1 = int(_bottlePriceArr[0]);
         _openCost2 = int(_bottlePriceArr[1]);
         _openCost3 = int(_bottlePriceArr[2]);
         _openBtn1.text = String(_openCost1);
         _openBtn2.text = String(_openCost2);
         _openBtn3.text = String(_openCost3);
         addToContent(_bottleFrameBg1);
         addToContent(_bottleFrameBg2);
         addToContent(_bottleFrameBg3);
         addToContent(_titleBg1);
         addToContent(_titleBg2);
         addToContent(_titleBg3);
         addToContent(_bottleBg);
         addToContent(_countdownBack);
         addToContent(_countdownIcon);
         addToContent(_bottleAnime);
         _bottleAnime.x = 199;
         _bottleAnime.y = 12;
         _bottleAnime.gotoAndStop(1);
         _bottleAnime["gold"].gotoAndStop(1);
         addToContent(_boxView);
         addToContent(_bottleBottomView);
         addToContent(_openBtn1);
         addToContent(_openBtn2);
         addToContent(_openBtn3);
         addToContent(_helpBtn);
         addToContent(_rewardsListScroll);
         addToContent(_luckShowListScroll);
         addToContent(_hammerTitleText);
         _hammerTitleText.text = LanguageMgr.GetTranslation("bottle.view.BottleFrame.hammerTitleText");
         addToContent(_hammerNumText);
         addToContent(_remainTimeText);
         addToContent(_fallItemsBtn);
         addToContent(_checkBtn);
         _checkBtn.selected = true;
         _checkBtn.text = LanguageMgr.GetTranslation("bottle.view.BottleFrame.UseStickCheckText");
         _remainTime = DateFormatter.getStopDateString(BottleManager.instance.BOTTLE_END_DATE.time / 1000 - PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond);
         _remainTimeText.text = LanguageMgr.GetTranslation("bottle.view.BottleFrame.remainTimeText") + _remainTime;
         _bottleShowIdArr = model.boutiqueGoodsArr;
         _loc4_ = 0;
         while(_loc4_ < _bottleShowIdArr.length)
         {
            _loc5_ = ComponentFactory.Instance.creatComponentByStylename("bottle.ItemBack");
            _loc5_.x = 638 + _loc4_ % 3 * 72;
            _loc5_.y = 51 + int(_loc4_ / 3) * 72;
            addToContent(_loc5_);
            _loc6_ = new GoodsInfo();
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("bottle.Item");
            _loc6_.templateId = _bottleShowIdArr[_loc4_].tempId;
            _loc2_.data = _loc6_;
            addToContent(_loc2_);
            _loc2_.x = _loc5_.x + 5;
            _loc2_.y = _loc5_.y + 5;
            if(_bottleShowIdArr[_loc4_].isNewItems)
            {
               _loc3_ = ComponentFactory.Instance.creatBitmap("asset.bottle.GoodsNew");
               addToContent(_loc3_);
               _loc3_.x = _loc2_.x - 15;
               _loc3_.y = _loc2_.y - 10;
            }
            _loc4_++;
         }
         __upDateHammerNum(null);
         _rewardsListScroll.setView(_rewardsVBox);
         _luckShowListScroll.setView(_luckShowVBox);
         KeyBoardRegister.instance.keyEnable = false;
         _helpBtn.tipData = LanguageMgr.GetTranslation("bottle.BottleFrame.HelpTxt");
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _openBtn1.addEventListener("click",__openBottleHandler);
         _openBtn2.addEventListener("click",__openBottleHandler);
         _openBtn3.addEventListener("click",__openBottleHandler);
         _storageButton.addEventListener("click",__openStorageHandler);
         _helpBtn.addEventListener("click",__openHelpHandler);
         _fallItemsBtn.addEventListener("click",__onLinkHandler);
         GoodsManager.instance.addEventListener("UPDATE_BAG",__upDateHammerNum);
         model.addEventListener("UPDATE_REWARDS_INFO",__refreshRewardsInfo);
         model.addEventListener("UPDATE_LUCK_SHOW_INFO",__refreshLuckShowInfo);
         NotificationManager.instance.addEventListener("REFRESH_TOPTOOLS",__refreshState);
         _timer = new Timer(1000);
         _timer.addEventListener("timer",__timerHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _openBtn1.removeEventListener("click",__openBottleHandler);
         _openBtn2.removeEventListener("click",__openBottleHandler);
         _openBtn3.removeEventListener("click",__openBottleHandler);
         _storageButton.removeEventListener("click",__openStorageHandler);
         _helpBtn.removeEventListener("click",__openHelpHandler);
         _fallItemsBtn.removeEventListener("click",__onLinkHandler);
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__upDateHammerNum);
         model.removeEventListener("UPDATE_REWARDS_INFO",__refreshRewardsInfo);
         model.removeEventListener("UPDATE_LUCK_SHOW_INFO",__refreshLuckShowInfo);
         NotificationManager.instance.removeEventListener("REFRESH_TOPTOOLS",__refreshState);
         _timer.stop();
         _timer.removeEventListener("timer",__timerHandler);
         _timer = null;
         BottleManager.instance.removeEventListener("CT__UPDATE_BOX_STATUS",__onServerResultBack);
      }
      
      private function __upDateHammerNum(param1:BagEvent) : void
      {
         if(param1 && param1.info)
         {
            if(param1.info.bagType != 1 || param1.info.templateId != 208022)
            {
               return;
            }
         }
         _hammerNum = GoodsManager.instance.getGoodsNumByTempId(208022);
         _hammerNumText.text = String(_hammerNum);
      }
      
      private function __timerHandler(param1:TimerEvent) : void
      {
         _remainTime = DateFormatter.getStopDateString(BottleManager.instance.BOTTLE_END_DATE.time / 1000 - PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond);
         _remainTimeText.text = LanguageMgr.GetTranslation("bottle.view.BottleFrame.remainTimeText") + _remainTime;
      }
      
      private function __onLinkHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:BottleDropFrame = ComponentFactory.Instance.creatComponentByStylename("bottle.BottleDropFrame");
         _loc2_.show();
      }
      
      private function __openHelpHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("bottle.BottleHelpFrame");
         _loc2_.show();
      }
      
      private function __refreshState(param1:NotificationEvent) : void
      {
         if(!BottleManager.instance.openBottle)
         {
            dispose();
         }
      }
      
      private function __openStorageHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:BottleStorageFrame = ComponentFactory.Instance.creatComponentByStylename("bottle.BottleStorageFrame");
         _loc2_.show();
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               BottleManager.instance.sendOpenInfo(3,0);
               dispose();
         }
      }
      
      private function __openBottleHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         SoundManager.instance.play("022");
         _rewardsIconArr = GoodsManager.instance.getBottleBagList().getList();
         if(_rewardsIconArr.length > 8 * 5)
         {
            _loc2_ = LanguageMgr.GetTranslation("bottle.view.BottleFrame.openTipData");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(PlayerManager.instance.currentPlayerModel.nowDate > BottleManager.instance.BOTTLE_END_DATE.time)
         {
            _loc2_ = LanguageMgr.GetTranslation("activity.ActivityManager.command02");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         _openCost = int(param1.currentTarget.text);
         switch(_openCost)
         {
            case _openCost1:
               _openType = 1;
               _openNum = 1;
               break;
            case _openCost2:
               _openType = 2;
               _openNum = 10;
               if(openAlert(openAlertBack))
               {
                  return;
               }
               break;
            case _openCost3:
               _openType = 3;
               _openNum = 50;
               if(openAlert(openAlertBack))
               {
                  return;
               }
               break;
            default:
               _openType = 0;
         }
         openCall();
      }
      
      private function openAlert(param1:Function = null) : Boolean
      {
         var _loc8_:TodayNotAlertFrame = null;
         var _loc7_:String = null;
         var _loc3_:String = null;
         var _loc4_:Date = SharedManager.instance.mysteryShopRefreshCheckDate;
         var _loc6_:Boolean = Boolean(SharedManager.instance.mysteryShopRefresh);
         var _loc5_:Date = new Date();
         var _loc2_:Boolean = false;
         if(!_loc6_ || _loc4_.month <= _loc4_.month && _loc4_.date < _loc5_.date)
         {
            _loc2_ = true;
         }
         if(_loc2_)
         {
            _loc8_ = ComponentFactory.Instance.creatComponentByStylename("bottle.OpenBottleAlertFrame");
            _loc7_ = LanguageMgr.GetTranslation("bottle.view.BottleFrame.openTipData.openAlertContent",_openCost,_openNum);
            _loc3_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc8_.show(_loc7_,_loc3_,openAlertBack,null,"center");
         }
         return _loc2_;
      }
      
      private function openAlertBack(param1:Boolean) : void
      {
         SharedManager.instance.mysteryShopRefresh = param1;
         SharedManager.instance.mysteryShopRefreshCheckDate = new Date();
         SharedManager.instance.saveMysteryShopRefreshCheck();
         openCall();
      }
      
      private function openCall() : void
      {
         if(_checkBtn == null)
         {
            return;
         }
         if(_checkBtn.selected)
         {
            if(PlayerManager.instance.currentPlayerModel.playerInfo.point + _hammerNum * _openCost1 < _openCost)
            {
               RechargeAlertMannager.show();
               return;
            }
         }
         else if(PlayerManager.instance.currentPlayerModel.playerInfo.point < _openCost)
         {
            RechargeAlertMannager.show();
            return;
         }
         this.closeButton.enable = _storageButton.enable = _openBtn1.enable = _openBtn2.enable = _openBtn3.enable = false;
         BottleManager.instance.removeEventListener("CT__UPDATE_BOX_STATUS",__onServerResultBack);
         _bottleAnime.play();
         _bottleAnime["gold"].play();
         _treeShakeEnd = false;
         _serverDataOk = false;
         setTimeout(__onTreeShakeEnd,1000);
         BottleManager.instance.addEventListener("CT__UPDATE_BOX_STATUS",__onServerResultBack);
         BottleManager.instance.sendOpenInfo(0,_openType,_checkBtn.selected);
         _delayId = setTimeout(timeEndFunc,10000);
      }
      
      private function __onTreeShakeEnd() : void
      {
         _treeShakeEnd = true;
         resetView();
      }
      
      private function __onServerResultBack(param1:BottleEvent) : void
      {
         if(param1.data.alert)
         {
            BottleManager.instance.removeEventListener("CT__UPDATE_BOX_STATUS",__onServerResultBack);
            clearTimeout(_delayId);
            _delayId = 0;
            _serverDataOk = true;
            resetView();
         }
      }
      
      private function resetView() : void
      {
         if(_treeShakeEnd && _serverDataOk)
         {
            _bottleAnime.gotoAndStop(1);
            _bottleAnime["gold"].gotoAndStop(1);
            BottleManager.instance.sendOpenInfo(3,0);
            this.closeButton.enable = _storageButton.enable = _openBtn1.enable = _openBtn2.enable = _openBtn3.enable = true;
            refreshView();
         }
      }
      
      private function timeEndFunc() : void
      {
         if(_delayId != 0)
         {
            dispose();
         }
         _delayId = 0;
      }
      
      private function __newGoodsHandler(param1:BagEvent) : void
      {
         GoodsManager.instance.removeEventListener("UPDATE_BOTTLE_BAG",__newGoodsHandler);
         _tempIdArr.push(param1.info.templateId);
         _bottleAnime.play();
         _bottleAnime["gold"].play();
         setTimeout(playMc,2000);
         clearTimeout(_delayId);
         _delayId = 0;
      }
      
      private function playMc() : void
      {
         createIconAnime();
         _bottleAnime["gold"].gotoAndStop(1);
         _bottleAnime.gotoAndStop(1);
      }
      
      private function createIconAnime() : void
      {
         if(_tempIdArr[_tempIdArr.length - _animeCount - 1])
         {
            _tempId = _tempIdArr[_tempIdArr.length - _animeCount - 1];
         }
         else
         {
            _tempId = _tempIdArr[_tempIdArr.length - 1];
         }
         var _loc1_:BaseIconView = ComponentFactory.Instance.creatCustomObject("core.BaseIcon",[iconComplete]);
         _loc1_.icon = IconFactory.getGoodsIconByTID(_tempId);
      }
      
      private function iconComplete(param1:BaseIconView = null) : void
      {
         var storagePoint:Point;
         var icon:BaseIconView = param1;
         var bottleAnimePoint:Point = this.localToGlobal(new Point(_bottleAnime.x,_bottleAnime.y));
         icon.x = bottleAnimePoint.x + 185;
         icon.y = bottleAnimePoint.y + 240;
         icon.mouseChildren = icon.mouseEnabled = false;
         storagePoint = this.localToGlobal(new Point(_storageButton.x,_storageButton.y));
         if(icon)
         {
            _animeCount = _animeCount + 1;
            TweenMax.to(icon,2,{
               "delay":_animeCount * 0.3,
               "bezierThrough":[{
                  "x":icon.x,
                  "y":icon.y
               },{
                  "x":storagePoint.x + 75,
                  "y":storagePoint.y + 108
               }],
               "scaleX":0.3,
               "scaleY":0.3,
               "orientToBezier":false,
               "ease":Quart.easeOut,
               "onUpdate":function():void
               {
                  if(!icon.parent)
                  {
                     StageReferance.stage.addChild(icon);
                  }
               },
               "onComplete":_moveComplete,
               "onCompleteParams":[icon]
            });
         }
         if(!isDie && _openType * 2 - 1 > _animeCount)
         {
            createIconAnime();
         }
      }
      
      private function _moveComplete(param1:BaseIconView) : void
      {
         TweenMax.to(param1,0.5,{
            "alpha":0,
            "onComplete":disapearComplete,
            "onCompleteParams":[param1]
         });
      }
      
      private function disapearComplete(param1:BaseIconView) : void
      {
         if(_openType * 2 - 1 <= _animeCount)
         {
            _bottleAnime.gotoAndStop(1);
            _animeCount = 0;
            BottleManager.instance.sendOpenInfo(3,0);
            if(!isDie)
            {
               this.closeButton.enable = _storageButton.enable = _openBtn1.enable = _openBtn2.enable = _openBtn3.enable = true;
               refreshView();
            }
         }
         ObjectUtils.disposeObject(param1);
      }
      
      private function refreshView() : void
      {
         _hammerNum = GoodsManager.instance.getGoodsNumByTempId(208022);
         _hammerNumText.text = String(_hammerNum);
         _remainTime = DateFormatter.getStopDateString(BottleManager.instance.BOTTLE_END_DATE.time / 1000 - PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond);
         _remainTimeText.text = LanguageMgr.GetTranslation("bottle.view.BottleFrame.remainTimeText") + _remainTime;
      }
      
      public function __refreshRewardsInfo(param1:BottleEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:BottleNotic = null;
         var _loc2_:ChatData = null;
         _rewardsVBox.removeAllChild();
         _rewardsVBox.disposeAllChildren();
         _rewardsVBox.beginChanges();
         if(model.bottleRewardsInfo)
         {
            _loc3_ = 0;
            while(_loc3_ < model.bottleRewardsInfo.length)
            {
               _loc4_ = new BottleNotic();
               _loc2_ = ObjectPool.getObject(ChatData) as ChatData;
               _loc2_.channel = 21;
               _loc2_.msg = model.bottleRewardsInfo[_loc3_];
               _loc2_.chatItemData.cellVector = ChatFormat.getContentCellData(_loc2_);
               _loc4_.data = _loc2_;
               _rewardsVBox.addChild(_loc4_);
               _loc3_++;
            }
         }
         _rewardsVBox.commitChanges();
         _rewardsListScroll.invalidateViewport(true);
      }
      
      public function __refreshLuckShowInfo(param1:BottleEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:BottleNotic = null;
         var _loc2_:ChatData = null;
         _luckShowVBox.removeAllChild();
         _luckShowVBox.disposeAllChildren();
         _luckShowVBox.beginChanges();
         if(model.bottleLuckShowInfo)
         {
            _loc3_ = 0;
            while(_loc3_ < model.bottleLuckShowInfo.length)
            {
               _loc4_ = new BottleNotic();
               _loc2_ = ObjectPool.getObject(ChatData) as ChatData;
               _loc2_.channel = 21;
               _loc2_.msg = model.bottleLuckShowInfo[_loc3_];
               _loc2_.chatItemData.cellVector = ChatFormat.getContentCellData(_loc2_);
               _loc4_.data = _loc2_;
               _luckShowVBox.addChild(_loc4_);
               _loc3_++;
            }
         }
         _luckShowVBox.commitChanges();
         _luckShowListScroll.invalidateViewport(true);
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1,0,true);
         model.hasOpenFrame = true;
      }
      
      override public function dispose() : void
      {
         if(!isDie)
         {
            model.hasOpenFrame = false;
            clearTimeout(_delayId);
            KeyBoardRegister.instance.keyEnable = true;
            removeEvent();
            TweenMax.killAll(true);
            _luckShowVBox.disposeAllChildren();
            _rewardsVBox.disposeAllChildren();
            ObjectUtils.disposeObject(_boxView);
            _boxView = null;
            ObjectUtils.disposeObject(_bottleBottomView);
            _bottleBottomView = null;
            ObjectUtils.disposeObject(_fallItemsBtn);
            _fallItemsBtn = null;
            ObjectUtils.disposeAllChildren(this);
            super.dispose();
         }
      }
      
      private function get model() : BottleModel
      {
         return BottleManager.instance.model;
      }
   }
}

