package yishi.view.component
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.cell.IListCellFactory;
   import com.pickgliss.utils.StringUtils;
   
   public class ListCellFactory implements IListCellFactory
   {
      
      private var _ViewWidthNoCount:int;
      
      private var _allCellHasSameHeight:Boolean;
      
      private var _cellHeight:int;
      
      private var _cellStyle:String;
      
      private var _shareCells:Boolean;
      
      private var _buttonGroup:SelectedButtonGroup;
      
      public function ListCellFactory(param1:String, param2:int, param3:int = -1, param4:String = "true", param5:Boolean = true)
      {
         super();
         _cellStyle = param1;
         _allCellHasSameHeight = StringUtils.converBoolean(param4);
         _shareCells = param5;
         _cellHeight = param2;
         _ViewWidthNoCount = param3;
         _buttonGroup = new SelectedButtonGroup();
      }
      
      public function createNewCell() : IListCell
      {
         var _loc1_:IListCell = ComponentFactory.Instance.creat(_cellStyle);
         _buttonGroup.addSelectItem(_loc1_ as ISelectable);
         return _loc1_;
      }
      
      public function getCellHeight() : int
      {
         return _cellHeight;
      }
      
      public function getViewWidthNoCount() : int
      {
         return _ViewWidthNoCount;
      }
      
      public function isAllCellHasSameHeight() : Boolean
      {
         return _allCellHasSameHeight;
      }
      
      public function isShareCells() : Boolean
      {
         return _shareCells;
      }
   }
}

