package map.campaign.mediator.duskarea
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import map.campaign.view.ui.duskarea.DuskAreaInfoView;
   import map.campaign.view.ui.duskarea.DuskAreaSelfInfoView;
   import yishi.interfaces.IMediator;
   
   public class DuskAreaUIMediator implements IMediator
   {
      
      private var _duskAreaInfoView:DuskAreaInfoView;
      
      private var _duskAreaSelfInfoView:DuskAreaSelfInfoView;
      
      public function DuskAreaUIMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         StageReferance.stage.addEventListener("resize",__resizeHandler);
         _duskAreaInfoView = new DuskAreaInfoView();
         _duskAreaInfoView.show();
         _duskAreaSelfInfoView = new DuskAreaSelfInfoView();
         _duskAreaSelfInfoView.show();
         __resizeHandler(null);
      }
      
      public function unregister(param1:Object) : void
      {
         StageReferance.stage.removeEventListener("resize",__resizeHandler);
         ObjectUtils.disposeObject(_duskAreaInfoView);
         _duskAreaInfoView = null;
         ObjectUtils.disposeObject(_duskAreaSelfInfoView);
         _duskAreaSelfInfoView = null;
      }
      
      private function __resizeHandler(param1:Event) : void
      {
         _duskAreaInfoView.x = (StageReferance.gameStageWidth - _duskAreaInfoView.width) / 2;
         _duskAreaInfoView.y = 20;
         _duskAreaSelfInfoView.x = StageReferance.gameStageWidth - _duskAreaSelfInfoView.viewWidth;
         _duskAreaSelfInfoView.y = 270;
      }
   }
}

