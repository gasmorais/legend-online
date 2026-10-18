package consortia.view.myConsortia.building
{
   import com.greensock.TweenLite;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortia.helper.ConsortiaAltarHelper;
   import events.ConsortiaEvent;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import managers.VIPManager;
   import mvc.module.consortia.ConsortiaModel;
   import mvc.module.vip.VIPModel;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.PlayerEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.view.community.BaseItemView;
   
   public class ConsortiaNewAltarFrame extends Frame
   {
      
      public static const QUICK_BLESS_VIP_GRADE:int = 4;
      
      public static const LEVEL_ARR:Array = [1,4,7];
      
      private var _bg:MutipleImage;
      
      private var _btnVbox:VBox;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _statue:ScaleFrameImage;
      
      private var _descTxt:FilterFrameText;
      
      private var _introduceTxt:FilterFrameText;
      
      private var _goodsTxt:FilterFrameText;
      
      private var _achievementNumTxt:FilterFrameText;
      
      private var _contributionNumTxt:FilterFrameText;
      
      private var _leftCountTxt:FilterFrameText;
      
      private var _consumeContributionTxt:FilterFrameText;
      
      private var _consumeAchievementTxt:FilterFrameText;
      
      private var _blessBtn:IconButton;
      
      private var _oneKeyBlessBtn:IconButton;
      
      private var _centerContainer:Sprite;
      
      private var _centerItem:BaseItemView;
      
      private var _altarEffectMC:MovieClip;
      
      private var _btnEffectMC:MovieClip;
      
      private var _stripView1:StripView;
      
      private var _stripView2:StripView;
      
      public function ConsortiaNewAltarFrame()
      {
         super();
         initView();
         initEvent();
         refreshView();
         initData();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("consortia.view.myConsortia.building.ConsortiaAltarFrame.titleText",model.consortiaInfo.altarLevel);
         _bg = ComponentFactory.Instance.creatComponentByStylename("consortiaNewAltarFrame.bg");
         _btnVbox = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaNewAltarFrame.btnVbox");
         _statue = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaNewAltarFrame.statue");
         _descTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaNewAltarFrame.descTxt");
         _introduceTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaNewAltarFrame.introduceTxt");
         _goodsTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaNewAltarFrame.goodsTxt");
         _achievementNumTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaNewAltarFrame.achievementNumTxt");
         _contributionNumTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaNewAltarFrame.contributionNumTxt");
         _leftCountTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaNewAltarFrame.leftCountTxt");
         _consumeContributionTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaNewAltarFrame.consumeContributionTxt");
         _consumeAchievementTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaNewAltarFrame.consumeAchievementTxt");
         _blessBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaNewAltarFrame.blessBtn");
         _oneKeyBlessBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaNewAltarFrame.oneKeyBlessBtn");
         _altarEffectMC = ComponentFactory.Instance.creat("asset.consortia.altarNewEffctMC");
         _centerItem = ComponentFactory.Instance.creatCustomObject("consortia.AltarFrameBaseItemView");
         _btnEffectMC = ComponentFactory.Instance.creat("asset.consortia.altarBtnEffctMC");
         _stripView1 = ComponentFactory.Instance.creatCustomObject("consortiaNewAltarFrame.StripView");
         _stripView2 = ComponentFactory.Instance.creatCustomObject("consortiaNewAltarFrame.StripView");
         addToContent(_bg);
         addToContent(_btnEffectMC);
         addToContent(_btnVbox);
         addToContent(_statue);
         addToContent(_descTxt);
         addToContent(_introduceTxt);
         addToContent(_goodsTxt);
         addToContent(_achievementNumTxt);
         addToContent(_contributionNumTxt);
         addToContent(_leftCountTxt);
         addToContent(_consumeContributionTxt);
         addToContent(_consumeAchievementTxt);
         addToContent(_blessBtn);
         addToContent(_oneKeyBlessBtn);
         addToContent(_altarEffectMC);
         _altarEffectMC.gotoAndStop(1);
         _altarEffectMC.visible = false;
         _altarEffectMC.x = 360;
         _altarEffectMC.y = 500;
         initBtnView();
         _centerContainer = new Sprite();
         _centerContainer.x = 222;
         _centerContainer.y = -1;
         _centerContainer.visible = false;
         addToContent(_centerContainer);
         _centerContainer.addChild(_centerItem);
      }
      
      private function initBtnView() : void
      {
         var _loc2_:int = 0;
         var _loc4_:SelectedIconButton = null;
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         addToContent(_stripView1);
         addToContent(_stripView2);
         _stripView2.y = _stripView1.y + 130;
         _stripView1.setHitArea(0,0,65,65);
         _stripView2.setHitArea(0,0,65,65);
         _stripView1.mouseEnabled = _stripView1.mouseChildren = false;
         _stripView2.mouseEnabled = _stripView2.mouseChildren = false;
         _btnGroup = new SelectedButtonGroup();
         _loc2_ = 1;
         while(_loc2_ <= 3)
         {
            _loc4_ = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaNewAltarFrame.btn" + _loc2_);
            _btnVbox.addChild(_loc4_);
            _btnGroup.addSelectItem(_loc4_);
            _loc3_ = _loc2_ - 1;
            _loc1_ = int(LEVEL_ARR[_loc3_]);
            if(model.consortiaInfo.altarLevel < _loc1_)
            {
               _loc4_.enable = false;
               this["_stripView" + _loc3_].tipData = LanguageMgr.GetTranslation("ConsortiaNewAltarFrame.openLevel",_loc1_);
               this["_stripView" + _loc3_].mouseEnabled = true;
               this["_stripView" + _loc3_].mouseChildren = true;
               if(model.altarWorshipIndex == _loc2_)
               {
                  model.altarWorshipIndex = 1;
               }
            }
            _loc2_++;
         }
         _btnGroup.selectIndex = model.altarWorshipIndex - 1;
         _btnEffectMC.x = 590;
         _btnEffectMC.y = 38 + 130 * _btnGroup.selectIndex;
      }
      
      private function initData() : void
      {
         _oneKeyBlessBtn.tipData = LanguageMgr.GetTranslation("consortia.view.myConsortia.building.ConsortiaAltarView.QuickBlessTipTxt");
         _descTxt.text = LanguageMgr.GetTranslation("ConsortiaNewAltarFrame.descTxt.text");
         _introduceTxt.text = LanguageMgr.GetTranslation("ConsortiaNewAltarFrame.introduceTxt.text");
         _achievementNumTxt.text = model.reputation + "";
         _contributionNumTxt.text = playerInfo.consortiaOffer + "";
         _consumeContributionTxt.htmlText = LanguageMgr.GetTranslation("ConsortiaNewAltarFrame.consumeContributionTxt.text",consume);
         _consumeAchievementTxt.htmlText = LanguageMgr.GetTranslation("ConsortiaNewAltarFrame.consumeAchievementTxt.text",altarReputationCost);
         _statue.setFrame(model.altarWorshipIndex);
         FrameControllerManager.instance.consortiaController.initAltarFrameInfo();
      }
      
      public function playAltarEffect() : void
      {
         _altarEffectMC.visible = true;
         _altarEffectMC.addFrameScript(15,function():void
         {
            altarCallback();
            _centerContainer.visible = true;
            _centerContainer.x = 430;
            _centerContainer.y = 200;
            _centerContainer.scaleX = 0.1;
            _centerContainer.scaleY = 0.1;
            TweenLite.to(_centerContainer,0.15,{
               "x":430,
               "y":185,
               "scaleX":1,
               "scaleY":1
            });
         });
         _altarEffectMC.addFrameScript(_altarEffectMC.totalFrames - 1,function():void
         {
            _altarEffectMC.stop();
         });
         _altarEffectMC.gotoAndPlay(1);
      }
      
      private function altarCallback() : void
      {
         model.lastaltarGoods = model.altarGoods;
         model.isBlessing = false;
         setBtnState();
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         if(_btnGroup)
         {
            _btnGroup.addEventListener("change",__tabChangeHandler);
         }
         _centerContainer.addEventListener("click",__onIconClickHandler);
         model.addEventListener("CONSORTIA_UPGRADE",__onConsortiaUpgrade);
         model.addEventListener("UPDA_ALTAR_BLESS_LEFT_TIME",__onBlessLeftTimeUpdata);
         model.addEventListener("UPDE_ALTAR_GOODS",__updateAltarGoods);
         model.addEventListener("UPDA_ALTAR_BLESS_INFO",__onBlessInfoCallback);
         model.addEventListener("UPDA_ALTAR_BLESS",__onBlessCallback);
         playerInfo.addEventListener("CONSORTIA_OFFER_CHANGE",__onSelfConsortiaOfferUpdata);
         playerInfo.addEventListener("CONSORTIA_CHANGE",__existConsortiaHandler);
         _blessBtn.addEventListener("click",__onBlessClickHandler);
         _oneKeyBlessBtn.addEventListener("click",__onQuickBlessClickHandler);
         MsgMan.addObserver("UPDATE_QUEST_INFO",this,__updateReputationHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_btnGroup)
         {
            _btnGroup.removeEventListener("change",__tabChangeHandler);
         }
         _centerContainer.removeEventListener("click",__onIconClickHandler);
         model.removeEventListener("CONSORTIA_UPGRADE",__onConsortiaUpgrade);
         model.removeEventListener("UPDA_ALTAR_BLESS_LEFT_TIME",__onBlessLeftTimeUpdata);
         model.removeEventListener("UPDE_ALTAR_GOODS",__updateAltarGoods);
         model.removeEventListener("UPDA_ALTAR_BLESS_INFO",__onBlessInfoCallback);
         model.removeEventListener("UPDA_ALTAR_BLESS",__onBlessCallback);
         playerInfo.removeEventListener("CONSORTIA_OFFER_CHANGE",__onSelfConsortiaOfferUpdata);
         playerInfo.removeEventListener("CONSORTIA_CHANGE",__existConsortiaHandler);
         _blessBtn.removeEventListener("click",__onBlessClickHandler);
         _oneKeyBlessBtn.removeEventListener("click",__onQuickBlessClickHandler);
         MsgMan.removeObserver("UPDATE_QUEST_INFO",this,__updateReputationHandler);
      }
      
      private function __updateReputationHandler(param1:String, param2:Object) : void
      {
         _achievementNumTxt.text = model.reputation + "";
      }
      
      private function __onBlessClickHandler(param1:MouseEvent) : void
      {
         _centerItem.data = null;
         if(!ConsortiaAltarHelper.canBless(model,totalTime,consume,playerInfo.consortiaOffer,onDrawClick,altarReputationCost))
         {
            return;
         }
         FrameControllerManager.instance.consortiaController.consortiaAltarBless();
         setBtnState();
      }
      
      private function __onQuickBlessClickHandler(param1:MouseEvent) : void
      {
         _centerItem.data = null;
         if(!ConsortiaAltarHelper.canBless(model,totalTime,consume,playerInfo.consortiaOffer,onDrawClick,altarReputationCost))
         {
            return;
         }
         var _loc2_:int = Math.min(totalTime - model.alTarBlessLeftTime,playerInfo.consortiaOffer / consume);
         FrameControllerManager.instance.consortiaController.consortiaAltarBless(_loc2_);
         setBtnState();
      }
      
      private function __quickBlessHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            FrameControllerManager.instance.openControllerByInfo("vip");
         }
      }
      
      private function __existConsortiaHandler(param1:PlayerEvent) : void
      {
         if(playerInfo.consortiaID == 0)
         {
            dispose();
         }
      }
      
      private function __onIconClickHandler(param1:MouseEvent) : void
      {
         onDrawClick();
      }
      
      private function onDrawClick() : void
      {
         _centerItem.data = null;
         _altarEffectMC.gotoAndStop(1);
         _altarEffectMC.visible = false;
      }
      
      private function __onBlessInfoCallback(param1:ConsortiaEvent) : void
      {
         playAltarEffect();
      }
      
      private function __onBlessCallback(param1:ConsortiaEvent) : void
      {
         model.isBlessing = false;
         setBtnState();
      }
      
      private function setBtnState() : void
      {
         _blessBtn.enable = _oneKeyBlessBtn.enable = _closeButton.enable = !model.isBlessing;
      }
      
      private function __onConsortiaUpgrade(param1:ConsortiaEvent) : void
      {
         _consumeContributionTxt.htmlText = LanguageMgr.GetTranslation("ConsortiaNewAltarFrame.consumeContributionTxt.text",consume);
      }
      
      private function __onBlessLeftTimeUpdata(param1:ConsortiaEvent) : void
      {
         var _loc2_:int = int(model.alTarBlessLeftTime);
         _loc2_ = totalTime - _loc2_ < 0 ? 0 : totalTime - _loc2_;
         _leftCountTxt.htmlText = LanguageMgr.GetTranslation("ConsortiaNewAltarFrame.leftCountTxt.text",_loc2_,totalTime);
      }
      
      private function __updateAltarGoods(param1:ConsortiaEvent) : void
      {
         if(model.lastaltarGoods)
         {
            _centerItem.data = model.lastaltarGoods;
            FrameControllerManager.instance.consortiaController.getConsortiaAddFreshItem();
         }
      }
      
      private function __onSelfConsortiaOfferUpdata(param1:PlayerEvent) : void
      {
         _contributionNumTxt.text = playerInfo.consortiaOffer + "";
      }
      
      private function __tabChangeHandler(param1:Event) : void
      {
         _btnEffectMC.y = 38 + 130 * _btnGroup.selectIndex;
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc1_:int = _btnGroup.selectIndex + 1;
         model.altarWorshipIndex = _loc1_;
         _consumeAchievementTxt.htmlText = LanguageMgr.GetTranslation("ConsortiaNewAltarFrame.consumeAchievementTxt.text",altarReputationCost);
         _statue.setFrame(_loc1_);
         _goodsTxt.text = LanguageMgr.GetTranslation("ConsortiaNewAltarFrame.goodsTxt.text" + _loc1_);
      }
      
      private function get consume() : int
      {
         return TempleteManager.instance.getConsortiaTempleteByTypeAndLevel(3,model.consortiaInfo.altarLevel).Property1;
      }
      
      private function get totalTime() : int
      {
         return TempleteManager.instance.getConsortiaTempleteByTypeAndLevel(3,model.consortiaInfo.altarLevel).Property2;
      }
      
      private function get model() : ConsortiaModel
      {
         return FrameControllerManager.instance.consortiaController.model;
      }
      
      private function get vipModel() : VIPModel
      {
         return VIPManager.Instance.model;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get altarReputationCost() : int
      {
         var _loc1_:Array = ConfigInfoManager.instance.getAltarReputationCost();
         return _loc1_[model.altarWorshipIndex - 1];
      }
      
      public function show() : void
      {
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
               break;
            case 1:
               if(_closeButton.enable)
               {
                  dispose();
               }
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         TweenLite.killTweensOf(_centerContainer);
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_btnGroup);
         _btnGroup = null;
         ObjectUtils.disposeObject(_btnVbox);
         _btnVbox = null;
         ObjectUtils.disposeObject(_statue);
         _statue = null;
         ObjectUtils.disposeObject(_descTxt);
         _descTxt = null;
         ObjectUtils.disposeObject(_introduceTxt);
         _introduceTxt = null;
         ObjectUtils.disposeObject(_goodsTxt);
         _goodsTxt = null;
         ObjectUtils.disposeObject(_achievementNumTxt);
         _achievementNumTxt = null;
         ObjectUtils.disposeObject(_contributionNumTxt);
         _contributionNumTxt = null;
         ObjectUtils.disposeObject(_leftCountTxt);
         _leftCountTxt = null;
         ObjectUtils.disposeObject(_consumeContributionTxt);
         _consumeContributionTxt = null;
         ObjectUtils.disposeObject(_consumeAchievementTxt);
         _consumeAchievementTxt = null;
         ObjectUtils.disposeObject(_blessBtn);
         _blessBtn = null;
         ObjectUtils.disposeObject(_oneKeyBlessBtn);
         _oneKeyBlessBtn = null;
         ObjectUtils.disposeObject(_centerContainer);
         _centerContainer = null;
         ObjectUtils.disposeObject(_centerItem);
         _centerItem = null;
         ObjectUtils.disposeObject(_stripView1);
         _stripView1 = null;
         ObjectUtils.disposeObject(_stripView2);
         _stripView2 = null;
         ObjectUtils.disposeViolentMc(_altarEffectMC);
         _altarEffectMC = null;
         ObjectUtils.disposeViolentMc(_btnEffectMC);
         _btnEffectMC = null;
         super.dispose();
         KeyBoardRegister.instance.keyEnable = true;
         FrameControllerManager.instance.consortiaController.closeAltarFrame();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

