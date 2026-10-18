package mvc.module.chesspvp
{
   import yishi.utils.DateFormatter;
   
   public class ChesspvpRecordInfo
   {
      
      public var result:int;
      
      public var group:int;
      
      public var name:String;
      
      public var serverName:String;
      
      public var addScore:int;
      
      public var rivalGroup:int;
      
      public var rivalName:String;
      
      public var rivalServerName:String;
      
      public var rivalAddScore:int;
      
      public var sortNum:Number = 0;
      
      private var _recordDate:String;
      
      public function ChesspvpRecordInfo()
      {
         super();
      }
      
      public function get recordDate() : String
      {
         return _recordDate;
      }
      
      public function set recordDate(param1:String) : void
      {
         if(_recordDate == param1 || param1 == null || param1.length < 1)
         {
            return;
         }
         _recordDate = param1;
         var _loc2_:Date = DateFormatter.parse(_recordDate,"YYYY-MM-DD hh:mm:ss");
         sortNum = _loc2_.time;
      }
   }
}

