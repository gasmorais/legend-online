package areslords.room.left
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   
   public class AresLordsRoomLeftListItem extends Component implements IListCell
   {
      
      private var _rank:ScaleFrameImage;
      
      private var _rankTxt:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _pointTxt:FilterFrameText;
      
      public function AresLordsRoomLeftListItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _rank = ComponentFactory.Instance.creatComponentByStylename("areslordsroom.LeftListRank");
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("areslordsroom.LeftListRankTxt");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("areslordsroom.LeftListNameTxt");
         _pointTxt = ComponentFactory.Instance.creatComponentByStylename("areslordsroom.LeftListPointTxt");
         addChild(_rank);
         addChild(_rankTxt);
         addChild(_nameTxt);
         addChild(_pointTxt);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_rank);
         _rank = null;
         ObjectUtils.disposeObject(_rankTxt);
         _rankTxt = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_pointTxt);
         _pointTxt = null;
         super.dispose();
      }
      
      public function getCellValue() : *
      {
         return null;
      }
      
      public function setCellValue(param1:*) : void
      {
         if(param1)
         {
            if(param1.rankOrder <= 3)
            {
               _rank.visible = true;
               _rank.setFrame(param1.rankOrder);
               _rankTxt.textFormatStyle = "areslordsroom.format_3";
               _rankTxt.text = "";
               _nameTxt.textFormatStyle = "areslordsroom.format_3";
               _nameTxt.text = param1.nickName + "";
               _pointTxt.textFormatStyle = "areslordsroom.format_3";
               _pointTxt.text = param1.totalScore + "";
            }
            else
            {
               _rank.visible = false;
               _rankTxt.textFormatStyle = "areslordsroom.format_4";
               _rankTxt.text = param1.rankOrder;
               _nameTxt.textFormatStyle = "areslordsroom.format_4";
               _nameTxt.text = param1.nickName + "";
               _pointTxt.textFormatStyle = "areslordsroom.format_4";
               _pointTxt.text = param1.totalScore + "";
            }
         }
         else
         {
            _rank.visible = false;
            _rankTxt.text = "";
            _nameTxt.text = "";
            _pointTxt.text = "";
         }
      }
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void
      {
      }
   }
}

