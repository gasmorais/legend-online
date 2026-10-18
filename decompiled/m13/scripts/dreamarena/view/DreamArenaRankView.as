package dreamarena.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import dreamarena.item.DreamArenaRankItem;
   import manager.LanguageMgr;
   import managers.DreamArenaManager;
   import mvc.module.dreamarena.DreamArenaModel;
   
   public class DreamArenaRankView extends Component
   {
      
      private var _titleBack:MutipleImage;
      
      private var _rankText:FilterFrameText;
      
      private var _nameText:FilterFrameText;
      
      private var _scoreText:FilterFrameText;
      
      private var _itemBox:VBox;
      
      private var _scrollPanel:ScrollPanel;
      
      public function DreamArenaRankView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _titleBack = ComponentFactory.Instance.creatComponentByStylename("DreamArenaRankView.titleBack");
         _rankText = ComponentFactory.Instance.creatComponentByStylename("DreamArenaRankView.rankText");
         _nameText = ComponentFactory.Instance.creatComponentByStylename("DreamArenaRankView.nameText");
         _scoreText = ComponentFactory.Instance.creatComponentByStylename("DreamArenaRankView.scoreText");
         _itemBox = ComponentFactory.Instance.creatComponentByStylename("DreamArenaRankView.itemBox");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("DreamArenaRankView.scrollPanel");
         addChild(_titleBack);
         addChild(_rankText);
         addChild(_nameText);
         addChild(_scoreText);
         addChild(_scrollPanel);
         _scrollPanel.setView(_itemBox);
         _rankText.text = LanguageMgr.GetTranslation("colosseum.view.HeroRankFrame.rank");
         _nameText.text = LanguageMgr.GetTranslation("outyard.OutyardMemberFrame.sortText2");
         _scoreText.text = LanguageMgr.GetTranslation("apexroom.rightView.str3");
      }
      
      public function refreshListView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:DreamArenaRankItem = null;
         _itemBox.removeAllChild();
         var _loc2_:int = int(model.rankList.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = new DreamArenaRankItem();
            _loc1_.data = model.rankList[_loc3_];
            _itemBox.addChild(_loc1_);
            _loc3_++;
         }
         _scrollPanel.beginChanges();
         _scrollPanel.invalidateViewport();
         _scrollPanel.commitChanges();
      }
      
      private function get model() : DreamArenaModel
      {
         return DreamArenaManager.instance.model;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_titleBack);
         _titleBack = null;
         ObjectUtils.disposeObject(_rankText);
         _rankText = null;
         ObjectUtils.disposeObject(_nameText);
         _nameText = null;
         ObjectUtils.disposeObject(_scoreText);
         _scoreText = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         ObjectUtils.disposeObject(_itemBox);
         _itemBox = null;
         super.dispose();
      }
   }
}

