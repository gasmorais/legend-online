package stage3drender.avatar
{
   import avatar.data.AvatarPartInfo;
   
   public class AvatarInfo
   {
      
      private var _avatarPartInfoList:Array = [];
      
      public function AvatarInfo()
      {
         super();
      }
      
      public function addPartInfo(param1:AvatarPartInfo) : void
      {
         var _loc2_:int = _avatarPartInfoList.indexOf(param1);
         if(_loc2_ >= 0)
         {
            _avatarPartInfoList.splice(_loc2_,1);
         }
         _avatarPartInfoList.push(param1);
      }
      
      public function get avatarPartInfoList() : Array
      {
         return _avatarPartInfoList;
      }
      
      public function getPartInfo(param1:String) : AvatarPartInfo
      {
         for each(var _loc2_:AvatarPartInfo in _avatarPartInfoList)
         {
            if(_loc2_.partPosition == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function clear() : void
      {
         _avatarPartInfoList = [];
      }
   }
}

