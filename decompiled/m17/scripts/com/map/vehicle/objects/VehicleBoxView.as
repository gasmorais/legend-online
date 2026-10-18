package com.map.vehicle.objects
{
   import com.map.vehicle.VehicleModel;
   import com.map.vehicle.data.VGlobal;
   import com.map.vehicle.data.VehicleNode;
   import com.map.vehicle.events.VehicleEvent;
   import com.map.vehicle.net.VehicleSocketManager;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.mapengine.bitmap.BaseMapScene;
   import com.road.mapengine.bitmap.logic.BitmapSimpleLogic;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import yishi.manager.CursorManagerII;
   import yishi.manager.PathManager;
   
   public class VehicleBoxView extends BitmapSimpleLogic
   {
      
      private var _data:VehicleNode;
      
      private var _mc:MovieClip;
      
      private var _nameTxt:FilterFrameText;
      
      private var _model:VehicleModel = VehicleSocketManager.instance.model;
      
      private var _frame:int = 1;
      
      public function VehicleBoxView(param1:BaseMapScene)
      {
         super(param1);
      }
      
      public function get data() : VehicleNode
      {
         return _data;
      }
      
      public function set data(param1:VehicleNode) : void
      {
         _data = param1;
         if(_data)
         {
            _data.logicView = this;
            initView();
            addEvent();
            loadResource();
         }
      }
      
      private function initView() : void
      {
         if(!_nameTxt)
         {
            _nameTxt = ComponentFactory.Instance.creatComponentByStylename("campaign.map.NpcNameTxt");
         }
         if(data.name != "")
         {
            _nameTxt.text = data.name;
         }
         _nameTxt.selectable = _nameTxt.mouseEnabled = _nameTxt.mouseWheelEnabled = false;
         if(_data.nameColor > 0)
         {
            _nameTxt.setFrame(_data.nameColor);
         }
         _container.addChild(_baseView);
         VGlobal.logicWorld.nameLayer.addChild(_nameTxt);
      }
      
      private function addEvent() : void
      {
         _data.addEventListener("updateNode",__updateHandler);
      }
      
      private function removeEvent() : void
      {
         if(_data)
         {
            _data.removeEventListener("updateNode",__updateHandler);
         }
      }
      
      private function __updateHandler(param1:VehicleEvent) : void
      {
      }
      
      private function loadResource() : void
      {
         var _loc1_:String = PathManager.solveMapPhysicsBySonType(data.sonType);
         LoaderManagerII.instance.load(_loc1_,2,8,__loaderCompleteHandler);
      }
      
      private function __loaderCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         if(!_model)
         {
            return;
         }
         _mc = param2 as MovieClip;
         if(!_mc)
         {
            return;
         }
         _container.addChildAt(_mc,0);
         _mc.mouseEnabled = _mc.mouseChildren = false;
         this.x = x;
         this.y = y;
      }
      
      override public function set x(param1:Number) : void
      {
         var _loc2_:MovieClip = null;
         super.x = param1;
         if(_mc && _mc.pos)
         {
            _loc2_ = _mc.pos;
            _nameTxt.x = super.x + _loc2_.x - _nameTxt.width / 2;
         }
      }
      
      override public function set y(param1:Number) : void
      {
         var _loc2_:MovieClip = null;
         super.y = param1;
         if(_mc && _mc.pos)
         {
            _loc2_ = _mc.pos;
            _nameTxt.y = super.y + _loc2_.y - 15;
         }
      }
      
      override public function update() : void
      {
         if(_data && _data.type == 1 && _data.teamId != 0 && VGlobal.model.selfVehicleInfo != null)
         {
            this.container.visible = _data.teamId == VGlobal.model.selfVehicleInfo.team;
         }
      }
      
      override public function mouseClickEvent(param1:MouseEvent) : Boolean
      {
         var _loc3_:Point = null;
         var _loc2_:Boolean = false;
         if(param1 && param1.target == _container)
         {
            _loc2_ = true;
         }
         if(_loc2_)
         {
            _loc3_ = new Point(this.x,this.y);
            if(_data)
            {
               if(_data.resetPosX != 0 && _data.resetPosY != 0)
               {
                  _loc3_.x = _data.resetPosX * 20;
                  _loc3_.y = _data.resetPosY * 20;
               }
            }
            VGlobal.logicWorld.moveMeToPos(_loc3_.x,_loc3_.y);
         }
         return _loc2_;
      }
      
      override public function mouseMoveEvent(param1:MouseEvent) : Boolean
      {
         return false;
      }
      
      override public function mouseOutEvent(param1:MouseEvent) : Boolean
      {
         if(_mc)
         {
            VGlobal.buildfilter.setNormalFilter(_mc);
         }
         CursorManagerII.instance.resetCursor();
         return true;
      }
      
      override public function mouseOverEvent(param1:MouseEvent) : Boolean
      {
         if(_mc)
         {
            VGlobal.buildfilter.setLightFilter(_mc);
            CursorManagerII.instance.showCursorByType("COLLECT_CURSOR");
         }
         return true;
      }
      
      override public function dispose() : void
      {
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__loaderCompleteHandler);
         if(_mc)
         {
            _mc.gotoAndStop(1);
         }
         ObjectUtils.disposeObject(_mc);
         _mc = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         removeEvent();
         _model = null;
         super.dispose();
      }
      
      override public function get curResourceType() : int
      {
         return 8;
      }
   }
}

