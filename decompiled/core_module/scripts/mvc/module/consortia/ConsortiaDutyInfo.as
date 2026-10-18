package mvc.module.consortia
{
   import flash.utils.ByteArray;
   
   public class ConsortiaDutyInfo
   {
      
      public static const TRANSFER:int = 1;
      
      public static const UPDATESKILL:int = 2;
      
      public static const UPDATEBUILDING:int = 3;
      
      public static const MOIDIFYBBS:int = 4;
      
      public static const KICKMEMBER:int = 5;
      
      public static const LOOKLOG:int = 6;
      
      public static const DUTYEDIT:int = 7;
      
      public static const INVITEMEMBER:int = 8;
      
      public static const PASSINVITE:int = 9;
      
      public static const PURSE:int = 10;
      
      public static const OPTATIVE:int = 11;
      
      public static const LOOKBBS:int = 12;
      
      public static const USESKILL:int = 13;
      
      public static const USESTORE:int = 14;
      
      public static const USESHOP:int = 15;
      
      public static const QUIT:int = 16;
      
      public static const LEVEL:int = 17;
      
      public static const RENAME:int = 18;
      
      public static const CHANGEJOB:int = 19;
      
      public static const CREATEFIGHT:int = 20;
      
      public static const JOINFIGHT:int = 21;
      
      public static const LOOKFIGHT:int = 22;
      
      public static const VIEWMEMBER:int = 23;
      
      public static const INVITELIST:int = 28;
      
      public static const MODIFYDESC:int = 30;
      
      public static const INVITEDEL:int = 31;
      
      public static const DISBAND:int = 32;
      
      public static const OPENAPP:int = 33;
      
      public static const STOCK:int = 43;
      
      public static const MASTER_SKILL:int = 44;
      
      public static const CALL_BOSS:int = 41;
      
      public static const CALL_FARM_TREE:int = 45;
      
      public static const HUGE_HEAD_SIGN:int = 46;
      
      public static const CONSORTIA_BOSS:int = 47;
      
      public static const chairman:Array = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,28,30,31,32,33,43,44,41,45,46,47];
      
      public static const vicePresident:Array = [2,5,6,8,9,10,11,12,13,14,15,16,19,21,22,23,28,31];
      
      public static const officer:Array = [5,6,8,9,10,11,12,13,14,15,16,21,22,23,28,31];
      
      public static const Elite:Array = [6,10,11,12,13,14,undefined,15,16,21,22,23];
      
      public var levels:int;
      
      public var dutyName:String;
      
      public var rights:ByteArray;
      
      public var rightsStr:String = "";
      
      public function ConsortiaDutyInfo()
      {
         super();
      }
   }
}

