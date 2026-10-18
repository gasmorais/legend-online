package com.map.vehicle.objects
{
   import com.map.vehicle.VehicleModel;
   import com.map.vehicle.data.VehicleNode;
   import com.map.vehicle.net.VehicleSocketManager;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.road.mapengine.bitmap.BaseMapScene;
   import com.road.mapengine.bitmap.load.ResourceLoaderInfo;
   import com.road.mapengine.bitmap.logic.BitmapSimpleLogic;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.VehicleSkillTempInfo;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   
   public class VehicleTrapView extends BitmapSimpleLogic
   {
      
      private var _data:VehicleNode;
      
      private var _mc:MovieClip;
      
      private var _skillTemplate:VehicleSkillTempInfo;
      
      private var _model:VehicleModel = VehicleSocketManager.instance.model;
      
      private var _createrId:int;
      
      private var _playerInfo:PlayerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
      
      public function VehicleTrapView(param1:BaseMapScene)
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
         _skillTemplate = TempleteManager.instance.vehicleSkillTempteCate.getTemplateByTid(1234);
         _createrId = 1;
      }
      
      private function loadResource() : void
      {
         var _loc1_:ResourceLoaderInfo = new ResourceLoaderInfo();
         _loc1_.resourceType = 5;
         _loc1_.loaderType = 2;
         var _loc2_:String = PathManager.solveMapPhysicsBySonType(data.sonType);
         LoaderManagerII.instance.load(_loc2_,2,4,loaderResourceCall,null,null,_loc1_);
      }
      
      override protected function loaderResourceCall(param1:LoaderInfo, param2:Object) : void
      {
         if(!_container)
         {
            return;
         }
         _mc = param2 as MovieClip;
         if(_baseView && _baseView.bitmapData)
         {
            _baseView.bitmapData.dispose();
         }
         var _loc4_:BitmapData = new BitmapData(_mc.width,_mc.height,true,0);
         _baseView.bitmapData = _loc4_;
         var _loc3_:MovieClip = _mc.pos;
         _mc.gotoAndStop(1);
      }
      
      override public function update() : void
      {
         if(_data && _createrId == _playerInfo.userId)
         {
         }
      }
      
      override public function dispose() : void
      {
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(loaderResourceCall);
         super.dispose();
      }
   }
}

