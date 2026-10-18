package mvc.module.gvgcross
{
   import com.pickgliss.ui.controls.cell.INotSameHeightListCellData;
   
   public class GvgCrossSortData implements INotSameHeightListCellData
   {
      
      public var guildInfo:GvgCrossGuildInfo;
      
      public function GvgCrossSortData()
      {
         super();
      }
      
      public function getCellHeight() : Number
      {
         return 33;
      }
   }
}

