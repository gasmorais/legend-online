package dreamarena.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import dreamarena.item.DreamArenaRewardItem;
   import manager.LanguageMgr;
   import managers.DreamArenaManager;
   import mvc.module.dreamarena.DreamArenaModel;
   import yishi.datas.templates.CommonDropSortInfo;
   import yishi.manager.TempleteManager;
   
   public class DreamArenaRewardView extends Component
   {
      
      private var _titleComponent:Component;
      
      private var _titleBack:MutipleImage;
      
      private var _rankText:FilterFrameText;
      
      private var _rewardText:FilterFrameText;
      
      private var _itemBox:VBox;
      
      private var _scrollPanel:ScrollPanel;
      
      public function DreamArenaRewardView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _titleComponent = ComponentFactory.Instance.creatComponentByStylename("DreamArenaRewardView.titleComponent");
         _titleBack = ComponentFactory.Instance.creatComponentByStylename("DreamArenaRewardView.titleBack");
         _rankText = ComponentFactory.Instance.creatComponentByStylename("DreamArenaRewardView.rankText");
         _rewardText = ComponentFactory.Instance.creatComponentByStylename("DreamArenaRewardView.rewardText");
         _itemBox = ComponentFactory.Instance.creatComponentByStylename("DreamArenaRewardView.itemBox");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("DreamArenaRewardView.scrollPanel");
         addChild(_titleComponent);
         addChild(_scrollPanel);
         _scrollPanel.setView(_itemBox);
         _titleComponent.addChild(_titleBack);
         _titleComponent.addChild(_rankText);
         _titleComponent.addChild(_rewardText);
         _rewardText.text = LanguageMgr.GetTranslation("CrossGuildCommonRewardView.rewardText.text");
         _rankText.text = LanguageMgr.GetTranslation("apex.rank.str1");
      }
      
      public function refreshView() : void
      {
         var _loc1_:DreamArenaRewardItem = null;
         var _loc2_:Array = TempleteManager.instance.dreamArenaRewardTempCate.getTemplatesAry();
         _itemBox.removeAllChild();
         for each(var _loc3_:CommonDropSortInfo in _loc2_)
         {
            _loc1_ = new DreamArenaRewardItem();
            _loc1_.clean();
            _loc1_.setTitleText(_loc3_.rankTitle);
            _loc1_.data = _loc3_.dropAry;
            _itemBox.addChild(_loc1_);
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
         ObjectUtils.disposeObject(_titleComponent);
         _titleComponent = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         ObjectUtils.disposeObject(_itemBox);
         _itemBox = null;
         ObjectUtils.disposeObject(_titleBack);
         _titleBack = null;
         ObjectUtils.disposeObject(_rankText);
         _rankText = null;
         ObjectUtils.disposeObject(_rewardText);
         _rewardText = null;
         super.dispose();
      }
   }
}

