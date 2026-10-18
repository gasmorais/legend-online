package battle.view.ui
{
   import battle.BattleManager;
   import battle.events.BattleEvent;
   import com.pickgliss.ui.core.Component;
   import yishi.datas.BattleModel;
   import yishi.datas.battle.BattleCooldownModel;
   import yishi.datas.objects.HeroRoleInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.view.component.TileContainer;
   
   public class ChildCommonSkillItemListView extends Component
   {
      
      private var _enable:Boolean = false;
      
      private var controller:ChildCommonSkillItemListController;
      
      private var container:TileContainer;
      
      private var _skillItemViews:Vector.<BattleSkillItemII>;
      
      public function ChildCommonSkillItemListView()
      {
         super();
         _skillItemViews = new Vector.<BattleSkillItemII>();
         controller = new ChildCommonSkillItemListController(this);
      }
      
      public function initView(param1:Array) : void
      {
         var _loc5_:int = 0;
         var _loc2_:BattleSkillItemII = null;
         if(!battleModel)
         {
            return;
         }
         container && container.parent && container.parent.removeChild(container);
         if(_skillItemViews)
         {
            _loc5_ = 0;
            while(_loc5_ < _skillItemViews.length)
            {
               _skillItemViews[_loc5_].dispose();
               _skillItemViews[_loc5_] = null;
               _loc5_++;
            }
         }
         container = new TileContainer();
         container.x = 0;
         container.y = 0;
         container.width = 600;
         container.paddingH = 4;
         addChild(container);
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _skillItemViews = new Vector.<BattleSkillItemII>();
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            _loc2_ = new BattleSkillItemII();
            _loc2_.addEventListener("SKILL_CLICK_BattleEvent",__skillClick);
            _loc2_["data"] = param1[_loc4_] || null;
            _loc2_["numCount"] = _loc3_ + 101;
            _skillItemViews.push(_loc2_);
            if(_loc2_["data"] == null)
            {
               _loc2_.buttonSkiner.enable = false;
               _loc2_.setState(4);
               _loc2_.lock();
            }
            _loc4_++;
            container.appendItem(_loc2_,{"width":50});
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
      
      public function cdStart(param1:int, param2:int = 0, param3:int = -1, param4:int = 0) : void
      {
         var _loc5_:BattleSkillItemII = getItemViewBySkillId(param1);
         if(_loc5_)
         {
            _loc5_.cdStart(param2,param3);
         }
      }
      
      public function refreshItemState() : void
      {
         refreshForSpChanged();
      }
      
      private function getItemViewBySkillId(param1:int) : BattleSkillItemII
      {
         var _loc3_:int = 0;
         for each(var _loc2_:BattleSkillItemII in _skillItemViews)
         {
            _loc3_ = getSkillId(_loc2_.data);
            if(_loc3_ == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function getSkillId(param1:Object) : int
      {
         var _loc2_:int = -1;
         if(param1 is SkillTempInfo)
         {
            _loc2_ = int(SkillTempInfo(param1).TemplateId);
         }
         return _loc2_;
      }
      
      private function __skillClick(param1:BattleEvent) : void
      {
         for each(var _loc2_:BattleSkillItemII in _skillItemViews)
         {
            _loc2_.setDownEffect();
         }
         NotificationManager.instance.sendNotification("ACTION_SKILL_BattleNotic",param1.data);
      }
      
      public function get enable() : Boolean
      {
         return _enable;
      }
      
      public function setEnable(param1:Boolean) : void
      {
         var _loc2_:SkillTempInfo = null;
         if(param1 == _enable)
         {
            return;
         }
         _enable = param1;
         for each(var _loc3_:BattleSkillItemII in _skillItemViews)
         {
            if(!_loc3_.isLock)
            {
               if(!_enable)
               {
                  _loc3_.setDownEffect();
               }
               _loc2_ = _loc3_.data as SkillTempInfo;
               if(_loc2_)
               {
                  if(!(_enable && _loc3_.data.hasOwnProperty("useCount") && _loc3_.data.useCount <= 0))
                  {
                     _loc3_.parentEnable = _enable;
                     _loc3_.buttonSkiner.enable = _enable;
                  }
               }
            }
         }
         refreshForSpChanged();
      }
      
      public function refreshForSpChanged() : void
      {
         var _loc3_:SkillTempInfo = null;
         var _loc1_:int = 0;
         var _loc4_:HeroRoleInfo = selfInfo;
         if(!_loc4_ || _loc4_.totalBloodA <= 0)
         {
            return;
         }
         for each(var _loc2_:BattleSkillItemII in _skillItemViews)
         {
            if(!_loc2_.isLock)
            {
               _loc1_ = getSkillId(_loc2_.data);
               _loc3_ = TempleteManager.instance.getSkillTemplateInfoById(_loc1_);
               if(_loc3_)
               {
                  if(_loc3_.Priority == 3)
                  {
                     if(_enable)
                     {
                        if(_loc4_.awaken < 100)
                        {
                           _loc2_.buttonSkiner.enable = false;
                           _loc2_.setState(1);
                        }
                        else
                        {
                           _loc2_.buttonSkiner.enable = true;
                        }
                     }
                     else if(_loc4_.awaken < 100)
                     {
                        _loc2_.setState(1);
                     }
                  }
               }
            }
         }
      }
      
      private function get battleModel() : BattleModel
      {
         return BattleManager.getInstance().battleModel;
      }
      
      private function get selfInfo() : HeroRoleInfo
      {
         return battleModel.selfChildHeroInfo;
      }
      
      override public function dispose() : void
      {
         for each(var _loc1_:BattleSkillItemII in _skillItemViews)
         {
            _loc1_.removeEventListener("SKILL_CLICK_BattleEvent",__skillClick);
            _loc1_.dispose();
         }
         _skillItemViews = null;
         container = null;
         controller.dispose();
         controller = null;
         super.dispose();
      }
   }
}

