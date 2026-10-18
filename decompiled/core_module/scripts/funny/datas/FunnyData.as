package funny.datas
{
   import com.pickgliss.ui.core.Disposeable;
   
   public class FunnyData implements Disposeable
   {
      
      public var id:String;
      
      public var title:String;
      
      public var describe:String;
      
      public var startTime:Number;
      
      public var endTime:Number;
      
      public var showStart:Number;
      
      public var showEnd:Number;
      
      public var condition:String;
      
      public var finishNum:int = -1;
      
      public var canGet:int = -1;
      
      public var type:int = -1;
      
      public var bagList:Vector.<FunnyBagData>;
      
      public var expenseList:Vector.<KarnevalInfo>;
      
      public var getWay:int;
      
      public var anyToGet:Boolean;
      
      public var order:int;
      
      public var isInitiate:int;
      
      public var appendParam:String;
      
      public function FunnyData()
      {
         super();
         bagList = new Vector.<FunnyBagData>();
         expenseList = new Vector.<KarnevalInfo>();
      }
      
      public function dispose() : void
      {
         expenseList = null;
         bagList == null;
      }
   }
}

