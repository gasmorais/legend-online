package com.map.vehicle.view
{
   import com.map.vehicle.VehicleModel;
   import com.map.vehicle.data.VGlobal;
   import com.map.vehicle.events.VehicleEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Component;
   import flash.events.Event;
   import map.internals.effect.RedScreen;
   
   public class VehicleScreenEffectLayer extends Component
   {
      
      private var _redScreen:RedScreen = new RedScreen();
      
      private var _model:VehicleModel = VGlobal.model;
      
      public function VehicleScreenEffectLayer()
      {
         this.mouseChildren = this.mouseEnabled = false;
         super();
         if(_model.selfVehicleInfo)
         {
            addEvent();
         }
         else
         {
            _model.addEventListener("addPlayer",__addPlayerHandler);
         }
      }
      
      private function __addPlayerHandler(param1:Event) : void
      {
         if(_model.selfVehicleInfo)
         {
            _model.removeEventListener("addPlayer",__addPlayerHandler);
            addEvent();
         }
      }
      
      private function addEvent() : void
      {
         if(_model.selfVehicleInfo)
         {
            __checkRedScreenHandler();
            _model.selfVehicleInfo.addEventListener("update_hp",__checkRedScreenHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_model)
         {
            _model.removeEventListener("addPlayer",__addPlayerHandler);
            if(_model.selfVehicleInfo)
            {
               _model.selfVehicleInfo.removeEventListener("update_hp",__checkRedScreenHandler);
            }
         }
      }
      
      private function __checkRedScreenHandler(param1:VehicleEvent = null) : void
      {
         if(!_model.selfVehicleInfo)
         {
            return;
         }
         if(_model.selfVehicleInfo.hp <= _model.selfVehicleInfo.totalHp * 0.2 && _model.selfVehicleInfo.hp > 0)
         {
            if(!_redScreen.parent)
            {
               addChild(_redScreen);
               _redScreen.play();
            }
         }
         else if(_redScreen.parent)
         {
            removeChild(_redScreen);
            _redScreen.stop();
         }
      }
      
      public function show() : void
      {
         resize();
         LayerManager.Instance.addToLayer(this,4);
      }
      
      public function resize() : void
      {
         var _loc1_:int = int(StageReferance.stageWidth);
         var _loc2_:int = int(StageReferance.stageHeight);
         if(_redScreen)
         {
            _redScreen.resize(_loc1_,_loc2_);
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_redScreen)
         {
            _redScreen.dispose();
            _redScreen = null;
         }
         super.dispose();
      }
   }
}

