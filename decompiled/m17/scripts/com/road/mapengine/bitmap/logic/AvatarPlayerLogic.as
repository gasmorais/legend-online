package com.road.mapengine.bitmap.logic
{
   import avatar.data.AvatarStaticData;
   import com.pickgliss.loader.LoaderManagerII;
   import com.road.mapengine.ai.astar.AvatarPathWalkAi;
   import com.road.mapengine.bitmap.BaseMapScene;
   import com.road.mapengine.bitmap.load.ResourceLoaderInfo;
   import managers.RoomManager;
   import map.campaign.data.CampaignArmy;
   import yishi.datas.consant.JobType;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   
   public class AvatarPlayerLogic extends BitmapAvatarLogic
   {
      
      private var _sex:int;
      
      protected var _data:CampaignArmy;
      
      private var _isMounting:Boolean;
      
      private var _pathLogic:AvatarPathWalkAi;
      
      public function AvatarPlayerLogic(param1:int, param2:BaseMapScene)
      {
         super(param2,true);
         _sex = param1;
         _pathLogic = new AvatarPathWalkAi();
         _pathLogic.avatar = this;
         _walkTotalFrameX = 8;
         _walkTotalFrameY = 5;
         _standTotalFrameX = 4;
         _standTotalFrameY = 3;
      }
      
      public function get data() : CampaignArmy
      {
         return _data;
      }
      
      public function set data(param1:CampaignArmy) : void
      {
         _isMounting = false;
         _data = param1;
         var _loc6_:CampaignArmy = RoomManager.instance.roomInfo.getPlayerByUserId(param1.baseHero.userId);
         if(_loc6_ == null || _loc6_.baseHero == null)
         {
            _loc6_ = param1;
         }
         var _loc11_:int = int(_loc6_.baseHero.changeShapeId);
         var _loc3_:int = int(_loc6_.baseHero.templateInfo.Sexs);
         var _loc13_:int = int(_loc6_.baseHero.templateInfo.Job);
         var _loc7_:String = _loc6_.baseHero.bodyAvata == "" ? JobType.getDefaultBodyEquipNameByJob(_loc13_) : _loc6_.baseHero.bodyAvata;
         var _loc2_:String = _loc6_.baseHero.armsAvata == "" ? JobType.getDefaultArmysEquipNameByJob(_loc13_) : _loc6_.baseHero.armsAvata;
         var _loc10_:String = JobType.getDefaultHairUpByJob(_loc13_);
         var _loc5_:String = JobType.getDefaultHairDownByJob(_loc13_);
         var _loc9_:String = _loc7_ + "_cloak";
         var _loc4_:String = _loc6_.baseHero.wingAvata;
         var _loc12_:String = _loc6_.mountTemplate ? _loc6_.mountTemplate.AvatarPath : "";
         var _loc8_:Boolean = PlayerManager.instance.currentPlayerModel.playerInfo.userId == data.userId;
         if(_loc11_ > 0)
         {
            return;
         }
         if(_loc6_.mountTemplate)
         {
            _isMounting = true;
            _loc7_ = JobType.getMapMountEquipment(_loc7_);
            _loc2_ = JobType.getMapMountEquipment(_loc2_);
            _loc10_ = JobType.getMapMountEquipment(_loc10_);
            _loc5_ = JobType.getMapMountEquipment(_loc5_);
            _loc9_ = JobType.getMapMountEquipment(_loc9_);
            _loc4_ = JobType.getMapMountEquipment(_loc4_);
            if(!_loc12_)
            {
               _loc12_ = JobType.getDefaultMount();
            }
         }
         showAvatarWithPath(_loc7_,_loc2_,_loc10_,_loc5_,_loc9_,_isMounting,!_loc8_,_loc4_,_loc12_);
      }
      
      public function get sex() : int
      {
         return _sex;
      }
      
      override public function update() : void
      {
         _pathLogic.execute();
         super.update();
      }
      
      public function set path(param1:Array) : void
      {
         _pathLogic.paths = param1;
      }
      
      private function showAvatarWithPath(param1:String, param2:String, param3:String, param4:String, param5:String, param6:Boolean, param7:Boolean, param8:String = "", param9:String = "") : void
      {
         var _loc11_:ResourceLoaderInfo = null;
         var _loc10_:String = "";
         _loc11_ = createLoaderInfo(param1,"body",param6,param7);
         _loc10_ = getResourcepath(param1);
         LoaderManagerII.instance.load(_loc10_,4,4,loaderResourceCall,null,null,_loc11_);
         _loc11_ = createLoaderInfo(param2,"army",param6,param7);
         _loc10_ = getResourcepath(param2);
         LoaderManagerII.instance.load(_loc10_,4,4,loaderResourceCall,null,null,_loc11_);
         _loc11_ = createLoaderInfo(param3,"hairUp",param6,param7);
         _loc10_ = getResourcepath(param3);
         LoaderManagerII.instance.load(_loc10_,4,4,loaderResourceCall,null,null,_loc11_);
         _loc11_ = createLoaderInfo(param4,"hairDown",param6,param7);
         _loc10_ = getResourcepath(param4);
         LoaderManagerII.instance.load(_loc10_,4,4,loaderResourceCall,null,null,_loc11_);
         if(param8)
         {
            _loc11_ = createLoaderInfo(param8,"wing",param6,param7);
            _loc10_ = getResourcepath(param8);
            LoaderManagerII.instance.load(_loc10_,4,4,loaderResourceCall,null,null,_loc11_);
         }
         else
         {
            _loc11_ = createLoaderInfo(param5,"cloak",param6,param7);
            _loc10_ = getResourcepath(param5);
            LoaderManagerII.instance.load(_loc10_,4,4,loaderResourceCall,null,null,_loc11_);
         }
         if(param9)
         {
            _loc11_ = createLoaderInfo(param9,"mount",param6,param7);
            _loc10_ = getResourcepath(param9);
            LoaderManagerII.instance.load(_loc10_,4,4,loaderResourceCall,null,null,_loc11_);
         }
      }
      
      private function createLoaderInfo(param1:String, param2:String, param3:Boolean, param4:Boolean) : ResourceLoaderInfo
      {
         var _loc5_:ResourceLoaderInfo = new ResourceLoaderInfo();
         _loc5_.url = getResourcepath(param1);
         _loc5_.stand = AvatarStaticData.getBaseNumByType("Stand",param2,param3);
         _loc5_.walk = AvatarStaticData.getBaseNumByType("Walk",param2,param3);
         _loc5_.position = param2;
         _loc5_.resourceType = 4;
         _loc5_.queueLoader = param4;
         return _loc5_;
      }
      
      override public function get curResourceType() : int
      {
         return 4;
      }
      
      override protected function getResourcepath(param1:String) : String
      {
         return PathManager.avatarResourcePath(param1,_sex);
      }
      
      override public function dispose() : void
      {
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(loaderResourceCall);
         super.dispose();
      }
   }
}

