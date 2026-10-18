package yishi.view.adapter
{
   import com.pickgliss.ui.controls.AbstractTextButton;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import mvc.module.friends.FriendGroupInfo;
   
   public class FriendCellAdapter extends AbstractTextButton implements IListCell
   {
      
      private var _data:Object;
      
      public function FriendCellAdapter()
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
            if(_data is FriendGroupInfo)
            {
               text = _data.groupName;
            }
            else
            {
               text = _data["name"];
            }
         }
      }
   }
}

