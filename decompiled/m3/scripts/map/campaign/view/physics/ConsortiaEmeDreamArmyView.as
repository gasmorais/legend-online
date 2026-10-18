package map.campaign.view.physics
{
   import events.ArmyEvent;
   import flash.display.Sprite;
   import flash.geom.Point;
   import map.campaign.action.ConsortiaEmeDreamArmyDannyAction;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.skill.MapBuffHurtData;
   import yishi.interfaces.IAction;
   import yishi.manager.ActionQueueManager;
   import yishi.utils.AsynActionManager;
   
   public class ConsortiaEmeDreamArmyView extends CampaignArmyView
   {
      
      private var _actionQueue:ActionQueueManager;
      
      private var _asynActionMgr:AsynActionManager;
      
      private var _effectLayer:Sprite;
      
      public function ConsortiaEmeDreamArmyView()
      {
         super();
         _actionQueue = new ActionQueueManager();
         _asynActionMgr = new AsynActionManager();
      }
      
      override public function execute() : void
      {
         if(_actionQueue)
         {
            _actionQueue.update();
         }
         if(_asynActionMgr)
         {
            _asynActionMgr.update();
         }
         super.execute();
      }
      
      public function addAction(param1:IAction, param2:Boolean = false) : void
      {
         if(!_actionQueue || !_asynActionMgr)
         {
            return;
         }
         if(param2)
         {
            _asynActionMgr.addAction(param1);
         }
         else
         {
            _actionQueue.addAction(param1);
         }
      }
      
      override protected function addEvent() : void
      {
         if(_data)
         {
            _data.addEventListener("ADD_BUFF",__onAddBuffHandler);
         }
         super.addEvent();
      }
      
      override protected function removeEvent() : void
      {
         if(_data)
         {
            _data.removeEventListener("ADD_BUFF",__onAddBuffHandler);
         }
         super.removeEvent();
      }
      
      private function __onAddBuffHandler(param1:ArmyEvent) : void
      {
         var _loc2_:MapBuffHurtData = param1.data as MapBuffHurtData;
         addArmyDannyAction(_loc2_);
      }
      
      private function addArmyDannyAction(param1:MapBuffHurtData) : void
      {
         var _loc2_:ConsortiaEmeDreamArmyDannyAction = new ConsortiaEmeDreamArmyDannyAction(data,param1);
         addAction(_loc2_,true);
      }
      
      override public function set data(param1:CampaignArmy) : void
      {
         var _loc2_:MapBuffHurtData = null;
         if(!_effectLayer)
         {
            _effectLayer = new Sprite();
            _effectLayer.mouseChildren = _effectLayer.mouseEnabled = false;
            addChild(_effectLayer);
         }
         super.data = param1;
         if(data.emeDreamBuffList && data.emeDreamBuffList.length > 0)
         {
            _loc2_ = data.emeDreamBuffList[0];
            addArmyDannyAction(_loc2_);
         }
      }
      
      override protected function layoutTxtViewWithNamePosY() : void
      {
         super.layoutTxtViewWithNamePosY();
         addChild(_effectLayer);
         data.dispatchEvent(new ArmyEvent("LAYOUT",this));
      }
      
      public function get effectLayer() : Sprite
      {
         return _effectLayer;
      }
      
      public function getHeadPos() : Point
      {
         var _loc1_:Point = new Point();
         _loc1_.y = _showNamePosY;
         return _loc1_;
      }
      
      public function getHitPoint() : Point
      {
         return new Point(this.x,this.y);
      }
   }
}

