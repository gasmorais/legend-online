package planeswar.view
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import events.PlanesWarEvent;
   import flash.display.Sprite;
   import flash.events.Event;
   import mvc.module.planeswar.PlanesWarModel;
   import yishi.manager.PlanesWarManager;
   
   public class PlanesUiLayer extends Sprite implements Disposeable
   {
      
      private var topView:PlanesTopView;
      
      private var leftView:PlanesLeftView;
      
      private var rightView:PlanesRightView;
      
      private var smallMapView:PlanesSmallMapView;
      
      private var alertFrame:BaseAlerFrame;
      
      public function PlanesUiLayer()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         topView = new PlanesTopView();
         leftView = new PlanesLeftView();
         rightView = new PlanesRightView();
         smallMapView = new PlanesSmallMapView();
         addChild(topView);
         addChild(leftView);
         addChild(rightView);
         addChild(smallMapView);
         refresh(null);
         this.mouseEnabled = false;
         resize(null);
      }
      
      private function addEvent() : void
      {
         StageReferance.stage.addEventListener("resize",resize);
         PlanesWarManager.instance.addEventListener("PLANES_WARINFO_UPDATE",refresh);
      }
      
      private function refresh(param1:PlanesWarEvent) : void
      {
         topView.refreshView();
         leftView.refreshView();
         rightView.refreshView();
         smallMapView.refreshView();
      }
      
      private function resize(param1:Event) : void
      {
         topView.x = (StageReferance.stageWidth - 586) / 2;
         leftView.y = 170;
         smallMapView.x = StageReferance.stageWidth - 216;
         rightView.x = StageReferance.stageWidth - 230;
         rightView.y = smallMapView.y + 170;
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("resize",resize);
         PlanesWarManager.instance.removeEventListener("PLANES_WARINFO_UPDATE",refresh);
      }
      
      private function get model() : PlanesWarModel
      {
         return PlanesWarManager.instance.model;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(topView)
         {
            ObjectUtils.disposeObject(topView);
         }
         topView = null;
         if(leftView)
         {
            ObjectUtils.disposeObject(leftView);
         }
         leftView = null;
         if(rightView)
         {
            ObjectUtils.disposeObject(rightView);
         }
         rightView = null;
         if(smallMapView)
         {
            ObjectUtils.disposeObject(smallMapView);
         }
         smallMapView = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

