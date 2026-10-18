package consortia.view.crossguild.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import mvc.module.crossguild.CrossGuildModel;
   import yishi.manager.CrossGuildManager;
   
   public class CrossGuildRankView extends Component
   {
      
      private var _titleBack:MutipleImage;
      
      private var _rankText:FilterFrameText;
      
      private var _nameText:FilterFrameText;
      
      private var _seasonScoreText:FilterFrameText;
      
      private var _itemBox:VBox;
      
      private var _scrollPanel:ScrollPanel;
      
      public function CrossGuildRankView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _titleBack = ComponentFactory.Instance.creatComponentByStylename("CrossGuildRankView.titleBack");
         _rankText = ComponentFactory.Instance.creatComponentByStylename("CrossGuildRankView.rankText");
         _nameText = ComponentFactory.Instance.creatComponentByStylename("CrossGuildRankView.nameText");
         _seasonScoreText = ComponentFactory.Instance.creatComponentByStylename("CrossGuildRankView.seasonScoreText");
         _itemBox = ComponentFactory.Instance.creatComponentByStylename("CrossGuildRankView.itemBox");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("CrossGuildRankView.scrollPanel");
         addChild(_titleBack);
         addChild(_rankText);
         addChild(_nameText);
         addChild(_seasonScoreText);
         addChild(_scrollPanel);
         _scrollPanel.setView(_itemBox);
         _rankText.text = LanguageMgr.GetTranslation("colosseum.view.HeroRankFrame.rank");
         _nameText.text = LanguageMgr.GetTranslation("sort.view.MemberTitleView.ConsortiaName");
         _seasonScoreText.text = LanguageMgr.GetTranslation("CrossGuildRankView.seasonScoreText.text");
      }
      
      public function refreshListView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:CrossGuildRanItem = null;
         _itemBox.removeAllChild();
         var _loc2_:int = int(model.guildRankList.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = new CrossGuildRanItem();
            _loc1_.data = model.guildRankList[_loc3_];
            _itemBox.addChild(_loc1_);
            _loc3_++;
         }
         _scrollPanel.beginChanges();
         _scrollPanel.invalidateViewport();
         _scrollPanel.commitChanges();
      }
      
      private function get model() : CrossGuildModel
      {
         return CrossGuildManager.instance.model;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_titleBack);
         _titleBack = null;
         ObjectUtils.disposeObject(_rankText);
         _rankText = null;
         ObjectUtils.disposeObject(_nameText);
         _nameText = null;
         ObjectUtils.disposeObject(_seasonScoreText);
         _seasonScoreText = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         ObjectUtils.disposeObject(_itemBox);
         _itemBox = null;
         super.dispose();
      }
   }
}

