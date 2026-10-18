package com.map.vehicle.view
{
   import com.map.vehicle.data.PlayerVehicleInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   
   public class VehicleSortItemView extends Component
   {
      
      private var _data:PlayerVehicleInfo;
      
      private var _flag:ScaleFrameImage;
      
      private var _index:int;
      
      private var _nameTxt:FilterFrameText;
      
      private var _numTxt:FilterFrameText;
      
      private var _scoreTxt:FilterFrameText;
      
      public function VehicleSortItemView(param1:int)
      {
         super();
         _index = param1;
         this.height = 25;
         this.mouseChildren = this.mouseEnabled = false;
         initView();
      }
      
      public function get data() : PlayerVehicleInfo
      {
         return _data;
      }
      
      public function set data(param1:PlayerVehicleInfo) : void
      {
         _data = param1;
         if(_data && _data.name)
         {
            _numTxt.text = String(_index) + ".";
            _nameTxt.text = _data.name;
            _scoreTxt.text = String(_data.score);
            _flag.visible = true;
            _flag.setFrame(_data.team);
            if(_index >= 4)
            {
               _numTxt.setFrame(4);
               _nameTxt.setFrame(4);
               _scoreTxt.setFrame(4);
            }
            else
            {
               _numTxt.setFrame(_index);
               _nameTxt.setFrame(_index);
               _scoreTxt.setFrame(_index);
            }
         }
         else
         {
            _numTxt.text = "";
            _nameTxt.text = "";
            _scoreTxt.text = "";
            _flag.visible = false;
         }
      }
      
      override public function dispose() : void
      {
         uintView();
         super.dispose();
      }
      
      private function initView() : void
      {
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("vehiclemap_right.numTxt");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("vehiclemap_right.nameTxt");
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("vehiclemap_right.scoreTxt");
         _flag = ComponentFactory.Instance.creatComponentByStylename("vehiclemap.teamFlag");
         _flag.width = _flag.height = 20;
         _flag.x = 7;
         _flag.y = 0;
         addChild(_numTxt);
         addChild(_flag);
         addChild(_nameTxt);
         addChild(_scoreTxt);
      }
      
      private function uintView() : void
      {
         _numTxt = null;
         _nameTxt = null;
         _scoreTxt = null;
      }
   }
}

