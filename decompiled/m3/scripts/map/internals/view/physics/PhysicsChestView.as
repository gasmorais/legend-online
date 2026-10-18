package map.internals.view.physics
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.ShowTipManager;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getTimer;
   import map.campaign.CampaignManager;
   import map.campaign.view.fall.BattleFallGoodsView;
   import map.internals.data.CampaignNode;
   import map.internals.data.ChestInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   
   public class PhysicsChestView extends MapPhysicsBase
   {
      
      private var _goods:Array;
      
      private var _isOpen:Boolean;
      
      private var _time:int;
      
      public function PhysicsChestView(param1:Array)
      {
         super();
         _goods = param1;
         this.mouseChildren = false;
         tipStyle = "tips.MapPhysicsTip";
         tipDirctions = "4,6,5,7";
         isFollowMouse = false;
         ShowTipManager.Instance.removeTip(this);
         this.addEventListener("rollOver",__rollOverHandler);
         this.addEventListener("rollOut",__rollOutHandler);
      }
      
      public function set goods(param1:Array) : void
      {
         _goods = param1;
      }
      
      private function __rollOverHandler(param1:MouseEvent) : void
      {
         StageReferance.stage.addEventListener("click",mouseClickHandler);
      }
      
      private function __rollOutHandler(param1:MouseEvent) : void
      {
         StageReferance.stage.removeEventListener("click",mouseClickHandler);
      }
      
      override protected function updateView() : void
      {
         var _loc1_:BattleFallGoodsView = null;
         var _loc2_:int = int(info.info.state);
         super.updateView();
         if(_loc2_ == 9)
         {
            if(!this.visible)
            {
               return;
            }
            NotificationManager.instance.dispatchEvent(new NotificationEvent("OPEN_CHEST_BOX",null));
            _loc1_ = new BattleFallGoodsView(disposeCall);
            _loc1_.nodeInfo = info;
            _isOpen = true;
            _loc1_.arrayData = _goods;
            LayerManager.Instance.addToLayer(_loc1_,3,true,true,2);
            _loc1_.posX = (info.info as ChestInfo).nodePosX;
            _loc1_.posY = (info.info as ChestInfo).nodePosY;
            _loc1_.signId = (info.info as ChestInfo).signId;
            this.visible = false;
         }
         else if(_loc2_ == 8)
         {
            this.visible = false;
         }
         else
         {
            this.visible = true;
         }
      }
      
      private function disposeCall() : void
      {
         _isOpen = false;
      }
      
      override public function mouseClickHandler(param1:MouseEvent) : Boolean
      {
         var _loc4_:int = getTimer();
         if(_loc4_ - _time < 30)
         {
            return false;
         }
         _time = _loc4_;
         var _loc3_:Object = CampaignManager.instance.controller.getArmyView(CampaignManager.instance.mapModel.selfMemberData);
         var _loc2_:int = Point.distance(new Point(_loc3_.x,_loc3_.y),new Point(x,y));
         if(_loc2_ > 100)
         {
            CampaignManager.instance.controller.moveArmyByPos(this.x,this.y);
            return true;
         }
         info.info.state = 9;
         info.commit();
         return true;
      }
      
      override protected function get resourcesPath() : String
      {
         if(info.info.types == 201)
         {
            return PathManager.solveCampaignMovieByUrl(info.info.names);
         }
         return PathManager.solveMapPhysicsBySonType((info as CampaignNode).sonType);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this.removeEventListener("rollOver",__rollOverHandler);
         this.removeEventListener("rollOut",__rollOutHandler);
         StageReferance.stage.removeEventListener("click",mouseClickHandler);
      }
   }
}

