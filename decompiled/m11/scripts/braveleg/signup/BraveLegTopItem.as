package braveleg.signup
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import yishi.utils.NumberViewUtils;
   import yishi.view.community.HeadIconCell;
   
   public class BraveLegTopItem extends Component implements IListCell
   {
      
      private var _rankNumBg:ScaleFrameImage;
      
      private var _rankNum:Component;
      
      private var _head:HeadIconCell;
      
      private var _medal:ScaleFrameImage;
      
      private var _nameTxt:FilterFrameText;
      
      private var _scoreImg:Image;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _fightImg:Image;
      
      private var _fightTxt:FilterFrameText;
      
      public function BraveLegTopItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _rankNumBg = ComponentFactory.Instance.creatComponentByStylename("braveleg.RankNumBg");
         _rankNum = ComponentFactory.Instance.creatComponentByStylename("braveleg.RankNum");
         _head = ComponentFactory.Instance.creatComponentByStylename("braveleg.TopItemHead");
         _medal = ComponentFactory.Instance.creatComponentByStylename("braveleg.RankMedal");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("braveleg.RankNameTxt");
         _scoreImg = ComponentFactory.Instance.creatComponentByStylename("braveleg.RankScoreImg");
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("braveleg.RankScoreTxt");
         _fightImg = ComponentFactory.Instance.creatComponentByStylename("braveleg.RankFightImg");
         _fightTxt = ComponentFactory.Instance.creatComponentByStylename("braveleg.RankFightTxt");
         addChild(_rankNumBg);
         addChild(_rankNum);
         addChild(_head);
         addChild(_medal);
         addChild(_nameTxt);
         addChild(_scoreImg);
         addChild(_scoreTxt);
         addChild(_fightImg);
         addChild(_fightTxt);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_rankNumBg);
         _rankNumBg = null;
         ObjectUtils.disposeObject(_rankNum);
         _rankNum = null;
         ObjectUtils.disposeObject(_head);
         _head = null;
         ObjectUtils.disposeObject(_medal);
         _medal = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_scoreImg);
         _scoreImg = null;
         ObjectUtils.disposeObject(_scoreTxt);
         _scoreTxt = null;
         ObjectUtils.disposeObject(_fightImg);
         _fightImg = null;
         ObjectUtils.disposeObject(_fightTxt);
         _fightTxt = null;
         super.dispose();
      }
      
      public function getCellValue() : *
      {
         return null;
      }
      
      public function setCellValue(param1:*) : void
      {
         var _loc2_:* = null;
         if(param1)
         {
            if(param1.rankOrder <= 3)
            {
               _rankNumBg.setFrame(param1.rankOrder);
            }
            else
            {
               _rankNumBg.setFrame(4);
            }
            _rankNumBg.visible = true;
            _rankNum.visible = true;
            NumberViewUtils.printNumber(param1.rankOrder,_rankNum,ComponentFactory.Instance.creatBitmapData("asset.braveleg.RankNum"),"0123456789",-8,1);
            if(param1.nickName)
            {
               _head.headId = param1.headId > 0 ? param1.headId : param1.sexJob;
               _head.visible = true;
               _medal.tipData = LanguageMgr.GetTranslation("braveleg.GroupName.full" + (param1.teamType + 1));
               _medal.setFrame(param1.teamType + 1);
               _medal.visible = true;
               _scoreImg.visible = true;
               _fightImg.visible = true;
               _nameTxt.htmlText = LanguageMgr.GetTranslation("braveleg.SignUp.RankName",param1.nickName + "");
               _scoreTxt.text = param1.totalScore + "";
               _fightTxt.text = param1.fightPower + "";
            }
            else
            {
               _head.visible = false;
               _medal.tipData = null;
               _medal.visible = false;
               _scoreImg.visible = false;
               _fightImg.visible = false;
               _nameTxt.text = "";
               _scoreTxt.text = "";
               _fightTxt.text = "";
            }
         }
         else
         {
            _rankNumBg.visible = false;
            _rankNum.visible = false;
            _head.headId = 0;
            _head.visible = false;
            _medal.visible = false;
            _scoreImg.visible = false;
            _fightImg.visible = false;
            _nameTxt.text = "";
            _scoreTxt.text = "";
            _fightTxt.text = "";
         }
      }
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void
      {
      }
   }
}

