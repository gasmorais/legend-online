package com.road.mapengine.bitmap.logic
{
   import avatar.data.AvatarStaticData;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.toplevel.StageReferance;
   import com.road.mapengine.ai.vehicle.Vector2D;
   import com.road.mapengine.ai.vehicle.VehicleAi;
   import com.road.mapengine.bitmap.BaseMapScene;
   import com.road.mapengine.bitmap.load.ResourceLoaderInfo;
   import map.internals.data.CampaignNode;
   import yishi.manager.PathManager;
   
   public class AvatarNpcLogic extends BitmapAvatarLogic
   {
      
      private var _data:CampaignNode;
      
      private var _ai:VehicleAi;
      
      public function AvatarNpcLogic(param1:BaseMapScene)
      {
         super(param1);
         _walkTotalFrameX = 6;
         _walkTotalFrameY = 5;
         _standTotalFrameX = 5;
         _standTotalFrameY = 3;
         _ai = new VehicleAi();
         _ai.view = this;
         _ai.maxSpeed = 3;
         play();
      }
      
      override protected function loaderResourceCall(param1:LoaderInfo, param2:Object) : void
      {
         super.loaderResourceCall(param1,param2);
      }
      
      public function get data() : CampaignNode
      {
         return _data;
      }
      
      public function set data(param1:CampaignNode) : void
      {
         _data = param1;
         showAvatar();
      }
      
      private function showAvatar() : void
      {
         var _loc2_:ResourceLoaderInfo = createLoaderInfo(_data.sonType.toString(),"body",false);
         var _loc1_:String = getResourcepath(_data.sonType.toString());
         LoaderManagerII.instance.load(_loc1_,4,4,loaderResourceCall,null,null,_loc2_);
      }
      
      override public function update() : void
      {
         _ai.seek(new Vector2D(StageReferance.stage.mouseX,StageReferance.stage.mouseY));
         _ai.update();
         super.update();
      }
      
      private function createLoaderInfo(param1:String, param2:String, param3:Boolean) : ResourceLoaderInfo
      {
         var _loc4_:ResourceLoaderInfo = new ResourceLoaderInfo();
         _loc4_.url = getResourcepath(param1);
         _loc4_.stand = AvatarStaticData.getBaseNumByType("Stand",param2);
         _loc4_.walk = AvatarStaticData.getBaseNumByType("Walk",param2);
         _loc4_.position = param2;
         _loc4_.resourceType = 5;
         _loc4_.queueLoader = param3;
         return _loc4_;
      }
      
      override protected function getResourcepath(param1:String) : String
      {
         return PathManager.NpcAvatarResourcePath(param1);
      }
      
      override public function get curResourceType() : int
      {
         return 5;
      }
      
      override public function dispose() : void
      {
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(loaderResourceCall);
         super.dispose();
      }
   }
}

