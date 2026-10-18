package areslords.start
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
   import yishi.utils.IconFactory;
   import yishi.utils.NumberViewUtils;
   import yishi.view.community.BaseIconView;
   
   public class AresLordsStartRankItemView extends Component implements IListCell
   {
      
      private var _bg:Image;
      
      private var _rankNumBg:ScaleFrameImage;
      
      private var _rankNum:Component;
      
      private var _headBg:Image;
      
      private var _head:BaseIconView;
      
      private var _fightTitle:Image;
      
      private var _point:Component;
      
      private var _pointImg:Image;
      
      private var _medal:ScaleFrameImage;
      
      private var _groupName:ScaleFrameImage;
      
      private var _nameTitleTxt:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _svrNameTitleTxt:FilterFrameText;
      
      private var _svrNameTxt:FilterFrameText;
      
      private var _fightTxt:FilterFrameText;
      
      public function AresLordsStartRankItemView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("areslords.StartRankBg");
         _rankNumBg = ComponentFactory.Instance.creatComponentByStylename("areslords.StartRankNumBg");
         _rankNum = ComponentFactory.Instance.creatComponentByStylename("areslords.StartRankNum");
         _headBg = ComponentFactory.Instance.creatComponentByStylename("areslords.StartRankHeadBg");
         _head = ComponentFactory.Instance.creatComponentByStylename("areslords.StartRankHead");
         _fightTitle = ComponentFactory.Instance.creatComponentByStylename("areslords.StartRankFightTitle");
         _point = ComponentFactory.Instance.creatComponentByStylename("areslords.StartRankPointNum");
         _pointImg = ComponentFactory.Instance.creatComponentByStylename("areslords.StartRankPointImg");
         _medal = ComponentFactory.Instance.creatComponentByStylename("areslords.StartRankMedal");
         _groupName = ComponentFactory.Instance.creatComponentByStylename("areslords.StartRankGroupName");
         _nameTitleTxt = ComponentFactory.Instance.creatComponentByStylename("areslords.StartRankNameTitleTxt");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("areslords.StartRankNameTxt");
         _svrNameTitleTxt = ComponentFactory.Instance.creatComponentByStylename("areslords.StartRankSvrNameTitleTxt");
         _svrNameTxt = ComponentFactory.Instance.creatComponentByStylename("areslords.StartRankSvrNameTxt");
         _fightTxt = ComponentFactory.Instance.creatComponentByStylename("areslords.StartRankFightTxt");
         addChild(_bg);
         addChild(_rankNumBg);
         addChild(_rankNum);
         addChild(_headBg);
         addChild(_head);
         addChild(_fightTitle);
         addChild(_point);
         addChild(_pointImg);
         addChild(_medal);
         addChild(_groupName);
         addChild(_nameTitleTxt);
         addChild(_nameTxt);
         addChild(_svrNameTitleTxt);
         addChild(_svrNameTxt);
         addChild(_fightTxt);
         _nameTitleTxt.text = LanguageMgr.GetTranslation("areslords.StartFrame.name");
         _svrNameTitleTxt.text = LanguageMgr.GetTranslation("areslords.StartFrame.svrname");
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_rankNumBg);
         _rankNumBg = null;
         ObjectUtils.disposeObject(_rankNum);
         _rankNum = null;
         ObjectUtils.disposeObject(_headBg);
         _headBg = null;
         ObjectUtils.disposeObject(_head);
         _head = null;
         ObjectUtils.disposeObject(_fightTitle);
         _fightTitle = null;
         ObjectUtils.disposeObject(_point);
         _point = null;
         ObjectUtils.disposeObject(_pointImg);
         _pointImg = null;
         ObjectUtils.disposeObject(_medal);
         _medal = null;
         ObjectUtils.disposeObject(_groupName);
         _groupName = null;
         ObjectUtils.disposeObject(_nameTitleTxt);
         _nameTitleTxt = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_svrNameTitleTxt);
         _svrNameTitleTxt = null;
         ObjectUtils.disposeObject(_svrNameTxt);
         _svrNameTxt = null;
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
         if(param1)
         {
            addChild(_rankNumBg);
            addChild(_rankNum);
            if(param1.rankOrder <= 3)
            {
               _rankNumBg.setFrame(param1.rankOrder);
            }
            else
            {
               _rankNumBg.setFrame(4);
            }
            NumberViewUtils.printNumber(param1.rankOrder,_rankNum,ComponentFactory.Instance.creatBitmapData("asset.areslords.StartRankNum"),"0123456789",-8,1);
            if(param1.nickName)
            {
               addChild(_headBg);
               addChild(_head);
               addChild(_fightTitle);
               addChild(_point);
               addChild(_pointImg);
               addChild(_medal);
               addChild(_groupName);
               addChild(_nameTitleTxt);
               addChild(_nameTxt);
               addChild(_svrNameTitleTxt);
               addChild(_svrNameTxt);
               addChild(_fightTxt);
               _head.icon = IconFactory.getHeadIcon(param1.sexJob,"head");
               NumberViewUtils.printNumber(param1.totalScore,_point,ComponentFactory.Instance.creatBitmapData("asset.areslords.StartFightNum"),"0123456789",-4,2);
               _medal.setFrame(param1.teamType + 1);
               _groupName.setFrame(param1.teamType + 1);
               _nameTxt.text = param1.nickName + "";
               _svrNameTxt.text = param1.serverName + "";
               _fightTxt.text = param1.fightPower + "";
            }
            else
            {
               ObjectUtils.removeFromParent(_headBg);
               ObjectUtils.removeFromParent(_head);
               ObjectUtils.removeFromParent(_fightTitle);
               ObjectUtils.removeFromParent(_point);
               ObjectUtils.removeFromParent(_pointImg);
               ObjectUtils.removeFromParent(_medal);
               ObjectUtils.removeFromParent(_groupName);
               ObjectUtils.removeFromParent(_nameTitleTxt);
               ObjectUtils.removeFromParent(_nameTxt);
               ObjectUtils.removeFromParent(_svrNameTitleTxt);
               ObjectUtils.removeFromParent(_svrNameTxt);
               ObjectUtils.removeFromParent(_fightTxt);
            }
         }
         else
         {
            ObjectUtils.removeFromParent(_rankNumBg);
            ObjectUtils.removeFromParent(_rankNum);
            ObjectUtils.removeFromParent(_headBg);
            ObjectUtils.removeFromParent(_head);
            ObjectUtils.removeFromParent(_fightTitle);
            ObjectUtils.removeFromParent(_point);
            ObjectUtils.removeFromParent(_pointImg);
            ObjectUtils.removeFromParent(_medal);
            ObjectUtils.removeFromParent(_groupName);
            ObjectUtils.removeFromParent(_nameTitleTxt);
            ObjectUtils.removeFromParent(_nameTxt);
            ObjectUtils.removeFromParent(_svrNameTitleTxt);
            ObjectUtils.removeFromParent(_svrNameTxt);
            ObjectUtils.removeFromParent(_fightTxt);
         }
      }
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void
      {
      }
   }
}

