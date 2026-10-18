package com.map.vehicle.view
{
   import avatar.view.AppellView;
   import com.greensock.TweenMax;
   import com.map.vehicle.data.PlayerVehicleInfo;
   import com.map.vehicle.data.VGlobal;
   import com.map.vehicle.events.VehicleEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import yishi.datas.VersionSwitch;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.utils.StringHelper;
   
   public class VehicleBloodStuffView extends Component
   {
      
      protected var _npcNameTxt:FilterFrameText;
      
      protected var _consortNameTxt:FilterFrameText;
      
      protected var _vipIcon:ScaleFrameImage;
      
      protected var _honerTxt:GradientText;
      
      protected var _honerView:AppellView;
      
      protected var _data:PlayerVehicleInfo;
      
      protected var _appellId:int = 0;
      
      protected var _vocationIcon:ScaleFrameImage;
      
      private var _mc:MovieClip;
      
      private var _bloodMask:MovieClip;
      
      private var _teamBlood:MovieClip;
      
      private var _tween:TweenMax;
      
      public var lastPosY:int = 0;
      
      public function VehicleBloodStuffView()
      {
         super();
         initView();
         this.mouseChildren = mouseEnabled = false;
      }
      
      private function initView() : void
      {
         _npcNameTxt = ComponentFactory.Instance.creatComponentByStylename("core.NpcNameText");
         _consortNameTxt = ComponentFactory.Instance.creatComponentByStylename("map.campaign.ConsortiaText");
         _vipIcon = ComponentFactory.Instance.creatComponentByStylename("core.vipIcon");
         _vipIcon.visible = false;
         _vocationIcon = ComponentFactory.Instance.creatComponentByStylename("army.VocationIcon");
         _vocationIcon.visible = false;
         _mc = ComponentFactory.Instance.creat("asset.vehiclemap.HeroBloodBar");
         addChild(_mc);
         addChild(_vipIcon);
         addChild(_npcNameTxt);
         addChild(_consortNameTxt);
         addChild(_vocationIcon);
         _mc.gotoAndStop(1);
         _bloodMask = _mc["bloodMask"] as MovieClip;
         _teamBlood = _mc["teamBlood"] as MovieClip;
         _bloodMask.gotoAndStop(100);
         _teamBlood.gotoAndStop(1);
      }
      
      public function updateHoner() : void
      {
         if(_honerView)
         {
            _honerView.draw();
         }
      }
      
      public function get isHoner() : Boolean
      {
         if(VersionSwitch.APPELL)
         {
            return _data.appellId != 0;
         }
         return false;
      }
      
      private function get honerName() : String
      {
         if(VersionSwitch.APPELL && data.appellTemplate)
         {
            return data.appellTemplate.Title;
         }
         return "";
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get honerStyle() : String
      {
         if(data && VersionSwitch.APPELL && data.appellTemplate)
         {
            return "map.campaign.HonerText" + data.appellTemplate.Quality;
         }
         return "map.campaign.HonerText";
      }
      
      private function isFriend() : Boolean
      {
         if(VGlobal.model.selfVehicleInfo && _data)
         {
            return _data.team == VGlobal.model.selfVehicleInfo.team;
         }
         return false;
      }
      
      private function refreshVocation() : void
      {
         if(_data && _data.vocationGrades > 0)
         {
            _vocationIcon.setFrame(_data.vocationLevel);
            _vocationIcon.visible = true;
         }
         else
         {
            _vocationIcon.visible = false;
         }
      }
      
      public function get data() : PlayerVehicleInfo
      {
         return _data;
      }
      
      public function set data(param1:PlayerVehicleInfo) : void
      {
         _data = param1;
         if(!_data)
         {
            return;
         }
         if(VGlobal.model.isFriend(_data.team))
         {
            _teamBlood.gotoAndStop(1);
         }
         else
         {
            _teamBlood.gotoAndStop(2);
         }
         update();
         initBlood();
         switchBloodBar();
         addEvent();
      }
      
      private function switchBloodBar() : void
      {
         _mc.visible = data.hp > 0;
      }
      
      private function initBlood() : void
      {
         var _loc1_:int = data.hp * 100 / data.totalHp;
         _bloodMask.gotoAndStop(_loc1_);
      }
      
      private function addEvent() : void
      {
         _data.addEventListener("HP_CUT",__cutHpHandler);
         _data.addEventListener("HP_ADD",__addHpHandler);
      }
      
      private function removeEvent() : void
      {
         if(_data)
         {
            _data.removeEventListener("HP_CUT",__cutHpHandler);
            _data.removeEventListener("HP_ADD",__addHpHandler);
         }
      }
      
      private function __cutHpHandler(param1:VehicleEvent) : void
      {
         var _loc2_:int = data.hp * 100 / data.totalHp;
         if(_loc2_ != _bloodMask.currentFrame)
         {
            killTweens();
            _tween = TweenMax.to(_bloodMask,0.7,{
               "delay":0.3,
               "frame":_loc2_,
               "onComplete":killTweens
            });
         }
         switchBloodBar();
      }
      
      private function __addHpHandler(param1:VehicleEvent) : void
      {
         var _loc2_:int = data.hp * 100 / data.totalHp;
         killTweens();
         _bloodMask.gotoAndStop(_loc2_);
         switchBloodBar();
      }
      
      public function update() : void
      {
         showNameInfo();
      }
      
      private function showNameInfo() : void
      {
         var _loc3_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc4_:int = -15;
         _mc.y = _loc4_;
         _npcNameTxt.y = _loc4_ - 15;
         _consortNameTxt.y = _npcNameTxt.y - 20;
         _vipIcon.y = _npcNameTxt.y;
         _data.vipType == 2 ? _vipIcon.setFrame(1) : _vipIcon.setFrame(2);
         _npcNameTxt.text = data.name;
         var _loc1_:int = isFriend() ? 1 : 5;
         _npcNameTxt.setFrame(_loc1_);
         setHonerName();
         if(data.consortiaName)
         {
            _consortNameTxt.text = StringHelper.format("<{0}>",data.consortiaName);
            if(_honerTxt)
            {
               _honerTxt.y = _consortNameTxt.y - 20;
            }
            if(_honerView)
            {
               _honerView.y = _consortNameTxt.y - _data.appellTemplate.ImgHeight;
            }
         }
         else
         {
            _consortNameTxt.text = "";
            if(_honerTxt)
            {
               _honerTxt.y = _npcNameTxt.y - 20;
            }
            if(_honerView)
            {
               _honerView.y = _npcNameTxt.y - _data.appellTemplate.ImgHeight;
            }
         }
         if(_data.isVip)
         {
            _vipIcon.visible = true;
            _loc3_ = _vipIcon.width + _npcNameTxt.textWidth + 10;
            _loc2_ = _npcNameTxt.width - _npcNameTxt.textWidth >> 1;
            _vipIcon.x = -_loc3_ >> 1;
            _npcNameTxt.x = _vipIcon.x + _vipIcon.width - _loc2_ + 1;
         }
         else
         {
            _vipIcon.visible = false;
            _npcNameTxt.x = -(_npcNameTxt.width >> 1);
         }
         if(_consortNameTxt)
         {
            _consortNameTxt.x = -(_consortNameTxt.width >> 1);
         }
         if(_honerTxt)
         {
            _honerTxt.x = -(_honerTxt.width >> 1);
         }
         if(_honerView)
         {
            _honerView.x = -(_honerView.appellWidth >> 1);
         }
         if(_vocationIcon != null)
         {
            if(_vipIcon && _vipIcon.visible)
            {
               _vocationIcon.y = _vipIcon.y - 4;
               _vocationIcon.x = _vipIcon.x - _vocationIcon.width;
            }
            else
            {
               _vocationIcon.y = _npcNameTxt.y - 4;
               _vocationIcon.x = _npcNameTxt.x - _vocationIcon.width;
            }
         }
         refreshVocation();
      }
      
      private function setHonerName() : void
      {
         if(_appellId == _data.appellId && (_honerView && _honerView.parent || _honerTxt && _honerTxt.parent))
         {
            return;
         }
         _appellId = _data.appellId;
         if(_honerTxt && _honerTxt.parent)
         {
            _honerTxt.parent.removeChild(_honerTxt);
         }
         ObjectUtils.disposeObject(_honerTxt);
         _honerTxt = null;
         if(_honerView && _honerView.parent)
         {
            _honerView.parent.removeChild(_honerView);
         }
         ObjectUtils.disposeObject(_honerView);
         _honerView = null;
         if(isHoner)
         {
            _honerTxt = ComponentFactory.Instance.creatComponentByStylename(honerStyle);
            _honerTxt.text = honerName;
            _honerView = new AppellView(_data.appellTemplate);
            showHoner();
         }
      }
      
      private function showHoner() : void
      {
         if(VersionSwitch.APPELL)
         {
            if(_honerTxt && _honerTxt.parent)
            {
               _honerTxt.parent.removeChild(_honerTxt);
            }
            if(_honerView)
            {
               addChild(_honerView);
            }
         }
         else
         {
            if(_honerTxt)
            {
               addChild(_honerTxt);
            }
            if(_honerView && _honerView.parent)
            {
               _honerView.parent.removeChild(_honerView);
            }
         }
      }
      
      private function getHonerHeight() : int
      {
         if(VersionSwitch.APPELL)
         {
            if(_honerView)
            {
               return _honerView.appellHeight;
            }
            return 0;
         }
         if(_honerTxt)
         {
            return _honerTxt.textField.textHeight;
         }
         return 0;
      }
      
      private function killTweens() : void
      {
         if(_tween)
         {
            _tween.kill();
            _tween = null;
         }
      }
      
      public function getTextHeight() : int
      {
         var _loc1_:int = 0;
         _loc1_ += _mc.height;
         _loc1_ += _npcNameTxt.textHeight;
         _loc1_ += _consortNameTxt.textHeight;
         _loc1_ += getHonerHeight();
         return _loc1_ - 15;
      }
      
      override public function dispose() : void
      {
         killTweens();
         removeEvent();
         ObjectUtils.disposeObject(_honerTxt);
         _honerTxt = null;
         ObjectUtils.disposeObject(_honerView);
         _honerView = null;
         ObjectUtils.disposeObject(_vocationIcon);
         _vocationIcon = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

