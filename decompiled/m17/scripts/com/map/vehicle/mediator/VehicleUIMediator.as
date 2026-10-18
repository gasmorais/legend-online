package com.map.vehicle.mediator
{
   import com.map.vehicle.view.VehicleBossDownTimeView;
   import com.map.vehicle.view.VehicleBottomView;
   import com.map.vehicle.view.VehicleReviveView;
   import com.map.vehicle.view.VehicleRightView;
   import com.map.vehicle.view.VehicleScreenEffectLayer;
   import com.map.vehicle.view.VehicleTeamView;
   import com.map.vehicle.view.VehicleTopView;
   import com.pickgliss.toplevel.StageReferance;
   import flash.events.Event;
   import yishi.interfaces.IMediator;
   
   public class VehicleUIMediator implements IMediator
   {
      
      private var _screenEffectView:VehicleScreenEffectLayer;
      
      private var _bottomView:VehicleBottomView;
      
      private var _topView:VehicleTopView;
      
      private var _teamView:VehicleTeamView;
      
      private var _rightView:VehicleRightView;
      
      private var _bossDownTime:VehicleBossDownTimeView;
      
      private var _riverView:VehicleReviveView;
      
      public function VehicleUIMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _screenEffectView = new VehicleScreenEffectLayer();
         _bottomView = new VehicleBottomView();
         _topView = new VehicleTopView();
         _teamView = new VehicleTeamView();
         _rightView = new VehicleRightView();
         _bossDownTime = new VehicleBossDownTimeView();
         _riverView = new VehicleReviveView();
         _screenEffectView.show();
         _rightView.show();
         _teamView.show();
         _topView.show();
         _bottomView.show();
         _bossDownTime.show();
         __resizeHandler();
         StageReferance.stage.addEventListener("resize",__resizeHandler);
      }
      
      private function __resizeHandler(param1:Event = null) : void
      {
         _screenEffectView.resize();
         _bottomView.resize();
         _topView.resize();
         _teamView.resize();
         _rightView.resize();
         _riverView.resize();
         _bossDownTime.resize();
      }
      
      public function unregister(param1:Object) : void
      {
         StageReferance.stage.removeEventListener("resize",__resizeHandler);
         _screenEffectView.dispose();
         _bottomView.dispose();
         _topView.dispose();
         _teamView.dispose();
         _rightView.dispose();
         _bossDownTime.dispose();
         _riverView.dispose();
         _bottomView = null;
         _topView = null;
         _teamView = null;
         _rightView = null;
         _screenEffectView = null;
         _bossDownTime = null;
         _riverView = null;
      }
   }
}

