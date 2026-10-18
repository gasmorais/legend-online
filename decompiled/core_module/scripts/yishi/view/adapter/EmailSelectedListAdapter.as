package yishi.view.adapter
{
   import com.pickgliss.ui.controls.AbstractTextButton;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import yishi.datas.playerinfo.ThaneInfo;
   
   public class EmailSelectedListAdapter extends AbstractTextButton implements IListCell
   {
      
      private var _data:ThaneInfo;
      
      public function EmailSelectedListAdapter()
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
         _data = param1;
         text = _data.nickName;
      }
   }
}

