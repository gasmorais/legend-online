package battle.view.ui
{
   import battle.BattleManager;
   import battle.events.BattleEvent;
   import com.greensock.TweenLite;
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.CustomBitmap;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import mainBar.effects.MainToolBtnGlowEffect;
   import org.aswing.KeyboardManager;
   import yishi.datas.BattleModel;
   import yishi.datas.consant.SkillPriorityType;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.events.NotificationEvent;
   import yishi.filter.UIFilter;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.ButtonSkiner;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class BattleSkillItemII extends Sprite implements Disposeable
   {
      
      public static const STATE_NORMAL:int = 0;
      
      public static const STATE_GRAY:int = 1;
      
      public static const STATE_DARK:int = 2;
      
      public static const STATE_LOCK:int = 4;
      
      protected var _iconContain:MovieClip;
      
      protected var _icon:BaseIconView;
      
      protected var _superSkill:Bitmap;
      
      protected var _countBack:Bitmap;
      
      protected var _countTxt:FilterFrameText;
      
      protected var _downMc:MovieClip;
      
      protected var _overMc:MovieClip;
      
      protected var _cdEffect:SkillItemCDEffect;
      
      protected var _ceNumView:SkillItemCDNumView;
      
      protected var _lockImg:Bitmap;
      
      protected var _banImg:Bitmap;
      
      protected var _buttonSkiner:ButtonSkiner;
      
      protected var _circleImg:CustomBitmap;
      
      protected var _iconRemoved:Boolean;
      
      protected var _numCount:int = 1;
      
      public var isLock:Boolean = false;
      
      private var _disEffect:MainToolBtnGlowEffect;
      
      private var _useCountTxt:FilterFrameText;
      
      private var _useCount:int = 2147483647;
      
      public var parentEnable:Boolean;
      
      public var bufferUnEnable:Boolean;
      
      public var shape:int = 0;
      
      private var maskShape:Shape;
      
      private var _skillEnable:Boolean = false;
      
      private var _shortcutChar:String = "";
      
      protected var _data:Object;
      
      public function BattleSkillItemII(param1:int = 0)
      {
         shape = param1;
         super();
         createAsset();
         initView();
         initEvent();
         if(shape != 5)
         {
            _buttonSkiner.enable = false;
         }
      }
      
      protected function createAsset() : void
      {
         _iconContain = ComponentFactory.Instance.creatCustomObject("asset.battle.SkillItemCDFlashAsset");
         _icon = ComponentFactory.Instance.creatCustomObject("battle.SkillItemView");
         _superSkill = ComponentFactory.Instance.creatBitmap("asset.battle.SuperSkill");
         _countBack = ComponentFactory.Instance.creatBitmap("asset.battle.SkillCountBack");
         _countTxt = ComponentFactory.Instance.creatComponentByStylename("battle.SkillCount");
         _downMc = ComponentFactory.Instance.creatCustomObject("asset.battle.DownMc");
         _overMc = ComponentFactory.Instance.creatCustomObject("asset.battle.OverMc");
         _lockImg = ComponentFactory.Instance.creatBitmap("asset.battle.BattlePropLockAsset");
         _banImg = ComponentFactory.Instance.creatBitmap("asset.battle.BanAsset");
         if(shape == 1)
         {
            _circleImg = ComponentFactory.Instance.creatCustomObject("battleSkillItemII.circleImg");
            _useCountTxt = ComponentFactory.Instance.creatComponentByStylename("battle.MarrPropCount");
            _ceNumView = new SkillItemCDNumView(44,0.6);
            _ceNumView.x = 1;
            _ceNumView.y = 3;
            maskShape = new Shape();
            maskShape.graphics.clear();
            maskShape.graphics.beginFill(0,0);
            maskShape.graphics.drawCircle(20,20,16);
            maskShape.graphics.endFill();
            maskShape.x = 5;
            maskShape.y = 8;
            _iconContain.addChild(maskShape);
            _iconContain.mask = maskShape;
            _countBack.x = 16;
            _countBack.y = 36;
            _countTxt.x = 4;
            _countTxt.y = 34;
            _lockImg.x = -4;
            _lockImg.y = -1;
            if(_overMc.fg)
            {
               _overMc.fg.gotoAndStop(2);
            }
         }
         else if(shape == 2)
         {
            _circleImg = ComponentFactory.Instance.creatCustomObject("battleSkillItemII.bigCircleImg");
            _countBack = ComponentFactory.Instance.creatBitmap("asset.battle.SkillCountBack");
            _countTxt = ComponentFactory.Instance.creatComponentByStylename("battle.SkillBigCount");
            _useCountTxt = ComponentFactory.Instance.creatComponentByStylename("battle.MarrPropCount");
            _ceNumView = new SkillItemCDNumView(44,0.6);
            _ceNumView.x = 1;
            _ceNumView.y = 3;
            maskShape = new Shape();
            maskShape.graphics.clear();
            maskShape.graphics.beginFill(0,0);
            maskShape.graphics.drawCircle(20,20,19);
            maskShape.graphics.endFill();
            _countBack.x = 21;
            _countBack.y = 43;
            maskShape.x = 9;
            maskShape.y = 9;
            _icon.x = 6;
            _icon.y = 6;
            _superSkill.x = 10;
            _superSkill.y = 10;
            _iconContain.addChild(maskShape);
            _iconContain.mask = maskShape;
            _lockImg.x = 0;
            _lockImg.y = 0;
            if(_overMc.fg)
            {
               _overMc.fg.gotoAndStop(3);
            }
         }
         else if(shape == 3)
         {
            _circleImg = ComponentFactory.Instance.creatCustomObject("battleSkillItemII.sacristy.blackCircle");
            _countBack = ComponentFactory.Instance.creatBitmap("asset.battle.SkillCountBack");
            _countTxt = ComponentFactory.Instance.creatComponentByStylename("battle.SkillBigCount");
            _useCountTxt = ComponentFactory.Instance.creatComponentByStylename("battle.MarrPropCount");
            _icon = ComponentFactory.Instance.creatCustomObject("battle.SkillSacristyItemView");
            _ceNumView = new SkillItemCDNumView(44,0.6);
            _ceNumView.x = 1;
            _ceNumView.y = 3;
            maskShape = new Shape();
            maskShape.graphics.clear();
            maskShape.graphics.beginFill(0,0);
            maskShape.graphics.drawCircle(26,26,27);
            maskShape.graphics.endFill();
            _countBack.x = 26;
            _countBack.y = 45;
            maskShape.x = 9;
            maskShape.y = 9;
            _icon.x = 6;
            _icon.y = 6;
            _superSkill.x = 10;
            _superSkill.y = 10;
            _iconContain.addChild(maskShape);
            _iconContain.mask = maskShape;
            _lockImg.x = 0;
            _lockImg.y = 0;
            _countTxt.x = 10;
            _countTxt.y = 44;
            _circleImg.visible = false;
            if(_overMc.fg)
            {
               _overMc.fg.gotoAndStop(4);
            }
         }
         else if(shape == 4)
         {
            _countBack.visible = false;
            _countTxt.visible = false;
            _ceNumView = new SkillItemCDNumView(50,1);
            scaleX = scaleY = 0.6;
         }
         else if(shape == 5)
         {
            _countBack.visible = false;
            _countTxt.visible = false;
            _ceNumView = new SkillItemCDNumView(50,1);
            if(!_disEffect)
            {
               _disEffect = new MainToolBtnGlowEffect(this);
            }
            _disEffect.play();
         }
         else
         {
            _ceNumView = new SkillItemCDNumView(50,1);
         }
      }
      
      private function initView() : void
      {
         _countTxt.selectable = false;
         if(_superSkill)
         {
            _superSkill.visible = false;
         }
         _icon.buttonMode = true;
         _downMc.visible = _downMc.mouseChildren = _downMc.mouseEnabled = false;
         _overMc.mouseChildren = _overMc.mouseEnabled = false;
         _ceNumView.mouseChildren = _ceNumView.mouseEnabled = false;
         _iconContain.container.addChild(_icon);
         if(_superSkill)
         {
            _iconContain.container.addChild(_superSkill);
         }
         addChild(_iconContain);
         addChild(_downMc);
         if(_circleImg)
         {
            addChild(_circleImg);
         }
         if(_countBack)
         {
            addChild(_countBack);
         }
         addChild(_countTxt);
         if(_useCountTxt)
         {
            addChild(_useCountTxt);
         }
      }
      
      public function setUseCount(param1:int) : void
      {
         _useCount = param1;
         if(_useCountTxt)
         {
            _useCountTxt.text = _useCount.toString();
         }
         if(_useCount <= 0)
         {
            hideCDNum();
         }
      }
      
      private function initEvent() : void
      {
         _icon.addEventListener("click",__iconClick);
         KeyboardManager.getInstance().addEventListener("keyDown",onKeyDown);
         NotificationManager.instance.addEventListener("SKILL_ENABLE",__skillEnable);
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
         KeyboardManager.getInstance().removeEventListener("keyDown",onKeyDown);
         NotificationManager.instance.removeEventListener("SKILL_ENABLE",__skillEnable);
         if(_buttonSkiner)
         {
            _buttonSkiner.onNormalView = null;
            _buttonSkiner.onOverView = null;
            _buttonSkiner.onDisableView = null;
            _buttonSkiner.onEnableView = null;
         }
      }
      
      private function __skillEnable(param1:NotificationEvent) : void
      {
         if(param1 && param1.data == true)
         {
            NotificationManager.instance.removeEventListener("SKILL_ENABLE",__skillEnable);
            _skillEnable = true;
         }
      }
      
      private function get roleInfo() : HeroRoleInfo
      {
         return BattleManager.getInstance().battleModel.selfHero;
      }
      
      private function __enable() : void
      {
         _icon.buttonMode = true;
         _icon.filters = null;
         if(_superSkill && _superSkill.visible)
         {
            _superSkill.filters = null;
         }
      }
      
      private function __disable() : void
      {
         _icon.buttonMode = false;
         _icon.filters = [UIFilter.getDarkFilter()];
         if(_superSkill && _superSkill.visible)
         {
            _superSkill.filters = _icon.filters;
         }
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
         if(_iconRemoved)
         {
            return;
         }
         var _loc2_:BattleModel = BattleManager.getInstance().battleModel;
         if(_loc2_ == null)
         {
            return;
         }
         if(BattleManager.getInstance().battleModel.battleType == 16)
         {
            return;
         }
         _loc2_.setAutoFight(2);
         if(!_buttonSkiner.enable)
         {
            return;
         }
         if(data == null)
         {
            return;
         }
         if(isCding)
         {
            return;
         }
         if(param1)
         {
            ShowTipManager.Instance.hideTip(_icon);
         }
         dispatchEvent(new BattleEvent("SKILL_CLICK_BattleEvent",data));
      }
      
      protected function onKeyDown(param1:KeyboardEvent) : void
      {
         var _loc2_:* = undefined;
         if(isLock || !_buttonSkiner.enable)
         {
            return;
         }
         if(battleModel.isChildBattle && numCount < 100)
         {
            return;
         }
         if(battleModel.battleType == 3845 && numCount < 100)
         {
            return;
         }
         if(!visible)
         {
            return;
         }
         if(_lockImg.parent)
         {
            return;
         }
         if(_numCount == 8)
         {
            if(isValidKey(param1.charCode) && data)
            {
               if(!_buttonSkiner)
               {
                  return;
               }
               if(!_skillEnable)
               {
                  return;
               }
               __iconClick(null);
            }
         }
         else if(_numCount == 9)
         {
            if(isValidKey(param1.charCode) && data)
            {
               if(!_buttonSkiner)
               {
                  return;
               }
               if(!_skillEnable)
               {
                  return;
               }
               __iconClick(null);
            }
         }
         else if(_numCount == 6 || _numCount == 7)
         {
            if(isValidKey(param1.charCode) && data)
            {
               if(!_buttonSkiner)
               {
                  return;
               }
               __iconClick(null);
            }
         }
         else if(_numCount == 18)
         {
            if(param1.charCode == _numCount + 83 && data)
            {
               if(!_buttonSkiner)
               {
                  return;
               }
               __iconClick(null);
            }
         }
         else if(_numCount >= 200 && _numCount <= 205)
         {
            if(isValidKey(param1.charCode) && data)
            {
               if(!_buttonSkiner)
               {
                  return;
               }
               __iconClick(null);
            }
         }
         else if(_numCount >= 100)
         {
            if(param1.charCode == _numCount - 52 && data)
            {
               if(!_buttonSkiner)
               {
                  return;
               }
               __iconClick(null);
            }
         }
         else if(param1.charCode == _numCount + 48 && data)
         {
            if(!_buttonSkiner)
            {
               return;
            }
            if(PlayerManager.instance.newbieProcess == 12500)
            {
               _loc2_ = DisplayLoader.Context.applicationDomain.getDefinition("mediators.NewbieBaseActionMediator") as Class;
               if(_loc2_.canEnableKeyboard && (data.TemplateId == 20711 || data.TemplateId == 30711 || data.TemplateId == 10711))
               {
                  return;
               }
            }
            __iconClick(null);
         }
      }
      
      private function isValidKey(param1:int) : Boolean
      {
         if(param1 == _shortcutChar.charCodeAt(0) || param1 == _shortcutChar.charCodeAt(0) - 32)
         {
            return true;
         }
         return false;
      }
      
      public function get isCding() : Boolean
      {
         if(!_cdEffect)
         {
            return false;
         }
         return _cdEffect.isCding;
      }
      
      public function get numCount() : int
      {
         return _numCount;
      }
      
      public function set numCount(param1:int) : void
      {
         _numCount = param1;
         if(param1 == 6)
         {
            _shortcutChar = "q";
            _countTxt.text = "Q";
         }
         else if(param1 == 7)
         {
            _shortcutChar = "e";
            _countTxt.text = "E";
            _countTxt.x = 2;
            _countTxt.y = 33;
         }
         else if(param1 == 8)
         {
            _shortcutChar = "r";
            _countTxt.text = "R";
            _countTxt.x = 6;
            _countTxt.y = 41;
         }
         else if(param1 == 9)
         {
            _shortcutChar = "f";
            _countTxt.text = "F";
            _countTxt.x = 6;
            _countTxt.y = 41;
         }
         else if(param1 == 18)
         {
            _shortcutChar = "e";
            _countTxt.text = "E";
         }
         else if(param1 >= 100 && param1 < 200)
         {
            _countTxt.text = String(param1 - 100);
         }
         else if(param1 == 200)
         {
            _shortcutChar = "b";
            _countTxt.text = "B";
         }
         else if(param1 == 201)
         {
            _shortcutChar = "n";
            _countTxt.text = "N";
         }
         else if(param1 == 202)
         {
            _shortcutChar = "u";
            _countTxt.text = "U";
         }
         else if(param1 == 203)
         {
            _shortcutChar = "h";
            _countTxt.text = "H";
         }
         else if(param1 == 204)
         {
            _shortcutChar = "i";
            _countTxt.text = "I";
         }
         else if(param1 == 205)
         {
            _shortcutChar = "j";
            _countTxt.text = "J";
         }
         else
         {
            _countTxt.text = String(param1);
         }
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      public function set data(param1:Object) : void
      {
         _data = param1;
         if(_data)
         {
            _icon.tipData = _data;
            _icon.icon = IconFactory.getTecIconByIcon(_data.Icons);
            _superSkill.visible = SkillPriorityType.isSuperSkill(_data.Priority);
         }
         else
         {
            _icon.tipData = null;
            _icon.icon = null;
            _superSkill.visible = false;
         }
      }
      
      public function cdStart(param1:int = 0, param2:int = -1) : void
      {
         if(_iconRemoved)
         {
            return;
         }
         if(_cdEffect)
         {
            _cdEffect.dispose();
         }
         if(_data.CoolDown <= 0)
         {
            return;
         }
         _cdEffect = new SkillItemCDEffect(_data.CoolDown,cdCompleteHandler,updateCDNum);
         _cdEffect.visible = false;
         _cdEffect.x = 4;
         _cdEffect.y = 4;
         _iconContain.container.addChild(_cdEffect);
         if(_disEffect)
         {
            _disEffect.stop();
         }
         if(_cdEffect)
         {
            _cdEffect.start(param1,param2);
            _cdEffect.visible = true;
            showCDNum();
         }
      }
      
      public function startAppearCD(param1:int = 0, param2:int = -1) : void
      {
         if(_iconRemoved)
         {
            return;
         }
         if(!_data)
         {
            return;
         }
         if(!_data.hasOwnProperty("AppearCD"))
         {
            return;
         }
         if(_data.AppearCD <= 0)
         {
            return;
         }
         if(_cdEffect)
         {
            if(_data.AppearCD <= _cdEffect.getLeftTime() * 1000)
            {
               return;
            }
            _cdEffect.dispose();
         }
         _cdEffect = new SkillItemCDEffect(_data.AppearCD,cdCompleteHandler,updateCDNum);
         _cdEffect.visible = false;
         _cdEffect.x = 4;
         _cdEffect.y = 4;
         _iconContain.container.addChild(_cdEffect);
         if(_cdEffect)
         {
            _cdEffect.start(param1,param2);
            _cdEffect.visible = true;
            showCDNum();
         }
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
         if(_superSkill && _superSkill.visible)
         {
            _superSkill.filters = _icon.filters;
         }
      }
      
      public function lock() : void
      {
         var _loc1_:Shape = null;
         if(_lockImg.parent)
         {
            return;
         }
         addChild(_lockImg);
         this.mouseEnabled = this.mouseChildren = false;
         _countBack.visible = false;
         _countTxt.visible = false;
         if(shape == 1)
         {
            _loc1_ = new Shape();
            _loc1_.x = -1;
            _loc1_.y = 2;
            _loc1_.graphics.clear();
            _loc1_.graphics.beginFill(0,0);
            _loc1_.graphics.drawCircle(25,25,17);
            _loc1_.graphics.endFill();
            this.mask = _loc1_;
            addChild(_loc1_);
         }
         else if(shape == 2)
         {
            _loc1_ = new Shape();
            _loc1_.x = 5;
            _loc1_.y = 5;
            _loc1_.graphics.clear();
            _loc1_.graphics.beginFill(0,0);
            _loc1_.graphics.drawCircle(25,25,20);
            _loc1_.graphics.endFill();
            this.mask = _loc1_;
            addChild(_loc1_);
         }
         else if(shape == 3)
         {
            _loc1_ = new Shape();
            _loc1_.x = 5;
            _loc1_.y = 5;
            _loc1_.graphics.clear();
            _loc1_.graphics.beginFill(0,0);
            _loc1_.graphics.drawCircle(25,25,20);
            _loc1_.graphics.endFill();
            this.mask = _loc1_;
            addChild(_loc1_);
         }
      }
      
      public function unLock() : void
      {
         this.mouseEnabled = this.mouseChildren = true;
         this.mask = null;
         _countBack.visible = true;
         _countTxt.visible = true;
         if(_lockImg && _lockImg.parent)
         {
            _lockImg.parent.removeChild(_lockImg);
         }
      }
      
      public function setDownEffect(param1:Boolean = false) : void
      {
         _downMc.visible = param1;
      }
      
      public function refresh() : void
      {
      }
      
      public function removeIcon() : void
      {
         if(_icon && _icon.parent)
         {
            _icon.parent.removeChild(_icon);
         }
         _iconRemoved = true;
         if(_overMc)
         {
            _overMc.gotoAndStop(1);
         }
      }
      
      protected function updateCDNum() : void
      {
         if(_ceNumView && _cdEffect)
         {
            _ceNumView.setNum(_cdEffect.getLeftTime());
         }
      }
      
      protected function cdCompleteHandler() : void
      {
         if(_cdEffect)
         {
            _cdEffect.visible = false;
            _cdEffect = null;
            _iconContain.gotoAndPlay(2);
            hideCDNum();
         }
         if(shape == 5)
         {
            if(_disEffect)
            {
               _disEffect.play();
            }
         }
      }
      
      public function clearCD() : void
      {
         cdCompleteHandler();
      }
      
      protected function showCDNum() : void
      {
         if(shape != 1 && shape != 2 && shape != 3 || _useCount > 0)
         {
            addChild(_ceNumView);
         }
      }
      
      private function hideCDNum() : void
      {
         if(_ceNumView && _ceNumView.parent)
         {
            _ceNumView.parent.removeChild(_ceNumView);
         }
      }
      
      public function get buttonSkiner() : ButtonSkiner
      {
         return _buttonSkiner;
      }
      
      public function get icon() : BaseIconView
      {
         return _icon;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ShowTipManager.Instance.hideTip(_icon);
         ShowTipManager.Instance.removeTip(_icon);
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_superSkill);
         _superSkill = null;
         ObjectUtils.disposeObject(_countBack);
         _countBack = null;
         ObjectUtils.disposeObject(_countTxt);
         _countTxt = null;
         ObjectUtils.disposeObject(_downMc);
         _downMc = null;
         ObjectUtils.disposeObject(_overMc);
         _overMc = null;
         ObjectUtils.disposeObject(_overMc);
         _overMc = null;
         ObjectUtils.disposeObject(_cdEffect);
         _cdEffect = null;
         ObjectUtils.disposeObject(_ceNumView);
         _ceNumView = null;
         ObjectUtils.disposeObject(_lockImg);
         _lockImg = null;
         ObjectUtils.disposeObject(_banImg);
         _banImg = null;
         if(_buttonSkiner)
         {
            _buttonSkiner.dispose();
         }
         _buttonSkiner = null;
         ObjectUtils.disposeObject(_circleImg);
         _circleImg = null;
         ObjectUtils.disposeObject(_useCountTxt);
         _useCountTxt = null;
         ObjectUtils.disposeViolentMc(_iconContain);
         _iconContain = null;
         if(maskShape)
         {
            maskShape.graphics.clear();
            if(maskShape.parent)
            {
               maskShape.parent.removeChild(maskShape);
            }
         }
         maskShape = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function get battleModel() : BattleModel
      {
         return BattleManager.getInstance().battleModel;
      }
      
      public function get banImg() : Bitmap
      {
         return _banImg;
      }
   }
}

