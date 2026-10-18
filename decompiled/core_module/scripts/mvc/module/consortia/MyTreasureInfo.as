package mvc.module.consortia
{
   import yishi.utils.DateFormatter;
   
   public class MyTreasureInfo
   {
      
      public var treasureId:int;
      
      private var _openTime:String;
      
      private var _nOpenTime:Number = 0;
      
      public var treasureTemplateId:int;
      
      public var helperName:String;
      
      public var requestHelpCount:int;
      
      public var status:int;
      
      public function MyTreasureInfo()
      {
         super();
      }
      
      public function set openTime(param1:String) : void
      {
         _openTime = param1;
         _nOpenTime = DateFormatter.parse(param1,"YYYY-MM-DD hh:mm:ss").time;
      }
      
      public function get newOpenTime() : Number
      {
         return _nOpenTime;
      }
   }
}

