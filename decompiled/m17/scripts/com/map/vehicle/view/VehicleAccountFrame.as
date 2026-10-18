package com.map.vehicle.view
{
   import com.map.vehicle.data.VehicleAccountInfo;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import manager.LanguageMgr;
   
   public class VehicleAccountFrame extends Frame
   {
      
      private var _topView:VehicleAccountTopView;
      
      private var _downView:VehicleAccountBottomView;
      
      private var _info:VehicleAccountInfo;
      
      public function VehicleAccountFrame()
      {
         super();
         addEvent();
      }
      
      private function initView() : void
      {
         _topView = new VehicleAccountTopView(_info);
         _downView = new VehicleAccountBottomView(_info);
         _topView.x = -3;
         _topView.y = 8;
         _downView.x = -3;
         _downView.y = 300;
         addToContent(_topView);
         addToContent(_downView);
         this.titleText = LanguageMgr.GetTranslation("vehicle.sortTitle");
      }
      
      private function uintView() : void
      {
         if(_topView)
         {
            _topView.dispose();
         }
         if(_downView)
         {
            _downView.dispose();
         }
         _topView = null;
         _downView = null;
      }
      
      private function addEvent() : void
      {
         this.addEventListener("response",__frameResponse);
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("response",__frameResponse);
      }
      
      public function show(param1:VehicleAccountInfo) : void
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
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uintView();
         super.dispose();
         _info = null;
      }
   }
}

