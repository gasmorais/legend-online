package skyboxroad.view
{
   import com.greensock.TweenMax;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import managers.SkyboxRoadManager;
   import mvc.module.skyboxroad.SkyTrialPortalInfo;
   import mvc.module.skyboxroad.SkyboxRoadModel;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   
   public class SkyBoxRoadCheckPointView extends Component
   {
      
      private var _bgMc:MovieClip;
      
      private var _portalMc:MovieClip;
      
      private var _pressImg:Bitmap;
      
      private var _pressMark:Shape;
      
      private var _pressTxt:FilterFrameText;
      
      private var _btnBg:Bitmap;
      
      private var _findBtn:BaseButton;
      
      private var _dekaronbtn:BaseButton;
      
      private var _init_x:Number;
      
      private var _init_y:Number;
      
      private var _skyTrialPortalInfo:SkyTrialPortalInfo;
      
      private var _shapeMark:Shape;
      
      private var _guardArr:Array;
      
      private var _guardTipArr:Array;
      
      private var _rewardBtn:BaseButton;
      
      private var _cleanImg:Bitmap;
      
      private var _playerBgMc:Boolean = true;
      
      private var _portalMcURL:String = "";
      
      public function SkyBoxRoadCheckPointView()
      {
         super();
         _guardTipArr = [];
         _guardArr = [];
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bgMc = ComponentFactory.Instance.creatCustomObject("skyboxroad.checkpointBgMc");
         _bgMc.gotoAndStop(1);
         _bgMc.mouseChildren = false;
         _pressImg = ComponentFactory.Instance.creatBitmap("asset.skyboxroad.checkpointPressImg");
         _pressMark = new Shape();
         _pressMark.graphics.beginFill(0);
         _pressMark.graphics.drawRect(0,0,_pressImg.width,_pressImg.height);
         _pressMark.x = _pressImg.x;
         _pressMark.y = _pressImg.y;
         _pressImg.mask = _pressMark;
         _pressTxt = ComponentFactory.Instance.creatComponentByStylename("skyboxroad.checkpoint.pressTxt");
         _btnBg = ComponentFactory.Instance.creatBitmap("asset.skyboxroad.checkpointBtnBg");
         _findBtn = ComponentFactory.Instance.creatComponentByStylename("skyboxroad.checkpoint.findBtn");
         _dekaronbtn = ComponentFactory.Instance.creatComponentByStylename("skyboxroad.checkpoint.dekaronbtn");
         _btnBg.visible = _findBtn.visible = _dekaronbtn.visible = false;
         _shapeMark = new Shape();
         _shapeMark.x = _shapeMark.y = 10;
         _shapeMark.graphics.beginFill(0);
         _shapeMark.graphics.drawRect(0,0,140,145);
         _shapeMark.graphics.endFill();
         _rewardBtn = ComponentFactory.Instance.creatComponentByStylename("skyboxroad.SkyBoxRoadCheckPointView.rewardBtn");
         _cleanImg = ComponentFactory.Instance.creatBitmap("asset.skyboxroad.checkpointCleanImg");
         addChild(_bgMc);
         addChild(_pressImg);
         addChild(_pressMark);
         addChild(_pressTxt);
         addChild(_btnBg);
         addChild(_findBtn);
         addChild(_dekaronbtn);
         addChild(_shapeMark);
         addChild(_rewardBtn);
         addChild(_cleanImg);
         _findBtn.tipData = LanguageMgr.GetTranslation("SkyBoxRoadCheckPointView.findBtnDesc");
      }
      
      public function saveInitData(param1:SkyTrialPortalInfo) : void
      {
         _init_x = this.x;
         _init_y = this.y;
         _skyTrialPortalInfo = param1;
         _rewardBtn.tipData = "1|" + _skyTrialPortalInfo.tempInfo.ClearReward;
         updateView();
      }
      
      private function initEvent() : void
      {
         this.addEventListener("mouseOver",onMouseOver);
         this.addEventListener("mouseOut",onMouseOut);
         _findBtn.addEventListener("click",onFindBtnClick);
         this.addEventListener("addedToStage",onAddToStage);
         NotificationManager.instance.addEventListener("SKYBOX_ROAD_INFO_UPDATE",onInfoUpdate);
         _dekaronbtn.addEventListener("click",onDekaronClick);
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("mouseOver",onMouseOver);
         this.removeEventListener("mouseOut",onMouseOut);
         _findBtn.removeEventListener("click",onFindBtnClick);
         this.removeEventListener("addedToStage",onAddToStage);
         NotificationManager.instance.removeEventListener("SKYBOX_ROAD_INFO_UPDATE",onInfoUpdate);
         _dekaronbtn.removeEventListener("click",onDekaronClick);
      }
      
      private function onDekaronClick(param1:MouseEvent) : void
      {
         SkyboxRoadManager.instance.dekaronBoss(_skyTrialPortalInfo.portalTempId);
      }
      
      private function onAddToStage(param1:Event) : void
      {
         if(model.currentPortalId == _skyTrialPortalInfo.portalTempId)
         {
            onFindBtnClick();
            _playerBgMc = false;
         }
      }
      
      private function onInfoUpdate(param1:Event) : void
      {
         updateView();
      }
      
      private function onFindBtnClick(param1:MouseEvent = null) : void
      {
         if(this.parent)
         {
            this.parent["showChooseCheckPoint"](this);
            model.currentPortalId = _skyTrialPortalInfo.portalTempId;
            model.lastLayer = _skyTrialPortalInfo.tempInfo.LayerNum;
         }
         NotificationManager.instance.dispatchEvent(new Event("SKYBOX_ROAD_EXPLOREBTN_CLICK"));
      }
      
      private function get model() : SkyboxRoadModel
      {
         return SkyboxRoadManager.instance.model;
      }
      
      public function showFindBg() : void
      {
         var _loc1_:int = 0;
         if(_bgMc)
         {
            _bgMc.addEventListener("PLAY_OVER",onBgMcPlayeOver);
            if(_playerBgMc)
            {
               _bgMc.gotoAndPlay(1);
            }
            else
            {
               _bgMc.gotoAndPlay(_bgMc.totalFrames - 10);
               _playerBgMc = true;
            }
         }
         if(_portalMc != null)
         {
            _portalMc.visible = false;
         }
         _pressImg.visible = _pressMark.visible = _pressTxt.visible = _cleanImg.visible = false;
         this.mouseChildren = this.mouseEnabled = false;
         _loc1_ = 0;
         while(_loc1_ < _guardTipArr.length)
         {
            _guardTipArr[_loc1_].visible = false;
            _loc1_++;
         }
         _rewardBtn.visible = false;
         SkyboxRoadManager.instance.explore(3,_skyTrialPortalInfo.portalTempId);
      }
      
      public function showInitView() : void
      {
         var _loc1_:int = 0;
         this.visible = true;
         _bgMc.gotoAndStop(1);
         if(_portalMc != null)
         {
            _portalMc.visible = true;
         }
         _pressImg.visible = _pressMark.visible = _pressTxt.visible = true;
         this.mouseChildren = this.mouseEnabled = true;
         TweenMax.to(this,0.2,{
            "x":_init_x,
            "y":_init_y
         });
         _loc1_ = 0;
         while(_loc1_ < _guardTipArr.length)
         {
            _guardTipArr[_loc1_].visible = true;
            _loc1_++;
         }
         _rewardBtn.visible = true;
         if(_skyTrialPortalInfo.clear)
         {
            _cleanImg.visible = true;
         }
      }
      
      private function onBgMcPlayeOver(param1:Event) : void
      {
         if(_bgMc)
         {
            _bgMc.removeEventListener("PLAY_OVER",onBgMcPlayeOver);
         }
         NotificationManager.instance.dispatchEvent(new Event("SKYBOX_ROAD_SHOW_EXPLOREVIEW"));
      }
      
      private function onMouseOver(param1:MouseEvent) : void
      {
         _btnBg.visible = _findBtn.visible = _dekaronbtn.visible = true;
         if(_portalMc != null)
         {
            _portalMc.gotoAndPlay(1);
         }
         if(this.parent != null)
         {
            this.parent.setChildIndex(this,this.parent.numChildren - 1);
         }
      }
      
      private function onMouseOut(param1:MouseEvent) : void
      {
         _btnBg.visible = _findBtn.visible = _dekaronbtn.visible = false;
         if(_portalMc != null)
         {
            _portalMc.gotoAndStop(1);
         }
      }
      
      private function updateView() : void
      {
         var _loc4_:int = 0;
         var _loc6_:String = null;
         var _loc7_:ScaleFrameImage = null;
         var _loc2_:StripView = null;
         _pressMark.scaleX = _skyTrialPortalInfo.explorePercen;
         _pressTxt.text = int(_skyTrialPortalInfo.explorePercen * 100) + "%";
         var _loc3_:Boolean = true;
         if(_portalMc != null && _portalMcURL == PathManager.getSkyTrialPortal(_skyTrialPortalInfo.tempInfo.ResourcePath))
         {
            _loc3_ = false;
         }
         if(_loc3_)
         {
            ObjectUtils.disposeViolentMc(_portalMc);
            _portalMc = null;
            _loc6_ = PathManager.getSkyTrialPortal(_skyTrialPortalInfo.tempInfo.ResourcePath);
            LoaderManagerII.instance.load(_loc6_,2,8,__onLoaderComplete);
            _portalMcURL = _loc6_;
         }
         _dekaronbtn.enable = false;
         if(_skyTrialPortalInfo.explorePercen >= 1)
         {
            _dekaronbtn.enable = true;
         }
         _loc4_ = 0;
         while(_loc4_ < _guardTipArr.length)
         {
            _guardTipArr[_loc4_].visible = false;
            _loc4_++;
         }
         var _loc1_:Array = LanguageMgr.GetTranslation("singlepass.view.SinglePassCardItemView.PetTypeList").split("|");
         var _loc5_:Array = _skyTrialPortalInfo.tempInfo.NatureType.split(",");
         _loc4_ = 0;
         while(_loc4_ < _loc5_.length)
         {
            _loc7_ = _guardArr[_loc4_];
            _loc2_ = _guardTipArr[_loc4_];
            if(_loc2_ == null)
            {
               _loc2_ = ComponentFactory.Instance.creatCustomObject("skyboxroad.GuardTip" + _loc4_);
               addChild(_loc2_);
               _guardTipArr.push(_loc2_);
            }
            _loc2_.tipData = [_loc1_[_loc5_[_loc4_] - 1]];
            _loc2_.visible = true;
            if(_loc7_ == null)
            {
               _loc7_ = ComponentFactory.Instance.creatComponentByStylename("skyboxroad.Guard");
               _guardTipArr[_loc4_].addChild(_loc7_);
               _guardArr.push(_loc7_);
            }
            _loc7_.setFrame(_loc5_[_loc4_]);
            _loc4_++;
         }
         _cleanImg.visible = false;
         if(_skyTrialPortalInfo.clear)
         {
            _cleanImg.visible = true;
         }
      }
      
      private function __onLoaderComplete(param1:LoaderInfo, param2:Object) : void
      {
         ObjectUtils.disposeViolentMc(_portalMc);
         _portalMc = null;
         _portalMc = (param2 as MovieClip).getChildAt(0) as MovieClip;
         _portalMc.mouseChildren = _portalMc.mouseEnabled = false;
         _portalMc.gotoAndStop(1);
         try
         {
            addChildAt(_portalMc,1);
         }
         catch(e:Error)
         {
         }
         _portalMc.mask = _shapeMark;
         _portalMc.visible = this.mouseChildren;
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         removeEvent();
         _skyTrialPortalInfo = null;
         ObjectUtils.disposeViolentMc(_bgMc);
         _bgMc = null;
         ObjectUtils.disposeViolentMc(_portalMc);
         _portalMc = null;
         ObjectUtils.disposeObject(_pressImg);
         _pressImg = null;
         ObjectUtils.disposeObject(_pressMark);
         _pressMark = null;
         ObjectUtils.disposeObject(_pressTxt);
         _pressTxt = null;
         ObjectUtils.disposeObject(_shapeMark);
         _shapeMark = null;
         ObjectUtils.disposeObject(_btnBg);
         _btnBg = null;
         ObjectUtils.disposeObject(_findBtn);
         _findBtn = null;
         ObjectUtils.disposeObject(_dekaronbtn);
         _dekaronbtn = null;
         ObjectUtils.disposeObject(_rewardBtn);
         _rewardBtn = null;
         ObjectUtils.disposeObject(_cleanImg);
         _cleanImg = null;
         _loc1_ = 0;
         while(_loc1_ < _guardArr.length)
         {
            ObjectUtils.disposeObject(_guardArr[_loc1_]);
            _loc1_++;
         }
         _guardArr = [];
         _loc1_ = 0;
         while(_loc1_ < _guardTipArr.length)
         {
            ObjectUtils.disposeObject(_guardTipArr[_loc1_]);
            _loc1_++;
         }
         _guardTipArr = [];
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

