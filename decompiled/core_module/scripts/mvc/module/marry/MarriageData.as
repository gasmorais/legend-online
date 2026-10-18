package mvc.module.marry
{
   public class MarriageData
   {
      
      public var userId:int;
      
      public var type:int = -1;
      
      private var _happyInfo:MarriageHappyInfo;
      
      private var _mateHappyInfo:MarriageHappyInfo;
      
      private var _ringInfo:MarriageRingInfo;
      
      private var _godTreeInfo:MarriageGodTreeInfo;
      
      public function MarriageData()
      {
         super();
      }
      
      public function set happyInfo(param1:MarriageHappyInfo) : void
      {
         _happyInfo = param1;
      }
      
      public function get happyInfo() : MarriageHappyInfo
      {
         if(_happyInfo == null)
         {
            _happyInfo = new MarriageHappyInfo();
         }
         return _happyInfo;
      }
      
      public function set mateHappyInfo(param1:MarriageHappyInfo) : void
      {
         _mateHappyInfo = param1;
      }
      
      public function get mateHappyInfo() : MarriageHappyInfo
      {
         if(_mateHappyInfo == null)
         {
            _mateHappyInfo = new MarriageHappyInfo();
         }
         return _mateHappyInfo;
      }
      
      public function set ringInfo(param1:MarriageRingInfo) : void
      {
         _ringInfo = param1;
      }
      
      public function get ringInfo() : MarriageRingInfo
      {
         if(_ringInfo == null)
         {
            _ringInfo = new MarriageRingInfo();
         }
         return _ringInfo;
      }
      
      public function set godTreeInfo(param1:MarriageGodTreeInfo) : void
      {
         _godTreeInfo = param1;
      }
      
      public function get godTreeInfo() : MarriageGodTreeInfo
      {
         if(_godTreeInfo == null)
         {
            _godTreeInfo = new MarriageGodTreeInfo();
         }
         return _godTreeInfo;
      }
   }
}

