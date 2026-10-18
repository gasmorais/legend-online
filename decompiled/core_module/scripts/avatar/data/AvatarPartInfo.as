package avatar.data
{
   public class AvatarPartInfo
   {
      
      public static const BODY:String = "body";
      
      public static const ARMS:String = "arms";
      
      public static const HAIR_UP:String = "hair_up";
      
      public static const HAIR_DOWN:String = "hair_down";
      
      public static const CLOAK:String = "cloak";
      
      public static const MOUNT:String = "mount";
      
      public static const WING:String = "wing";
      
      public static const PET:String = "pet";
      
      public static const BODY_MOUNT:String = "body_mount";
      
      public static const ARMS_MOUNT:String = "arms_mount";
      
      public static const HAIR_UP_MOUNT:String = "hair_up_mount";
      
      public static const HAIR_DOWN_MOUNT:String = "hair_down_mount";
      
      public static const CLOAK_MOUNT:String = "cloak_mount";
      
      public static const MOUNT_MOUNT:String = "mount_mount";
      
      public static const WING_MOUNT:String = "wing_mount";
      
      public static const PET_MOUNT:String = "pet_mount";
      
      private var _url:String;
      
      public var partPosition:String;
      
      public function AvatarPartInfo()
      {
         super();
      }
      
      public function get url() : String
      {
         return _url;
      }
      
      public function set url(param1:String) : void
      {
         _url = param1.toLowerCase();
      }
   }
}

