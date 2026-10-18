package battle.view.ui
{
   import battle.BattleManager;
   import battle.events.BattleEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import map.campaign.CampaignManager;
   import map.campaign.data.TrailPropInfo;
   import yishi.datas.BattleModel;
   import yishi.datas.BattlePropItem;
   import yishi.datas.battle.BattleCooldownModel;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.WorldBossHelper;
   import yishi.view.component.TileContainer;
   
   public class SkillItemListView extends Sprite
   {
      
      private var _trailBack:ScaleFrameImage;
      
      private var _trailBox:HBox;
      
      private var container:TileContainer;
      
      private var petContainer:TileContainer;
      
      private var _propContainer:TileContainer;
      
      private var _sealSkillItem:BattleSkillItemII;
      
      private var _marrSkillItem:BattleSkillItemII;
      
      private var _childSkillItem:BattleSkillItemII;
      
      private var _childSkillItem2:BattleSkillItemII;
      
      private var _skillItemViews:Vector.<BattleSkillItemII>;
      
      private var _heroSkills:Vector.<BattleSkillItemII>;
      
      private var _petSkills:Vector.<BattleSkillItemII>;
      
      private var controller:SkillItemListController;
      
      private var _enable:Boolean = false;
      
      private var _addSkBg:Bitmap;
      
      private var _addHbox:HBox;
      
      private var _petSkill:Boolean;
      
      public function SkillItemListView()
      {
         super();
         _skillItemViews = new Vector.<BattleSkillItemII>();
         controller = new SkillItemListController(this);
      }
      
      public function get marrSkillItem() : BattleSkillItemII
      {
         return _marrSkillItem;
      }
      
      public function get childSkillItem() : BattleSkillItemII
      {
         return _childSkillItem;
      }
      
      public function get childSkillItem2() : BattleSkillItemII
      {
         return _childSkillItem2;
      }
      
      public function initView(param1:Array) : void
      {
         var _loc2_:DisplayObject = null;
         var _loc6_:Array = null;
         var _loc5_:Array = null;
         var _loc7_:int = 0;
         if(!battleModel)
         {
            return;
         }
         _heroSkills = new Vector.<BattleSkillItemII>();
         var _loc3_:int = 0;
         if(battleModel.isTrail() || battleModel.isRandomBoss() || battleModel.isSkyboxRoad() || battleModel.isMateLords() || battleModel.isAresLords() || battleModel.isOutyardTitan() || battleModel.isCrossGuild())
         {
            if(battleModel.selfHero)
            {
               _loc6_ = battleModel.selfHero.trialProps;
               _loc6_.sortOn("index",16);
               _trailBack = ComponentFactory.Instance.creatComponentByStylename("battle.TrailBack");
               _trailBox = ComponentFactory.Instance.creatComponentByStylename("battle.TrailPropBox");
               _loc3_ = 0;
               while(_loc3_ < _loc6_.length)
               {
                  _loc2_ = new BattleTrailPropItem();
                  _loc2_.addEventListener("SKILL_CLICK_BattleEvent",__skillClick);
                  _loc2_["data"] = _loc6_[_loc3_];
                  _trailBox.addChild(_loc2_);
                  _skillItemViews.push(_loc2_);
                  _loc3_++;
               }
               addChild(_trailBack);
               addChild(_trailBox);
               if(battleModel.isCrossGuild())
               {
                  _trailBack.setFrame(2);
                  if(_loc6_.length <= 0)
                  {
                     _trailBack.visible = false;
                  }
               }
               else
               {
                  _trailBack.setFrame(1);
                  if(_loc6_.length <= 0)
                  {
                     _trailBack.visible = false;
                  }
               }
            }
         }
         if(battleModel.battleType == 3914)
         {
            _addSkBg = ComponentFactory.Instance.creatBitmap("asset.battle.comAddSkbg");
            _addHbox = ComponentFactory.Instance.creatComponentByStylename("battle.addSkHBox");
            addChild(_addSkBg);
            addChild(_addHbox);
            _addSkBg.x = 175;
            _addSkBg.y = -43;
            _addHbox.beginChanges();
            _loc5_ = battleModel.selfHero.thessBoxSkills;
            _loc3_ = 0;
            while(_loc3_ < 3)
            {
               _loc7_ = int(_loc5_[_loc3_]);
               _loc2_ = new BattleSkillItemII(4);
               _loc2_.addEventListener("SKILL_CLICK_BattleEvent",__skillClick);
               _skillItemViews.push(_loc2_);
               _heroSkills.push(_loc2_);
               _loc2_["data"] = _loc7_ > 0 ? TempleteManager.instance.getSkillById(_loc7_) : null;
               _loc2_["numCount"] = -1;
               _addHbox.addChild(_loc2_);
               _loc3_++;
            }
            _addHbox.commitChanges();
         }
         container = new TileContainer();
         container.x = 29;
         container.y = 4;
         addChild(container);
         _propContainer = new TileContainer();
         _propContainer.x = 322;
         _propContainer.y = 4;
         addChild(_propContainer);
         var _loc4_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            _loc2_ = new BattleSkillItemII();
            _loc2_.addEventListener("SKILL_CLICK_BattleEvent",__skillClick);
            _loc2_["data"] = param1[_loc4_] || null;
            _loc2_["numCount"] = _loc3_ + 1;
            _skillItemViews.push(_loc2_);
            _heroSkills.push(_loc2_);
            _loc4_++;
            container.appendItem(_loc2_,{"width":44});
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < 2)
         {
            _loc2_ = new BattleSkillItemII(1);
            _loc2_.addEventListener("SKILL_CLICK_BattleEvent",__skillClick);
            _loc2_["data"] = param1[_loc4_] || null;
            _loc2_["numCount"] = _loc4_ + 1;
            _skillItemViews.push(_loc2_);
            _heroSkills.push(_loc2_);
            _loc4_++;
            addChild(_loc2_);
            if(_loc3_ == 0)
            {
               _sealSkillItem = _loc2_ as BattleSkillItemII;
               _sealSkillItem.x = -14;
               _sealSkillItem.y = -40;
               if(!isOpenSealSkill || CampaignManager.instance.mapModel && WorldBossHelper.checkForbiddenBoss(CampaignManager.instance.mapModel.mapId) || battleModel && battleModel.battleType == 3902 || battleModel && battleModel.battleType == 3904 || battleModel && battleModel.battleType == 3907 || battleModel && battleModel.battleType == 3905 || battleModel && battleModel.battleType == 3906)
               {
                  (_loc2_ as BattleSkillItemII).isLock = true;
                  (_loc2_ as BattleSkillItemII).buttonSkiner.enable = false;
                  (_loc2_ as BattleSkillItemII).setState(4);
               }
            }
            else if(_loc3_ == 1)
            {
               _marrSkillItem = _loc2_ as BattleSkillItemII;
               _marrSkillItem.x = 431;
               _marrSkillItem.y = -38;
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < 2)
         {
            _loc2_ = new BattleSkillItemII(2);
            _loc2_.addEventListener("SKILL_CLICK_BattleEvent",__skillClick);
            _loc2_["data"] = param1[_loc4_] || null;
            _loc2_["numCount"] = _loc4_ + 1;
            _skillItemViews.push(_loc2_);
            _heroSkills.push(_loc2_);
            _loc4_++;
            addChild(_loc2_);
            if(_loc3_ == 0)
            {
               _childSkillItem = _loc2_ as BattleSkillItemII;
               _childSkillItem.x = 584;
               _childSkillItem.y = 2;
            }
            else if(_loc3_ == 1)
            {
               _childSkillItem2 = _loc2_ as BattleSkillItemII;
               _childSkillItem2.x = 637;
               _childSkillItem2.y = 2;
            }
            if(!isOpenChildSkill)
            {
               (_loc2_ as BattleSkillItemII).isLock = true;
               (_loc2_ as BattleSkillItemII).buttonSkiner.enable = false;
               (_loc2_ as BattleSkillItemII).setState(4);
            }
            _loc3_++;
         }
         if(battleModel && battleModel.battleType == 3870)
         {
            return;
         }
         _loc3_ = 0;
         while(_loc3_ < 2)
         {
            _loc2_ = new PropSkillBattleItem();
            _loc2_.addEventListener("SKILL_CLICK_BattleEvent",__skillClick);
            PropSkillBattleItem(_loc2_).openGrade = 35 + _loc3_ * 5;
            _loc2_["data"] = param1[_loc4_] || null;
            _loc2_["numCount"] = _loc4_ + 1;
            _skillItemViews.push(_loc2_);
            _heroSkills.push(_loc2_);
            _loc4_++;
            _propContainer.appendItem(_loc2_,{"width":53});
            _loc3_++;
         }
      }
      
      public function initCD() : void
      {
         var _loc3_:int = 0;
         var _loc1_:Array = battleModel.cooldownInfo;
         if(_loc1_)
         {
            for each(var _loc2_:BattleCooldownModel in _loc1_)
            {
               _loc3_ = Math.max(_loc2_.cooldown,_loc2_.appearCoolDown);
               if(_loc3_ > 0)
               {
                  _loc2_.stop();
                  cdStart(_loc2_.templateId,0,_loc3_ * 1000);
               }
            }
         }
      }
      
      public function initPetSkills(param1:Array) : void
      {
         var _loc2_:BattleSkillItemII = null;
         var _loc3_:int = 0;
         if(!param1)
         {
            return;
         }
         _petSkills = new Vector.<BattleSkillItemII>();
         petContainer = new TileContainer();
         petContainer.x = 27;
         petContainer.y = 4;
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            _loc2_ = new BattleSkillItemII();
            _loc2_.data = param1[_loc3_];
            _loc2_.numCount = _loc3_ + 1;
            _petSkills.push(_loc2_);
            _skillItemViews.push(_loc2_);
            petContainer.appendItem(_loc2_,{"width":44});
            _loc2_.addEventListener("SKILL_CLICK_BattleEvent",__skillClick);
            _loc3_++;
         }
         addChild(petContainer);
      }
      
      public function switchSkills(param1:Boolean) : void
      {
         var _loc2_:BattleSkillItemII = null;
         var _loc3_:int = 0;
         _petSkill = param1;
         petContainer.visible = param1;
         container.visible = !param1;
         _loc3_ = 0;
         while(_loc3_ < container.numChildren)
         {
            _loc2_ = container.getChildAt(_loc3_) as BattleSkillItemII;
            if(_loc2_)
            {
               _loc2_.visible = !param1;
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < petContainer.numChildren)
         {
            _loc2_ = petContainer.getChildAt(_loc3_) as BattleSkillItemII;
            if(_loc2_)
            {
               _loc2_.visible = param1;
            }
            _loc3_++;
         }
      }
      
      public function get isOpenSealSkill() : Boolean
      {
         if(ArmyManager.instance.thane.grades < 50)
         {
            return false;
         }
         return true;
      }
      
      public function get isOpenChildSkill() : Boolean
      {
         if(ArmyManager.instance.thane.grades < 70)
         {
            return false;
         }
         return true;
      }
      
      public function startAppearCd() : void
      {
         var _loc1_:* = null;
         for each(_loc1_ in _heroSkills)
         {
            if(_loc1_.visible)
            {
               _loc1_.startAppearCD();
            }
         }
         for each(_loc1_ in _petSkills)
         {
            if(_loc1_.visible)
            {
               _loc1_.startAppearCD();
            }
         }
      }
      
      public function cdStart(param1:int, param2:int = 0, param3:int = -1, param4:int = 0) : void
      {
         var _loc7_:Boolean = false;
         var _loc6_:Vector.<BattleSkillItemII> = getItemViewBySkillId(param1);
         if(_loc6_.length > 0)
         {
            for each(var _loc5_:BattleSkillItemII in _loc6_)
            {
               if(_loc5_ is PropSkillBattleItem)
               {
                  _loc7_ = true;
               }
               _loc5_.cdStart(param2,param3);
            }
         }
         if(_loc7_)
         {
            propPublicCDStart(param1,param2,param3);
         }
      }
      
      private function propPublicCDStart(param1:int, param2:int = 0, param3:int = -1) : void
      {
         var _loc4_:int = int(TempleteManager.instance.getConfigInfoByConfigName("RuneCommonCD").ConfigValue);
         var _loc6_:Vector.<BattleSkillItemII> = new Vector.<BattleSkillItemII>();
         for each(var _loc5_:BattleSkillItemII in _skillItemViews)
         {
            if(_loc5_ is PropSkillBattleItem)
            {
               if(_loc5_.data)
               {
                  if((_loc5_.data as BattlePropItem).skillTempId != param1)
                  {
                     (_loc5_ as PropSkillBattleItem).publicCdStart(param2,_loc4_);
                  }
               }
            }
         }
      }
      
      private function __skillClick(param1:BattleEvent) : void
      {
         if(param1.currentTarget != _childSkillItem && param1.currentTarget != _childSkillItem2)
         {
            for each(var _loc2_:BattleSkillItemII in _skillItemViews)
            {
               _loc2_.setDownEffect();
            }
         }
         NotificationManager.instance.sendNotification("ACTION_SKILL_BattleNotic",param1.data);
      }
      
      private function getItemViewBySkillId(param1:int) : Vector.<BattleSkillItemII>
      {
         var _loc4_:int = 0;
         var _loc3_:Vector.<BattleSkillItemII> = new Vector.<BattleSkillItemII>();
         for each(var _loc2_:BattleSkillItemII in _skillItemViews)
         {
            if(_loc2_.data is BattlePropItem)
            {
               if((_loc2_.data as BattlePropItem).skillTempId == param1)
               {
                  _loc3_.push(_loc2_);
               }
            }
            else
            {
               _loc4_ = getSkillId(_loc2_.data);
               if(_loc4_ == param1)
               {
                  _loc3_.push(_loc2_);
               }
               if(_loc2_.data is SkillTempInfo && param1 == (_loc2_.data as SkillTempInfo).Parameter3)
               {
                  _loc3_.push(_loc2_);
               }
            }
         }
         return _loc3_;
      }
      
      private function getSkillId(param1:Object) : int
      {
         var _loc2_:int = -1;
         if(param1 is SkillTempInfo)
         {
            _loc2_ = int(SkillTempInfo(param1).TemplateId);
         }
         else if(param1 is TrailPropInfo)
         {
            _loc2_ = int(TrailPropInfo(param1).id);
         }
         return _loc2_;
      }
      
      public function get enable() : Boolean
      {
         return _enable;
      }
      
      public function setEnableForce(param1:Boolean) : void
      {
         var _loc2_:* = undefined;
         setEnable(param1);
         for each(var _loc3_:BattleSkillItemII in _skillItemViews)
         {
            if(_loc3_.data is TrailPropInfo && (_loc3_.data as TrailPropInfo).skillTemp.IsUseOnDead == 1 && (_loc3_.data as TrailPropInfo).useCount > 0)
            {
               _loc2_ = BattleManager.getInstance().getSelfRoleView();
               if(_loc2_ && _loc2_.info)
               {
                  _loc3_.buttonSkiner.enable = true;
               }
            }
         }
      }
      
      public function setBeControled() : void
      {
         for each(var _loc1_:BattleSkillItemII in _skillItemViews)
         {
            if(_loc1_.data)
            {
               _loc1_.parentEnable = false;
               _loc1_.buttonSkiner.enable = false;
               _loc1_.setState(1);
            }
         }
      }
      
      public function setEnable(param1:Boolean) : void
      {
         if(BattleManager.getInstance().battleModel.isControledByBoss())
         {
            setBeControled();
            return;
         }
         var _loc2_:HeroRoleInfo = BattleManager.getInstance().battleModel.selfHero;
         var _loc3_:Boolean = _loc2_.isWaitingChangeBody;
         if(param1 == _enable || param1 && _loc3_)
         {
            return;
         }
         _enable = param1;
         for each(var _loc4_:BattleSkillItemII in _skillItemViews)
         {
            if(!_loc4_.isLock)
            {
               if(!_enable)
               {
                  _loc4_.setDownEffect();
               }
               if(_loc4_.data)
               {
                  if(!(_enable && _loc4_.data.hasOwnProperty("useCount") && _loc4_.data.useCount <= 0))
                  {
                     if(_enable && _loc4_ == _marrSkillItem && _loc4_.data)
                     {
                        controller.updateMarrSkillItem();
                     }
                     else if(_loc4_ && (_loc4_ == _childSkillItem || _loc4_ == _childSkillItem2) && _loc4_.data)
                     {
                        controller.updateChildSkillItem();
                     }
                     else
                     {
                        _loc4_.parentEnable = _enable;
                        _loc4_.buttonSkiner.enable = _enable;
                     }
                  }
               }
            }
         }
         refreshForSpChanged();
         refreshForAwakenValueChanged();
      }
      
      public function setChildDark(param1:Boolean) : void
      {
         controller.childSkillDark = param1;
         if(param1)
         {
            if(_childSkillItem != null && _childSkillItem.data != null)
            {
               if(_childSkillItem.isLock)
               {
                  return;
               }
               _childSkillItem.setState(2);
               _childSkillItem.buttonSkiner.enable = !param1;
            }
            if(_childSkillItem2 != null && _childSkillItem2.data != null)
            {
               if(_childSkillItem2.isLock)
               {
                  return;
               }
               _childSkillItem2.setState(2);
               _childSkillItem2.buttonSkiner.enable = !param1;
            }
         }
         else
         {
            if(_childSkillItem != null && _childSkillItem.data != null)
            {
               if(_childSkillItem.isLock)
               {
                  return;
               }
               _childSkillItem.setState(0);
               _childSkillItem.buttonSkiner.enable = !param1;
            }
            if(_childSkillItem2 != null && _childSkillItem2.data != null)
            {
               if(_childSkillItem2.isLock)
               {
                  return;
               }
               _childSkillItem2.setState(0);
               _childSkillItem2.buttonSkiner.enable = !param1;
            }
         }
      }
      
      public function setChildEnable(param1:Boolean) : void
      {
         if(_childSkillItem != null && _childSkillItem.data != null)
         {
            if(param1 && _childSkillItem.data.hasOwnProperty("useCount") && _childSkillItem.data.useCount <= 0)
            {
               return;
            }
            if(_childSkillItem.isLock)
            {
               return;
            }
            if(param1 && _childSkillItem2.data.hasOwnProperty("useCount") && _childSkillItem2.data.useCount <= 0)
            {
               return;
            }
            if(_childSkillItem2.isLock)
            {
               return;
            }
            controller.updateChildSkillItem();
            _childSkillItem.parentEnable = param1;
            _childSkillItem.buttonSkiner.enable = param1;
            refreshForSpChanged();
            refreshForAwakenValueChanged();
         }
      }
      
      public function refreshForSpChanged() : void
      {
         var _loc4_:HeroRoleInfo = null;
         var _loc3_:SkillTempInfo = null;
         var _loc1_:int = 0;
         if(battleModel)
         {
            _loc4_ = battleModel.selfHero;
            if(_loc4_ && _loc4_.totalBloodA <= 0)
            {
               return;
            }
         }
         for each(var _loc2_:BattleSkillItemII in _heroSkills)
         {
            if(!_loc2_.isLock)
            {
               if(_loc2_ != _marrSkillItem)
               {
                  if(_loc2_ != _childSkillItem)
                  {
                     if(_loc2_ != _childSkillItem2)
                     {
                        _loc1_ = getSkillId(_loc2_.data);
                        _loc3_ = TempleteManager.instance.getSkillTemplateInfoById(_loc1_);
                        if(_loc3_)
                        {
                           if(_loc2_.bufferUnEnable)
                           {
                              _loc2_.buttonSkiner.enable = false;
                              _loc2_.setState(1);
                           }
                           else if(_enable)
                           {
                              if(battleModel.selfHero.sp + _loc3_.Cost < 0 || battleModel.selfHero.hitPoint + _loc3_.HitPointCost < 0)
                              {
                                 _loc2_.buttonSkiner.enable = false;
                                 _loc2_.setState(1);
                              }
                              else
                              {
                                 _loc2_.buttonSkiner.enable = true;
                              }
                           }
                           else if(battleModel.selfHero.sp + _loc3_.Cost < 0 || battleModel.selfHero.hitPoint + _loc3_.HitPointCost < 0)
                           {
                              _loc2_.setState(1);
                           }
                        }
                     }
                  }
               }
            }
         }
      }
      
      public function refreshForAwakenValueChanged() : void
      {
         var _loc4_:HeroRoleInfo = null;
         var _loc3_:SkillTempInfo = null;
         var _loc1_:int = 0;
         if(battleModel)
         {
            _loc4_ = battleModel.selfHero;
            if(_loc4_ && _loc4_.totalBloodA <= 0)
            {
               return;
            }
         }
         for each(var _loc2_:BattleSkillItemII in _petSkills)
         {
            if(!_loc2_.isLock)
            {
               _loc1_ = getSkillId(_loc2_.data);
               _loc3_ = TempleteManager.instance.getSkillTemplateInfoById(_loc1_);
               if(_loc3_)
               {
                  if(_loc2_.bufferUnEnable)
                  {
                     _loc2_.buttonSkiner.enable = false;
                     _loc2_.setState(1);
                  }
                  else if(_enable)
                  {
                     if(!_loc4_.isPetState || battleModel.selfHero.awaken + _loc3_.Cost < 0)
                     {
                        _loc2_.buttonSkiner.enable = false;
                        _loc2_.setState(1);
                     }
                     else
                     {
                        _loc2_.buttonSkiner.enable = true;
                     }
                  }
                  else if(battleModel.selfHero.awaken + _loc3_.Cost < 0)
                  {
                     _loc2_.setState(1);
                  }
               }
            }
         }
      }
      
      public function getItemView(param1:Object) : BattleSkillItemII
      {
         for each(var _loc2_:BattleSkillItemII in _skillItemViews)
         {
            if(_loc2_.data == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function removeItemByData(param1:Object) : void
      {
         for each(var _loc2_:BattleSkillItemII in _skillItemViews)
         {
            if(_loc2_.data == param1)
            {
               _loc2_.removeIcon();
               _loc2_ = null;
               break;
            }
         }
      }
      
      private function get battleModel() : BattleModel
      {
         return BattleManager.getInstance().battleModel;
      }
      
      public function dispose() : void
      {
         for each(var _loc1_:BattleSkillItemII in _skillItemViews)
         {
            _loc1_.removeEventListener("SKILL_CLICK_BattleEvent",__skillClick);
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
         for each(var _loc2_:BattleSkillItemII in _heroSkills)
         {
            _loc2_.removeEventListener("SKILL_CLICK_BattleEvent",__skillClick);
            ObjectUtils.disposeObject(_loc2_);
            _loc2_ = null;
         }
         for each(var _loc3_:BattleSkillItemII in _petSkills)
         {
            _loc3_.removeEventListener("SKILL_CLICK_BattleEvent",__skillClick);
            ObjectUtils.disposeObject(_loc3_);
            _loc3_ = null;
         }
         ObjectUtils.disposeObject(_trailBack);
         _trailBack = null;
         ObjectUtils.disposeObject(_trailBox);
         _trailBox = null;
         ObjectUtils.disposeObject(container);
         container = null;
         ObjectUtils.disposeObject(petContainer);
         petContainer = null;
         ObjectUtils.disposeObject(_propContainer);
         _propContainer = null;
         ObjectUtils.disposeObject(_sealSkillItem);
         _sealSkillItem = null;
         ObjectUtils.disposeObject(_marrSkillItem);
         _marrSkillItem = null;
         ObjectUtils.disposeObject(_childSkillItem);
         _childSkillItem = null;
         ObjectUtils.disposeObject(_childSkillItem2);
         _childSkillItem2 = null;
         if(_skillItemViews)
         {
            _skillItemViews.length = 0;
         }
         _skillItemViews = null;
         ObjectUtils.disposeObject(_addSkBg);
         _addSkBg = null;
         ObjectUtils.disposeObject(_addHbox);
         _addHbox = null;
         if(controller)
         {
            controller.dispose();
         }
         controller = null;
         if(_heroSkills)
         {
            _heroSkills.length = 0;
         }
         _heroSkills = null;
         if(_petSkills)
         {
            _petSkills.length = 0;
         }
         _petSkills = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get skillItemViews() : Vector.<BattleSkillItemII>
      {
         return _skillItemViews;
      }
   }
}

