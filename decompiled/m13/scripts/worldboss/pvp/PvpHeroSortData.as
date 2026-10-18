package worldboss.pvp
{
   import com.pickgliss.ui.controls.cell.INotSameHeightListCellData;
   
   public class PvpHeroSortData implements INotSameHeightListCellData
   {
      
      public var playerName:String = "";
      
      public var serverName:String = "";
      
      public var kill:String = "";
      
      public var honor:String = "";
      
      public function PvpHeroSortData()
      {
         super();
      }
      
      public function getCellHeight() : Number
      {
         return 33;
      }
   }
}

