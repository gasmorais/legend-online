package map.campaign.view.ui.activevehicle
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import map.campaign.data.ActiveVehicleAccountInfo;
   
   public class ActiveVehicleAccountFrame extends Frame
   {
      
      private var _topView:ActiveVehicleAccountTopView;
      
      private var _downView:ActiveVehicleAccountBottomView;
      
      private var _info:ActiveVehicleAccountInfo;
      
      public function ActiveVehicleAccountFrame()
      {
         super();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         _topView = new ActiveVehicleAccountTopView(_info);
         _downView = new ActiveVehicleAccountBottomView(_info);
         _topView.x = -3;
         _topView.y = 8;
         _downView.x = -3;
         _downView.y = 300;
         addToContent(_topView);
         addToContent(_downView);
         this.titleText = LanguageMgr.GetTranslation("ActiveVehicleAccountFrame.title.text");
      }
      
      private function addEvent() : void
      {
         this.addEventListener("response",__frameResponse);
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("response",__frameResponse);
      }
      
      public function show(param1:ActiveVehicleAccountInfo) : void
      {
         if(isDie)
         {
            return;
         }
         _info = param1;
         initView();
         LayerManager.Instance.addToLayer(this,3,true,true,2);
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_topView)
         {
            ObjectUtils.disposeObject(_topView);
         }
         _topView = null;
         if(_downView)
         {
            ObjectUtils.disposeObject(_downView);
         }
         _downView = null;
         super.dispose();
         _info = null;
      }
   }
}

