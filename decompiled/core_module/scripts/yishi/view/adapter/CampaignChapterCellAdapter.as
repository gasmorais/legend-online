package yishi.view.adapter
{
   import com.pickgliss.ui.controls.AbstractTextButton;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Disposeable;
   import mvc.module.selectcampaign.CampaignChapterInfo;
   
   public class CampaignChapterCellAdapter extends AbstractTextButton implements IListCell, Disposeable
   {
      
      private var _data:CampaignChapterInfo;
      
      public function CampaignChapterCellAdapter()
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
            text = _data.getChapterName();
         }
      }
   }
}

