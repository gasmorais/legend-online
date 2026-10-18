package tasktracetip.data
{
   import yishi.datas.goods.GoodsInfo;
   
   public class TipMessageData
   {
      
      public static const CAMPAIGN_ADD_PAWN:int = 1;
      
      public static const BETTER_GOODS:int = 2;
      
      public static const BUY_BLOOD:int = 3;
      
      public static const INTENSIFY:int = 4;
      
      public static const MOUNT:int = 5;
      
      public static const UPGRADE_PAWN:int = 6;
      
      public static const HASUNEQUIP:int = 7;
      
      public static const STAR:int = 8;
      
      public static const MILITARYTEC:int = 9;
      
      public static const GRADEBOX:int = 10;
      
      public static const HOOKREWARD:int = 11;
      
      public static const OPEN_BAG:int = 13;
      
      public static const TREE_CAN_PICK:int = 14;
      
      public static const USE_WEARY:int = 16;
      
      public static const BUFFER:int = 17;
      
      public static const TASK:int = 18;
      
      public static const FARM_CAN_PICK:int = 19;
      
      public static const VIP_CARD:int = 20;
      
      public static const VIP_GRADE:int = 21;
      
      public static const VIP_GIFT:int = 22;
      
      public static const VIP_OPEN:int = 23;
      
      public static const KINGCONTRACT:int = 24;
      
      public static const CALL_SECRET_TREE:int = 25;
      
      public static const DEMON_OPEN:int = 26;
      
      public static const PAWN_CHARACTERISTICS_TIP_VIEW:int = 27;
      
      public static const MOUNT_OPEN_TIP_VIEW:int = 28;
      
      public static const REGRESSION_TIP_VIEW:int = 29;
      
      public static const FATE_GUARD:int = 31;
      
      public static const PET_ADD_POINT:int = 32;
      
      public static const SHOPTIMEBUY:int = 33;
      
      public static const VIP_MOUNT_ACTIVITY:int = 34;
      
      public static const VIP_MOUNT_LOSE:int = 35;
      
      public static const TREASURE_MAP:int = 36;
      
      public static const CAMPAIGN_CARD:int = 38;
      
      public static const VIP_CUSTOM:int = 39;
      
      public static const DRAGON_SOUL_OPEN:int = 40;
      
      public static const MARRY_TREE:int = 41;
      
      public static const PET_BOSS:int = 42;
      
      public static const SINGLEPASS_HAS_BUGLE:int = 43;
      
      public static const FASHION_IDENTITY_BUFF:int = 44;
      
      public static const MULTILORDS_BET:int = 45;
      
      public static const CONSORTIA_BOSS:int = 46;
      
      public static const MATELORDS_BET:int = 47;
      
      public static const CONSORTIA_SKILL:int = 48;
      
      public static const MOUNT_PROPERTY:int = 49;
      
      public static const REFRESH:int = 50;
      
      public static const CONSORTIA_TREASURE:int = 51;
      
      public static const EXP_BACK:int = 1000;
      
      public static const PERKINLAB_CANPICK:int = 1001;
      
      public static const CHILDPATROL_TASK:int = 1002;
      
      public static const BETTER_EQUIP_COMPOSE:int = 1003;
      
      public static const CONSORTIA_EME_DREAM:int = 56;
      
      public static const APEX_START:int = 57;
      
      public static const ANTAEUS_BATTLE_FAILURE:int = 58;
      
      public static const ANTAEUS_MEET:int = 59;
      
      public static const EME_DREAM:int = 60;
      
      public static const CONSORTIA_NEW_BOSS:int = 61;
      
      public static const CONSORTIA_TREE:int = 62;
      
      public var title:String;
      
      public var name:String;
      
      public var content:String;
      
      public var type:int;
      
      public var icon:String;
      
      public var btnTxt:String;
      
      public var goods:GoodsInfo;
      
      public var data:Object;
      
      public var isFource:Boolean = false;
      
      public function TipMessageData()
      {
         super();
      }
   }
}

