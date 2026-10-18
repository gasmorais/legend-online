package mvc.module.crossguild
{
   import com.pickgliss.ui.controls.cell.INotSameHeightListCellData;
   
   public class CrossGuildData implements INotSameHeightListCellData
   {
      
      public var guildUid:String;
      
      public var crossOrder:int;
      
      public var serverName:String;
      
      public var consortiaName:String;
      
      public var score:int;
      
      public function CrossGuildData()
      {
         super();
      }
      
      public function getCellHeight() : Number
      {
         return 33;
      }
   }
}

