package mvc.module.singlepass
{
   import com.pickgliss.ui.controls.cell.INotSameHeightListCellData;
   
   public class SinglePassOrderInfo implements INotSameHeightListCellData
   {
      
      public var userId:int;
      
      public var job:int;
      
      public var nickName:String;
      
      public var consortiaName:String;
      
      public var grades:int;
      
      public var order:int;
      
      public var index:int;
      
      public var fightingCapacity:int;
      
      public var isVip:Boolean;
      
      public var vipType:int;
      
      public var selected:Boolean;
      
      public function SinglePassOrderInfo()
      {
         super();
      }
      
      public function getCellHeight() : Number
      {
         return 38;
      }
   }
}

