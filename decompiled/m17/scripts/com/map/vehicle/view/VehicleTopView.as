package com.map.vehicle.view
{
   import com.map.vehicle.VehicleModel;
   import com.map.vehicle.events.VehicleEvent;
   import com.map.vehicle.net.VehicleSocketManager;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.Bitmap;
   import flash.events.Event;
   
   public class VehicleTopView extends Component
   {
      
      private var _back:Bitmap;
      
      private var _blueFlag:Bitmap;
      
      private var _blueTxt:FilterFrameText;
      
      private var _countTime:VehicleDownTimeView;
      
      private var _countTimeBg:Bitmap;
      
      private var _model:VehicleModel = VehicleSocketManager.instance.model;
      
      private var _redFlag:Bitmap;
      
      private var _redTxt:FilterFrameText;
      
      private var _started:Boolean = false;
      
      public function VehicleTopView()
      {
         super();
         this.width = 342;
         this.height = 35;
         initView();
         addEvent();
         mouseChildren = mouseEnabled = false;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uintView();
         if(_countTime)
         {
            _countTime.dispose();
         }
         _countTime = null;
         super.dispose();
      }
      
      public function resize() : void
      {
         var _loc1_:int = int(StageReferance.stageWidth);
         var _loc2_:int = int(StageReferance.stageHeight);
         this.x = (_loc1_ - this.width) / 2;
         this.y = 0;
      }
      
      public function show() : void
      {
         resize();
         LayerManager.Instance.addToLayer(this,4,false,false,0,0);
      }
      
      private function __completeHandler(param1:Event) : void
      {
         _countTime.removeEventListener("complete",__completeHandler);
         _model.remainsTime = 0;
      }
      
      private function __scoreChangeHandler(param1:VehicleEvent) : void
      {
         update();
      }
      
      private function addEvent() : void
      {
         if(_model)
         {
            _model.addEventListener("SCORE_CHANGE",__scoreChangeHandler);
         }
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.vehiclemap.TopBack");
         _redFlag = ComponentFactory.Instance.creatBitmap("asset.vehiclemap.RedFlag");
         _blueFlag = ComponentFactory.Instance.creatBitmap("asset.vehiclemap.BlueFlag");
         _redTxt = ComponentFactory.Instance.creatComponentByStylename("vehiclemap.redScoreTxt");
         _blueTxt = ComponentFactory.Instance.creatComponentByStylename("vehiclemap.blueScoreTxt");
         _countTimeBg = ComponentFactory.Instance.creatBitmap("asset.vehiclemap.TeamCountBack");
         _countTime = new VehicleDownTimeView(2);
         _countTime.x = 70;
         _countTime.y = 10;
         addChild(_back);
         addChild(_redFlag);
         addChild(_blueFlag);
         addChild(_redTxt);
         addChild(_blueTxt);
         addChild(_countTimeBg);
         addChild(_countTime);
         _countTimeBg.x = -7;
         _redFlag.x = 70;
         _blueFlag.x = 174;
         _countTimeBg.visible = false;
         _countTime.visible = false;
         update();
      }
      
      private function removeEvent() : void
      {
         if(_model)
         {
            _model.removeEventListener("SCORE_CHANGE",__scoreChangeHandler);
         }
         if(_countTime)
         {
            _countTime.removeEventListener("complete",__completeHandler);
         }
      }
      
      private function uintView() : void
      {
         _back = null;
         _redFlag = null;
         _blueFlag = null;
         _redTxt = null;
         _blueTxt = null;
      }
      
      private function update() : void
      {
         _redTxt.text = String(_model.redScore);
         _blueTxt.text = String(_model.blueScore);
         if(_model.remainsTime > 0)
         {
            if(!_started)
            {
               _started = true;
               _countTime.visible = true;
               _countTimeBg.visible = true;
               _countTime.count = _model.remainsTime;
               _countTime.addEventListener("complete",__completeHandler);
            }
         }
      }
   }
}

