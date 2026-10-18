package yishi.datas.templates
{
   public class GuildFBTempInfo
   {
      
      public var NodeId:int;
      
      public var AreaId:int;
      
      public var Difficulty:int;
      
      public var NextNodeId:int;
      
      public var Name:String;
      
      public var BossId:String;
      
      public var AreaDropId:int;
      
      public var NodeDropId:int;
      
      public function GuildFBTempInfo()
      {
         super();
      }
      
      public function get conciseName() : String
      {
         var _loc1_:String = "";
         if(Name != null)
         {
            _loc1_ = Name.replace(/[1-9-\[\]]/g,"");
         }
         return _loc1_;
      }
   }
}

