package map.campaign.data
{
   public class StallInfo
   {
      
      public var userId:int;
      
      public var stallId:String;
      
      public var state:int;
      
      public var name:String;
      
      public var x:int;
      
      public var y:int;
      
      public var items:Array;
      
      public var isNew:Boolean;
      
      public function StallInfo()
      {
         super();
         items = [];
      }
   }
}

