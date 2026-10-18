package friends.view
{
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import im.view.IMHistoryCell;
   
   public class IMHistoryCellAdapter extends Component implements IListCell
   {
      
      private var _data:IMHistoryCell;
      
      public function IMHistoryCellAdapter()
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
         if(_data)
         {
            _data.dispose();
            _data = null;
         }
         _data = param1;
         if(_data)
         {
            addChild(_data);
         }
      }
      
      override public function dispose() : void
      {
         if(_data)
         {
            _data.dispose();
         }
         _data = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

