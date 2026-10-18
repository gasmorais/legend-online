package map.campaign.view.physics
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import flash.events.MouseEvent;
   import map.internals.view.physics.MapPhysicsBase;
   import mvc.module.monopoly.MonopolyNodeInfo;
   import yishi.manager.PathManager;
   
   public class MonopolyEventView extends MapPhysicsBase
   {
      
      private var _eventIcon:ScaleFrameImage;
      
      private var _monopolyNodeInfo:MonopolyNodeInfo;
      
      public function MonopolyEventView(param1:MonopolyNodeInfo)
      {
         super();
         _monopolyNodeInfo = param1;
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
         if(_monopolyNodeInfo.type == 2)
         {
            return PathManager.solveCampaignMovieByUrl("images/chest.swf");
         }
         return null;
      }
      
      override protected function initView() : void
      {
         _eventIcon = ComponentFactory.Instance.creatComponentByStylename("monopoly.EventIcon");
         _eventIcon.visible = false;
         _eventIcon.setFrame(1);
         _eventIcon.x = -60;
         _eventIcon.y = -30;
         movie.addChild(_eventIcon);
         switch(int(_monopolyNodeInfo.type) - 1)
         {
            case 0:
               _eventIcon.visible = true;
               _eventIcon.setFrame(3);
               break;
            case 2:
               _eventIcon.visible = true;
               _eventIcon.setFrame(5);
               break;
            case 3:
               _eventIcon.visible = true;
               _eventIcon.setFrame(4);
               break;
            case 8:
               _eventIcon.visible = true;
               _eventIcon.setFrame(1);
               break;
            case 9:
               _eventIcon.visible = true;
               _eventIcon.setFrame(2);
               break;
            default:
               _eventIcon.visible = false;
         }
      }
      
      override protected function setHideView() : void
      {
         this.visible = false;
      }
   }
}

