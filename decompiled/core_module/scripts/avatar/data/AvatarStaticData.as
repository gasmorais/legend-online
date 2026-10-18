package avatar.data
{
   import flash.utils.Dictionary;
   
   public class AvatarStaticData
   {
      
      private static var _instance:AvatarStaticData;
      
      public static const BASE_NPC_WALK:Array = [0,0,0,0,0];
      
      public static const BASE_NPC_STAND:Array = [0,0,0];
      
      private static const WARRIOR_MAN_BODY_WALK:Array = [10,20,40,40,40];
      
      private static const WARRIOR_MAN_ARMY_WALK:Array = [20,10,0,0,0];
      
      private static const WARRIOR_MAN_HAIR_UP_WALK:Array = [0,0,10,10,10];
      
      private static const WARRIOR_MAN_HAIR_DOWN_WALK:Array = [30,30,20,20,20];
      
      private static const WARRIOR_MAN_CLOAK_WALK:Array = [40,40,30,30,30];
      
      private static const WARRIOR_MAN_WING_WALK:Array = [40,40,30,30,30];
      
      private static const WARRIOR_MAN_PET_WALK:Array = [-10,-10,-10,-10,-10];
      
      private static const WARRIOR_MAN_BODY_STAND:Array = [10,30,50];
      
      private static const WARRIOR_MAN_ARMY_STAND:Array = [20,0,0];
      
      private static const WARRIOR_MAN_HAIR_UP_STAND:Array = [0,10,20];
      
      private static const WARRIOR_MAN_HAIR_DOWN_STAND:Array = [30,20,30];
      
      private static const WARRIOR_MAN_CLOAK_STAND:Array = [40,40,40];
      
      private static const WARRIOR_MAN_WING_STAND:Array = [40,40,10];
      
      private static const WARRIOR_MAN_PET_STAND:Array = [-10,-10,-10];
      
      private static const WARRIOR_MAN_BODY_WALK_MOUNT:Array = [5,15,40,40,40];
      
      private static const WARRIOR_MAN_ARMY_WALK_MOUNT:Array = [20,10,0,0,0];
      
      private static const WARRIOR_MAN_HAIR_UP_WALK_MOUNT:Array = [0,0,10,10,10];
      
      private static const WARRIOR_MAN_HAIR_DOWN_WALK_MOUNT:Array = [30,30,20,20,20];
      
      private static const WARRIOR_MAN_CLOAK_WALK_MOUNT:Array = [40,40,30,30,30];
      
      private static const WARRIOR_MAN_MOUNT_WALK_MOUNT:Array = [50,50,50,50,50];
      
      private static const WARRIOR_MAN_WING_WALK_MOUNT:Array = [10,20,45,30,30];
      
      private static const WARRIOR_MAN_PET_WALK_MOUNT:Array = [-10,-10,-10,-10,-10];
      
      private static const WARRIOR_MAN_MOUNT_WING_WALK_MOUNT:Array = [45,-5,-5,-5,45];
      
      private static const WARRIOR_MAN_BODY_STAND_MOUNT:Array = [20,25,50];
      
      private static const WARRIOR_MAN_ARMY_STAND_MOUNT:Array = [10,0,10];
      
      private static const WARRIOR_MAN_HAIR_UP_STAND_MOUNT:Array = [0,10,20];
      
      private static const WARRIOR_MAN_HAIR_DOWN_STAND_MOUNT:Array = [30,20,30];
      
      private static const WARRIOR_MAN_CLOAK_STAND_MOUNT:Array = [40,40,40];
      
      private static const WARRIOR_MAN_MOUNT_STAND_MOUNT:Array = [50,50,60];
      
      private static const WARRIOR_MAN_WING_STAND_MOUNT:Array = [40,30,0];
      
      private static const WARRIOR_MAN_PET_STAND_MOUNT:Array = [-10,-10,-10];
      
      private static const WARRIOR_MAN_MOUNT_WING_STAND_MOUNT:Array = [-5,-5,-5];
      
      public var dic:Dictionary = new Dictionary();
      
      public function AvatarStaticData()
      {
         super();
         dic["S_0_hair_up"] = 1;
         dic["S_0_body"] = 2;
         dic["S_0_arms"] = 3;
         dic["S_0_hair_down"] = 4;
         dic["S_0_cloak"] = 5;
         dic["S_0_wing"] = 6;
         dic["S_0_mount"] = 7;
         dic["S_1_arms"] = 1;
         dic["S_1_hair_up"] = 2;
         dic["S_1_hair_down"] = 3;
         dic["S_1_body"] = 4;
         dic["S_1_cloak"] = 5;
         dic["S_1_wing"] = 6;
         dic["S_1_mount"] = 7;
         dic["S_2_arms"] = 1;
         dic["S_2_wing"] = 2;
         dic["S_2_hair_up"] = 3;
         dic["S_2_hair_down"] = 4;
         dic["S_2_cloak"] = 5;
         dic["S_2_body"] = 6;
         dic["S_2_mount"] = 7;
         dic["S_0_hair_up_mount"] = 1;
         dic["S_0_arms_mount"] = 2;
         dic["S_0_body_mount"] = 3;
         dic["S_0_hair_down_mount"] = 4;
         dic["S_0_cloak_mount"] = 5;
         dic["S_0_wing_mount"] = 7;
         dic["S_0_mount"] = 6;
         dic["S_1_arms_mount"] = 1;
         dic["S_1_hair_up_mount"] = 2;
         dic["S_1_hair_down_mount"] = 3;
         dic["S_1_body_mount"] = 4;
         dic["S_1_cloak_mount"] = 5;
         dic["S_1_wing_mount"] = 6;
         dic["S_1_mount_mount"] = 7;
         dic["S_2_wing_mount"] = 1;
         dic["S_2_arms_mount"] = 2;
         dic["S_2_hair_up_mount"] = 3;
         dic["S_2_hair_down_mount"] = 4;
         dic["S_2_cloak_mount"] = 5;
         dic["S_2_body_mount"] = 6;
         dic["S_2_mount"] = 7;
         dic["W_0_hair_up"] = 1;
         dic["W_0_body"] = 2;
         dic["W_0_arms"] = 3;
         dic["W_0_hair_down"] = 4;
         dic["W_0_cloak"] = 5;
         dic["W_0_wing"] = 6;
         dic["W_0_mount"] = 7;
         dic["W_1_hair_up"] = 1;
         dic["W_1_arms"] = 2;
         dic["W_1_body"] = 3;
         dic["W_1_hair_down"] = 4;
         dic["W_1_cloak"] = 5;
         dic["W_1_wing"] = 6;
         dic["W_1_mount"] = 7;
         dic["W_2_arms"] = 1;
         dic["W_2_hair_up"] = 2;
         dic["W_2_hair_down"] = 3;
         dic["W_2_wing"] = 4;
         dic["W_2_cloak"] = 5;
         dic["W_2_body"] = 6;
         dic["W_2_mount"] = 7;
         dic["W_3_arms"] = 1;
         dic["W_3_hair_up"] = 2;
         dic["W_3_hair_down"] = 3;
         dic["W_3_cloak"] = 4;
         dic["W_3_wing"] = 5;
         dic["W_3_body"] = 6;
         dic["W_3_mount"] = 7;
         dic["W_4_arms"] = 1;
         dic["W_4_hair_up"] = 2;
         dic["W_4_hair_down"] = 3;
         dic["W_4_cloak"] = 4;
         dic["W_4_wing"] = 5;
         dic["W_4_body"] = 6;
         dic["W_4_mount"] = 7;
         dic["W_0_hair_up"] = 1;
         dic["W_0_body"] = 2;
         dic["W_0_arms"] = 3;
         dic["W_0_hair_down"] = 4;
         dic["W_0_cloak"] = 5;
         dic["W_0_mount"] = 6;
         dic["W_0_wing"] = 7;
         dic["W_1_hair_up"] = 1;
         dic["W_1_arms"] = 2;
         dic["W_1_body"] = 3;
         dic["W_1_hair_down"] = 4;
         dic["W_1_cloak"] = 5;
         dic["W_1_mount"] = 6;
         dic["W_1_wing"] = 7;
         dic["W_2_arms"] = 1;
         dic["W_2_hair_up"] = 2;
         dic["W_2_hair_down"] = 3;
         dic["W_2_wing"] = 4;
         dic["W_2_cloak"] = 5;
         dic["W_2_mount"] = 6;
         dic["W_2_body"] = 7;
         dic["W_3_arms"] = 1;
         dic["W_3_hair_up"] = 2;
         dic["W_3_hair_down"] = 3;
         dic["W_3_cloak"] = 4;
         dic["W_3_wing"] = 5;
         dic["W_3_body"] = 6;
         dic["W_3_mount"] = 7;
         dic["W_4_arms"] = 1;
         dic["W_4_hair_up"] = 2;
         dic["W_4_hair_down"] = 3;
         dic["W_4_cloak"] = 4;
         dic["W_4_wing"] = 5;
         dic["W_4_mount"] = 6;
         dic["W_4_body"] = 7;
      }
      
      public static function get instance() : AvatarStaticData
      {
         if(!_instance)
         {
            _instance = new AvatarStaticData();
         }
         return _instance;
      }
      
      public static function getBaseNumByType(param1:String, param2:String, param3:Boolean = false) : Array
      {
         if(!param3)
         {
            if(param1 == "Walk")
            {
               switch(param2)
               {
                  case "body":
                     return WARRIOR_MAN_BODY_WALK;
                  case "army":
                     return WARRIOR_MAN_ARMY_WALK;
                  case "hairUp":
                     return WARRIOR_MAN_HAIR_UP_WALK;
                  case "hairDown":
                     return WARRIOR_MAN_HAIR_DOWN_WALK;
                  case "cloak":
                     return WARRIOR_MAN_CLOAK_WALK;
                  case "wing":
                     return WARRIOR_MAN_WING_WALK;
                  case "pet":
                     return WARRIOR_MAN_PET_WALK;
               }
            }
            else if(param1 == "Stand")
            {
               switch(param2)
               {
                  case "body":
                     return WARRIOR_MAN_BODY_STAND;
                  case "army":
                     return WARRIOR_MAN_ARMY_STAND;
                  case "hairUp":
                     return WARRIOR_MAN_HAIR_UP_STAND;
                  case "hairDown":
                     return WARRIOR_MAN_HAIR_DOWN_STAND;
                  case "cloak":
                     return WARRIOR_MAN_CLOAK_STAND;
                  case "wing":
                     return WARRIOR_MAN_WING_STAND;
                  case "pet":
                     return WARRIOR_MAN_PET_STAND;
               }
            }
         }
         else if(param1 == "Walk")
         {
            switch(param2)
            {
               case "body":
                  return WARRIOR_MAN_BODY_WALK_MOUNT;
               case "army":
                  return WARRIOR_MAN_ARMY_WALK_MOUNT;
               case "hairUp":
                  return WARRIOR_MAN_HAIR_UP_WALK_MOUNT;
               case "hairDown":
                  return WARRIOR_MAN_HAIR_DOWN_WALK_MOUNT;
               case "cloak":
                  return WARRIOR_MAN_CLOAK_WALK_MOUNT;
               case "wing":
                  return WARRIOR_MAN_WING_WALK_MOUNT;
               case "mount":
                  return WARRIOR_MAN_MOUNT_WALK_MOUNT;
               case "pet":
                  return WARRIOR_MAN_PET_WALK_MOUNT;
            }
         }
         else if(param1 == "Stand")
         {
            switch(param2)
            {
               case "body":
                  return WARRIOR_MAN_BODY_STAND_MOUNT;
               case "army":
                  return WARRIOR_MAN_ARMY_STAND_MOUNT;
               case "hairUp":
                  return WARRIOR_MAN_HAIR_UP_STAND_MOUNT;
               case "hairDown":
                  return WARRIOR_MAN_HAIR_DOWN_STAND_MOUNT;
               case "cloak":
                  return WARRIOR_MAN_CLOAK_STAND_MOUNT;
               case "wing":
                  return WARRIOR_MAN_WING_STAND_MOUNT;
               case "mount":
                  return WARRIOR_MAN_MOUNT_STAND_MOUNT;
               case "pet":
                  return WARRIOR_MAN_PET_STAND_MOUNT;
            }
         }
         return [];
      }
      
      public static function getSetOffsetArray(param1:String, param2:String, param3:Boolean, param4:Array) : Array
      {
         var _loc10_:* = null;
         var _loc6_:Number = NaN;
         var _loc9_:Array = null;
         var _loc5_:Array = getBaseNumByType(param1,param2,param3);
         var _loc8_:Boolean = false;
         loop0:
         for each(_loc10_ in param4)
         {
            var _loc13_:int = 0;
            var _loc12_:Object = _loc10_;
            do
            {
               for each(var _loc11_:Number in _loc12_)
               {
               }
               continue loop0;
            }
            while(_loc11_ == 0);
            _loc8_ = true;
         }
         if(_loc8_)
         {
            _loc9_ = [];
            _loc5_ = _loc9_.concat(_loc5_);
            for each(_loc10_ in param4)
            {
               for(var _loc7_:Object in _loc10_)
               {
                  _loc6_ = Number(_loc10_[_loc7_]);
                  _loc5_[_loc7_] += _loc6_;
               }
            }
         }
         return _loc5_;
      }
   }
}

