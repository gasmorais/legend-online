package mvc.module.newmemorycard
{
   public class NewMemoryCardModel
   {
      
      public var isOpen:Boolean;
      
      public var openTime:String;
      
      public var stopTime:String;
      
      public var clickIndexArr:Array = [];
      
      public var lock:Boolean = false;
      
      public var opType:int = 1;
      
      public var freeStep:int = 20;
      
      public var buyStep:int = 0;
      
      public var buyCount:int = 0;
      
      public var dropInfo:String = "";
      
      public var posInfo:String = "";
      
      public var specialInfo:String = "";
      
      public var canRefresh:Boolean = false;
      
      public var isMatch:Boolean = false;
      
      public var result:String = "";
      
      public function NewMemoryCardModel()
      {
         super();
      }
      
      public function get step() : int
      {
         return freeStep + buyStep;
      }
   }
}

