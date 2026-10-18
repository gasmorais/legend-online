package battle.view.ui
{
   import battle.BattleManager;
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import yishi.datas.BattleModel;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.NotificationManager;
   import yishi.utils.ButtonSkiner;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class AddOtherSkillItem extends Sprite
   {
      
      protected var _iconContain:MovieClip;
      
      protected var _icon:BaseIconView;
      
      protected var _downMc:MovieClip;
      
      protected var _overMc:MovieClip;
      
      protected var _buttonSkiner:ButtonSkiner;
      
      protected var _lockImg:Bitmap;
      
      protected var _banImg:Bitmap;
      
      protected var _iconRemoved:Boolean;
      
      public var isLock:Boolean = false;
      
      public var bufferUnEnable:Boolean;
      
      protected var _cdEffect:SkillItemCDEffect;
      
      public var parentEnable:Boolean;
      
      protected var _data:SkillTempInfo;
      
      public const STATE_NORMAL:int = 0;
      
      public const STATE_GRAY:int = 1;
      
      public const STATE_DARK:int = 2;
      
      public const STATE_LOCK:int = 4;
      
      public function AddOtherSkillItem()
      {
         super();
         initView();
         initEvent();
         _buttonSkiner.enable = false;
      }
      
      private function initView() : void
      {
         _iconContain = ComponentFactory.Instance.creatCustomObject("asset.battle.SkillItemCDFlashAsset");
         _icon = ComponentFactory.Instance.creatCustomObject("battle.warsoul.SkillItemView");
         _downMc = ComponentFactory.Instance.creatCustomObject("asset.battle.DownMc");
         _overMc = ComponentFactory.Instance.creatCustomObject("asset.battle.OverMc");
         _lockImg = ComponentFactory.Instance.creatBitmap("asset.battle.BattlePropLockAsset");
         _banImg = ComponentFactory.Instance.creatBitmap("asset.battle.BanAsset");
         _downMc.visible = _downMc.mouseChildren = _downMc.mouseEnabled = false;
         _overMc.mouseChildren = _overMc.mouseEnabled = false;
         addChild(_iconContain);
         addChild(_downMc);
         addChild(_overMc);
         addChild(_lockImg);
         _iconContain.container.addChild(_icon);
      }
      
      private function initEvent() : void
      {
         _icon.addEventListener("click",__iconClick);
         _buttonSkiner = new ButtonSkiner(_icon);
         _buttonSkiner.onNormalView = __normal;
         _buttonSkiner.onOverView = __onMouseOver;
         _buttonSkiner.onDisableView = __disable;
         _buttonSkiner.onEnableView = __enable;
      }
      
      protected function removeEvent() : void
      {
         if(_icon)
         {
            _icon.removeEventListener("click",__iconClick);
         }
         if(_buttonSkiner)
         {
            _buttonSkiner.onNormalView = null;
            _buttonSkiner.onOverView = null;
            _buttonSkiner.onDisableView = null;
            _buttonSkiner.onEnableView = null;
         }
      }
      
      public function setDownEffect(param1:Boolean = false) : void
      {
         _downMc.visible = param1;
      }
      
      protected function __iconClick(param1:MouseEvent) : void
      {
         if(isLock)
         {
            return;
         }
         if(!visible)
         {
            return;
         }
         if(data == null)
         {
            return;
         }
         if(!_buttonSkiner.enable)
         {
            return;
         }
         if(_iconRemoved)
         {
            return;
         }
         var _loc2_:BattleModel = BattleManager.getInstance().battleModel;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:HeroRoleInfo = _loc2_.selfHero;
         if(_loc3_ == null)
         {
            return;
         }
         if(param1)
         {
            ShowTipManager.Instance.hideTip(_icon);
         }
         NotificationManager.instance.sendNotification("AddOther.skillUse",_data);
      }
      
      private function __enable() : void
      {
         _icon.buttonMode = true;
         _icon.filters = null;
      }
      
      private function __disable() : void
      {
         _icon.buttonMode = false;
         _icon.filters = [UIFilter.getDarkFilter()];
      }
      
      private function __normal() : void
      {
         if(_iconRemoved)
         {
            return;
         }
         if(_buttonSkiner.enable)
         {
            TweenLite.to(_overMc,0.4,{"frame":1});
         }
      }
      
      private function __onMouseOver() : void
      {
         if(_iconRemoved)
         {
            return;
         }
         if(_buttonSkiner.enable)
         {
            TweenLite.to(_overMc,0.4,{"frame":10});
         }
      }
      
      public function get buttonSkiner() : ButtonSkiner
      {
         return _buttonSkiner;
      }
      
      public function get data() : SkillTempInfo
      {
         return _data;
      }
      
      public function set data(param1:SkillTempInfo) : void
      {
         _data = param1;
         if(_data)
         {
            _icon.tipData = _data;
            _icon.icon = IconFactory.getTecIconByIcon(_data.Icons);
            _lockImg.visible = false;
         }
         else
         {
            _icon.tipData = null;
            _icon.icon = null;
            _lockImg.visible = true;
         }
      }
      
      public function get banImg() : Bitmap
      {
         return _banImg;
      }
      
      public function setState(param1:int) : void
      {
         if(BattleManager.getInstance().battleModel && BattleManager.getInstance().battleModel.isControledByBoss())
         {
            param1 = 1;
         }
         switch(param1)
         {
            case 0:
               _icon.filters = null;
               break;
            case 1:
               _icon.filters = [UIFilter.getGrayFilter()];
               break;
            case 2:
               _icon.filters = [UIFilter.getDarkFilter()];
               break;
            case 4:
               _icon.filters = null;
               _icon.tipData = null;
               lock();
         }
      }
      
      public function lock() : void
      {
         if(_lockImg.parent)
         {
            return;
         }
         addChild(_lockImg);
         this.mouseEnabled = this.mouseChildren = false;
      }
      
      public function unLock() : void
      {
         this.mouseEnabled = this.mouseChildren = true;
         this.mask = null;
         if(_lockImg && _lockImg.parent)
         {
            _lockImg.parent.removeChild(_lockImg);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ShowTipManager.Instance.hideTip(_icon);
         ShowTipManager.Instance.removeTip(_icon);
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_downMc);
         _downMc = null;
         ObjectUtils.disposeObject(_overMc);
         _overMc = null;
         ObjectUtils.disposeObject(_overMc);
         _overMc = null;
         ObjectUtils.disposeObject(_lockImg);
         _lockImg = null;
         ObjectUtils.disposeObject(_banImg);
         _banImg = null;
         if(_buttonSkiner)
         {
            _buttonSkiner.dispose();
         }
         _buttonSkiner = null;
         ObjectUtils.disposeViolentMc(_iconContain);
         _iconContain = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

