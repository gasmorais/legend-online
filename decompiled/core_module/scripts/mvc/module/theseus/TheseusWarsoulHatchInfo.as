package mvc.module.theseus
{
   import yishi.utils.DateFormatter;
   
   public class TheseusWarsoulHatchInfo
   {
      
      public var hatchNum:int;
      
      public var useItem:int;
      
      private var _startDate:String;
      
      private var _startTime:Date;
      
      private var _stopDate:String;
      
      private var _stopTime:Date;
      
      public function TheseusWarsoulHatchInfo()
      {
         super();
      }
      
      public function get stopTime() : Date
      {
         return _stopTime;
      }
      
      public function get startTime() : Date
      {
         return _startTime;
      }
      
      public function set stopDate(param1:String) : void
      {
         if(_stopDate == param1)
         {
            return;
         }
         _stopDate = param1;
         _stopTime = DateFormatter.parse(_stopDate,"YYYY-MM-DD hh:mm:ss");
      }
      
      public function set startDate(param1:String) : void
      {
         if(_startDate == param1)
         {
            return;
         }
         _startDate = param1;
         _startTime = DateFormatter.parse(_startDate,"YYYY-MM-DD hh:mm:ss");
      }
   }
}

