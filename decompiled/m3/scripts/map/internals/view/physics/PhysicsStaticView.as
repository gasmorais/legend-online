package map.internals.view.physics
{
   import flash.events.MouseEvent;
   import map.internals.data.CampaignNode;
   import yishi.manager.PathManager;
   
   public class PhysicsStaticView extends MapPhysicsBase
   {
      
      public function PhysicsStaticView()
      {
         super();
         this.mouseChildren = this.mouseEnabled = false;
      }
      
      override public function mouseOverHandler(param1:MouseEvent) : Boolean
      {
         return false;
      }
      
      override public function mouseOutHandler(param1:MouseEvent) : Boolean
      {
         return false;
      }
      
      override public function mouseClickHandler(param1:MouseEvent) : Boolean
      {
         return false;
      }
      
      override protected function get resourcesPath() : String
      {
         if(info.info.types == 201)
         {
            return PathManager.solveCampaignMovieByUrl(info.info.names);
         }
         return PathManager.solveMapPhysicsBySonType((info as CampaignNode).sonType);
      }
      
      override protected function initView() : void
      {
         var _loc1_:CampaignNode = info as CampaignNode;
         if(_loc1_ && !parent && _loc1_.preParent)
         {
            _loc1_.preParent.addChildAt(this,0);
         }
      }
      
      override protected function setHideView() : void
      {
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

