package mvc.module.llk
{
   public class LlkInfo
   {
      
      public var score:int;
      
      public var fullScore:int;
      
      public var time:int;
      
      public var strength:int;
      
      public var bombCount:int;
      
      public var resetCount:int;
      
      public var gate:int;
      
      private var _points:String;
      
      public var selfOrder:int;
      
      public var deleteList:Vector.<LlkDeleteData>;
      
      public var boxList:Array;
      
      public var sortList:Array;
      
      public function LlkInfo()
      {
         super();
         deleteList = new Vector.<LlkDeleteData>();
         boxList = [];
         sortList = [];
      }
      
      public function get points() : String
      {
         return _points;
      }
      
      public function set points(param1:String) : void
      {
         _points = param1;
      }
   }
}

