package gamehall.room
{
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Disposeable;
   import mvc.module.gamehall.GameHallGameInfo;
   
   public class GameHallGameCellAdapter extends TextButton implements IListCell, Disposeable
   {
      
      private var _data:GameHallGameInfo;
      
      public function GameHallGameCellAdapter()
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
            text = _data.gameName;
         }
      }
   }
}

