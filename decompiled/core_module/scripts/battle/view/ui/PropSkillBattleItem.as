package battle.view.ui
{
   import battle.BattleManager;
   import battle.events.BattleEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.events.KeyboardEvent;
   import yishi.datas.BattlePropItem;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   
   public class PropSkillBattleItem extends BattleSkillItemII
   {
      
      protected var _itemText:FilterFrameText;
      
      private var _shortcutChar:String = "";
      
      private var _currentCd:int;
      
      public var openGrade:int = 35;
      
      public function PropSkillBattleItem()
      {
         super();
         _itemText = ComponentFactory.Instance.creatComponentByStylename("core.BaseItemText");
         _itemText.y = 0;
         _iconContain.container.addChild(_itemText);
         NotificationManager.instance.addEventListener("BUFFER_SKILL_ENABLE",__bufferEnabeleHandler);
      }
      
      private function __bufferEnabeleHandler(param1:NotificationEvent) : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:Boolean = false;
         var _loc2_:Boolean = false;
         if(_data is BattlePropItem)
         {
            bufferUnEnable = roleInfo.existUnenableSkillBuffer((_data as BattlePropItem).skillTempId);
            if(bufferUnEnable)
            {
               buttonSkiner.enable = false;
               setState(1);
               addChild(_banImg);
            }
            else
            {
               _loc3_ = _data.useCount > 0;
               _loc4_ = BattleManager.getInstance().battleModel.currentReadySkillId != -1;
               _loc2_ = BattleManager.getInstance().battleModel.battleType == 25;
               if(_banImg.parent)
               {
                  removeChild(_banImg);
               }
               if(_loc4_ || !_loc3_ || _loc2_)
               {
                  return;
               }
               if(roleInfo.bloodA <= 0)
               {
                  return;
               }
               buttonSkiner.enable = true;
               setState(0);
            }
         }
      }
      
      private function get roleInfo() : HeroRoleInfo
      {
         return BattleManager.getInstance().battleModel.selfHero;
      }
      
      override public function set data(param1:Object) : void
      {
         var _loc3_:SkillTempInfo = null;
         _data = param1;
         var _loc2_:BattlePropItem = param1 as BattlePropItem;
         if(param1)
         {
            _data.addEventListener("PROP_USECOUNT_CHANGE",__countChangeHandler);
            _loc3_ = TempleteManager.instance.getSkillTemplateInfoById(_loc2_.skillTempId);
            _icon.tipData = _loc3_;
            _icon.icon = IconFactory.getTecIconByIcon(_loc3_.Icons);
            _itemText.text = _loc2_.useCount + "";
            if(_loc2_.useCount <= 0)
            {
               buttonSkiner.enable = false;
               setState(1);
            }
         }
      }
      
      private function __countChangeHandler(param1:BattleEvent) : void
      {
         if(data)
         {
            _itemText.text = data.useCount.toString();
         }
      }
      
      public function publicCdStart(param1:int = 0, param2:int = -1) : void
      {
         if((_data as BattlePropItem).useCount <= 0)
         {
            buttonSkiner.enable = false;
            setState(1);
            return;
         }
         if(_cdEffect)
         {
            _currentCd = _cdEffect.getLeftTime();
            if(_currentCd > param2 / 1000)
            {
               return;
            }
            _cdEffect.start(0,param2);
         }
         else
         {
            _cdEffect = new SkillItemCDEffect(_data.getSkillTemplate().CoolDown,cdCompleteHandler,updateCDNum);
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
      }
      
      override public function cdStart(param1:int = 0, param2:int = -1) : void
      {
         if(_iconRemoved)
         {
            return;
         }
         if((_data as BattlePropItem).useCount <= 0)
         {
            buttonSkiner.enable = false;
            setState(1);
            return;
         }
         if(_cdEffect)
         {
            _cdEffect.dispose();
         }
         if(_data.getSkillTemplate().CoolDown <= 0)
         {
            return;
         }
         _cdEffect = new SkillItemCDEffect(_data.getSkillTemplate().CoolDown,cdCompleteHandler,updateCDNum);
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
      
      override public function setState(param1:int) : void
      {
         super.setState(param1);
      }
      
      override protected function cdCompleteHandler() : void
      {
         super.cdCompleteHandler();
         if((_data as BattlePropItem).useCount <= 0)
         {
            buttonSkiner.enable = false;
            setState(1);
         }
      }
      
      public function setLock(param1:Boolean) : void
      {
         if(param1)
         {
            addChild(_lockImg);
            _countBack.visible = false;
            _countTxt.visible = false;
         }
      }
      
      override protected function onKeyDown(param1:KeyboardEvent) : void
      {
         if(data)
         {
            if(isValidKey(param1.charCode))
            {
               if(!_buttonSkiner)
               {
                  return;
               }
               __iconClick(null);
            }
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
      
      override public function set numCount(param1:int) : void
      {
         _numCount = param1;
         if(_numCount == 10)
         {
            _shortcutChar = "z";
         }
         else if(_numCount == 11)
         {
            _shortcutChar = "x";
         }
         _countTxt.text = _shortcutChar;
         if(ArmyManager.instance.thane.grades < openGrade)
         {
            lock();
         }
      }
      
      override public function removeIcon() : void
      {
         removeItemCount();
         super.removeIcon();
      }
      
      private function removeItemCount() : void
      {
         if(_itemText)
         {
            if(_itemText.parent)
            {
               _itemText.parent.removeChild(_itemText);
            }
            _itemText.dispose();
            _itemText = null;
         }
      }
      
      override public function dispose() : void
      {
         NotificationManager.instance.removeEventListener("BUFFER_SKILL_ENABLE",__bufferEnabeleHandler);
         if(_data)
         {
            _data.removeEventListener("PROP_USECOUNT_CHANGE",__countChangeHandler);
         }
         removeItemCount();
         _data = null;
         super.dispose();
      }
   }
}

