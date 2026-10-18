package mvc.module.exchargerank
{
   import com.pickgliss.ui.core.Disposeable;
   import funny.datas.FunnyBagData;
   
   public class ExchargeData implements Disposeable
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
      
      public var getWay:int;
      
      public var anyToGet:Boolean;
      
      public var order:int;
      
      public var isInitiate:int;
      
      public var appendParam:String;
      
      private var _bagList:Vector.<FunnyBagData>;
      
      public function ExchargeData()
      {
         super();
         _bagList = new Vector.<FunnyBagData>();
      }
      
      public function dispose() : void
      {
         _bagList = null;
      }
      
      public function get bagList() : Vector.<FunnyBagData>
      {
         return _bagList;
      }
      
      public function set bagList(param1:Vector.<FunnyBagData>) : void
      {
         _bagList = param1;
      }
   }
}

