package com.map.vehicle.view
{
   import com.greensock.TweenMax;
   import com.map.vehicle.data.VehicleNode;
   import com.map.vehicle.events.VehicleEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   
   public class VehicleNpcBloodStuffView extends Component
   {
      
      private var _nameTxt:FilterFrameText;
      
      private var _mc:MovieClip;
      
      private var _bloodMc:MovieClip;
      
      private var _data:VehicleNode;
      
      private var _tween:TweenMax;
      
      public function VehicleNpcBloodStuffView()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _mc = ComponentFactory.Instance.creat("asset.campaign.map.BloodAsset");
         _mc.mouseChildren = _mc.mouseEnabled = false;
         _bloodMc = _mc["bloodMc"] as MovieClip;
         _bloodMc.gotoAndStop(100);
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("core.NpcNameText");
         _nameTxt.selectable = _nameTxt.mouseEnabled = _nameTxt.mouseWheelEnabled = false;
         addChild(_mc);
         addChild(_nameTxt);
      }
      
      private function layout() : void
      {
         _mc.y = -_mc.height;
         _nameTxt.x = -_nameTxt.width / 2;
         _nameTxt.y = -_mc.height - _nameTxt.textHeight;
      }
      
      public function get data() : VehicleNode
      {
         return _data;
      }
      
      public function set data(param1:VehicleNode) : void
      {
         _data = param1;
         _nameTxt.text = _data.name;
         if(data.nameColor > 0)
         {
            _nameTxt.setFrame(data.nameColor);
         }
         layout();
         addEvent();
         __updateBloodHandler();
      }
      
      private function addEvent() : void
      {
         _data.addEventListener("updateNode",__updateBloodHandler);
      }
      
      private function removeEvent() : void
      {
         if(_data)
         {
            _data.removeEventListener("updateNode",__updateBloodHandler);
         }
      }
      
      private function __updateBloodHandler(param1:VehicleEvent = null) : void
      {
         var _loc2_:int = 0;
         if(_bloodMc)
         {
            killTweens();
            _loc2_ = data.hp * 100 / data.totalHp;
            if(_loc2_ != _bloodMc.currentFrame)
            {
               _tween = TweenMax.to(_bloodMc,0.7,{
                  "delay":0.7,
                  "frame":_loc2_,
                  "onComplete":killTweens
               });
            }
         }
      }
      
      private function killTweens() : void
      {
         if(_tween)
         {
            _tween.kill();
            _tween = null;
         }
      }
      
      override public function dispose() : void
      {
         killTweens();
         removeEvent();
         _bloodMc = null;
         ObjectUtils.disposeViolentMc(_mc);
         _mc = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         super.dispose();
      }
   }
}

