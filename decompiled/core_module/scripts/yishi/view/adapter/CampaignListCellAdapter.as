package yishi.view.adapter
{
   import com.pickgliss.ui.controls.AbstractTextButton;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import manager.LanguageMgr;
   import yishi.utils.StringHelper;
   
   public class CampaignListCellAdapter extends AbstractTextButton implements IListCell
   {
      
      private var _data:*;
      
      public function CampaignListCellAdapter()
      {
         super();
         enableHtml = true;
      }
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void
      {
      }
      
      public function get formatText() : String
      {
         return StringHelper.replaceStr(text,LanguageMgr.GetTranslation("public.Activity"),"");
      }
      
      public function getCellValue() : *
      {
         return _data;
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         var _loc1_:String = _textField["text"];
         _textField["text"] = _loc1_;
      }
      
      public function setCellValue(param1:*) : void
      {
         _data = param1;
         text = "";
         if(param1)
         {
            text = param1.CampaignName;
         }
      }
   }
}

