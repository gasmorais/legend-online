package mvc.module.consortia
{
   import yishi.utils.DateFormatter;
   
   public class OthersTreasureInfo
   {
      
      public var treasureId:int;
      
      public var openTime:Number;
      
      public var treasureTemplateId:int;
      
      public var ownerName:String;
      
      public var ownerHeadId:int;
      
      private var _helperRewardTime:String;
      
      private var _nhelperRewardTime:Number;
      
      public var status:int;
      
      public function OthersTreasureInfo()
      {
         super();
      }
      
      public function set helperRewardTime(param1:String) : void
      {
         _helperRewardTime = param1;
         _nhelperRewardTime = DateFormatter.parse(param1,"YYYY-MM-DD hh:mm:ss").time;
      }
      
      public function get newHelpRewardTime() : Number
      {
         return _nhelperRewardTime;
      }
   }
}

