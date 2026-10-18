package mvc.module.marry
{
   public class MarryCarInfo
   {
      
      public var userIdA:int;
      
      public var nickNameA:String;
      
      public var jobA:int;
      
      public var userIdB:int;
      
      public var nickNameB:String;
      
      public var jobB:int;
      
      public var property4:String;
      
      public var firstX:int;
      
      public var firstY:int;
      
      public var isExist:Boolean;
      
      private var _pathInfo:Array;
      
      public function MarryCarInfo()
      {
         super();
      }
      
      public function get pathInfo() : Array
      {
         if(!_pathInfo)
         {
            _pathInfo = [];
         }
         return _pathInfo;
      }
   }
}

