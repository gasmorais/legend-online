package map.campaign.view.ui.activevehicle
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import yishi.manager.NotificationManager;
   import yishi.utils.ButtonSkiner;
   import yishi.view.community.BaseIconView;
   
   public class CrossSkillIcon extends Sprite implements Disposeable
   {
      
      public static var OPEN:int = 1;
      
      public static var LOCK:int = 0;
      
      private var _asset:MovieClip;
      
      private var _buttonSkiner:ButtonSkiner;
      
      private var _cdEffect:CrossSkillCDEffect;
      
      private var _cdNumView:CrossSkillCDNumView;
      
      private var _closeImage:Bitmap;
      
      private var _frameFilter:Array;
      
      private var _glowMc:MovieClip;
      
      private var _icon:BaseIconView;
      
      private var _iconContainer:MovieClip;
      
      private var _key:String;
      
      private var _wide:Boolean = false;
      
      private var _mouseEventMc:MovieClip;
      
      private var skillTempId:int;
      
      private var _coolDown:int;
      
      private var _state:int;
      
      private var _skillInfo:Object;
      
      public function CrossSkillIcon(param1:String = "", param2:Boolean = false)
      {
         _key = param1;
         _wide = param2;
         init();
         super();
         this.state = 0;
      }
      
      private function init() : void
      {
         if(_wide)
         {
            _asset = ClassUtils.CreatInstance("asset.unrealshooting.BattleSkillItemAsset");
            _asset.countTxt.selectable = false;
         }
         else
         {
            _asset = ClassUtils.CreatInstance("asset.vehicle.BattleSkillItemAsset");
            _asset.countTxt.selectable = false;
         }
         TextField(_asset.countTxt).defaultTextFormat = new TextFormat(null,13,16777215,true);
         addChild(_asset);
         _asset.y = -5;
         _iconContainer = ComponentFactory.Instance.creat("asset.vehicle.SkillItemCDFlashAsset");
         _iconContainer.mouseEnabled = false;
         _asset.icon_pos.addChild(_iconContainer);
         _icon = ComponentFactory.Instance.creatCustomObject("vehicle.SkillItemView");
         _iconContainer.container.mouseEnabled = false;
         _iconContainer.container.addChild(_icon);
         _icon.buttonMode = true;
         _asset.flash_effect.visible = false;
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
         _cdNumView = new CrossSkillCDNumView();
         _cdNumView.mouseChildren = _cdNumView.mouseEnabled = false;
         _asset.countMc.visible = true;
         _asset.countTxt.text = _key;
         _frameFilter = ComponentFactory.Instance.creatFrameFilters("core.DefaultFilter,core.LightFilter,core.DefaultFilter,core.GrayFilter");
         _closeImage = ComponentFactory.Instance.creatBitmap("asset.vehicle.SkillItemClose");
         _asset.mouseEnabled = false;
         _asset.icon_pos.mouseEnabled = false;
         _asset.flash_effect.mouseChildren = _asset.flash_effect.mouseEnabled = false;
         _asset.countMc.mouseChildren = _asset.countMc.mouseEnabled = false;
         _asset.countTxt.mouseEnabled = false;
      }
      
      private function uintView() : void
      {
         if(_buttonSkiner)
         {
            _buttonSkiner.dispose();
         }
         _buttonSkiner = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_closeImage);
         _closeImage = null;
         ObjectUtils.disposeViolentMc(_iconContainer);
         _iconContainer = null;
         ObjectUtils.disposeViolentMc(_asset);
         _asset = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      public function get coolDown() : int
      {
         return _coolDown;
      }
      
      public function set coolDown(param1:int) : void
      {
         _coolDown = param1;
         if(param1 > 0)
         {
            _cdEffect = new CrossSkillCDEffect(param1,cdCompleteHandler,updateCD);
            _cdEffect.visible = false;
            _asset.icon_pos.addChild(_cdEffect);
         }
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function set state(param1:int) : void
      {
         _state = param1;
         if(param1 == OPEN)
         {
            if(_closeImage && _closeImage.parent)
            {
               _closeImage.parent.removeChild(_closeImage);
            }
            if(_asset)
            {
               _asset.countMc.visible = true;
               _asset.countTxt.visible = true;
               _asset.countTxt.text = _key;
            }
         }
         else
         {
            if(_closeImage)
            {
               addChild(_closeImage);
            }
            if(_asset)
            {
               _asset.countMc.visible = false;
               _asset.countTxt.visible = false;
            }
         }
      }
      
      public function get skillInfo() : Object
      {
         return _skillInfo;
      }
      
      public function set skillInfo(param1:Object) : void
      {
         _skillInfo = param1;
         if(param1)
         {
            _icon.buttonMode = true;
            addEvent();
         }
         else
         {
            removeEvent();
            _icon.buttonMode = false;
            cdCompleteHandler();
         }
         if(_icon)
         {
            _icon.tipData = param1;
         }
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
         _buttonSkiner.enable = true;
      }
      
      private function __iconClick(param1:MouseEvent) : void
      {
         if(isCding)
         {
            return;
         }
         NotificationManager.instance.sendNotification("MAP_USE_SKILL",this.skillInfo);
      }
      
      private function __disable() : void
      {
      }
      
      private function __enable() : void
      {
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
      
      public function hideCD() : void
      {
         if(_cdNumView && _cdNumView.parent)
         {
            _cdNumView.parent.removeChild(_cdNumView);
         }
         if(_cdEffect)
         {
            _cdEffect.dispose();
         }
         _cdEffect = null;
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
      
      public function startCD(param1:int = 0, param2:int = -1) : void
      {
         if(_cdEffect)
         {
            _cdEffect.start(param1,param2);
            _cdEffect.visible = true;
            showCD();
         }
      }
      
      public function showCD() : void
      {
         if(_cdNumView && !_cdNumView.parent)
         {
            _asset.icon_pos.addChild(_cdNumView);
         }
      }
      
      public function updateCD() : void
      {
         if(_cdNumView)
         {
            _cdNumView.setNum(_cdEffect.getLeftTime());
         }
      }
      
      private function cdCompleteHandler() : void
      {
         if(_cdEffect)
         {
            _cdEffect.visible = false;
         }
         if(_iconContainer)
         {
            _iconContainer.gotoAndPlay(2);
         }
         hideCD();
      }
      
      private function clean() : void
      {
         if(_icon && _icon.parent)
         {
            _icon.parent.removeChild(_icon);
         }
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("click",__iconClick);
         if(_buttonSkiner)
         {
            _buttonSkiner.enable = false;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         uintView();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

