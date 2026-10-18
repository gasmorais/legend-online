package com.map.vehicle.view
{
   import com.map.vehicle.data.VehicleSkillInfo;
   import com.map.vehicle.events.VehicleEvent;
   import com.map.vehicle.net.VehicleSocketManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import yishi.utils.ButtonSkiner;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class VehicleSkillIcon extends Sprite implements Disposeable
   {
      
      private var _asset:MovieClip;
      
      private var _buttonSkiner:ButtonSkiner;
      
      private var _cdEffect:VehicleSkillCDEffect;
      
      private var _cdNumView:VehicleSkillCDNumView;
      
      private var _closeImage:Bitmap;
      
      private var _data:VehicleSkillInfo;
      
      private var _frameFilter:Array;
      
      private var _glowMc:MovieClip;
      
      private var _icon:BaseIconView;
      
      private var _iconContainer:MovieClip;
      
      private var _key:String;
      
      private var _mouseEventMc:MovieClip;
      
      private var _state:int;
      
      private var skillTempId:int;
      
      public function VehicleSkillIcon(param1:String)
      {
         _key = param1;
         super();
         init();
      }
      
      public function get data() : VehicleSkillInfo
      {
         return _data;
      }
      
      public function set data(param1:VehicleSkillInfo) : void
      {
         this.mouseEnabled = this.mouseChildren = true;
         if(param1)
         {
            if(param1.tempalte)
            {
               if(key == "2" && param1.tempalte.InjuryEffect == 3)
               {
                  removeEvent();
                  this.mouseEnabled = this.mouseChildren = false;
                  if(_icon.icon != _closeImage)
                  {
                     _icon.icon = _closeImage;
                  }
                  hideCD();
               }
               else if(!_data || _data && param1.tempalte.TemplateId != skillTempId)
               {
                  if(_cdEffect)
                  {
                     _cdEffect.dispose();
                  }
                  _cdEffect = new VehicleSkillCDEffect(param1.tempalte.CoolDown,cdCompleteHandler,updateCD);
                  _cdEffect.visible = false;
                  _asset.icon_pos.addChild(_cdEffect);
                  this.icon = IconFactory.getCommonIconPath(param1.tempalte.Icons);
                  _icon.tipData = param1.tempalte;
                  skillTempId = param1.templateId;
                  hideCD();
               }
            }
            else
            {
               this.icon = null;
               hideCD();
            }
         }
         else
         {
            this.icon = null;
            hideCD();
            if(_cdEffect)
            {
               _cdEffect.dispose();
            }
         }
         _data = param1;
         addEvent();
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_buttonSkiner)
         {
            _buttonSkiner.dispose();
         }
         _buttonSkiner = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_closeImage);
         _closeImage = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function hideCD() : void
      {
         if(_cdNumView && _cdNumView.parent)
         {
            _cdNumView.parent.removeChild(_cdNumView);
         }
      }
      
      public function get icon() : String
      {
         if(_icon)
         {
            return String(_icon.icon);
         }
         return null;
      }
      
      public function set icon(param1:String) : void
      {
         if(_icon)
         {
            if(icon != param1)
            {
               _icon.icon = param1;
            }
         }
      }
      
      public function get isCding() : Boolean
      {
         if(_cdEffect)
         {
            return _cdEffect.isCding;
         }
         return false;
      }
      
      public function get key() : String
      {
         return _key;
      }
      
      public function showCD() : void
      {
         if(_cdNumView && !_cdNumView.parent)
         {
            _asset.icon_pos.addChild(_cdNumView);
         }
      }
      
      public function startCD(param1:int = 0, param2:int = -1) : void
      {
         if(!_data)
         {
            return;
         }
         if(_cdEffect)
         {
            _cdEffect.start(param1,param2);
            _cdEffect.visible = true;
            showCD();
         }
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function set state(param1:int) : void
      {
         _state = param1;
      }
      
      public function updateCD() : void
      {
         if(_cdNumView)
         {
            _cdNumView.setNum(_cdEffect.getLeftTime());
         }
      }
      
      private function __disable() : void
      {
      }
      
      private function __enable() : void
      {
      }
      
      private function __iconClick(param1:MouseEvent) : void
      {
         var _loc2_:* = 0;
         if(isCding)
         {
            return;
         }
         switch(_key)
         {
            case "1":
               _loc2_ = 49;
               break;
            case "2":
               _loc2_ = 50;
               break;
            case "Q":
               _loc2_ = 81;
         }
         VehicleSocketManager.instance.controller.vehicleWorld.characterController.keyDownHandler(_loc2_);
      }
      
      private function __mouseDown() : void
      {
      }
      
      private function __normal(param1:*) : void
      {
         _icon.filters = _frameFilter[0];
      }
      
      private function __onMouseOver(param1:*) : void
      {
         _icon.filters = _frameFilter[1];
      }
      
      private function __skillInfoChangeHandler(param1:VehicleEvent) : void
      {
      }
      
      private function addEvent() : void
      {
         this.addEventListener("click",__iconClick);
         if(!_buttonSkiner)
         {
            _buttonSkiner = new ButtonSkiner(_icon);
            _buttonSkiner.onDownView = __mouseDown;
            _buttonSkiner.onNormalView = __normal;
            _buttonSkiner.onOverView = __onMouseOver;
            _buttonSkiner.onDisableView = __disable;
            _buttonSkiner.onEnableView = __enable;
         }
      }
      
      private function cdCompleteHandler() : void
      {
         _cdEffect.visible = false;
         _iconContainer.gotoAndPlay(2);
         hideCD();
      }
      
      private function clean() : void
      {
         if(_icon && _icon.parent)
         {
            _icon.parent.removeChild(_icon);
         }
      }
      
      private function init() : void
      {
         _asset = ClassUtils.CreatInstance("asset.vehicle.BattleSkillItemAsset");
         _asset.countTxt.selectable = false;
         TextField(_asset.countTxt).defaultTextFormat = new TextFormat(null,13,16777215,true);
         addChild(_asset);
         _asset.y = -5;
         _iconContainer = ComponentFactory.Instance.creat("asset.vehicle.SkillItemCDFlashAsset");
         _asset.icon_pos.addChild(_iconContainer);
         _icon = ComponentFactory.Instance.creatCustomObject("vehicle.SkillItemView");
         _iconContainer.container.addChild(_icon);
         _icon.buttonMode = true;
         _asset.flash_effect.visible = false;
         _asset.flash_effect.mouseChildren = _asset.flash_effect.mouseEnabled = false;
         _glowMc = ClassUtils.CreatInstance("asset.vehicle.GlowMc");
         _glowMc.mouseEnabled = _glowMc.mouseChildren = false;
         _glowMc.gotoAndStop(1);
         addChild(_glowMc);
         _mouseEventMc = ClassUtils.CreatInstance("asset.vehicle.OverMc");
         _mouseEventMc.mouseEnabled = _mouseEventMc.mouseChildren = false;
         _mouseEventMc.gotoAndStop(1);
         _mouseEventMc.x = -1;
         _mouseEventMc.y = -1;
         _asset.icon_pos.addChild(_mouseEventMc);
         _cdNumView = new VehicleSkillCDNumView();
         _cdNumView.mouseChildren = _cdNumView.mouseEnabled = false;
         _asset.countMc.visible = true;
         _asset.countTxt.text = _key;
         _frameFilter = ComponentFactory.Instance.creatFrameFilters("core.DefaultFilter,core.LightFilter,core.DefaultFilter,core.GrayFilter");
         _closeImage = ComponentFactory.Instance.creatBitmap("asset.vehicle.SkillItemClose");
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void
      {
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("click",__iconClick);
      }
   }
}

