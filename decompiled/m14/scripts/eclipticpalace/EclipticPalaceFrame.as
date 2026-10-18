package eclipticpalace
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import eclipticpalace.item.EclipticPalaceChallengeItem;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.EclipticPalaceManager;
   import mvc.ModuleFrameInfo;
   import mvc.module.eclipticpalace.EclipticPalaceModel;
   import utils.LogicUtils;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.datas.templates.EclipticPalaceTempInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SharedManagerHelper;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class EclipticPalaceFrame extends Frame
   {
      
      private var _spiritText:FilterFrameText;
      
      private var _rewardText:FilterFrameText;
      
      private var _eventText:FilterFrameText;
      
      private var _childBufferText:FilterFrameText;
      
      private var _tipImage:Image;
      
      private var _border:ScaleBitmapImage;
      
      private var _challengeBtn:BaseButton;
      
      private var _pathImage:ScaleFrameImage;
      
      private var _titleImage:ScaleFrameImage;
      
      private var _titleTextImage:ScaleFrameImage;
      
      private var _mback:MutipleImage;
      
      private var _selectImage:Bitmap;
      
      private var _bottomView:EclipticPalaceLayerProcessView;
      
      private var _spiritMc:MovieClip;
      
      private var _declineContiner:Component;
      
      private var _declineText:FilterFrameText;
      
      private var _countDownImage:Bitmap;
      
      private var _childIcon1:BaseIconView;
      
      private var _childIcon2:BaseIconView;
      
      private var _itemVbox:VBox;
      
      private var itemList:Vector.<EclipticPalaceChallengeItem>;
      
      private var backHour:int;
      
      private var buyMaxCount:int;
      
      private var perRecoverCount:int;
      
      private var spiritMax:int;
      
      private var buyCost:int;
      
      private var curSpiritCost:int;
      
      private var hasReceiveMsg:Boolean = false;
      
      public function EclipticPalaceFrame()
      {
         super();
         initView();
         initListView();
         addEvent();
         model.selectPath = model.selectedRoute != 0 ? model.selectedRoute : 1;
         model.openEclipticPalaceFrame = true;
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      private function initView() : void
      {
         _spiritText = ComponentFactory.Instance.creatComponentByStylename("EclipticPalace.EclipticPalaceFrame.spiritText");
         _rewardText = ComponentFactory.Instance.creatComponentByStylename("EclipticPalace.EclipticPalaceFrame.rewardText");
         _eventText = ComponentFactory.Instance.creatComponentByStylename("EclipticPalace.EclipticPalaceFrame.eventText");
         _childBufferText = ComponentFactory.Instance.creatComponentByStylename("EclipticPalace.EclipticPalaceFrame.childBufferText");
         _tipImage = ComponentFactory.Instance.creatComponentByStylename("EclipticPalace.EclipticPalaceFrame.tipImage");
         _border = ComponentFactory.Instance.creatComponentByStylename("EclipticPalace.EclipticPalaceFrame.border");
         _challengeBtn = ComponentFactory.Instance.creatComponentByStylename("EclipticPalace.EclipticPalaceFrame.challengeBtn");
         _pathImage = ComponentFactory.Instance.creatComponentByStylename("EclipticPalace.EclipticPalaceFrame.pathImage");
         _titleImage = ComponentFactory.Instance.creatComponentByStylename("EclipticPalace.EclipticPalaceFrame.titleImage");
         _titleTextImage = ComponentFactory.Instance.creatComponentByStylename("EclipticPalace.EclipticPalaceFrame.titleTextImage");
         _mback = ComponentFactory.Instance.creatComponentByStylename("EclipticPalace.EclipticPalaceFrame.mback");
         _itemVbox = ComponentFactory.Instance.creatComponentByStylename("EclipticPalaceFrame.itemVbox");
         _bottomView = ComponentFactory.Instance.creatCustomObject("EclipticPalaceFrame.bottomView");
         _selectImage = ComponentFactory.Instance.creatBitmap("asset.EclipticPalaceFrame.selectPathImage");
         _spiritMc = ComponentFactory.Instance.creatCustomObject("EclipticPalaceFrame.spiritMc");
         _childIcon1 = ComponentFactory.Instance.creatCustomObject("EclipticPalaceFrame.childIcon1");
         _childIcon2 = ComponentFactory.Instance.creatCustomObject("EclipticPalaceFrame.childIcon2");
         _declineText = ComponentFactory.Instance.creatComponentByStylename("EclipticPalaceFrame.declineText");
         _countDownImage = ComponentFactory.Instance.creatBitmap("asset.EclipticPalace.mback.timeTextImage");
         _declineContiner = ComponentFactory.Instance.creatComponentByStylename("EclipticPalaceFrame.declineContiner");
         addToContent(_border);
         addToContent(_mback);
         addToContent(_selectImage);
         addToContent(_titleImage);
         _titleImage.setFrame(1);
         addToContent(_titleTextImage);
         _titleTextImage.setFrame(1);
         addToContent(_pathImage);
         _pathImage.setFrame(1);
         addToContent(_declineContiner);
         addToContent(_childIcon1);
         addToContent(_childIcon2);
         addToContent(_itemVbox);
         addToContent(_bottomView);
         addToContent(_childBufferText);
         addToContent(_eventText);
         addToContent(_challengeBtn);
         addToContent(_rewardText);
         addToContent(_spiritMc);
         addToContent(_spiritText);
         addToContent(_tipImage);
         _declineContiner.addChild(_countDownImage);
         _countDownImage.visible = false;
         _declineContiner.addChild(_declineText);
         _declineText.text = "00:00:00";
         _spiritMc.mouseChildren = _spiritMc.mouseEnabled = false;
         _spiritMc.gotoAndStop(1);
         _rewardText.mouseEnabled = true;
         backHour = ConfigInfoManager.instance.getEclipticPalaceBackLayerHour();
         spiritMax = ConfigInfoManager.instance.getEclipticPalaceSpiritMax();
         buyCost = ConfigInfoManager.instance.getEclipticPalaceSpiritBuyCost();
         _declineContiner.tipData = LanguageMgr.GetTranslation("EclipticPalaceFrame.declineContiner.tipdata",backHour);
         _rewardText.htmlText = LanguageMgr.GetTranslation("EclipticPalaceFrame.rewardText.text");
         _eventText.text = LanguageMgr.GetTranslation("EclipticPalaceFrame.eventText.text");
      }
      
      private function initListView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:EclipticPalaceChallengeItem = null;
         itemList = new Vector.<EclipticPalaceChallengeItem>();
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = new EclipticPalaceChallengeItem(_loc2_ + 1);
            _itemVbox.addChild(_loc1_);
            itemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _rewardText.addEventListener("click",__rewardTxtClickHandler);
         _challengeBtn.addEventListener("click",_challengeBtnClickHandler);
         MsgMan.addObserver("SELECT_PATH",this,__selectPathHandler);
         MsgMan.addObserver("ECLIPTIC_PALACE_INFO_CHANGE",this,__routeInfoChangeHandler);
         playerModel.addEventListener("SYSTIME_UPGRADE_SECOND",__updateTimerMsgHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_rewardText)
         {
            _rewardText.removeEventListener("click",__rewardTxtClickHandler);
         }
         if(_challengeBtn)
         {
            _challengeBtn.removeEventListener("click",_challengeBtnClickHandler);
         }
         MsgMan.removeObserver("SELECT_PATH",this,__selectPathHandler);
         MsgMan.removeObserver("ECLIPTIC_PALACE_INFO_CHANGE",this,__routeInfoChangeHandler);
         playerModel.removeEventListener("SYSTIME_UPGRADE_SECOND",__updateTimerMsgHandler);
      }
      
      private function __selectPathHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function __routeInfoChangeHandler(param1:String, param2:Object) : void
      {
         hasReceiveMsg = true;
         refreshView();
      }
      
      private function __rewardTxtClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("eclipticpalace","REWARD_FRAME");
      }
      
      private function _challengeBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc4_:String = null;
         var _loc3_:int = 0;
         SoundManager.instance.play("022");
         if(model.isChallengeOver)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("EclipticPalaceFrame.challengeOver.alert"));
            return;
         }
         if(model.curSpirit < curSpiritCost)
         {
            _loc2_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc4_ = LanguageMgr.GetTranslation("EclipticPalaceFrame.buySpirit.content",buyCost);
            SharedManagerHelper.ins.needAlert("EclipticPalaceFrame.buy.alert",buyResultHandler,_loc2_,_loc4_);
         }
         else
         {
            _loc3_ = int(model.selectedRoute != 0 ? model.selectedRoute : int(model.selectPath));
            EclipticPalaceManager.instance.sendEclipticPalaceRequest(2,_loc3_);
         }
      }
      
      private function buyResultHandler() : void
      {
         EclipticPalaceManager.instance.sendEclipticPalaceRequest(4);
      }
      
      private function __updateTimerMsgHandler(param1:PlayerEvent) : void
      {
         var _loc2_:int = model.declineEndTime - playerModel.sysCurTimeBySecond;
         var _loc3_:int = model.recoverEndTime - playerModel.sysCurTimeBySecond;
         if(model.curLayer == 1)
         {
            _countDownImage.visible = false;
            _declineText.text = "";
            _declineContiner.tipData = null;
         }
         else
         {
            _countDownImage.visible = true;
            _declineContiner.tipData = LanguageMgr.GetTranslation("EclipticPalaceFrame.declineContiner.tipdata",backHour);
            if(_loc2_ > 0)
            {
               _loc2_--;
               _declineText.text = DateFormatter.getConsortiaCountDate(_loc2_);
            }
            else
            {
               _declineText.text = "00:00:00";
            }
         }
         if(_loc3_ > 0)
         {
            _loc3_--;
         }
         if(hasReceiveMsg)
         {
            if(_loc2_ <= 0 && !model.popEvent || _loc3_ <= 0)
            {
               EclipticPalaceManager.instance.sendEclipticPalaceRequest(1);
            }
         }
      }
      
      private function refreshView() : void
      {
         var _loc4_:int = 0;
         var _loc1_:EclipticPalaceChallengeItem = null;
         setDescText();
         _bottomView.refreshView();
         _titleTextImage.setFrame(model.curLayer);
         _titleImage.setFrame(model.curLayer);
         _selectImage.visible = model.selectedRoute == 0;
         _eventText.visible = model.isEventBoss;
         var _loc2_:int = int(model.selectedRoute != 0 ? model.selectedRoute : int(model.selectPath));
         _pathImage.setFrame(_loc2_);
         _spiritText.text = model.curSpirit + "/" + spiritMax;
         var _loc3_:int = model.curSpirit * 100 / spiritMax;
         _spiritMc.gotoAndStop(_loc3_);
         _loc4_ = 0;
         while(_loc4_ < 3)
         {
            _loc1_ = itemList[_loc4_];
            _loc1_.data = _loc4_ < model.routeList.length ? model.routeList[_loc4_] : null;
            _loc4_++;
         }
      }
      
      private function setDescText() : void
      {
         var _loc2_:ChildTempInfo = null;
         var _loc3_:ChildTempInfo = null;
         var _loc7_:String = null;
         var _loc6_:String = null;
         var _loc4_:SkillTempInfo = null;
         var _loc5_:String = null;
         perRecoverCount = ConfigInfoManager.instance.getEclipticPalaceRecoverPerHour();
         buyMaxCount = ConfigInfoManager.instance.getEclipticPalaceSpiritBuyCountMax();
         var _loc1_:EclipticPalaceTempInfo = TempleteManager.instance.eclipticPalaceTempCate.getTemplateByLayer(model.curLayer);
         curSpiritCost = _loc1_ ? _loc1_.SpiritCost : 0;
         _tipImage.tipData = LanguageMgr.GetTranslation("EclipticPalaceFrame.tipImage.tipdata",perRecoverCount,curSpiritCost,buyMaxCount);
         _childIcon1.icon = null;
         _childIcon2.icon = null;
         _childBufferText.text = "";
         if(model.selectRouteInfo)
         {
            _loc2_ = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(model.selectRouteInfo.guardJobType1,1);
            _loc3_ = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(model.selectRouteInfo.guardJobType2,1);
            if(_loc2_)
            {
               _childIcon1.icon = PathManager.getChildHeadIcon(_loc2_.Icon);
            }
            if(_loc3_)
            {
               _childIcon2.icon = PathManager.getChildHeadIcon(_loc3_.Icon);
            }
            _loc7_ = _loc2_ ? _loc2_.JobName : "";
            _loc6_ = _loc3_ ? _loc3_.JobName : "";
            _loc4_ = TempleteManager.instance.skillTemplateDic[model.selectRouteInfo.skillId];
            if(!_loc4_)
            {
               return;
            }
            if(_loc7_ == "" && _loc6_ == "")
            {
               _childBufferText.text = _loc4_.TemplateName;
            }
            else if(_loc7_ == "" || _loc6_ == "")
            {
               _loc5_ = _loc7_ == "" ? _loc6_ : _loc7_;
               _childBufferText.text = LanguageMgr.GetTranslation("EclipticPalaceFrame.childBufferText.text1",_loc5_,_loc4_.TemplateName);
            }
            else
            {
               _childBufferText.text = LanguageMgr.GetTranslation("EclipticPalaceFrame.childBufferText.text2",_loc7_,_loc6_,_loc4_.TemplateName);
            }
         }
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
         var _loc5_:String = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         if(param1 && param1.frameData)
         {
            EclipticPalaceManager.instance.sendEclipticPalaceRequest(1);
         }
         else
         {
            refreshView();
         }
         if(model.popEvent)
         {
            _loc5_ = LanguageMgr.GetTranslation("EclipticPalaceFrame.event.content");
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc4_ = LanguageMgr.GetTranslation("public.prompt");
            SimpleAlertHelper.instance.data = [confirmEventHandler];
            SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,true,true,2);
         }
      }
      
      private function confirmEventHandler(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:int = param1 ? 1 : 0;
         EclipticPalaceManager.instance.sendEclipticPalaceRequest(3,_loc3_);
      }
      
      private function get model() : EclipticPalaceModel
      {
         return EclipticPalaceManager.instance.model;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_spiritText);
         _spiritText = null;
         ObjectUtils.disposeObject(_rewardText);
         _rewardText = null;
         ObjectUtils.disposeObject(_eventText);
         _eventText = null;
         ObjectUtils.disposeObject(_childBufferText);
         _childBufferText = null;
         ObjectUtils.disposeObject(_tipImage);
         _tipImage = null;
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_challengeBtn);
         _challengeBtn = null;
         ObjectUtils.disposeObject(_pathImage);
         _pathImage = null;
         ObjectUtils.disposeObject(_titleImage);
         _titleImage = null;
         ObjectUtils.disposeObject(_titleTextImage);
         _titleTextImage = null;
         ObjectUtils.disposeObject(_mback);
         _mback = null;
         ObjectUtils.disposeObject(_itemVbox);
         _itemVbox = null;
         ObjectUtils.disposeObject(_bottomView);
         _bottomView = null;
         ObjectUtils.disposeObject(_selectImage);
         _selectImage = null;
         ObjectUtils.disposeObject(_countDownImage);
         _countDownImage = null;
         ObjectUtils.disposeObject(_childIcon1);
         _childIcon1 = null;
         ObjectUtils.disposeObject(_childIcon2);
         _childIcon2 = null;
         ObjectUtils.disposeObject(_declineText);
         _declineText = null;
         ObjectUtils.disposeObject(_declineContiner);
         _declineContiner = null;
         ObjectUtils.disposeViolentMc(_spiritMc);
         _spiritMc = null;
         LogicUtils.disposeDisplayCollection(itemList);
         itemList = null;
         model.openEclipticPalaceFrame = false;
         super.dispose();
      }
   }
}

