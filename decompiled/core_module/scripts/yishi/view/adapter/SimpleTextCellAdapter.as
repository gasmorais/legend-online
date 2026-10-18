package yishi.view.adapter
{
   import com.pickgliss.ui.controls.AbstractTextButton;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   
   public class SimpleTextCellAdapter extends AbstractTextButton implements IListCell
   {
      
      private var _str:String;
      
      public function SimpleTextCellAdapter()
      {
         super();
      }
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void
      {
      }
      
      public function getCellValue() : *
      {
         return _str;
      }
      
      public function setCellValue(param1:*) : void
      {
         if(_str == param1)
         {
            return;
         }
         _str = param1;
         text = _str.toString();
      }
   }
}

