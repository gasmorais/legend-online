package avatar.data
{
   public class AvatarPosition
   {
      
      public static const ARMY:String = "army";
      
      public static const BODY:String = "body";
      
      public static const HAIR_UP:String = "hairUp";
      
      public static const HAIR_DOWN:String = "hairDown";
      
      public static const CLOAK:String = "cloak";
      
      public static const WING:String = "wing";
      
      public static const MOUNT:String = "mount";
      
      public static const MOUNT_WING:String = "mountWing";
      
      public static const PET:String = "pet";
      
      private static var _avatarId:int;
      
      public function AvatarPosition()
      {
         super();
      }
      
      public static function get avatarId() : int
      {
         return ++_avatarId;
      }
   }
}

