package mvc.module.maze
{
   import com.pickgliss.ui.controls.cell.INotSameHeightListCellData;
   
   public class MazeOrderInfo implements INotSameHeightListCellData
   {
      
      public var userId:int;
      
      public var job:int;
      
      public var nickName:String;
      
      public var consortiaName:String;
      
      public var mazeOrder:int;
      
      public var mazeOrder2:int;
      
      public var maxFloor:int;
      
      public var grades:int;
      
      public var fightingCapacity:int;
      
      public var isVip:Boolean;
      
      public var vipType:int;
      
      public var selected:Boolean;
      
      public function MazeOrderInfo()
      {
         super();
      }
      
      public function getCellHeight() : Number
      {
         return 38;
      }
   }
}

