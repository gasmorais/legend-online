package com.map.vehicle.view
{
   import com.map.vehicle.data.PlayerVehicleInfo;
   import com.map.vehicle.data.VGlobal;
   import com.map.vehicle.events.VehicleEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Component;
   import flash.display.Bitmap;
   import flash.events.Event;
   
   public class VehicleReviveView extends Component
   {
      
      private var _back:Bitmap;
      
      private var _text:Bitmap;
      
      private var _countTime:VehicleDownTimeView;
      
      private var _data:PlayerVehicleInfo;
      
      public function VehicleReviveView()
      {
         this.visible = false;
         super();
         this.mouseEnabled = mouseChildren = false;
      }
      
      override protected function init() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.vehiclemap.RevierBack");
         _text = ComponentFactory.Instance.creatBitmap("asset.vehiclemap.RevierTxt");
         _text.x = -5;
         _text.y = 8;
         _countTime = new VehicleDownTimeView();
         _countTime.x = 155;
         _countTime.y = -22;
         addChild(_back);
         addChild(_text);
         addChild(_countTime);
         if(VGlobal.model.selfVehicleInfo)
         {
            this.data = VGlobal.model.selfVehicleInfo;
         }
         else
         {
            VGlobal.model.addEventListener("addPlayer",__addPlayerHandler);
         }
      }
      
      private function __addPlayerHandler(param1:VehicleEvent) : void
      {
         if(VGlobal.model.selfVehicleInfo)
         {
            VGlobal.model.removeEventListener("addPlayer",__addPlayerHandler);
            this.data = VGlobal.model.selfVehicleInfo;
         }
      }
      
      public function get data() : PlayerVehicleInfo
      {
         return _data;
      }
      
      public function set data(param1:PlayerVehicleInfo) : void
      {
         if(!_data)
         {
            _data = param1;
            addEvent();
            if(_data.rebornTime > 0)
            {
               show();
            }
         }
      }
      
      private function addEvent() : void
      {
         if(_data)
         {
            _data.addEventListener("DIE_COUNT",__startCountHandler);
            _data.addEventListener("REVIER",__countCompleteHandler);
         }
         if(_countTime)
         {
            _countTime.addEventListener("complete",__countCompleteHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_data)
         {
            _data.removeEventListener("DIE_COUNT",__startCountHandler);
            _data.removeEventListener("REVIER",__countCompleteHandler);
         }
         if(_countTime)
         {
            _countTime.removeEventListener("complete",__countCompleteHandler);
         }
      }
      
      private function __countCompleteHandler(param1:Event) : void
      {
         hide();
      }
      
      private function __startCountHandler(param1:VehicleEvent) : void
      {
         if(_data.rebornTime > 0)
         {
            show();
         }
      }
      
      public function show() : void
      {
         if(visible)
         {
            return;
         }
         this.visible = true;
         _countTime.count = _data.rebornTime;
         resize();
         LayerManager.Instance.addToLayer(this,4,false,false,0,0);
      }
      
      private function hide() : void
      {
         this.visible = false;
         if(_data)
         {
            _data.rebornTime = 0;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function resize() : void
      {
         var _loc1_:int = int(StageReferance.stageWidth);
         var _loc2_:int = int(StageReferance.stageHeight);
         this.x = (_loc1_ - 278) / 2;
         this.y = 140;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
      }
   }
}

