package skyboxroad.view
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import managers.SkyboxRoadManager;
   import mvc.module.skyboxroad.SkyTrialPortalInfo;
   import mvc.module.skyboxroad.SkyboxRoadModel;
   import mvc.module.skyboxroad.SkyboxRoadRewardInfo;
   import skyboxroad.staypoint.SkyBoxRoadStayPointFrame;
   import yishi.datas.VersionSwitch;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   import yishi.manager.SharedManagerHelper;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class SkyboxRoadExploreView extends Component
   {
      
      private var _titleTxt:FilterFrameText;
      
      private var _bigImg:Bitmap;
      
      private var _pressBg:Bitmap;
      
      private var _pressImg:Bitmap;
      
      private var _pressMask:Shape;
      
      private var _pressTxt:FilterFrameText;
      
      private var _dekaronBtn:BaseButton;
      
      private var _exploreBtn:BaseButton;
      
      private var _exploreAllBtn:BaseButton;
      
      private var _returnBtn:BaseButton;
      
      private var _sceneMc:MovieClip;
      
      private var _skyTrialPortalInfo:SkyTrialPortalInfo;
      
      private var _rewardIconArray:Array;
      
      private var _rewardBg:Bitmap;
      
      private var _pressStripView:StripView;
      
      private var _rewardImg:Bitmap;
      
      private var _stagnationBtn:BaseButton;
      
      private var _currentURL:String;
      
      private var _sceneMcURL:String = "";
      
      private var _timeOutFlag:uint;
      
      public function SkyboxRoadExploreView()
      {
         super();
         _rewardIconArray = [];
         _skyTrialPortalInfo = model.skyTrialInfo.getPortalByLayerAndTempId(model.lastLayer,model.currentPortalId);
         initView();
         initEvent();
         updateView();
         onGetRewardUpdate();
      }
      
      private function initView() : void
      {
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("skyboxroad.exploreView.titleTxt");
         _bigImg = ComponentFactory.Instance.creatBitmap("asset.skyboxroad.explorePressOutImg");
         _pressBg = ComponentFactory.Instance.creatBitmap("asset.skyboxroad.explorePressBgImg");
         _pressImg = ComponentFactory.Instance.creatBitmap("asset.skyboxroad.explorePressImg");
         _pressMask = new Shape();
         _pressMask.graphics.beginFill(0);
         _pressMask.graphics.drawRect(0,0,_pressImg.width,_pressImg.height);
         _pressMask.graphics.endFill();
         _pressMask.x = _pressImg.x;
         _pressMask.y = _pressImg.y;
         _pressImg.mask = _pressMask;
         _dekaronBtn = ComponentFactory.Instance.creatComponentByStylename("skyboxroad.exploreView.dekaronbtn");
         _exploreBtn = ComponentFactory.Instance.creatComponentByStylename("skyboxroad.exploreView.findBtn");
         _returnBtn = ComponentFactory.Instance.creatComponentByStylename("skyboxroad.exploreView.returnbtn");
         _pressTxt = ComponentFactory.Instance.creatComponentByStylename("skyboxroad.exploreView.pressTxt");
         _pressStripView = ComponentFactory.Instance.creatCustomObject("skyboxroad.SkyboxRoadExploreView.pressTip");
         _pressStripView.tipData = [LanguageMgr.GetTranslation("skyboxroad.view.SkyboxRoadExploreView.pressStripView")];
         _rewardImg = ComponentFactory.Instance.creatBitmap("asset.skyboxroad.exploreRewardTxtImg");
         _stagnationBtn = ComponentFactory.Instance.creatComponentByStylename("skysecretarea.exploreStagnationBtn");
         _exploreAllBtn = ComponentFactory.Instance.creatComponentByStylename("skyboxroad.exploreView.findAllBtn");
         addChild(_bigImg);
         addChild(_titleTxt);
         addChild(_dekaronBtn);
         addChild(_exploreBtn);
         addChild(_exploreAllBtn);
         addChild(_returnBtn);
         addChild(_stagnationBtn);
         addChild(_pressStripView);
         _pressStripView.addChild(_pressBg);
         _pressStripView.addChild(_pressImg);
         _pressStripView.addChild(_pressMask);
         _pressStripView.addChild(_pressTxt);
         addChild(_rewardImg);
         _stagnationBtn.visible = VersionSwitch.SKYBOX_ROAD_POINT;
         _stagnationBtn.tipData = LanguageMgr.GetTranslation("skysecretareaView.exploreViewTips02");
      }
      
      private function initEvent() : void
      {
         _returnBtn.addEventListener("click",onReturnClick);
         _exploreBtn.addEventListener("click",onExploreClick);
         _exploreAllBtn.addEventListener("click",onExploreAllClick);
         _stagnationBtn.addEventListener("click",__stagnatOnClick);
         NotificationManager.instance.addEventListener("SKYBOX_ROAD_INFO_UPDATE",onInfoUpdate);
         NotificationManager.instance.addEventListener("SKYBOX_ROAD_CURRENT_REWARD",onGetRewardUpdate);
         _dekaronBtn.addEventListener("click",onDekaronClick);
         this.addEventListener("addedToStage",onAddToStage);
      }
      
      private function removeEvent() : void
      {
         _returnBtn.removeEventListener("click",onReturnClick);
         _exploreBtn.removeEventListener("click",onExploreClick);
         _exploreAllBtn.removeEventListener("click",onExploreAllClick);
         if(_stagnationBtn)
         {
            _stagnationBtn.removeEventListener("click",__stagnatOnClick);
         }
         NotificationManager.instance.removeEventListener("SKYBOX_ROAD_INFO_UPDATE",onInfoUpdate);
         NotificationManager.instance.removeEventListener("SKYBOX_ROAD_CURRENT_REWARD",onGetRewardUpdate);
         this.removeEventListener("enterFrame",onEnterFrame);
         _dekaronBtn.removeEventListener("click",onDekaronClick);
         this.removeEventListener("addedToStage",onAddToStage);
      }
      
      public function updateView() : void
      {
         if(_skyTrialPortalInfo == null)
         {
            return;
         }
         if(_skyTrialPortalInfo.tempInfo == null)
         {
            return;
         }
         if(model.currentPortalId != 0 && _skyTrialPortalInfo.portalTempId != model.currentPortalId)
         {
            _skyTrialPortalInfo = model.skyTrialInfo.getPortalByLayerAndTempId(model.lastLayer,model.currentPortalId);
         }
         if(_skyTrialPortalInfo == null)
         {
            return;
         }
         if(_titleTxt != null)
         {
            _titleTxt.text = _skyTrialPortalInfo.tempInfo.PortalName;
         }
         if(_pressTxt != null)
         {
            _pressTxt.text = int(_skyTrialPortalInfo.explorePercen * 100) + "%";
         }
         if(_pressMask != null)
         {
            _pressMask.scaleX = _skyTrialPortalInfo.explorePercen;
         }
         if(_dekaronBtn != null)
         {
            _dekaronBtn.visible = false;
            if(_skyTrialPortalInfo.explorePercen >= 1)
            {
               _dekaronBtn.visible = true;
            }
            _dekaronBtn.enable = false;
            if(_timeOutFlag == 0)
            {
               _dekaronBtn.enable = true;
            }
         }
         var _loc1_:int = _skyTrialPortalInfo.tempInfo.TotalSearchCount - _skyTrialPortalInfo.searchCount;
         _exploreAllBtn.enable = _loc1_ > 0;
         _stagnationBtn.visible = _skyTrialPortalInfo.explorePercen >= 1 && Boolean(VersionSwitch.SKYBOX_ROAD_POINT);
      }
      
      private function loaderSceneMc() : void
      {
         var _loc2_:String = null;
         var _loc1_:Boolean = true;
         if(_sceneMcURL == PathManager.getSkyTrialPortalScene(_skyTrialPortalInfo.tempInfo.ScenePath))
         {
            _loc1_ = false;
         }
         if(_loc1_)
         {
            ObjectUtils.disposeViolentMc(_sceneMc);
            _sceneMc = null;
            _loc2_ = PathManager.getSkyTrialPortalScene(_skyTrialPortalInfo.tempInfo.ScenePath);
            LoaderManagerII.instance.load(_loc2_,2,8,__onLoaderComplete);
            _sceneMcURL = _loc2_;
         }
      }
      
      private function __onLoaderComplete(param1:LoaderInfo, param2:Object) : void
      {
         _sceneMc = param2 as MovieClip;
         _sceneMc.x = -10;
         _sceneMc.mouseChildren = _sceneMc.mouseEnabled = false;
         MovieClip(_sceneMc.getChildAt(0)).gotoAndStop(1);
         addChildAt(_sceneMc,0);
      }
      
      private function onInfoUpdate(param1:Event) : void
      {
         updateView();
      }
      
      private function onAddToStage(param1:Event) : void
      {
         loaderSceneMc();
      }
      
      private function get model() : SkyboxRoadModel
      {
         return SkyboxRoadManager.instance.model;
      }
      
      private function onDekaronClick(param1:MouseEvent) : void
      {
         SkyboxRoadManager.instance.dekaronBoss(_skyTrialPortalInfo.portalTempId);
      }
      
      private function __stagnatOnClick(param1:MouseEvent) : void
      {
         if(!_skyTrialPortalInfo.clear)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("skysecretareaView.stagnatViewTips06"));
            return;
         }
         if(ArmyManager.instance.thane.vocationGrades <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("runeitemView.tip02"));
            return;
         }
         var _loc2_:SkyBoxRoadStayPointFrame = ComponentFactory.Instance.creatComponentByStylename("skyboxroad.SkyBoxRoadStayPointFrame");
         _loc2_.show();
      }
      
      private function onReturnClick(param1:MouseEvent) : void
      {
         model.currentPortalId = 0;
         SkyboxRoadManager.instance.exitPortal();
         NotificationManager.instance.dispatchEvent(new Event("SKYBOX_ROAD_RETURN_CLICK"));
      }
      
      private function onExploreClick(param1:MouseEvent) : void
      {
         if(model.skyTrialInfo.energy >= _skyTrialPortalInfo.tempInfo.EnergyCost)
         {
            MovieClip(_sceneMc.getChildAt(0)).gotoAndPlay(1);
            this.addEventListener("enterFrame",onEnterFrame);
            _exploreAllBtn.enable = _dekaronBtn.enable = _exploreBtn.enable = _returnBtn.enable = false;
         }
         else
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("skyboxroad.view.SkyboxRoadExploreView.onExploreClick"));
         }
      }
      
      private function onExploreAllClick(param1:MouseEvent) : void
      {
         var _loc4_:ConfigInfosTempInfo = null;
         var _loc7_:Array = null;
         var _loc6_:ConfigInfosTempInfo = null;
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc8_:String = null;
         var _loc5_:int = _skyTrialPortalInfo.tempInfo.TotalSearchCount - _skyTrialPortalInfo.searchCount;
         _loc5_ = int(_loc5_ < 10 ? _loc5_ : 10);
         if(model.skyTrialInfo.energy >= _skyTrialPortalInfo.tempInfo.EnergyCost * _loc5_)
         {
            MovieClip(_sceneMc.getChildAt(0)).gotoAndPlay(1);
            this.addEventListener("enterFrame",onEnterFrame1);
            _exploreAllBtn.enable = _dekaronBtn.enable = _exploreBtn.enable = _returnBtn.enable = false;
         }
         else
         {
            _loc4_ = TempleteManager.instance.getConfigInfoByConfigName("skytrial_buy_energy");
            _loc7_ = _loc4_.ConfigValue.split(",");
            _loc6_ = TempleteManager.instance.getConfigInfoByConfigName("skytrial_max_buy_energy");
            _loc2_ = int(_loc6_.ConfigValue) - model.skyTrialInfo.buyEnergyCount;
            if(_loc2_ <= 0)
            {
               if(model.skyTrialInfo.energy >= 20)
               {
                  MovieClip(_sceneMc.getChildAt(0)).gotoAndPlay(1);
                  this.addEventListener("enterFrame",onEnterFrame1);
                  _exploreAllBtn.enable = _dekaronBtn.enable = _exploreBtn.enable = _returnBtn.enable = false;
               }
               else
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("skyboxroad.SkyBoxRoadFrame.txt3"));
               }
               return;
            }
            _loc3_ = LanguageMgr.GetTranslation("active.expback.frame.selectbtntxt");
            _loc8_ = LanguageMgr.GetTranslation("skyboxroad.SkyBoxRoadFrame.txt2",_loc7_[0],_loc7_[1],_loc2_);
            SharedManagerHelper.ins.needAlert("skyboxroad.SkyBoxRoadFrame.onBuyActiveClick",buyActiveCallBack,_loc3_,_loc8_,"");
         }
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
      
      private function onEnterFrame(param1:Event) : void
      {
         if(_sceneMc == null)
         {
            this.removeEventListener("enterFrame",onEnterFrame);
            return;
         }
         if(MovieClip(_sceneMc.getChildAt(0)).currentFrame == MovieClip(_sceneMc.getChildAt(0)).totalFrames)
         {
            this.removeEventListener("enterFrame",onEnterFrame);
            MovieClip(_sceneMc.getChildAt(0)).gotoAndStop(1);
            SkyboxRoadManager.instance.explore(2,_skyTrialPortalInfo.portalTempId,1);
            _timeOutFlag = setTimeout(settimeoutFun,1000);
         }
         _dekaronBtn.enable = false;
      }
      
      private function onEnterFrame1(param1:Event) : void
      {
         var _loc2_:int = _skyTrialPortalInfo.tempInfo.TotalSearchCount - _skyTrialPortalInfo.searchCount;
         _loc2_ = int(_loc2_ < 10 ? _loc2_ : 10);
         if(model.skyTrialInfo.energy < _skyTrialPortalInfo.tempInfo.EnergyCost * _loc2_)
         {
            _loc2_ = Math.floor(model.skyTrialInfo.energy / 20);
         }
         if(_sceneMc == null)
         {
            this.removeEventListener("enterFrame",onEnterFrame1);
            return;
         }
         if(MovieClip(_sceneMc.getChildAt(0)).currentFrame == MovieClip(_sceneMc.getChildAt(0)).totalFrames)
         {
            this.removeEventListener("enterFrame",onEnterFrame1);
            MovieClip(_sceneMc.getChildAt(0)).gotoAndStop(1);
            SkyboxRoadManager.instance.explore(2,_skyTrialPortalInfo.portalTempId,_loc2_);
            _timeOutFlag = setTimeout(settimeoutFun,1000);
         }
         _dekaronBtn.enable = false;
      }
      
      private function settimeoutFun() : void
      {
         var _loc1_:int = _skyTrialPortalInfo.tempInfo.TotalSearchCount - _skyTrialPortalInfo.searchCount;
         _exploreAllBtn.enable = _loc1_ > 0;
         _exploreBtn.enable = _returnBtn.enable = true;
         if(_skyTrialPortalInfo.explorePercen >= 1)
         {
            _dekaronBtn.enable = _dekaronBtn.visible = true;
         }
         _timeOutFlag = 0;
      }
      
      private function onGetRewardUpdate(param1:Event = null) : void
      {
         var _loc5_:int = 0;
         var _loc8_:SkyboxRoadRewardInfo = null;
         var _loc3_:BaseItemView = null;
         var _loc7_:GoodsInfo = null;
         var _loc4_:BaseIconView = null;
         var _loc6_:SkillTempInfo = null;
         _loc5_ = 0;
         while(_loc5_ < _rewardIconArray.length)
         {
            ObjectUtils.disposeObject(_rewardIconArray[_loc5_]);
            _loc5_++;
         }
         _rewardIconArray = [];
         var _loc2_:Array = model.portalRewardArray;
         _loc5_ = 0;
         while(_loc5_ < _loc2_.length)
         {
            switch(int((_loc8_ = _loc2_[_loc5_]).type) - 1)
            {
               case 0:
                  _loc3_ = createGoodsItem(_loc8_);
                  _loc7_ = new GoodsInfo();
                  _loc7_.templateId = _loc8_.tempId;
                  _loc7_.count = _loc8_.count;
                  _loc3_.data = _loc7_;
                  _rewardIconArray.push(_loc3_);
                  addChild(_loc3_);
                  break;
               case 2:
                  _loc4_ = ComponentFactory.Instance.creatCustomObject("skyboxroad.SkillItemIcon");
                  _loc6_ = TempleteManager.instance.getSkillTemplateInfoById(_loc8_.tempId);
                  _loc4_.icon = IconFactory.getTecIconByIcon(_loc6_.Icons);
                  _loc4_.tipData = _loc6_;
                  _rewardIconArray.push(_loc4_);
                  addChild(_loc4_);
            }
            _rewardIconArray[_loc5_].x = 12 + _loc5_ * 61;
            _rewardIconArray[_loc5_].y = 394;
            _loc5_++;
         }
      }
      
      private function createGoodsItem(param1:SkyboxRoadRewardInfo) : BaseItemView
      {
         var _loc2_:BaseItemView = ComponentFactory.Instance.creatCustomObject("skyboxroad.exploreRewardView");
         var _loc3_:GoodsInfo = new GoodsInfo();
         _loc3_.templateId = param1.tempId;
         _loc2_.data = _loc3_;
         return _loc2_;
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         _skyTrialPortalInfo = null;
         removeEvent();
         clearTimeout(_timeOutFlag);
         ObjectUtils.disposeObject(_titleTxt);
         _titleTxt = null;
         ObjectUtils.disposeObject(_pressBg);
         _pressBg = null;
         ObjectUtils.disposeObject(_pressImg);
         _pressImg = null;
         ObjectUtils.disposeObject(_pressMask);
         _pressMask = null;
         ObjectUtils.disposeObject(_dekaronBtn);
         _dekaronBtn = null;
         ObjectUtils.disposeObject(_exploreBtn);
         _exploreBtn = null;
         ObjectUtils.disposeObject(_returnBtn);
         _returnBtn = null;
         ObjectUtils.disposeObject(_pressTxt);
         _pressTxt = null;
         ObjectUtils.disposeViolentMc(_sceneMc);
         _sceneMc = null;
         ObjectUtils.disposeObject(_bigImg);
         _bigImg = null;
         ObjectUtils.disposeObject(_rewardBg);
         _rewardBg = null;
         ObjectUtils.disposeObject(_pressStripView);
         _pressStripView = null;
         _loc1_ = 0;
         while(_loc1_ < _rewardIconArray.length)
         {
            ObjectUtils.disposeObject(_rewardIconArray[_loc1_]);
            _rewardIconArray[_loc1_] = null;
            _loc1_++;
         }
         _rewardIconArray = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

