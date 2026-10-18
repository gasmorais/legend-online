package map.campaign.data
{
   import yishi.datas.templates.VehicleObjectTempInfo;
   import yishi.manager.TempleteManager;
   
   public class ArmyVehicleInfo
   {
      
      public var tempInfo:VehicleObjectTempInfo;
      
      private var _tempId:int;
      
      public var hp:int;
      
      public function ArmyVehicleInfo()
      {
         super();
         this.tempId = 1;
      }
      
      public function get tempId() : int
      {
         return _tempId;
      }
      
      public function set tempId(param1:int) : void
      {
         _tempId = param1;
         tempInfo = TempleteManager.instance.vehicleObjectTempInfoCate.getTemplateByIndex(param1);
      }
   }
}

