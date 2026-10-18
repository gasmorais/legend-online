package goldroad
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Quart;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.GoldRoadEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.net.URLVariables;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   import manager.LanguageMgr;
   import managers.GoldRoadManager;
   import map.space.SpaceManager;
   import mvc.module.armyII.BaseArmy;
   import mvc.module.goldroad.GoldRoadModel;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ConfigManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class GoldRoadFrame extends Frame
   {
      
      private static const SUPERDICE_ID:int = 208051;
      
      private var _bg:Bitmap;
      
      private var _goldRoadview:GoldRoadView;
      
      private var _bottomBg:Bitmap;
      
      private var oneButton:SelectedIconButton;
      
      private var doubleButton:SelectedIconButton;
      
      private var fiveButton:SelectedIconButton;
      
      private var mutiGrounp:SelectedButtonGroup;
      
      private var diceButton:BaseButton;
      
      private var mutiDiceBtn:IconButton;
      
      private var refreshButton:BaseButton;
      
      private var bagButton:BaseButton;
      
      private var _helpBtn:BaseButton;
      
      private var doubleAlertMc:MovieClip;
      
      private var fiveAlertMc:MovieClip;
      
      private var _scoreMcSprite:ScoreMovieSprite;
      
      private var _scoreTxt:FilterFrameText;
      
      private var indexArr:Array = [1,2,5];
      
      private var isBacth:Boolean = false;
      
      private var _timeId:int;
      
      private var _goodsList:Array = [];
      
      private var _newGoodsCount:int;
      
      private var _tempId:int;
      
      private var _dropLen:int;
      
      private var mutiConfigInfo:ConfigInfosTempInfo;
      
      private var mutiDiceCount:int;
      
      public function GoldRoadFrame()
      {
         super();
         loadGoldRoadBg();
         initView();
         initEvent();
         GoldRoadManager.instance.getOrRefreshGoldInfo(1);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         _goldRoadview = ComponentFactory.Instance.creatCustomObject("goldRoadFrame.goldRoadView");
         _bottomBg = ComponentFactory.Instance.creatBitmap("asset.goldroad.bottomBg");
         oneButton = ComponentFactory.Instance.creatComponentByStylename("goldRoadFrame.oneButton");
         doubleButton = ComponentFactory.Instance.creatComponentByStylename("goldRoadFrame.doubleButton");
         fiveButton = ComponentFactory.Instance.creatComponentByStylename("goldRoadFrame.fiveButton");
         diceButton = ComponentFactory.Instance.creatComponentByStylename("goldRoadFrame.diceButton");
         refreshButton = ComponentFactory.Instance.creatComponentByStylename("goldRoadFrame.refreshButton");
         bagButton = ComponentFactory.Instance.creatComponentByStylename("goldRoadFrame.bagButton");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("goldRoadFrame.helpBtn");
         mutiDiceBtn = ComponentFactory.Instance.creatComponentByStylename("goldRoadFrame.mutiDiceBtn");
         _scoreMcSprite = ComponentFactory.Instance.creatCustomObject("goldRoadFrame.scoreMovieSprite");
         doubleAlertMc = ComponentFactory.Instance.creatCustomObject("goldRoadFrame.doubleAlertMc");
         fiveAlertMc = ComponentFactory.Instance.creatCustomObject("goldRoadFrame.fiveAlertMc");
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("goldRoadFrame.scoreDescTxt");
         addToContent(_goldRoadview);
         addToContent(_bottomBg);
         addToContent(doubleAlertMc);
         addToContent(fiveAlertMc);
         addToContent(oneButton);
         addToContent(doubleButton);
         addToContent(fiveButton);
         addToContent(diceButton);
         addToContent(refreshButton);
         addToContent(bagButton);
         addToContent(_helpBtn);
         addToContent(_scoreMcSprite);
         addToContent(mutiDiceBtn);
         addToContent(_scoreTxt);
         mutiGrounp = new SelectedButtonGroup();
         mutiGrounp.addSelectItem(oneButton);
         mutiGrounp.addSelectItem(doubleButton);
         mutiGrounp.addSelectItem(fiveButton);
         oneButton.tipData = LanguageMgr.GetTranslation("goldroad.goldRoadFrame.oneButtonTipdata");
         doubleButton.tipData = LanguageMgr.GetTranslation("goldroad.goldRoadFrame.doubleButtonTipdata");
         fiveButton.tipData = LanguageMgr.GetTranslation("goldroad.goldRoadFrame.fiveButtonTipdata");
         diceButton.tipData = LanguageMgr.GetTranslation("goldroad.goldRoadFrame.diceButtonTipdata");
         refreshButton.tipData = LanguageMgr.GetTranslation("goldroad.goldRoadFrame.refreshButtonTipdata",10);
         bagButton.tipData = LanguageMgr.GetTranslation("goldroad.goldRoadFrame.bagButtonTipdata");
         _helpBtn.tipData = LanguageMgr.GetTranslation("goldroad.goldRoadFrame.helpButtonTipdata");
         mutiConfigInfo = TempleteManager.instance.getConfigInfoByConfigName("Golden_Road_Batch_Times");
         if(mutiConfigInfo)
         {
            mutiDiceCount = int(mutiConfigInfo.ConfigValue);
         }
         mutiDiceBtn.tipData = LanguageMgr.GetTranslation("goldroad.goldRoadFrame.mutiDiceBtnTipdata",mutiDiceCount);
         _scoreTxt.text = LanguageMgr.GetTranslation("goldroad.goldRoadFrame.scoreTxt");
         mutiGrounp.selectIndex = indexArr.indexOf(model.mutiCount);
         setMutiGroupAndTextMc(model.mutiCount);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         GoldRoadManager.instance.addEventListener("GOLDROADRE_DICE",refreshScoreAndStep);
         diceButton.addEventListener("click",__diceClickHandler);
         mutiDiceBtn.addEventListener("click",__diceClickHandler);
         refreshButton.addEventListener("click",__refreshHandler);
         bagButton.addEventListener("click",__openBagHandler);
         _helpBtn.addEventListener("click",__onHelperBtnClick);
         model.addEventListener("GOLDROADRE_ARRIVE",__arriveHandler);
         model.addEventListener("GOLDROADRE_SUPERDICE",__selectSuperDiceHandler);
         NotificationManager.instance.addEventListener("REFRESH_TOPTOOLS",__refreshState);
         mutiGrounp.addEventListener("change",__multipleHandler);
      }
      
      private function loadGoldRoadBg() : void
      {
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(onloadGoldRoadBgComplete);
         var _loc1_:URLVariables = new URLVariables();
         _loc1_["rnd"] = ComponentSetting.LOGIN_RND;
         var _loc2_:String = ComponentSetting.RESOURCE_PATH + "goldroadback.jpg";
         LoaderManagerII.instance.load(_loc2_,2,8,onloadGoldRoadBgComplete,null,null,null,_loc1_);
      }
      
      private function onloadGoldRoadBgComplete(param1:LoaderInfo, param2:Object) : void
      {
         if(param2)
         {
            _bg = param2 as Bitmap;
            addToContentAt(_bg,0);
         }
      }
      
      private function refreshScoreAndStep(param1:GoldRoadEvent) : void
      {
         _goodsList = model.dropTempStr.split(",");
         _dropLen = _goodsList.length;
         if(_scoreMcSprite)
         {
            _scoreMcSprite.refreshView(null);
         }
         if(_dropLen > 1)
         {
            __arriveHandler(null);
         }
         else if(_goldRoadview)
         {
            _goldRoadview.refreshView();
         }
      }
      
      private function setButtonEnable(param1:Boolean = true) : void
      {
         if(diceButton == null)
         {
            return;
         }
         mutiDiceBtn.enable = diceButton.enable = super.closeButton.enable = refreshButton.enable = bagButton.enable = param1;
         oneButton.enable = doubleButton.enable = fiveButton.enable = param1;
         _scoreMcSprite.mouseChildren = _scoreMcSprite.mouseEnabled = param1;
      }
      
      private function __selectSuperDiceHandler(param1:GoldRoadEvent) : void
      {
         setButtonEnable(!param1.data);
      }
      
      private function __arriveHandler(param1:GoldRoadEvent) : void
      {
         _timeId = setInterval(popGoods,300);
      }
      
      private function popGoods() : void
      {
         _tempId = _goodsList.pop();
         playNewGoodsEffect(_tempId);
         _newGoodsCount += 1;
         if(_newGoodsCount >= 5 || _goodsList.length == 0 || _newGoodsCount >= _dropLen)
         {
            clearInterval(_timeId);
            _goodsList = [];
            _newGoodsCount = 0;
            if(_tempId != -1)
            {
               GoldRoadManager.instance.sendBroadCast(true,0);
               setButtonEnable(true);
            }
         }
      }
      
      private function playNewGoodsEffect(param1:int) : void
      {
         var _loc2_:BaseIconView = null;
         if(param1 == -1)
         {
            GoldRoadManager.instance.throwDice(-1,0,false);
            return;
         }
         _loc2_ = ComponentFactory.Instance.creatCustomObject("core.BaseIcon",[iconComplete]);
         _loc2_.icon = IconFactory.getGoodsIconByTID(param1);
      }
      
      private function iconComplete(param1:BaseIconView = null) : void
      {
         var bagPoint:Point;
         var icon:BaseIconView = param1;
         var startPoint:Point = this.localToGlobal(new Point(688,390));
         icon.x = startPoint.x + 10;
         icon.y = startPoint.y - 10;
         icon.mouseChildren = icon.mouseEnabled = false;
         bagPoint = this.localToGlobal(new Point(780,490));
         if(icon)
         {
            TweenMax.to(icon,1,{
               "delay":0.3,
               "bezierThrough":[{
                  "x":icon.x,
                  "y":icon.y
               },{
                  "x":bagPoint.x,
                  "y":bagPoint.y
               }],
               "scaleX":0.5,
               "scaleY":0.5,
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
               "onCompleteParams":[icon]
            });
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
         ObjectUtils.disposeObject(param1);
      }
      
      private function __multipleHandler(param1:Event) : void
      {
         switch(mutiGrounp.getSelectedItem())
         {
            case oneButton:
               model.mutiCount = 1;
               break;
            case doubleButton:
               model.mutiCount = 2;
               break;
            case fiveButton:
               model.mutiCount = 5;
         }
         setMutiGroupAndTextMc(model.mutiCount);
      }
      
      private function setMutiGroupAndTextMc(param1:int) : void
      {
         switch(param1 - 1)
         {
            case 0:
               doubleAlertMc.gotoAndStop(1);
               fiveAlertMc.gotoAndStop(1);
               doubleAlertMc.visible = false;
               fiveAlertMc.visible = false;
               break;
            case 1:
               doubleAlertMc.visible = true;
               fiveAlertMc.visible = false;
               doubleAlertMc.gotoAndPlay(1);
               fiveAlertMc.gotoAndStop(1);
               break;
            case 4:
               doubleAlertMc.visible = false;
               fiveAlertMc.visible = true;
               doubleAlertMc.gotoAndStop(1);
               fiveAlertMc.gotoAndPlay(1);
         }
      }
      
      private function __diceClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(param1.target is BaseButton && param1.target.stylename == "goldRoadFrame.diceButton")
         {
            isBacth = false;
         }
         else if(param1.target is IconButton && param1.target.stylename == "goldRoadFrame.mutiDiceBtn")
         {
            isBacth = true;
         }
         if(GoodsManager.instance.getGoldRoadBagList().getList().length >= 8 * 7)
         {
            _loc2_ = LanguageMgr.GetTranslation("goldroad.goldRoadFrame.diceBagTipData");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(PlayerManager.instance.currentPlayerModel.nowDate > ConfigManager.info.GOLDROAD_END_DATE.time)
         {
            _loc2_ = LanguageMgr.GetTranslation("activity.ActivityManager.command02");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(todayNeedAlertForDice(isBacth))
         {
            showDiceAlertTips();
         }
         else
         {
            dickConfirm();
         }
      }
      
      private function dickConfirm() : void
      {
         var _loc1_:int = int(GoodsManager.instance.getGoodsNumByTempId(208051));
         var _loc2_:int = int(isBacth ? mutiDiceCount : 1);
         if(_loc1_ < model.mutiCount * _loc2_)
         {
            if(PlayerManager.instance.currentPlayerModel.playerInfo.point < model.mutiCount * 10 * _loc2_)
            {
               RechargeAlertMannager.show();
               return;
            }
         }
         setButtonEnable(false);
         GoldRoadManager.instance.throwDice(model.mutiCount,0,isBacth);
      }
      
      private function __refreshHandler(param1:MouseEvent) : void
      {
         if(PlayerManager.instance.currentPlayerModel.nowDate > ConfigManager.info.GOLDROAD_END_DATE.time)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.ActivityManager.command02"));
            return;
         }
         if(PlayerManager.instance.currentPlayerModel.playerInfo.point < 10)
         {
            RechargeAlertMannager.show();
            return;
         }
         if(todayNeedAlertForRefresh)
         {
            showAlertTips();
         }
         else
         {
            GoldRoadManager.instance.getOrRefreshGoldInfo(2);
         }
      }
      
      private function showAlertTips() : void
      {
         var _loc4_:TodayNotAlertFrame = null;
         var _loc1_:String = LanguageMgr.GetTranslation("active.expback.frame.selectbtntxt");
         var _loc3_:String = LanguageMgr.GetTranslation("goldroad.goldRoadFrame.refreshContentTxt",10);
         var _loc2_:Boolean = true;
         _loc2_ = todayNeedAlertForRefresh;
         if(_loc2_)
         {
            _loc4_ = ComponentFactory.Instance.creatComponentByStylename("goldroad.goldRoadTodayNotAlertFrame");
            _loc4_.show(_loc3_,_loc1_,__showTipResult,null,"center");
            return;
         }
      }
      
      private function __showTipResult(param1:Boolean) : void
      {
         if(param1)
         {
            SharedManager.instance.refreshGoldRoadGoods = new Date();
            SharedManager.instance.saverefreshGoldRoadAlertDate();
         }
         GoldRoadManager.instance.getOrRefreshGoldInfo(2);
      }
      
      private function get todayNeedAlertForRefresh() : Boolean
      {
         var _loc2_:Date = null;
         var _loc3_:Boolean = true;
         var _loc1_:Date = SharedManager.instance.refreshGoldRoadGoods;
         if(_loc1_)
         {
            _loc2_ = new Date();
            if(_loc2_.fullYear == _loc1_.fullYear && _loc2_.month == _loc1_.month && _loc2_.date == _loc1_.date)
            {
               _loc3_ = false;
            }
         }
         return _loc3_;
      }
      
      private function showDiceAlertTips() : void
      {
         var _loc7_:TodayNotAlertFrame = null;
         var _loc1_:String = LanguageMgr.GetTranslation("active.expback.frame.selectbtntxt");
         var _loc5_:int = int(isBacth ? mutiDiceCount : 1);
         var _loc3_:int = model.mutiCount * 10 * _loc5_;
         var _loc2_:String = TempleteManager.instance.goodsTemplateCate.getTemplateByID(208051).TemplateName;
         var _loc6_:String = LanguageMgr.GetTranslation("goldroad.goldRoadFrame.diceContentTxt",_loc3_,_loc5_,_loc2_);
         var _loc4_:Boolean = true;
         _loc4_ = todayNeedAlertForDice(isBacth);
         if(_loc4_)
         {
            _loc7_ = ComponentFactory.Instance.creatComponentByStylename("goldroad.goldRoadTodayNotAlertFrame");
            _loc7_.show(_loc6_,_loc1_,__showDiceTipResult,null,"center");
            return;
         }
      }
      
      private function todayNeedAlertForDice(param1:Boolean) : Boolean
      {
         var _loc2_:Date = null;
         var _loc3_:Date = null;
         var _loc4_:Boolean = true;
         if(!param1)
         {
            _loc2_ = SharedManager.instance.diceGoldRoad;
         }
         else
         {
            _loc2_ = SharedManager.instance.diceGoldRoad2;
         }
         if(_loc2_)
         {
            _loc3_ = new Date();
            if(_loc3_.fullYear == _loc2_.fullYear && _loc3_.month == _loc2_.month && _loc3_.date == _loc2_.date)
            {
               _loc4_ = false;
            }
         }
         return _loc4_;
      }
      
      private function __showDiceTipResult(param1:Boolean) : void
      {
         if(param1)
         {
            if(!isBacth)
            {
               SharedManager.instance.diceGoldRoad = new Date();
               SharedManager.instance.savereDiceAlertDate();
            }
            else
            {
               SharedManager.instance.diceGoldRoad2 = new Date();
               SharedManager.instance.savereDiceAlertDate2();
            }
         }
         dickConfirm();
      }
      
      private function __openBagHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:GoldRoadBagFrame = ComponentFactory.Instance.creatComponentByStylename("gold.goldRoadBagFrame");
         _loc2_.show();
      }
      
      private function __onHelperBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("goldRoad.goldRoadHelperFrame");
         _loc2_.show();
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         diceButton.removeEventListener("click",__diceClickHandler);
         mutiDiceBtn.removeEventListener("click",__diceClickHandler);
         refreshButton.removeEventListener("click",__refreshHandler);
         bagButton.removeEventListener("click",__openBagHandler);
         _helpBtn.removeEventListener("click",__onHelperBtnClick);
         model.removeEventListener("GOLDROADRE_ARRIVE",__arriveHandler);
         model.removeEventListener("GOLDROADRE_SUPERDICE",__selectSuperDiceHandler);
         NotificationManager.instance.removeEventListener("REFRESH_TOPTOOLS",__refreshState);
         GoldRoadManager.instance.removeEventListener("GOLDROADRE_DICE",refreshScoreAndStep);
         mutiGrounp.removeEventListener("change",__multipleHandler);
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
         }
      }
      
      public function show() : void
      {
         var _loc1_:* = undefined;
         model.hasOpenFrame = true;
         titleText = LanguageMgr.GetTranslation("gold.GoldRoadFrame.titleText");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
         this.x = (StageReferance.stageWidth - this.width) / 2;
         try
         {
            _loc1_ = SpaceManager.instance.controller.getArmyView(SpaceManager.instance.model.selfArmy as BaseArmy);
            _loc1_.stopWalkByOut();
         }
         catch(e:Error)
         {
         }
      }
      
      private function get model() : GoldRoadModel
      {
         return GoldRoadManager.instance.model;
      }
      
      public function setRefuse() : void
      {
         if(!model.goldRoadRefuseInvite)
         {
            SocketSendManager.instance.sendRefuseInvite();
         }
         if(!model.goldRoadRefuseInvitation)
         {
            SharedManager.instance.refuseInvitation = model.goldRoadRefuseInvitation;
            SharedManager.instance.save();
         }
         if(!model.goldRoadRefuseTeamInvite)
         {
            SocketSendManager.instance.sendRefuseTeamInvite();
         }
      }
      
      private function __refreshState(param1:NotificationEvent) : void
      {
         if(!ConfigManager.info.GOLDROAD || PlayerManager.instance.currentPlayerModel.nowDate >= ConfigManager.info.GOLDROAD_END_DATE.time)
         {
            dispose();
         }
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         model.hasOpenFrame = false;
         removeEvent();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_bottomBg)
         {
            ObjectUtils.disposeObject(_bottomBg);
         }
         _bottomBg = null;
         if(_goldRoadview)
         {
            ObjectUtils.disposeObject(_goldRoadview);
         }
         _goldRoadview = null;
         if(_scoreMcSprite)
         {
            ObjectUtils.disposeViolentMc(_scoreMcSprite);
         }
         _scoreMcSprite = null;
         if(oneButton)
         {
            ObjectUtils.disposeObject(oneButton);
         }
         oneButton = null;
         if(doubleButton)
         {
            ObjectUtils.disposeObject(doubleButton);
         }
         doubleButton = null;
         if(fiveButton)
         {
            ObjectUtils.disposeObject(fiveButton);
         }
         fiveButton = null;
         if(diceButton)
         {
            ObjectUtils.disposeObject(diceButton);
         }
         diceButton = null;
         if(bagButton)
         {
            ObjectUtils.disposeObject(bagButton);
         }
         bagButton = null;
         if(refreshButton)
         {
            ObjectUtils.disposeObject(refreshButton);
         }
         refreshButton = null;
         if(doubleAlertMc)
         {
            ObjectUtils.disposeViolentMc(doubleAlertMc);
         }
         doubleAlertMc = null;
         if(fiveAlertMc)
         {
            ObjectUtils.disposeViolentMc(fiveAlertMc);
         }
         fiveAlertMc = null;
         if(mutiDiceBtn)
         {
            ObjectUtils.disposeViolentMc(mutiDiceBtn);
         }
         mutiDiceBtn = null;
         if(_helpBtn)
         {
            ObjectUtils.disposeObject(_helpBtn);
         }
         _helpBtn = null;
         if(_closeButton)
         {
            ObjectUtils.disposeObject(_closeButton);
         }
         _closeButton = null;
         if(_scoreTxt)
         {
            ObjectUtils.disposeObject(_scoreTxt);
         }
         _scoreTxt = null;
         setRefuse();
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(onloadGoldRoadBgComplete);
         if(mutiGrounp)
         {
            ObjectUtils.disposeObject(mutiGrounp);
         }
         mutiGrounp = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

