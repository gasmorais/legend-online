package skyboxroad
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Quart;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import mainBar.ChatBar;
   import manager.LanguageMgr;
   import managers.MagicSpringManager;
   import managers.SkyboxRoadManager;
   import mvc.module.magicspring.MagicSpringSlotInfo;
   import mvc.module.skyboxroad.SkyboxRoadModel;
   import skyboxroad.view.SkyBoxRoadRightView;
   import skyboxroad.view.SkyBoxRoadView;
   import skyboxroad.view.SkyboxRoadExploreView;
   import ui.maintoolbar.MainToolBar;
   import ui.maintoolbar.view.MainToolButton;
   import yishi.datas.VersionSwitch;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.datas.templates.GameHeroTempInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.SkytrialeventTemplateInfo;
   import yishi.datas.templates.SkytriallayerTemplateInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.SharedManagerHelper;
   import yishi.manager.TempleteManager;
   import yishi.scene.BaseSceneView;
   import yishi.scene.SceneManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.community.MagicSpringBufferAddView;
   import yishi.view.tips.MessageTipManager;
   
   public class SkyBoxRoadFrame extends BaseSceneView
   {
      
      private var _bg:Bitmap;
      
      private var _titleBg:Bitmap;
      
      private var _titleTxtImg:Bitmap;
      
      private var _activeValueBg:Bitmap;
      
      private var _activeValueImg:Bitmap;
      
      private var _activeValueImgMask:Shape;
      
      private var _buyActiveBtn:BaseButton;
      
      private var _activePressTxt:FilterFrameText;
      
      private var _upBtn:IconButton;
      
      private var _downBtn:IconButton;
      
      private var _floorTxtImg:Bitmap;
      
      private var _flootTxt:FilterFrameText;
      
      private var _rightView:SkyBoxRoadRightView;
      
      private var _rewardBtn:BaseButton;
      
      private var _smallBg:Bitmap;
      
      private var _skyBoxRoadView:SkyBoxRoadView;
      
      private var _exploreView:SkyboxRoadExploreView;
      
      private var _maxEnergy:int;
      
      private var _eventTemplateInfo:SkytrialeventTemplateInfo;
      
      private var _bigBonusMc:MovieClip;
      
      private var _exploreCompleteMc:MovieClip;
      
      private var _layerInfoBg:Bitmap;
      
      private var _rewardIcon:Bitmap;
      
      private var _descTxt:FilterFrameText;
      
      private var _rankBtn:BaseButton;
      
      private var _bufferView:MagicSpringBufferAddView;
      
      private var _iconType:String;
      
      public function SkyBoxRoadFrame()
      {
         super();
         var _loc1_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("skytrial_max_energy");
         _maxEnergy = int(_loc1_.ConfigValue);
      }
      
      override public function enter(param1:BaseSceneView, param2:Object = null) : void
      {
         super.enter(param1,param2);
         initView();
         initBufferView();
         initEvent();
         updateView();
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.skyboxroad.bg");
         _titleBg = ComponentFactory.Instance.creatBitmap("asset.skyboxroad.TitleBg");
         _smallBg = ComponentFactory.Instance.creatBitmap("asset.skyboxroad.smallBg");
         _titleTxtImg = ComponentFactory.Instance.creatBitmap("asset.skyboxroad.TitleTxtImg");
         _activeValueBg = ComponentFactory.Instance.creatBitmap("asset.skyboxroad.progressBg");
         _activeValueImg = ComponentFactory.Instance.creatBitmap("asset.skyboxroad.progressImg");
         _activeValueImgMask = new Shape();
         _activeValueImgMask.graphics.beginFill(0);
         _activeValueImgMask.graphics.drawRect(0,0,_activeValueImg.width,_activeValueImg.height);
         _activeValueImgMask.graphics.endFill();
         _activeValueImgMask.x = _activeValueImg.x;
         _activeValueImgMask.y = _activeValueImg.y;
         _activeValueImg.mask = _activeValueImgMask;
         _activePressTxt = ComponentFactory.Instance.creatComponentByStylename("skyboxroad.mianframe.activePressTxt");
         _buyActiveBtn = ComponentFactory.Instance.creatComponentByStylename("skyboxroad.mianframe.buyActiveBtn");
         _upBtn = ComponentFactory.Instance.creatComponentByStylename("skyboxroad.mianframe.upBtn");
         _downBtn = ComponentFactory.Instance.creatComponentByStylename("skyboxroad.mianframe.downBtn");
         _rightView = ComponentFactory.Instance.creatCustomObject("skyboxroad.SkyBoxRoadRightView");
         _floorTxtImg = ComponentFactory.Instance.creatBitmap("asset.skyboxroad.floorTxtImg");
         _flootTxt = ComponentFactory.Instance.creatComponentByStylename("skyboxroad.mianframe.floorTxt");
         _rewardBtn = ComponentFactory.Instance.creatComponentByStylename("skyboxroad.ChapterRewardBtn");
         _skyBoxRoadView = ComponentFactory.Instance.creatCustomObject("skyboxroad.SkyBoxRoadView");
         _layerInfoBg = ComponentFactory.Instance.creatBitmap("asset.skyboxroad.LayerInfoBg");
         _rewardIcon = ComponentFactory.Instance.creatBitmap("asset.skyboxroad.ChapterRewardIcon");
         _rewardIcon.visible = false;
         _descTxt = ComponentFactory.Instance.creatComponentByStylename("skyboxroad.descTxt");
         _rankBtn = ComponentFactory.Instance.creatComponentByStylename("skyboxroad.rankBtn");
         _descTxt.text = LanguageMgr.GetTranslation("SkyBoxRoadFrame.descText");
         addChild(_bg);
         addChild(_layerInfoBg);
         addChild(_smallBg);
         addChild(_titleBg);
         addChild(_titleTxtImg);
         addChild(_activeValueBg);
         addChild(_activeValueImg);
         addChild(_activeValueImgMask);
         addChild(_activePressTxt);
         addChild(_buyActiveBtn);
         addChild(_upBtn);
         addChild(_downBtn);
         addChild(_rightView);
         addChild(_floorTxtImg);
         addChild(_flootTxt);
         addChild(_rewardBtn);
         addChild(_skyBoxRoadView);
         addChild(_rewardIcon);
         addChild(_descTxt);
         addChild(_rankBtn);
         _rankBtn.visible = VersionSwitch.SKYBOX_ROAD_POINT;
      }
      
      private function initBufferView() : void
      {
         var _loc1_:MagicSpringSlotInfo = MagicSpringManager.instance.model.checkIsExistBuffer(12);
         if(_loc1_)
         {
            _bufferView = new MagicSpringBufferAddView(_loc1_);
            _bufferView.setDescText(_loc1_.tempInfo.Desc);
            _bufferView.x = 310;
            _bufferView.y = 205;
            addChild(_bufferView);
         }
      }
      
      override public function enterOver() : void
      {
         super.enterOver();
         MainToolBar.instance.updateFriendNoticeBtnPos(false);
         MainToolBar.instance.show();
         ChatBar.instance.show();
         MainToolBar.instance.getButtnByType(10).visible = false;
         MainToolBar.instance.getButtnByType(15).visible = false;
         MainToolBar.instance.getButtnByType(16).visible = false;
         MainToolBar.instance.getButtnByType(9).enable = true;
         MainToolBar.instance.getMovieImageByType(1).visible = false;
         MainToolBar.instance.getMovieImageByType(2).visible = false;
         SceneManager.instance.isEnterFullScene = true;
         __resizeHanlder();
      }
      
      public function updateView() : void
      {
         _activeValueImgMask.scaleX = model.skyTrialInfo.energy / _maxEnergy > 1 ? 1 : model.skyTrialInfo.energy / _maxEnergy;
         _activePressTxt.text = model.skyTrialInfo.energy.toString();
         _flootTxt.text = model.currentLayer.toString();
         _floorTxtImg.x = _flootTxt.x + _flootTxt.textWidth + 6;
         updatePageBtn();
         _rewardBtn.tipData = "2|" + model.getCurrentLayerInfo().tempInfo.ClearReward;
         _rewardIcon.visible = false;
         if(model.getCurrentLayerInfo().isAllClear)
         {
            _rewardIcon.visible = true;
         }
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
               break;
            case 1:
               dispose();
         }
      }
      
      private function get model() : SkyboxRoadModel
      {
         return SkyboxRoadManager.instance.model;
      }
      
      override public function get SceneName() : String
      {
         return "SKYBOX_ROAD_SCENE";
      }
      
      override public function preLoadingStart(param1:Object = null) : void
      {
         super.preLoadingStart(param1);
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,6,true,false,1,0,true);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      private function onInfo(param1:Event) : void
      {
         if(_exploreView != null)
         {
            _exploreView.updateView();
         }
      }
      
      private function initEvent() : void
      {
         StageReferance.stage.addEventListener("resize",__resizeHanlder);
         addEventListener("response",__responseHandler);
         NotificationManager.instance.addEventListener("SKYBOX_ROAD_SHOW_EXPLOREVIEW",onShowExploreView);
         NotificationManager.instance.addEventListener("SKYBOX_ROAD_RETURN_CLICK",onExploreReturnClick);
         NotificationManager.instance.addEventListener("SKYBOX_ROAD_EXPLOREBTN_CLICK",onExploreBtnClick);
         if(_upBtn != null)
         {
            _upBtn.addEventListener("click",onPageUpClick);
         }
         if(_downBtn != null)
         {
            _downBtn.addEventListener("click",onPageDownClick);
         }
         NotificationManager.instance.addEventListener("SKYBOX_ROAD_INFO",onInfo);
         NotificationManager.instance.addEventListener("SKYBOX_ROAD_INFO_UPDATE",onInfoUpdate);
         NotificationManager.instance.addEventListener("SKYBOX_ROAD_EVENT",onEvent);
         _buyActiveBtn.addEventListener("click",onBuyActiveClick);
         _rankBtn.addEventListener("click",__onRankBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("resize",__resizeHanlder);
         removeEventListener("response",__responseHandler);
         NotificationManager.instance.removeEventListener("SKYBOX_ROAD_SHOW_EXPLOREVIEW",onShowExploreView);
         NotificationManager.instance.removeEventListener("SKYBOX_ROAD_RETURN_CLICK",onExploreReturnClick);
         NotificationManager.instance.removeEventListener("SKYBOX_ROAD_EXPLOREBTN_CLICK",onExploreBtnClick);
         if(_upBtn != null)
         {
            _upBtn.removeEventListener("click",onPageUpClick);
         }
         if(_downBtn != null)
         {
            _downBtn.removeEventListener("click",onPageDownClick);
         }
         NotificationManager.instance.removeEventListener("SKYBOX_ROAD_INFO",onInfo);
         NotificationManager.instance.removeEventListener("SKYBOX_ROAD_INFO_UPDATE",onInfoUpdate);
         NotificationManager.instance.removeEventListener("SKYBOX_ROAD_EVENT",onEvent);
         if(_buyActiveBtn != null)
         {
            _buyActiveBtn.removeEventListener("click",onBuyActiveClick);
         }
         if(_rankBtn)
         {
            _rankBtn.removeEventListener("click",__onRankBtnClickHandler);
         }
      }
      
      private function onExploreComplete() : void
      {
         if(_exploreCompleteMc == null)
         {
            _exploreCompleteMc = ComponentFactory.Instance.creatCustomObject("skyboxroad.exploreCompleteMc");
            addChild(_exploreCompleteMc);
         }
         _exploreCompleteMc.gotoAndPlay(1);
      }
      
      private function onBuyActiveClick(param1:MouseEvent) : void
      {
         var _loc4_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("skytrial_buy_energy");
         var _loc6_:Array = _loc4_.ConfigValue.split(",");
         var _loc5_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("skytrial_max_buy_energy");
         var _loc2_:int = int(_loc5_.ConfigValue) - model.skyTrialInfo.buyEnergyCount;
         if(_loc2_ <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("skyboxroad.SkyBoxRoadFrame.txt3"));
            return;
         }
         var _loc3_:String = LanguageMgr.GetTranslation("active.expback.frame.selectbtntxt");
         var _loc7_:String = LanguageMgr.GetTranslation("skyboxroad.SkyBoxRoadFrame.txt2",_loc6_[0],_loc6_[1],_loc2_);
         SharedManagerHelper.ins.needAlert("skyboxroad.SkyBoxRoadFrame.onBuyActiveClick",buyActiveCallBack,_loc3_,_loc7_,"");
      }
      
      private function buyActiveCallBack(param1:Boolean) : void
      {
         var _loc2_:int = 1;
         if(param1)
         {
            _loc2_ = 2;
         }
         SkyboxRoadManager.instance.buyEnergy(_loc2_);
      }
      
      private function onEvent(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc8_:SkillTempInfo = null;
         var _loc4_:Array = null;
         var _loc6_:GameHeroTempInfo = null;
         var _loc3_:int = int(model.currentEventId);
         if(_loc3_ == -1)
         {
            onExploreComplete();
            _loc2_ = LanguageMgr.GetTranslation("skyboxroad.fightBossDsc");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         _eventTemplateInfo = TempleteManager.instance.skytrialeventTemplateCate.getTemplateById(_loc3_);
         var _loc5_:Array = _eventTemplateInfo.Reward.split("|");
         var _loc7_:Array = String(_loc5_[0]).split(",");
         if(_loc7_[0] != 1 && _eventTemplateInfo.Monster == "")
         {
            if(_loc7_[0] != 4)
            {
               _loc8_ = TempleteManager.instance.getSkillTemplateInfoById(_loc7_[1]);
               _loc2_ = LanguageMgr.GetTranslation("tasktracetip.view.TreasureMapTipView.content",_loc8_.TemplateName);
            }
            else
            {
               _loc2_ = LanguageMgr.GetTranslation("skyboxroad.eventDsc1",_loc7_[2]);
            }
         }
         else if(_loc7_[0] != 1 && _eventTemplateInfo.Monster != "")
         {
            _loc4_ = _eventTemplateInfo.Monster.split(",");
            _loc6_ = TempleteManager.instance.gameHeroTemplateCate.getTemplateByID(_loc4_[0]);
            _loc2_ = LanguageMgr.GetTranslation("skyboxroad.MonsterEventDsc",_loc6_.TemplateName);
            MessageTipManager.instance().show(_loc2_);
         }
         if(_eventTemplateInfo.Monster != "")
         {
            return;
         }
         if(_eventTemplateInfo.BigBonus)
         {
            showBigBonus();
         }
         else
         {
            showGetReward();
         }
      }
      
      private function showGetReward() : void
      {
         var _loc4_:int = 0;
         var _loc3_:Array = null;
         var _loc2_:BaseIconView = null;
         var _loc5_:SkillTempInfo = null;
         var _loc1_:Array = _eventTemplateInfo.Reward.split("|");
         _loc4_ = 0;
         while(_loc4_ < _loc1_.length)
         {
            _loc3_ = String(_loc1_[_loc4_]).split(",");
            if(_loc3_[0] != 1)
            {
               if(_loc3_[0] == 2 || _loc3_[0] == 3)
               {
                  _iconType = "skill";
                  _loc2_ = ComponentFactory.Instance.creatCustomObject("core.BaseIcon",[iconComplete]);
                  _loc5_ = TempleteManager.instance.getSkillTemplateInfoById(_loc3_[1]);
                  _loc2_.icon = IconFactory.getTecIconByIcon(_loc5_.Icons);
               }
            }
            _loc4_++;
         }
      }
      
      private function showBigBonus() : void
      {
         if(_bigBonusMc == null)
         {
            _bigBonusMc = ComponentFactory.Instance.creatCustomObject("skyboxroad.bigbonusMc");
         }
         _bigBonusMc.gotoAndPlay(1);
         addChild(_bigBonusMc);
      }
      
      private function iconComplete(param1:BaseIconView = null) : void
      {
         var bagPoint:Point;
         var bagButton:MainToolButton;
         var icon:BaseIconView = param1;
         var startPoint:Point = this.localToGlobal(new Point(this.width / 2,this.height / 2));
         if(icon.x == 0)
         {
            icon.x = startPoint.x + 10;
            icon.y = startPoint.y - 10;
         }
         icon.mouseChildren = icon.mouseEnabled = false;
         if(_iconType == "goods")
         {
            bagButton = MainToolBar.instance.getButtnByType(2);
            bagPoint = bagButton.parent.localToGlobal(new Point(bagButton.x,bagButton.y));
         }
         else if(_iconType == "skill")
         {
            bagPoint = this.localToGlobal(new Point(1460,475));
         }
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
      
      private function onInfoUpdate(param1:Event) : void
      {
         updateView();
      }
      
      private function onShowExploreView(param1:Event) : void
      {
         if(_exploreView == null)
         {
            _exploreView = ComponentFactory.Instance.creatCustomObject("skyboxroad.SkyboxRoadExploreView");
         }
         _exploreView.updateView();
         addChild(_exploreView);
      }
      
      private function onPageUpClick(param1:MouseEvent) : void
      {
         model.lastLayer -= 1;
         model.isPageChange = true;
         _skyBoxRoadView.updateView();
         updateView();
      }
      
      private function onPageDownClick(param1:MouseEvent) : void
      {
         model.lastLayer += 1;
         model.isPageChange = true;
         _skyBoxRoadView.updateView();
         updateView();
      }
      
      private function onExploreBtnClick(param1:Event) : void
      {
         _upBtn.enable = _downBtn.enable = false;
      }
      
      private function onExploreReturnClick(param1:Event) : void
      {
         if(_exploreView != null && _exploreView.parent != null)
         {
            _exploreView.parent.removeChild(_exploreView);
         }
         if(_skyBoxRoadView)
         {
            _skyBoxRoadView.showInitView();
         }
         updatePageBtn();
      }
      
      private function updatePageBtn() : void
      {
         _upBtn.enable = _downBtn.enable = true;
         var _loc1_:SkytriallayerTemplateInfo = TempleteManager.instance.skytriallayerTemplateCate.getTemplateByLayerNum(model.currentLayer + 1);
         if(model.currentLayer == 1)
         {
            _upBtn.enable = false;
         }
         if(!model.getCurrentLayerInfo().isAllClear || !_loc1_)
         {
            _downBtn.enable = false;
         }
      }
      
      private function __onRankBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:SkyBoxRoadRankFrame = ComponentFactory.Instance.creatComponentByStylename("skyboxroad.SkyBoxRoadRankFrame");
         _loc2_.show();
      }
      
      private function __resizeHanlder(param1:Event = null) : void
      {
         x = (StageReferance.gameStageWidth - width) / 2;
         y = (StageReferance.gameStageHeight - height) / 2;
      }
      
      private function closeFrame(param1:Event) : void
      {
         dispose();
      }
      
      override public function leaving() : void
      {
         dispose();
      }
      
      public function dispose() : void
      {
         _eventTemplateInfo = null;
         model.leaveScene();
         ChatBar.instance.hide();
         FrameControllerManager.instance.skyBoxRoadControler.isInSkyBoxRoadFrame = false;
         SceneManager.instance.isEnterFullScene = false;
         MainToolBar.instance.buttonsStageByScene(SceneManager.instance.currentType);
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_titleBg);
         _titleBg = null;
         ObjectUtils.disposeObject(_upBtn);
         _upBtn = null;
         ObjectUtils.disposeObject(_downBtn);
         _downBtn = null;
         ObjectUtils.disposeObject(_flootTxt);
         _flootTxt = null;
         ObjectUtils.disposeObject(_titleTxtImg);
         _titleTxtImg = null;
         ObjectUtils.disposeObject(_activeValueBg);
         _activeValueBg = null;
         ObjectUtils.disposeObject(_activeValueImg);
         _activeValueImg = null;
         ObjectUtils.disposeObject(_buyActiveBtn);
         _buyActiveBtn = null;
         ObjectUtils.disposeObject(_activePressTxt);
         _activePressTxt = null;
         ObjectUtils.disposeObject(_activeValueImgMask);
         _activeValueImgMask = null;
         ObjectUtils.disposeObject(_rightView);
         _rightView = null;
         ObjectUtils.disposeObject(_floorTxtImg);
         _floorTxtImg = null;
         ObjectUtils.disposeObject(_rewardBtn);
         _rewardBtn = null;
         ObjectUtils.disposeObject(_smallBg);
         _smallBg = null;
         ObjectUtils.disposeObject(_skyBoxRoadView);
         _skyBoxRoadView = null;
         ObjectUtils.disposeObject(_exploreView);
         _exploreView = null;
         ObjectUtils.disposeViolentMc(_bigBonusMc);
         _bigBonusMc = null;
         ObjectUtils.disposeViolentMc(_exploreCompleteMc);
         _exploreCompleteMc = null;
         ObjectUtils.disposeObject(_layerInfoBg);
         _layerInfoBg = null;
         ObjectUtils.disposeObject(_rewardIcon);
         _rewardIcon = null;
         ObjectUtils.disposeObject(_rankBtn);
         _rankBtn = null;
         ObjectUtils.disposeObject(_descTxt);
         _descTxt = null;
         ObjectUtils.disposeObject(_bufferView);
         _bufferView = null;
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

