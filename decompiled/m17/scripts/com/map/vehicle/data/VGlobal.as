package com.map.vehicle.data
{
   import com.map.vehicle.VehicleModel;
   import com.map.vehicle.VehicleSceneController;
   import com.map.vehicle.VehicleView;
   import flash.media.SoundTransform;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.filter.SimpleBuildingFilter;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IBuildingFilter;
   import yishi.manager.PlayerManager;
   
   public class VGlobal
   {
      
      public static var logicWorld:VehicleView;
      
      public static var model:VehicleModel;
      
      public static var scene:VehicleSceneController;
      
      public static const InjuryEffect_SELF:int = 0;
      
      public static const InjuryEffect_MONOMER:int = 1;
      
      public static const InjuryEffect_GROUP:int = 2;
      
      public static const InjuryEffect_TRAP:int = 4;
      
      public static const InjuryEffect_PASSIVE:int = 3;
      
      public static const NodeResourceType_Image:int = 1;
      
      public static const NodeResourceType_Movie:int = 2;
      
      public static var uiFilter:UIFilter = new UIFilter();
      
      public static var buildfilter:IBuildingFilter = new SimpleBuildingFilter();
      
      public static var volume0:SoundTransform = new SoundTransform(0);
      
      public static var volume1:SoundTransform = new SoundTransform(1);
      
      public static var playerInfo:PlayerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
      
      public function VGlobal()
      {
         super();
      }
   }
}

