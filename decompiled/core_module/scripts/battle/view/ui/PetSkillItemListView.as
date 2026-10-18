package battle.view.ui
{
   import battle.BattleManager;
   import battle.events.BattleEvent;
   import flash.display.Sprite;
   import yishi.datas.BattleModel;
   import yishi.datas.battle.BattleCooldownModel;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.NotificationManager;
   import yishi.view.component.TileContainer;
   
   public class PetSkillItemListView extends Sprite
   {
      
      private var _enable:Boolean = false;
      
      private var controller:PetSkillItemListController;
      
      private var container:TileContainer;
      
      private var _skillItemViews:Vector.<BattleSkillItemII>;
      
      public function PetSkillItemListView()
      {
         super();
         _skillItemViews = new Vector.<BattleSkillItemII>();
         controller = new PetSkillItemListController(this);
      }
      
      public function initView(param1:Array) : void
      {
         var _loc2_:BattleSkillItemII = null;
         if(!battleModel)
         {
            return;
         }
         container = new TileContainer();
         container.x = 27;
         container.y = 4;
         container.width = 600;
         addChild(container);
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < 10)
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
            if(_loc2_["numCount"] == 110)
            {
               _loc2_["numCount"] = 100;
            }
            _loc4_++;
            container.appendItem(_loc2_,{"width":44.5});
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
      
      public function get enable() : Boolean
      {
         return _enable;
      }
      
      public function cdStart(param1:int, param2:int = 0, param3:int = -1, param4:int = 0) : void
      {
         var _loc6_:Vector.<BattleSkillItemII> = getItemViewBySkillId(param1);
         if(_loc6_.length > 0)
         {
            for each(var _loc5_:BattleSkillItemII in _loc6_)
            {
               _loc5_.cdStart(param2,param3);
            }
         }
      }
      
      public function clearCDButNotId(param1:int) : void
      {
         for each(var _loc2_:BattleSkillItemII in _skillItemViews)
         {
            if(param1 != getSkillId(_loc2_.data))
            {
               _loc2_.clearCD();
            }
         }
      }
      
      private function getItemViewBySkillId(param1:int) : Vector.<BattleSkillItemII>
      {
         var _loc4_:int = 0;
         var _loc3_:Vector.<BattleSkillItemII> = new Vector.<BattleSkillItemII>();
         for each(var _loc2_:BattleSkillItemII in _skillItemViews)
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
         return _loc3_;
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
         NotificationManager.instance.sendNotification("REMOTEPET_SKILL",param1.data);
      }
      
      public function setEnable(param1:Boolean) : void
      {
         if(param1 == _enable)
         {
            return;
         }
         _enable = param1;
         for each(var _loc2_:BattleSkillItemII in _skillItemViews)
         {
            if(!_loc2_.isLock)
            {
               if(!_enable)
               {
                  _loc2_.setDownEffect();
               }
               if(_loc2_.data)
               {
                  if(!(_enable && _loc2_.data.hasOwnProperty("useCount") && _loc2_.data.useCount <= 0))
                  {
                     _loc2_.parentEnable = _enable;
                     _loc2_.buttonSkiner.enable = _enable;
                  }
               }
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
            _loc1_.dispose();
         }
         _skillItemViews = null;
         container = null;
         controller.dispose();
         controller = null;
      }
   }
}

