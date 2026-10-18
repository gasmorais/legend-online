package mvc.module.skytreasure
{
   public class SkyTreasureRecordInfo
   {
      
      private var _time:String;
      
      private var _serverId:String;
      
      private var _name:String;
      
      private var _skyTreasureName:String;
      
      private var _templateId:int;
      
      private var _count:int;
      
      private var _isTotal:Boolean;
      
      public function SkyTreasureRecordInfo(param1:String, param2:String, param3:String, param4:String, param5:int, param6:int, param7:Boolean = false)
      {
         super();
         _time = param1;
         _name = param3;
         _skyTreasureName = param4;
         _templateId = param5;
         _count = param6;
         _serverId = param2;
         _isTotal = param7;
      }
      
      public function get time() : String
      {
         return _time;
      }
      
      public function get skyTreasureName() : String
      {
         return _skyTreasureName;
      }
      
      public function get recordDesc() : String
      {
         return _name;
      }
   }
}

