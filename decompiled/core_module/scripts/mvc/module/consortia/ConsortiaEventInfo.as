package mvc.module.consortia
{
   public class ConsortiaEventInfo
   {
      
      public static const JOIN_CONSORTIA:int = 1;
      
      public static const KICK:int = 2;
      
      public static const QUIT:int = 3;
      
      public static const CONSORTIA_UPGRADE:int = 4;
      
      public static const SKILL_UPGRADE:int = 5;
      
      public static const BUILDING_UPGRADE:int = 6;
      
      public static const CHANGE:int = 7;
      
      public static const DEDUCT:int = 8;
      
      public static const EVENT:int = 9;
      
      public static const SPEED:int = 10;
      
      public static const CONSORTIA_PICK_FRUIT:int = 11;
      
      public static const CHAIRMAN_SEND:int = 12;
      
      public var id:int;
      
      public var consortiaId:int;
      
      public var remark:String;
      
      public var createDate:Date;
      
      public var types:int;
      
      public var isExist:Boolean;
      
      public function ConsortiaEventInfo()
      {
         super();
      }
   }
}

