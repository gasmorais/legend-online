package goldenDionysia.rank
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import mvc.module.exchargerank.ExchargeRankData;
   
   public class GoldenDionysiaRankView extends Component implements Disposeable
   {
      
      private var _bg:Scale9CornerImage;
      
      private var _rankText:FilterFrameText;
      
      private var _userNameText:FilterFrameText;
      
      private var _agencySeverText:FilterFrameText;
      
      private var _exchanrgeNumberText:FilterFrameText;
      
      private var _separateLine:MutipleImage;
      
      private var _listPanel:ListPanel;
      
      public function GoldenDionysiaRankView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("goldenDionysiaRank.titleShineBg");
         _separateLine = ComponentFactory.Instance.creatComponentByStylename("goldenDionysiaRank.separateLine");
         _rankText = ComponentFactory.Instance.creatComponentByStylename("goldenDionysiaRank.rankTextStyle");
         _userNameText = ComponentFactory.Instance.creatComponentByStylename("goldenDionysiaRank.userNameTextStyle");
         _agencySeverText = ComponentFactory.Instance.creatComponentByStylename("goldenDionysiaRank.agencySeverTextStyle");
         _exchanrgeNumberText = ComponentFactory.Instance.creatComponentByStylename("goldenDionysiaRank.exchanrgeNumberTextStyle");
         _listPanel = ComponentFactory.Instance.creatComponentByStylename("goldenDionysiaRank.ListPanel");
         _listPanel.hScrollProxy = 2;
         addChild(_bg);
         addChild(_separateLine);
         addChild(_rankText);
         addChild(_userNameText);
         addChild(_agencySeverText);
         addChild(_exchanrgeNumberText);
         addChild(_listPanel);
         _rankText.text = LanguageMgr.GetTranslation("exchargerankFrame.exchargeCross.rankText");
         _userNameText.text = LanguageMgr.GetTranslation("exchargerankFrame.exchargeCross.userNameText");
         _agencySeverText.text = LanguageMgr.GetTranslation("sort.view.MemberTitleView.serverText");
         _exchanrgeNumberText.text = LanguageMgr.GetTranslation("goldenDionysiaRankView.betNumTitle");
      }
      
      public function set type(param1:int) : void
      {
         if(param1 == 1)
         {
            _userNameText.visible = false;
         }
         else
         {
            _exchanrgeNumberText.visible = false;
         }
      }
      
      public function updateUI(param1:Vector.<ExchargeRankData>, param2:int = 1) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _listPanel.vectorListModel.clear();
         if(param1 != null && param1.length > 0)
         {
            _listPanel.beginChanges();
            _loc3_ = int(param1.length);
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               param1[_loc4_].isVip = param2;
               _listPanel.vectorListModel.append(param1[_loc4_]);
               _loc4_++;
            }
            _listPanel.commitChanges();
            _listPanel.invalidateViewport();
            _listPanel.list.updateListView();
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_rankText);
         _rankText = null;
         ObjectUtils.disposeObject(_userNameText);
         _userNameText = null;
         ObjectUtils.disposeObject(_agencySeverText);
         _agencySeverText = null;
         ObjectUtils.disposeObject(_exchanrgeNumberText);
         _exchanrgeNumberText = null;
         ObjectUtils.disposeObject(_separateLine);
         _separateLine = null;
         ObjectUtils.disposeObject(_listPanel);
         _listPanel = null;
         super.dispose();
      }
   }
}

