package avatar.view
{
   import com.road.mapengine.bitmap.load.ResourceLoaderInfo;
   
   public class HumanAvatar extends Avatar
   {
      
      public function HumanAvatar(param1:String, param2:Boolean, param3:String = "auto", param4:Boolean = true)
      {
         super(param1,param2,param3,param4);
      }
      
      public function set stepFrame(param1:int) : void
      {
      }
      
      public function set isShowWeapons(param1:Boolean) : void
      {
      }
      
      public function getCurrentPixels() : uint
      {
         return 0;
      }
      
      public function loaderCompleteHandler(param1:ResourceLoaderInfo, param2:Object) : void
      {
      }
   }
}

