package sevenyear.view.battleflag
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.active.anniversary.SevenYearOrderMsg;
   import manager.LanguageMgr;
   import managers.SevenYearManager;
   import mvc.module.sevenyear.SevenYearModel;
   import mvc.module.sevenyear.SevenYearRankInfo;
   import sevenyear.view.item.SevenYearRankItem;
   
   public class SevenYearRankView extends Component
   {
      
      private var _bg:MutipleImage;
      
      private var _rankGradeTxt:FilterFrameText;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _vBox:VBox;
      
      public function SevenYearRankView()
      {
         super();
         initView();
         refreshView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("SevenYearRankView.bg");
         _rankGradeTxt = ComponentFactory.Instance.creatComponentByStylename("SevenYearRankView.rankGradeTxt");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("SevenYearRankView.scrollPanel");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("SevenYearRankView.vBox");
         addChild(_bg);
         addChild(_rankGradeTxt);
         addChild(_vBox);
         _scrollPanel.setView(_vBox);
         _scrollPanel.invalidateViewport();
         addChild(_scrollPanel);
         _rankGradeTxt.text = LanguageMgr.GetTranslation("SevenYearRankView.rankGradeTxt.text");
      }
      
      public function refreshView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:SevenYearOrderMsg = null;
         var _loc4_:SevenYearRankInfo = null;
         var _loc2_:SevenYearRankItem = null;
         _vBox.removeAllChild();
         _scrollPanel.beginChanges();
         _loc3_ = 0;
         while(_loc3_ < model.orders.length)
         {
            _loc1_ = model.orders[_loc3_];
            _loc4_ = new SevenYearRankInfo();
            _loc4_.nickName = _loc1_.nickName;
            _loc4_.severName = _loc1_.serverName;
            _loc4_.flagGrade = _loc1_.flagGrade;
            _loc2_ = ComponentFactory.Instance.creatCustomObject("SevenYearRankView.rankItem");
            _loc2_.data = _loc4_;
            _vBox.addChild(_loc2_);
            _loc3_++;
         }
         _scrollPanel.invalidateViewport();
      }
      
      private function get model() : SevenYearModel
      {
         return SevenYearManager.instance.model;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_rankGradeTxt);
         _rankGradeTxt = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         super.dispose();
      }
   }
}

