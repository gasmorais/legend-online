package stage3drender
{
   import avatar.data.AvatarPartInfo;
   
   public class AvatarAtfLoader extends SimpleAtfLoader
   {
      
      public var partInfo:AvatarPartInfo;
      
      public function AvatarAtfLoader(param1:int)
      {
         super(param1);
      }
      
      override public function load(param1:String) : void
      {
         _path = param1;
         var _loc2_:String = _path.substr(_path.lastIndexOf("/"),_path.length);
         loadAtf(_path + _loc2_ + ".a");
      }
   }
}

