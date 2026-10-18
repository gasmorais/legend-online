package areslords.rank
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   
   public class AresLordsRankItemView extends Component implements IListCell
   {
      
      private var _rank:ScaleFrameImage;
      
      private var _rankTxt:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _fightValTxt:FilterFrameText;
      
      private var _pointTxt:FilterFrameText;
      
      public function AresLordsRankItemView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _rank = ComponentFactory.Instance.creatComponentByStylename("areslords.RankItemRank");
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("areslords.RankItemRankTxt");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("areslords.RankItemNameTxt");
         _fightValTxt = ComponentFactory.Instance.creatComponentByStylename("areslords.RankItemFightValTxt");
         _pointTxt = ComponentFactory.Instance.creatComponentByStylename("areslords.RankItemPointTxt");
         addChild(_rank);
         addChild(_rankTxt);
         addChild(_nameTxt);
         addChild(_fightValTxt);
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
         ObjectUtils.disposeObject(_fightValTxt);
         _fightValTxt = null;
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
               _rankTxt.text = "";
               _nameTxt.text = LanguageMgr.GetTranslation("areslords.RankFrame.str06",param1.nickName + "",param1.serverName + "");
               _fightValTxt.text = param1.fightPower + "";
               _pointTxt.text = param1.totalScore + "";
            }
            else
            {
               _rank.visible = false;
               _rankTxt.text = param1.rankOrder;
               _nameTxt.text = LanguageMgr.GetTranslation("areslords.RankFrame.str06",param1.nickName + "",param1.serverName + "");
               _fightValTxt.text = param1.fightPower + "";
               _pointTxt.text = param1.totalScore + "";
            }
         }
         else
         {
            _rank.visible = false;
            _rankTxt.text = "";
            _nameTxt.text = "";
            _fightValTxt.text = "";
            _pointTxt.text = "";
         }
      }
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void
      {
      }
   }
}

