package castle.view
{
   import castle.loader.CastleBuildingLoader;
   import castle.view.layer.CastleNameLayer;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.BuildingEvent;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.*;
   import manager.LanguageMgr;
   import managers.MopupManager;
   import mvc.controler.BuildingControler;
   import yishi.SwitchPageHelp;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.BuildingTempInfo;
   import yishi.interfaces.IBuildingFilter;
   import yishi.interfaces.ICheck;
   import yishi.manager.ArmyManager;
   import yishi.manager.BuildingManager;
   import yishi.manager.FrameControllerManager;
   import yishi.utils.ColorManager;
   import yishi.utils.StringHelper;
   import yishi.view.tips.MessageTipManager;
   import yishi.view.tips.WaterTreeTipInfo;
   import yishi.view.tools.SimpleMovie;
   
   public class CastleBuildingView extends BuildingBase implements ICheck
   {
      
      private var _rect:Rectangle = new Rectangle(0,0,0,0);
      
      private var _buildingFilter:IBuildingFilter;
      
      private var _colorManager:ColorManager;
      
      private var _effect:SimpleMovie;
      
      private var _newBuilding:Boolean = false;
      
      public var isLoaded:Boolean;
      
      private var isShowed:Boolean;
      
      private var _isUpgrade:Boolean;
      
      private var _scale:Number;
      
      public function CastleBuildingView(param1:IBuildingFilter, param2:CastleNameLayer = null)
      {
         _buildingFilter = param1;
         super(param2);
      }
      
      public function get checkRect() : Rectangle
      {
         return _rect;
      }
      
      protected function get isAdornment() : Boolean
      {
         switch(int(_buildingInfo.templeteInfo.SonType) - 1501)
         {
            case 0:
            case 1:
            case 2:
            case 5:
            case 7:
            case 9:
               return true;
            default:
               return false;
         }
      }
      
      override protected function initTipStyle() : void
      {
         if(isAdornment)
         {
            return;
         }
         switch(_buildingInfo.templeteInfo.SonType)
         {
            case 1501:
            case 1503:
            case 1502:
            case 1504:
            case 1505:
            case 1506:
            case 1507:
            case 1509:
            case 1510:
            case 1511:
            case 101:
            case 1201:
            case 301:
            case 1801:
            case 1601:
            case 1701:
               tipStyle = "yishi.view.tips.WaterTreeTip";
               break;
            default:
               tipStyle = "yishi.view.tips.BuildTip";
         }
      }
      
      override protected function initTipData() : void
      {
         var _loc1_:WaterTreeTipInfo = null;
         var _loc2_:String = null;
         if(isAdornment)
         {
            return;
         }
         switch(_buildingInfo.templeteInfo.SonType)
         {
            case 1501:
               _loc1_ = new WaterTreeTipInfo();
               _loc1_.title = LanguageMgr.GetTranslation("castle.view.CastleBuildingView.command01");
               _loc1_.content = LanguageMgr.GetTranslation("castle.view.CastleBuildingView.command02");
               tipData = _loc1_;
               break;
            case 1503:
               _loc1_ = new WaterTreeTipInfo();
               _loc1_.title = LanguageMgr.GetTranslation("castle.view.CastleBuildingView.command03");
               _loc1_.content = LanguageMgr.GetTranslation("castle.view.CastleBuildingView.command04");
               tipData = _loc1_;
               break;
            case 1502:
               _loc1_ = new WaterTreeTipInfo();
               _loc1_.title = LanguageMgr.GetTranslation("castle.view.CastleBuildingView.command05");
               _loc1_.content = LanguageMgr.GetTranslation("castle.view.CastleBuildingView.command06");
               tipData = _loc1_;
               break;
            case 1509:
               _loc1_ = new WaterTreeTipInfo();
               _loc1_.title = LanguageMgr.GetTranslation("castle.view.CastleBuildingView.command071");
               _loc1_.content = LanguageMgr.GetTranslation("castle.view.CastleBuildingView.command081");
               tipData = _loc1_;
               break;
            case 1504:
               _loc1_ = new WaterTreeTipInfo();
               _loc1_.title = LanguageMgr.GetTranslation("castle.view.CastleBuildingView.command09");
               _loc1_.content = LanguageMgr.GetTranslation("castle.view.CastleBuildingView.command10");
               tipData = _loc1_;
               break;
            case 1507:
               _loc1_ = new WaterTreeTipInfo();
               _loc1_.title = LanguageMgr.GetTranslation("castle.view.CastleBuildingView.command11");
               _loc1_.content = LanguageMgr.GetTranslation("castle.view.CastleBuildingView.command12");
               tipData = _loc1_;
               break;
            case 1510:
               _loc1_ = new WaterTreeTipInfo();
               _loc1_.title = LanguageMgr.GetTranslation("castle.view.CastleBuildingView.command13");
               _loc1_.content = LanguageMgr.GetTranslation("castle.view.CastleBuildingView.command14");
               tipData = _loc1_;
               break;
            case 1511:
               _loc1_ = new WaterTreeTipInfo();
               _loc1_.title = LanguageMgr.GetTranslation("castle.view.CastleBuildingView.command15");
               _loc1_.content = LanguageMgr.GetTranslation("castle.view.CastleBuildingView.command16");
               tipData = _loc1_;
               break;
            case 1506:
               _loc1_ = new WaterTreeTipInfo();
               _loc1_.title = LanguageMgr.GetTranslation("castle.view.CastleBuildingView.command24");
               _loc1_.content = LanguageMgr.GetTranslation("castle.view.CastleBuildingView.command25");
               tipData = _loc1_;
               break;
            case 1505:
               _loc1_ = new WaterTreeTipInfo();
               _loc1_.title = LanguageMgr.GetTranslation("castle.view.CastleBuildingView.vehicleTitle");
               _loc1_.content = LanguageMgr.GetTranslation("castle.view.CastleBuildingView.vehicleContent");
               tipData = _loc1_;
               break;
            case 1801:
               _loc1_ = new WaterTreeTipInfo();
               _loc1_.title = LanguageMgr.GetTranslation("castle.view.CastleBuildingView.command26");
               _loc1_.content = LanguageMgr.GetTranslation("castle.view.CastleBuildingView.command27");
               tipData = _loc1_;
               break;
            case 1601:
               _loc1_ = new WaterTreeTipInfo();
               _loc1_.title = LanguageMgr.GetTranslation("castle.view.CastleBuildingView.command28");
               _loc1_.content = LanguageMgr.GetTranslation("castle.view.CastleBuildingView.command29");
               tipData = _loc1_;
               break;
            case 1701:
               _loc1_ = new WaterTreeTipInfo();
               _loc1_.title = LanguageMgr.GetTranslation("castle.view.CastleBuildingView.command30");
               _loc1_.content = LanguageMgr.GetTranslation("castle.view.CastleBuildingView.command31");
               tipData = _loc1_;
               break;
            case 1508:
               break;
            default:
               tipData = _buildingInfo;
         }
         if(isNotOpen())
         {
            _loc2_ = "";
            switch(_buildingInfo.templeteInfo.SonType)
            {
               case 1511:
                  _loc2_ = LanguageMgr.GetTranslation("store.view.StoreFrame.command01",15);
                  break;
               case 1507:
                  _loc2_ = LanguageMgr.GetTranslation("store.view.StoreFrame.command01",12);
                  break;
               case 1509:
                  _loc2_ = LanguageMgr.GetTranslation("store.view.StoreFrame.command01",12);
                  break;
               case 1801:
                  _loc2_ = LanguageMgr.GetTranslation("store.view.StoreFrame.command01",25);
                  break;
               case 1601:
                  _loc2_ = LanguageMgr.GetTranslation("store.view.StoreFrame.command01",32);
                  break;
               case 1701:
                  _loc2_ = LanguageMgr.GetTranslation("castle.view.CastleBuildingView.command38");
            }
            if(_loc1_)
            {
               _loc1_.content = _loc2_;
            }
            this.buttonMode = false;
         }
         else
         {
            this.buttonMode = true;
         }
      }
      
      protected function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function get curView() : DisplayObject
      {
         return _curView;
      }
      
      override public function mouseOverHandler(param1:MouseEvent) : Boolean
      {
         if(isAdornment)
         {
            return true;
         }
         if(_curView && !isNotOpen())
         {
            _buildingFilter.setBuildingOverFilter(this._curView["effect_area"]);
         }
         return true;
      }
      
      override public function mouseOutHandler(param1:MouseEvent) : Boolean
      {
         if(isAdornment)
         {
            return true;
         }
         if(_curView && !isNotOpen())
         {
            _buildingFilter.setBuildingOutFilter(this._curView["effect_area"]);
         }
         return true;
      }
      
      override public function mouseClickHandler(param1:MouseEvent) : Boolean
      {
         if(isAdornment)
         {
            return true;
         }
         SoundManager.instance.play("011",true);
         var _loc2_:String = "";
         if(MopupManager.instance.model.isMopup)
         {
            _loc2_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01");
            MessageTipManager.instance().show(_loc2_);
            return false;
         }
         switch(_buildingInfo.templeteInfo.SonType)
         {
            case 1501:
               if(thane.grades < 7)
               {
                  _loc2_ = LanguageMgr.GetTranslation("castle.view.CastleBuildingView.command17");
                  MessageTipManager.instance().show(_loc2_);
                  return false;
               }
               FrameControllerManager.instance.storeController.startFrameByType("STORE_PANEL_INTENSIFY");
               break;
            case 1503:
               if(thane.grades < 16)
               {
                  _loc2_ = LanguageMgr.GetTranslation("castle.view.CastleBuildingView.command18");
                  MessageTipManager.instance().show(_loc2_);
                  return false;
               }
               SwitchPageHelp.goSpaceAndFind(6);
               break;
            case 1502:
               if(thane.grades < 20)
               {
                  _loc2_ = LanguageMgr.GetTranslation("castle.view.CastleBuildingView.command19");
                  MessageTipManager.instance().show(_loc2_);
                  return false;
               }
               SwitchPageHelp.goSpaceAndFind(2);
               break;
            case 1510:
               SwitchPageHelp.goSpaceAndFind(1);
               break;
            case 1504:
               FrameControllerManager.instance.openControllerByInfo("hook");
               break;
            case 1507:
               if(thane.grades < 12)
               {
                  _loc2_ = LanguageMgr.GetTranslation("castle.view.CastleBuildingView.command20");
                  MessageTipManager.instance().show(_loc2_);
                  return false;
               }
               FrameControllerManager.instance.openControllerByInfo("maze");
               break;
            case 1505:
               if(thane.grades < 35)
               {
                  _loc2_ = LanguageMgr.GetTranslation("vehicle.noOpen");
                  MessageTipManager.instance().show(_loc2_);
                  return false;
               }
               FrameControllerManager.instance.openControllerByInfo("vehicledaimon");
               break;
            case 1509:
               if(thane.grades < 12)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("castle.view.CastleBuildingView.command37"));
                  return false;
               }
               FrameControllerManager.instance.openControllerByInfo("farm","CastleBuildingView.FarmEnterNewFrame");
               break;
            case 1508:
               _loc2_ = LanguageMgr.GetTranslation("castle.view.CastleBuildingView.command21");
               MessageTipManager.instance().show(_loc2_);
               break;
            case 1506:
               SwitchPageHelp.goSpaceAndFind(8);
               break;
            case 101:
            case 1201:
            case 301:
               break;
            case 1511:
               if(thane.grades < 15)
               {
                  _loc2_ = LanguageMgr.GetTranslation("castle.view.CastleBuildingView.command36");
                  MessageTipManager.instance().show(_loc2_);
                  return false;
               }
               FrameControllerManager.instance.openControllerByInfo(BuildingControler.getModelNameByInfo(_buildingInfo),null,_buildingInfo);
               break;
            case 1801:
               if(thane.grades < 25)
               {
                  _loc2_ = LanguageMgr.GetTranslation("castle.view.CastleBuildingView.command32");
                  MessageTipManager.instance().show(_loc2_);
                  return false;
               }
               FrameControllerManager.instance.openControllerByInfo("minefield");
               break;
            case 1601:
               if(thane.grades < 32)
               {
                  _loc2_ = LanguageMgr.GetTranslation("castle.view.CastleBuildingView.command33");
                  MessageTipManager.instance().show(_loc2_);
                  return false;
               }
               FrameControllerManager.instance.openControllerByInfo("magiccard");
               break;
            case 1701:
               if(thane.vocationGrades <= 0)
               {
                  _loc2_ = LanguageMgr.GetTranslation("castle.view.CastleBuildingView.command34");
                  MessageTipManager.instance().show(_loc2_);
                  return false;
               }
               FrameControllerManager.instance.openControllerByInfo("perkinlab");
               break;
            default:
               FrameControllerManager.instance.openControllerByInfo(BuildingControler.getModelNameByInfo(_buildingInfo),null,_buildingInfo);
         }
         return true;
      }
      
      override protected function clean() : void
      {
         isLoaded = false;
         ObjectUtils.disposeAllChildren(_curViewContainer);
         _curView = null;
         if(_effectView)
         {
            (_effectView as MovieClip).stop();
            _effectView = null;
         }
      }
      
      override protected function refreshView() : void
      {
         if(!_buildingInfo)
         {
            return;
         }
         super.refreshView();
         var _loc2_:BuildingTempInfo = _buildingInfo.templeteInfo;
         var _loc1_:DisplayObject = _loc2_.view;
         setCurView(_loc1_);
         if(_loc1_ == null && !_curView)
         {
            if(StringHelper.isNullOrEmpty(_loc2_.PicPath) != false)
            {
               throw new Error(LanguageMgr.GetTranslation("castle.view.CastleBuildingView.command22"));
            }
            new CastleBuildingLoader(_buildingInfo,loadViewCallBack);
         }
      }
      
      private function loadViewCallBack(param1:int) : void
      {
         if(!_buildingInfo || _buildingInfo.templateId != param1)
         {
            return;
         }
         var _loc3_:BuildingTempInfo = _buildingInfo.templeteInfo;
         var _loc2_:DisplayObject = _loc3_.view;
         if(_loc2_ != null)
         {
            if(_newBuilding)
            {
               newBuildingFocus();
            }
            else
            {
               setCurView(_loc2_);
            }
         }
         isLoaded = true;
         BuildingManager.instance.dispatchEvent(new BuildingEvent("BUILDING_LOAD_COMPLETE",_buildingInfo));
         if(isAdornment)
         {
            showName = false;
            buttonMode = false;
            removeEvent();
         }
         if(_curView && isNotOpen())
         {
            _buildingFilter.setGrayFilter(this._curView);
         }
      }
      
      private function isNotOpen() : Boolean
      {
         return _buildingInfo.templeteInfo.SonType == 1511 && thane.grades < 15 || _buildingInfo.templeteInfo.SonType == 1507 && thane.grades < 12 || _buildingInfo.templeteInfo.SonType == 1509 && thane.grades < 12 || _buildingInfo.templeteInfo.SonType == 1801 && thane.grades < 25 || _buildingInfo.templeteInfo.SonType == 1601 && thane.grades < 32 || _buildingInfo.templeteInfo.SonType == 1701 && thane.vocationGrades <= 0;
      }
      
      public function updateShowFilter() : void
      {
         if(_curView && !isNotOpen() && !isShowed)
         {
            initTipData();
            _buildingFilter.setNormalFilter(this._curView);
            isShowed = true;
         }
      }
      
      protected function setCurView(param1:DisplayObject) : void
      {
         var _loc3_:Sprite = null;
         var _loc2_:BitmapData = null;
         if(_isUpgrade)
         {
            setBuildingFinishView();
            addChildByScale(_scale);
         }
         if(param1 == null || _curView)
         {
            return;
         }
         _curView = param1;
         startPoint = new Point(_curView.x,_curView.y);
         _rect.x = _buildingInfo.templeteInfo.PosX + _curView["line"].x;
         _rect.y = _buildingInfo.templeteInfo.PosY + _curView["line"].y;
         _curViewContainer.addChild(_curView);
         _effectView = _buildingInfo.templeteInfo.effect;
         if(_effectView)
         {
            (_effectView as MovieClip).play();
            _curViewContainer.addChild(_effectView);
         }
         tipGapV = -_curView.height / 3;
         tipGapH = -_curView.width / 3;
         if(_curView["effect_area"])
         {
            _loc2_ = new BitmapData(_curView["effect_area"].width,_curView["effect_area"].height,true,0);
            _loc2_.draw(_curView["effect_area"]);
            _loc3_ = DisplayUtils.getHitArea(_loc2_,5);
            hitArea = _loc3_;
            _curViewContainer.addChild(_loc3_);
         }
         else
         {
            mouseEnabled = mouseChildren = false;
         }
      }
      
      public function set newBuilding(param1:Boolean) : void
      {
         _newBuilding = param1;
         newBuildingFocus();
      }
      
      private function newBuildingFocus() : void
      {
         _newBuilding = false;
         _curView = _buildingInfo.templeteInfo.view;
         if(_curView)
         {
            _curViewContainer.addChild(_curView);
            _colorManager = new ColorManager(_curView["effect_area"]);
            _colorManager.addEventListener("complete",__onFinish);
         }
         else
         {
            refreshView();
         }
      }
      
      private function __onFinish(param1:Event) : void
      {
         if(_colorManager)
         {
            _colorManager.removeEventListener("complete",__onFinish);
            _colorManager = null;
         }
         refreshView();
      }
      
      public function buildingLevelUpdated(param1:Number) : void
      {
         _isUpgrade = true;
         _scale = param1;
      }
      
      public function setBuildingFinishView() : void
      {
         if(!_curView || !_curView["effect_area"])
         {
            return;
         }
         buttonMode = true;
         _isUpgrade = false;
         var _loc2_:MovieClip = ComponentFactory.Instance.creatCustomObject("castle.BuildLevelUpEffectMC");
         _effect = new SimpleMovie(_loc2_);
         _effect.addEventListener("complete",__effectComplete);
         var _loc1_:Number = _curView["effect_area"].width / _effect.width + 0.4;
         _effect.width *= _loc1_;
         _effect.height *= _loc1_;
         _effect.mouseChildren = false;
         _effect.mouseEnabled = false;
         _effect.x = _curView["effect_area"].width / 2 * _curView["effect_area"].scaleX;
         _effect.y = _curView["effect_area"].height * _curView["effect_area"].scaleY;
         addChild(_effect);
      }
      
      private function __effectComplete(param1:Event) : void
      {
         if(_effect)
         {
            _effect.removeEventListener("complete",__effectComplete);
         }
         _effect = null;
      }
      
      override public function dispose() : void
      {
         clean();
         _buildingFilter = null;
         _colorManager = null;
         ObjectUtils.disposeObject(_curViewContainer);
         _curViewContainer = null;
         _buildingInfo = null;
         ObjectUtils.disposeObject(_effect);
         _effect = null;
         ShowTipManager.Instance.removeTip(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

