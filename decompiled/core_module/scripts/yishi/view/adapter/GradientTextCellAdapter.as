package yishi.view.adapter
{
   import com.pickgliss.ui.controls.AbstractTextButton;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.text.GradientText;
   
   public class GradientTextCellAdapter extends AbstractTextButton implements IListCell
   {
      
      private var _data:Object;
      
      private var _gText:GradientText;
      
      public function GradientTextCellAdapter()
      {
         super();
      }
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void
      {
      }
      
      public function getCellValue() : *
      {
         return _data;
      }
      
      public function setCellValue(param1:*) : void
      {
         if(_data == param1)
         {
            return;
         }
         _data = param1;
         if(_data)
         {
            textStyle = _data["style"];
            text = _data["name"];
         }
      }
   }
}

