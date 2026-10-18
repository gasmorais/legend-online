package crisis.ui
{
   import com.pickgliss.utils.ObjectUtils;
   import crisis.ui.item.PlaneCrisisPointItem;
   import events.ObjectsEvent;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import map.internals.utils.ArmySpeedUtils;
   import map.internals.view.hero.AvatarBaseView;
   import mvc.module.crisis.PlaneCrisisArmy;
   import mvc.module.crisis.PlaneCrisisModel;
   import mvc.module.crisis.PlaneCrisisPlayerInfo;
   import yishi.ai.BaseArmyAiInfo;
   import yishi.datas.ai.AIBaseInfo;
   import yishi.datas.templates.PlaneCrisisTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.PlaneCrisisManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   
   public class PlaneCrisisWarkLayer extends Sprite implements IEnterFrame
   {
      
      private var _items:Dictionary;
      
      private var _gray:Array;
      
      public function PlaneCrisisWarkLayer()
      {
         super();
         init();
         addEvent();
      }
      
      private function init() : void
      {
         _gray = [UIFilter.getGrayFilter()];
         _items = model.armyViewDic;
         this.mouseEnabled = false;
         this.mouseChildren = false;
         initTeamArmys();
      }
      
      private function addEvent() : void
      {
         EnterFrameManager.instance.registeEnterFrame(this);
         model.addEventListener("PlaneCrisisEventType.addArmy",addArmyHandler);
         model.addEventListener("PlaneCrisisEventType.removeArmy",removeArmyHandler);
         model.addEventListener("PlaneCrisisEventType.updatePlayerInfo",updateAvaterHandler);
      }
      
      private function removeEvent() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         model.removeEventListener("PlaneCrisisEventType.addArmy",addArmyHandler);
         model.removeEventListener("PlaneCrisisEventType.removeArmy",removeArmyHandler);
         model.removeEventListener("PlaneCrisisEventType.updatePlayerInfo",updateAvaterHandler);
      }
      
      private function updateAvaterHandler(param1:Event) : void
      {
         var _loc2_:PlaneCrisisArmyView = null;
         var _loc3_:Dictionary = model.planeCrisisInfoDic;
         for each(var _loc4_:PlaneCrisisPlayerInfo in _loc3_)
         {
            _loc2_ = model.armyViewDic[_loc4_.userId];
            if(_loc2_ != null)
            {
               if(_loc4_.isOffline)
               {
                  _loc2_.filters = _gray;
               }
               else
               {
                  _loc2_.filters = null;
               }
            }
         }
      }
      
      private function addArmyHandler(param1:NotificationEvent) : void
      {
         var _loc2_:PlaneCrisisArmyView = null;
         var _loc3_:PlaneCrisisPlayerInfo = param1.data as PlaneCrisisPlayerInfo;
         if(_loc3_ != null && _loc3_.armyData != null)
         {
            _loc2_ = _items[_loc3_.userId];
            if(_loc2_ == null)
            {
               _loc2_ = createArmy(_loc3_.armyData);
               addChild(_loc2_);
               _items[_loc3_.userId] = _loc2_;
            }
         }
      }
      
      private function removeArmyHandler(param1:NotificationEvent) : void
      {
         var _loc2_:PlaneCrisisArmyView = null;
         var _loc3_:PlaneCrisisPointItem = null;
         var _loc4_:PlaneCrisisPlayerInfo = param1.data as PlaneCrisisPlayerInfo;
         if(_loc4_ != null)
         {
            _loc2_ = _items[_loc4_.userId];
            if(_loc2_ != null)
            {
               delete _items[_loc4_.userId];
               _loc2_.removeEventListener("walkOver",__warkOverHandler);
               _loc3_ = model.nodeItemDic[_loc4_.standNodeId];
               if(_loc3_ != null)
               {
                  _loc3_.showTeams();
               }
               ObjectUtils.disposeObject(_loc2_);
            }
         }
      }
      
      private function __warkOverHandler(param1:ObjectsEvent) : void
      {
         var _loc2_:PlaneCrisisArmyView = param1.target as PlaneCrisisArmyView;
         if(_loc2_ != selftArmy)
         {
            return;
         }
         model.commitPersonPostion(_loc2_.data.userId);
         _loc2_.data.isMoving = false;
         PlaneCrisisManager.Instance.gameOp(2,_loc2_.data.standNodeId);
      }
      
      private function get model() : PlaneCrisisModel
      {
         return PlaneCrisisManager.Instance.model;
      }
      
      private function get selftArmy() : PlaneCrisisArmyView
      {
         var _loc1_:int = int(PlayerManager.instance.currentPlayerModel.playerInfo.userId);
         return _items[_loc1_];
      }
      
      private function initTeamArmys() : void
      {
         var _loc2_:PlaneCrisisArmyView = null;
         var _loc1_:PlaneCrisisArmy = null;
         for each(var _loc3_:PlaneCrisisPlayerInfo in model.planeCrisisInfoDic)
         {
            _loc1_ = _loc3_.armyData;
            if(_loc1_ != null)
            {
               _loc2_ = createArmy(_loc1_);
               if(_loc3_.isOffline)
               {
                  _loc2_.filters = _gray;
               }
               addChild(_loc2_);
               _items[_loc1_.userId] = _loc2_;
            }
         }
      }
      
      private function createArmy(param1:PlaneCrisisArmy) : PlaneCrisisArmyView
      {
         var _loc2_:PlaneCrisisArmyView = new PlaneCrisisArmyView();
         var _loc4_:AIBaseInfo = new BaseArmyAiInfo();
         _loc4_.speed = ArmySpeedUtils.getMoveSpeed(param1);
         _loc2_.info = _loc4_;
         _loc2_.data = param1;
         _loc2_.filter = null;
         _loc2_.mouseChildren = false;
         _loc2_.mouseEnabled = false;
         var _loc3_:PlaneCrisisTempInfo = TempleteManager.instance.planeCrisisTempCate.getNodeTempInfo(model.currMapId,param1.standNodeId);
         if(_loc3_)
         {
            _loc2_.x = _loc3_.X;
            _loc2_.y = _loc3_.Y;
         }
         _loc2_.addEventListener("walkOver",__warkOverHandler);
         return _loc2_;
      }
      
      public function enterFrame() : void
      {
         if(!_items)
         {
            return;
         }
         for each(var _loc1_:AvatarBaseView in _items)
         {
            _loc1_.execute();
            if(!_loc1_.isLiving)
            {
               if(_loc1_)
               {
                  _loc1_.dispose();
               }
               _loc1_ = null;
            }
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         for each(var _loc1_:PlaneCrisisArmyView in _items)
         {
            _loc1_.removeEventListener("walkOver",__warkOverHandler);
            ObjectUtils.disposeObject(_loc1_);
         }
         if(parent)
         {
            parent.removeChild(this);
         }
         _items = null;
         _gray = null;
      }
   }
}

