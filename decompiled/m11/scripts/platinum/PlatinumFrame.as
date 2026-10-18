package platinum
{
   import bag.events.BagEvent;
   import bottle.BottleNotic;
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
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectPool;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.PlatinumEvent;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import mainBar.StripView;
   import mainBar.effects.MainToolBtnGlowEffect;
   import manager.LanguageMgr;
   import managers.PlatinumManager;
   import mvc.module.platinum.PlatinumModel;
   import mvc.module.shop.ShopGoodsInfo;
   import ui.maintoolbar.MainToolBar;
   import yishi.datas.goods.GoodsInfo;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.DateFormatter;
   import yishi.utils.IconFactory;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseIconView;
   import yishi.view.community.BaseItemView;
   import yishi.view.frame.BuyFrameI;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class PlatinumFrame extends Frame implements IManualSize
   {
      
      private static const HAMMER_ID:int = 208530;
      
      private static const PLATINUM_HAMMER_ID:int = 208531;
      
      private var _bottleFrameBg1:Scale9CornerImage;
      
      private var _bottleFrameBg2:Scale9CornerImage;
      
      private var _bottleFrameBg3:ScaleBitmapImage;
      
      private var _titleBg1:Image;
      
      private var _titleBg2:MutipleImage;
      
      private var _titleBg3:MutipleImage;
      
      private var _titleBg4:Image;
      
      private var _bottleBg:MutipleImage;
      
      private var _countdownIcon:Image;
      
      private var _openBtn1:IconButton;
      
      private var _openBtn2:IconButton;
      
      private var _fallItemsBtn:BaseButton;
      
      private var _helpBtn:BaseButton;
      
      private var _rewardsListScroll:ScrollPanel;
      
      private var _luckShowListScroll:ScrollPanel;
      
      private var _rewardsVBox:VBox;
      
      private var _luckShowVBox:VBox;
      
      private var _remainTimeText:FilterFrameText;
      
      private var _remainTime:String;
      
      private var _hammerNum:int;
      
      private var _openNum:int;
      
      private var _openCost:int;
      
      private var _animeCount:int = 0;
      
      private var _tempId:int;
      
      private var _tempIdArr:Array = [];
      
      private var _bottleShowIdArr:Array;
      
      private var _timer:Timer;
      
      private var _goldBtn:SelectedIconButton;
      
      private var _platinumBtn:SelectedIconButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _hBox:HBox;
      
      private var _descTxt:FilterFrameText;
      
      private var _hammerBmp:ScaleFrameImage;
      
      private var _hammerNumText:FilterFrameText;
      
      private var _plusBtn:IconButton;
      
      private var _hammer1:ScaleFrameImage;
      
      private var _txt1:FilterFrameText;
      
      private var _hammer2:ScaleFrameImage;
      
      private var _txt2:FilterFrameText;
      
      private var _sprite:Sprite;
      
      private var _bottleAnime:MovieClip;
      
      private var _platinumAnime:MovieClip;
      
      private var _effect:MainToolBtnGlowEffect;
      
      private var _stripView:StripView;
      
      private var _component:Component;
      
      public function PlatinumFrame()
      {
         super();
         initView();
         addEvent();
         __refreshLuckPassTip(null);
         __refreshPersonalTip(null);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,720,623);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("platinum.frame.title");
         _bottleFrameBg1 = ComponentFactory.Instance.creatComponentByStylename("platinum.PlatinumFrameBack1");
         _bottleFrameBg2 = ComponentFactory.Instance.creatComponentByStylename("platinum.PlatinumFrameBack2");
         _bottleFrameBg3 = ComponentFactory.Instance.creatComponentByStylename("platinum.PlatinumFrameBack3");
         _titleBg1 = ComponentFactory.Instance.creatComponentByStylename("platinum.TitleBack1");
         _titleBg2 = ComponentFactory.Instance.creatComponentByStylename("platinum.TitleBack2");
         _titleBg3 = ComponentFactory.Instance.creatComponentByStylename("platinum.TitleBack3");
         _titleBg4 = ComponentFactory.Instance.creatComponentByStylename("platinum.TitleBack4");
         _bottleBg = ComponentFactory.Instance.creatComponentByStylename("platinum.PlatinumBack");
         _countdownIcon = ComponentFactory.Instance.creatComponentByStylename("platinum.CountdownBugleIcon");
         _openBtn1 = ComponentFactory.Instance.creatComponentByStylename("platinum.openBtn1");
         _openBtn2 = ComponentFactory.Instance.creatComponentByStylename("platinum.openBtn2");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("platinum.BottleHelpBtn");
         _rewardsListScroll = ComponentFactory.Instance.creatComponentByStylename("platinum.RewardsListScrollPanel");
         _luckShowListScroll = ComponentFactory.Instance.creatComponentByStylename("platinum.LuckShowListScrollPanel");
         _rewardsVBox = ComponentFactory.Instance.creatComponentByStylename("platinum.RewardsVBox");
         _luckShowVBox = ComponentFactory.Instance.creatComponentByStylename("platinum.LuckShowVBox");
         _remainTimeText = ComponentFactory.Instance.creatComponentByStylename("platinum.RemainTimeText");
         _fallItemsBtn = ComponentFactory.Instance.creatComponentByStylename("platinum.fallItemsBtn");
         _goldBtn = ComponentFactory.Instance.creatComponentByStylename("platinum.goldBtn");
         _platinumBtn = ComponentFactory.Instance.creatComponentByStylename("platinum.platinumBtn");
         _hBox = ComponentFactory.Instance.creatComponentByStylename("platinum.btnHbox");
         _descTxt = ComponentFactory.Instance.creatComponentByStylename("platinum.descTxt");
         _hammerBmp = ComponentFactory.Instance.creatComponentByStylename("platinum.hammerBmp");
         _hammerNumText = ComponentFactory.Instance.creatComponentByStylename("platinum.hammerNumText");
         _plusBtn = ComponentFactory.Instance.creatComponentByStylename("platinum.plusBtn");
         _hammer1 = ComponentFactory.Instance.creatComponentByStylename("platinum.hammer1");
         _txt1 = ComponentFactory.Instance.creatComponentByStylename("platinum.txt1");
         _hammer2 = ComponentFactory.Instance.creatComponentByStylename("platinum.hammer2");
         _txt2 = ComponentFactory.Instance.creatComponentByStylename("platinum.txt2");
         _bottleAnime = ComponentFactory.Instance.creat("asset.platinum.goldAnime");
         _platinumAnime = ComponentFactory.Instance.creat("asset.platinum.platinumAnime");
         _stripView = ComponentFactory.Instance.creatCustomObject("platinumFrame.StripView");
         _stripView.setHitArea(0,0,30,30);
         _btnGroup = new SelectedButtonGroup();
         _hBox.addChild(_goldBtn);
         _hBox.addChild(_platinumBtn);
         _btnGroup.addSelectItem(_goldBtn);
         _btnGroup.addSelectItem(_platinumBtn);
         _btnGroup.selectIndex = 0;
         _sprite = new Sprite();
         _sprite.x = 455;
         _sprite.y = 51;
         _effect = new MainToolBtnGlowEffect(_platinumBtn);
         _effect.stop();
         _descTxt.text = LanguageMgr.GetTranslation("platinum.descTxt.text");
         _hammerBmp.setFrame(1);
         _txt1.text = "1";
         _txt2.text = "10";
         _hammer1.setFrame(1);
         _hammer2.setFrame(1);
         addToContent(_bottleFrameBg1);
         addToContent(_bottleFrameBg2);
         addToContent(_bottleFrameBg3);
         addToContent(_hBox);
         addToContent(_titleBg1);
         addToContent(_titleBg2);
         addToContent(_titleBg3);
         addToContent(_titleBg4);
         addToContent(_bottleBg);
         addToContent(_countdownIcon);
         addToContent(_hammerBmp);
         addToContent(_hammerNumText);
         addToContent(_stripView);
         addToContent(_plusBtn);
         addToContent(_hammer1);
         addToContent(_txt1);
         addToContent(_hammer2);
         addToContent(_txt2);
         addToContent(_openBtn1);
         addToContent(_openBtn2);
         addToContent(_helpBtn);
         addToContent(_descTxt);
         addToContent(_rewardsListScroll);
         addToContent(_luckShowListScroll);
         addToContent(_remainTimeText);
         addToContent(_fallItemsBtn);
         addToContent(_sprite);
         addToContent(_platinumAnime);
         addToContent(_bottleAnime);
         _platinumAnime.x = 100;
         _platinumAnime.y = 90;
         _platinumAnime.stop();
         _platinumAnime.visible = false;
         _bottleAnime.x = 100;
         _bottleAnime.y = 90;
         _bottleAnime.stop();
         _remainTime = DateFormatter.getDefaultFullDateString(PlatinumManager.instance.platinum_endDate.time / 1000 - PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond);
         _remainTimeText.text = LanguageMgr.GetTranslation("bottle.view.BottleFrame.remainTimeText") + _remainTime;
         _rewardsListScroll.setView(_rewardsVBox);
         _luckShowListScroll.setView(_luckShowVBox);
         KeyBoardRegister.instance.keyEnable = false;
         _helpBtn.tipData = LanguageMgr.GetTranslation("platinum.PlatinumFrame.HelpTxt");
         refreshView();
      }
      
      private function refreshItem() : void
      {
         var _loc2_:int = 0;
         var _loc4_:Image = null;
         var _loc5_:GoodsInfo = null;
         var _loc1_:BaseItemView = null;
         var _loc3_:MovieImage = null;
         _bottleShowIdArr = index == 0 ? model.goldItemNoticeInfo : model.platinumItemNoticeInfo;
         _sprite.removeChildren();
         _loc2_ = 0;
         while(_loc2_ < _bottleShowIdArr.length)
         {
            if(_loc2_ >= 6)
            {
               break;
            }
            _loc4_ = ComponentFactory.Instance.creatComponentByStylename("bottle.ItemBack");
            _loc4_.x = _loc2_ % 3 * 72;
            _loc4_.y = int(_loc2_ / 3) * 72;
            _sprite.addChild(_loc4_);
            _loc5_ = new GoodsInfo();
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("bottle.Item");
            _loc5_.templateId = _bottleShowIdArr[_loc2_].templateId;
            _loc5_.count = _bottleShowIdArr[_loc2_].count;
            _loc1_.data = _loc5_;
            _sprite.addChild(_loc1_);
            _loc1_.x = _loc4_.x + 5;
            _loc1_.y = _loc4_.y + 5;
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("bottle.LightEffect");
            _loc3_.mouseEnabled = false;
            _loc3_.mouseChildren = false;
            _loc3_.x = _loc1_.x + 28;
            _loc3_.y = _loc1_.y - 23;
            _sprite.addChild(_loc3_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _openBtn1.addEventListener("click",__openBottleHandler);
         _openBtn2.addEventListener("click",__openBottleHandler);
         _helpBtn.addEventListener("click",__openHelpHandler);
         _fallItemsBtn.addEventListener("click",__onLinkHandler);
         GoodsManager.instance.addEventListener("UPDATE_BAG",__upDateHammerNum);
         GoodsManager.instance.addEventListener("DELETE_BAG",__upDateHammerNum);
         NotificationManager.instance.addEventListener("REFRESH_TOPTOOLS",__refreshState);
         model.addEventListener("PLATINA_ACTIVE_INFO",__refreshActiveInfo);
         model.addEventListener("PLATINA_ACTIVE_LUCKPASS_TIP",__refreshLuckPassTip);
         model.addEventListener("PLATINA_ACTIVE_PERSONAL_TIP",__refreshPersonalTip);
         _btnGroup.addEventListener("change",__tabChangeHandler);
         _plusBtn.addEventListener("click",__plusBtnClickHandler);
         _timer = new Timer(1000);
         _timer.addEventListener("timer",__timerHandler);
         _timer.start();
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _openBtn1.removeEventListener("click",__openBottleHandler);
         _openBtn2.removeEventListener("click",__openBottleHandler);
         _helpBtn.removeEventListener("click",__openHelpHandler);
         _fallItemsBtn.removeEventListener("click",__onLinkHandler);
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__upDateHammerNum);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__upDateHammerNum);
         NotificationManager.instance.removeEventListener("REFRESH_TOPTOOLS",__refreshState);
         model.removeEventListener("PLATINA_ACTIVE_INFO",__refreshActiveInfo);
         model.removeEventListener("PLATINA_ACTIVE_LUCKPASS_TIP",__refreshLuckPassTip);
         model.removeEventListener("PLATINA_ACTIVE_PERSONAL_TIP",__refreshPersonalTip);
         _btnGroup.removeEventListener("change",__tabChangeHandler);
         _plusBtn.removeEventListener("click",__plusBtnClickHandler);
         model.removeEventListener("PLATINA_ACTIVE_ITEMID",__refreshActiveItemId);
         _timer.stop();
         _timer.removeEventListener("timer",__timerHandler);
         _timer = null;
      }
      
      private function __plusBtnClickHandler(param1:MouseEvent) : void
      {
         CheckUIModuleUtil.instance.tryCall("quickbuy",quickUIcallback);
      }
      
      private function quickUIcallback(param1:int = 1) : void
      {
         var _loc3_:int = index == 0 ? 208530 : 208531;
         var _loc4_:ShopGoodsInfo = TempleteManager.instance.getShopTempInfoByItemId(_loc3_);
         _loc4_.ShopType = 2;
         var _loc2_:BuyFrameI = ComponentFactory.Instance.creatComponentByStylename("quickbuy.buyFrame");
         _loc2_.data(_loc4_,param1);
         _loc2_.show();
      }
      
      private function __tabChangeHandler(param1:Event) : void
      {
         refreshView();
      }
      
      private function __refreshLuckPassTip(param1:PlatinumEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:BottleNotic = null;
         var _loc2_:ChatData = null;
         _luckShowVBox.removeAllChild();
         _luckShowVBox.disposeAllChildren();
         _luckShowVBox.beginChanges();
         if(model.luckPassTip)
         {
            _loc3_ = 0;
            while(_loc3_ < model.luckPassTip.length)
            {
               _loc4_ = new BottleNotic();
               _loc2_ = ObjectPool.getObject(ChatData) as ChatData;
               _loc2_.channel = 21;
               _loc2_.msg = model.luckPassTip[_loc3_];
               _loc2_.chatItemData.cellVector = ChatFormat.getContentCellData(_loc2_);
               _loc4_.data = _loc2_;
               _luckShowVBox.addChild(_loc4_);
               _loc3_++;
            }
         }
         _luckShowVBox.commitChanges();
         _luckShowListScroll.invalidateViewport(true);
      }
      
      private function __refreshPersonalTip(param1:PlatinumEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:BottleNotic = null;
         var _loc2_:ChatData = null;
         _rewardsVBox.removeAllChild();
         _rewardsVBox.disposeAllChildren();
         _rewardsVBox.beginChanges();
         if(model.personalTip)
         {
            _loc3_ = 0;
            while(_loc3_ < model.personalTip.length)
            {
               _loc4_ = new BottleNotic();
               _loc2_ = ObjectPool.getObject(ChatData) as ChatData;
               _loc2_.channel = 21;
               _loc2_.msg = model.personalTip[_loc3_];
               _loc2_.chatItemData.cellVector = ChatFormat.getContentCellData(_loc2_);
               _loc4_.data = _loc2_;
               _rewardsVBox.addChild(_loc4_);
               _loc3_++;
            }
         }
         _rewardsVBox.commitChanges();
         _rewardsListScroll.invalidateViewport(true);
      }
      
      private function __refreshActiveInfo(param1:PlatinumEvent) : void
      {
         refreshEffect();
         refreshItem();
      }
      
      private function refreshEffect() : void
      {
         if(index == 0 && Boolean(model.hasChance))
         {
            _effect.play();
         }
         else
         {
            _effect.stop();
         }
      }
      
      private function __upDateHammerNum(param1:BagEvent) : void
      {
         if(param1 && param1.info)
         {
            if(param1.info.bagType != 1)
            {
               return;
            }
            if(param1.info.templateId != 208530 && param1.info.templateId != 208531)
            {
               return;
            }
         }
         var _loc2_:int = index == 0 ? 208530 : 208531;
         _hammerNum = GoodsManager.instance.getGoodsNumByTempId(_loc2_);
         _hammerNumText.text = String(_hammerNum);
      }
      
      private function __timerHandler(param1:TimerEvent) : void
      {
         _remainTime = DateFormatter.getDefaultFullDateString(PlatinumManager.instance.platinum_endDate.time / 1000 - PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond);
         _remainTimeText.text = LanguageMgr.GetTranslation("bottle.view.BottleFrame.remainTimeText") + _remainTime;
      }
      
      private function __onLinkHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:PlatinumDropFrame = ComponentFactory.Instance.creatComponentByStylename("platinum.PlatinumDropFrame",[index]);
         _loc2_.show();
      }
      
      private function __openHelpHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("platinum.PlatinumHelpFrame");
         _loc2_.show();
      }
      
      private function __refreshState(param1:NotificationEvent) : void
      {
         if(!PlatinumManager.instance.openBottle)
         {
            dispose();
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
         }
      }
      
      private function __openBottleHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc5_:int = 0;
         var _loc7_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc6_:String = null;
         SoundManager.instance.play("022");
         if(PlayerManager.instance.currentPlayerModel.nowDate > PlatinumManager.instance.platinum_endDate.time)
         {
            _loc2_ = LanguageMgr.GetTranslation("activity.ActivityManager.command02");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         switch(param1.currentTarget)
         {
            case _openBtn1:
               _openNum = 1;
               break;
            case _openBtn2:
               _openNum = 10;
         }
         if(_hammerNum < _openNum)
         {
            _loc5_ = _openNum - _hammerNum;
            CheckUIModuleUtil.instance.tryCall("quickbuy",quickUIcallback,[_loc5_]);
            return;
         }
         if(index == 0 && Boolean(model.hasChance))
         {
            _loc7_ = LanguageMgr.GetTranslation("platinum.content.text");
            _loc3_ = LanguageMgr.GetTranslation("public.confirm");
            _loc4_ = LanguageMgr.GetTranslation("public.cancel");
            _loc6_ = LanguageMgr.GetTranslation("public.prompt");
            SimpleAlertHelper.instance.data = [backHandler];
            _component = SimpleAlertHelper.instance.popAlerFrame(_loc6_,_loc7_,_loc3_,_loc4_,true,true,true,2);
            return;
         }
         openCall();
      }
      
      private function backHandler(param1:Boolean, param2:Boolean) : void
      {
         if(!param1)
         {
            return;
         }
         openCall();
      }
      
      private function openCall() : void
      {
         this.closeButton.enable = _openBtn1.enable = _openBtn2.enable = _goldBtn.enable = _platinumBtn.enable = false;
         PlatinumManager.instance.sendOpenInfo(_openNum,index);
         model.addEventListener("PLATINA_ACTIVE_ITEMID",__refreshActiveItemId);
      }
      
      private function __refreshActiveItemId(param1:PlatinumEvent) : void
      {
         model.removeEventListener("PLATINA_ACTIVE_ITEMID",__refreshActiveItemId);
         _tempIdArr = model.itemIds;
         if(index == 0)
         {
            _bottleAnime.play();
            _bottleAnime.addEventListener("enterFrame",__enterFrameHandler);
         }
         else
         {
            _platinumAnime.play();
            _platinumAnime.addEventListener("enterFrame",__enterFrameHandler);
         }
      }
      
      private function __enterFrameHandler(param1:Event) : void
      {
         if(param1.target.currentFrame == param1.target.totalFrames - 36)
         {
            createIconAnime();
         }
         if(param1.target.currentFrame == param1.target.totalFrames)
         {
            if(index == 0)
            {
               _bottleAnime.removeEventListener("enterFrame",__enterFrameHandler);
               _bottleAnime.stop();
            }
            else
            {
               _platinumAnime.removeEventListener("enterFrame",__enterFrameHandler);
               _platinumAnime.stop();
            }
         }
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
         var bagBtnPos:Point;
         var icon:BaseIconView = param1;
         var bottleAnimePoint:Point = this.localToGlobal(new Point(_bottleAnime.x,_bottleAnime.y));
         icon.x = bottleAnimePoint.x + 125;
         icon.y = bottleAnimePoint.y + 130;
         icon.mouseChildren = icon.mouseEnabled = false;
         bagBtnPos = MainToolBar.instance.getBagBtnPos();
         if(icon)
         {
            _animeCount = _animeCount + 1;
            TweenMax.to(icon,1,{
               "delay":_animeCount * 0.3,
               "bezierThrough":[{
                  "x":icon.x,
                  "y":icon.y
               },{
                  "x":bagBtnPos.x + 10,
                  "y":bagBtnPos.y + 10
               }],
               "scaleX":0.3,
               "scaleY":0.3,
               "orientToBezier":false,
               "ease":Quart.easeIn,
               "onUpdate":function():void
               {
                  if(!icon.parent)
                  {
                     StageReferance.stage.addChild(icon);
                  }
               },
               "onComplete":_moveComplete,
               "onCompleteParams":[_animeCount,icon]
            });
         }
         if(!isDie && _openNum > _animeCount)
         {
            createIconAnime();
         }
      }
      
      private function _moveComplete(param1:int, param2:BaseIconView) : void
      {
         TweenMax.to(param2,0.5,{
            "alpha":0,
            "onComplete":disapearComplete,
            "onCompleteParams":[param1,param2]
         });
      }
      
      private function disapearComplete(param1:int, param2:BaseIconView) : void
      {
         if(_openNum <= param1)
         {
            _animeCount = 0;
            if(!isDie)
            {
               this.closeButton.enable = _goldBtn.enable = _platinumBtn.enable = true;
               if(index == 0 || Boolean(model.hasChance))
               {
                  _openBtn1.enable = _openBtn2.enable = true;
               }
               else
               {
                  _openBtn1.enable = _openBtn2.enable = false;
               }
               _bottleAnime.gotoAndStop(1);
               _platinumAnime.gotoAndStop(1);
            }
         }
         ObjectUtils.disposeObject(param2);
      }
      
      private function refreshView() : void
      {
         refreshEffect();
         refreshItem();
         _hammerBmp.setFrame(index + 1);
         _hammer1.setFrame(index + 1);
         _hammer2.setFrame(index + 1);
         _platinumAnime.stop();
         _bottleAnime.stop();
         _stripView.tipData = LanguageMgr.GetTranslation("platinumFrame.stripView.tip" + index);
         if(index == 0)
         {
            _openBtn1.enable = true;
            _openBtn2.enable = true;
            _descTxt.visible = true;
            _platinumAnime.visible = false;
            _bottleAnime.visible = true;
         }
         else
         {
            _descTxt.visible = false;
            _openBtn1.enable = model.hasChance;
            _openBtn2.enable = model.hasChance;
            _platinumAnime.visible = true;
            _bottleAnime.visible = false;
         }
         var _loc1_:int = index == 0 ? 208530 : 208531;
         _hammerNum = GoodsManager.instance.getGoodsNumByTempId(_loc1_);
         _hammerNumText.text = String(_hammerNum);
         _remainTime = DateFormatter.getDefaultFullDateString(PlatinumManager.instance.platinum_endDate.time / 1000 - PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond);
         _remainTimeText.text = LanguageMgr.GetTranslation("bottle.view.BottleFrame.remainTimeText") + _remainTime;
      }
      
      private function get index() : int
      {
         if(_btnGroup)
         {
            return _btnGroup.selectIndex;
         }
         return 0;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1,0,true);
      }
      
      override public function dispose() : void
      {
         if(!isDie)
         {
            KeyBoardRegister.instance.keyEnable = true;
            removeEvent();
            TweenMax.killAll(true);
            _luckShowVBox.disposeAllChildren();
            _rewardsVBox.disposeAllChildren();
            ObjectUtils.disposeObject(_fallItemsBtn);
            _fallItemsBtn = null;
            ObjectUtils.disposeObject(_component);
            _component = null;
            ObjectUtils.disposeAllChildren(this);
            super.dispose();
         }
      }
      
      private function get model() : PlatinumModel
      {
         return PlatinumManager.instance.model;
      }
   }
}

