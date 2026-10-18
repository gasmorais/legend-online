package lordtrial.rank
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import mvc.module.lordtrial.LordTrialRankInfo;
   
   public class LordTrialRankItem extends Component implements IListCell
   {
      
      private var _rankScaleFrameImg:ScaleFrameImage;
      
      private var _rankTxt:FilterFrameText;
      
      private var _vipImg:Image;
      
      private var _nickNameTxt:FilterFrameText;
      
      private var _layerNumTxt:FilterFrameText;
      
      private var _data:LordTrialRankInfo;
      
      public function LordTrialRankItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _rankScaleFrameImg = ComponentFactory.Instance.creatComponentByStylename("lordTrialRankItem.rankScaleFrameImg");
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("lordTrialRankItem.rankTxt");
         _vipImg = ComponentFactory.Instance.creatComponentByStylename("lordTrialRankItem.vipImg");
         _nickNameTxt = ComponentFactory.Instance.creatComponentByStylename("lordTrialRankItem.nickNameTxt");
         _layerNumTxt = ComponentFactory.Instance.creatComponentByStylename("lordTrialRankItem.layerNumTxt");
         addChild(_rankScaleFrameImg);
         addChild(_rankTxt);
         addChild(_vipImg);
         addChild(_nickNameTxt);
         addChild(_layerNumTxt);
         _rankScaleFrameImg.setFrame(1);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_rankScaleFrameImg);
         _rankScaleFrameImg = null;
         ObjectUtils.disposeObject(_rankTxt);
         _rankTxt = null;
         ObjectUtils.disposeObject(_vipImg);
         _vipImg = null;
         ObjectUtils.disposeObject(_nickNameTxt);
         _nickNameTxt = null;
         ObjectUtils.disposeObject(_layerNumTxt);
         _layerNumTxt = null;
         super.dispose();
      }
      
      public function getCellValue() : *
      {
         return null;
      }
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void
      {
      }
      
      public function setCellValue(param1:*) : void
      {
         if(param1)
         {
            if(param1.isVip == "true")
            {
               _vipImg.visible = true;
            }
            else
            {
               _vipImg.visible = false;
            }
            _nickNameTxt.text = param1.userName;
            _layerNumTxt.text = param1.layerNum.toString();
            if(param1.rank <= 3)
            {
               _rankScaleFrameImg.visible = true;
               _rankTxt.visible = false;
               _rankScaleFrameImg.setFrame(param1.rank);
            }
            else
            {
               _rankScaleFrameImg.visible = false;
               _rankTxt.visible = true;
               _rankTxt.text = param1.rank.toString();
            }
         }
         else
         {
            _vipImg.visible = false;
            _nickNameTxt.text = "";
            _layerNumTxt.text = "";
            _rankTxt.text = "";
            _rankScaleFrameImg.visible = false;
         }
      }
   }
}

