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
   import yishi.datas.templates.CommonDropSortInfo;
   import yishi.manager.CrossGuildManager;
   import yishi.manager.TempleteManager;
   
   public class CrossGuildCommonRewardView extends Component
   {
      
      private var _titleComponent:Component;
      
      private var _titleBack:MutipleImage;
      
      private var _rankText:FilterFrameText;
      
      private var _rewardText:FilterFrameText;
      
      private var _itemBox:VBox;
      
      private var _scrollPanel:ScrollPanel;
      
      private var showType:int;
      
      public function CrossGuildCommonRewardView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _titleComponent = ComponentFactory.Instance.creatComponentByStylename("CrossGuildCommonRewardView.titleComponent");
         _titleBack = ComponentFactory.Instance.creatComponentByStylename("CrossGuildCommonRewardView.titleBack");
         _rankText = ComponentFactory.Instance.creatComponentByStylename("CrossGuildCommonRewardView.rankText");
         _rewardText = ComponentFactory.Instance.creatComponentByStylename("CrossGuildCommonRewardView.rewardText");
         _itemBox = ComponentFactory.Instance.creatComponentByStylename("CrossGuildCommonRewardView.itemBox");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("CrossGuildCommonRewardView.scrollPanel");
         addChild(_titleComponent);
         addChild(_scrollPanel);
         _scrollPanel.setView(_itemBox);
         _titleComponent.addChild(_titleBack);
         _titleComponent.addChild(_rankText);
         _titleComponent.addChild(_rewardText);
         _rewardText.text = LanguageMgr.GetTranslation("CrossGuildCommonRewardView.rewardText.text");
      }
      
      public function refreshView(param1:int) : void
      {
         var _loc2_:CrossGuildCommonRewardItem = null;
         showType = param1;
         _rankText.text = LanguageMgr.GetTranslation("CrossGuildCommonRewardView.rankText.text" + showType);
         _rankText.y = _rankText.numLines > 1 ? -1 : 7;
         var _loc3_:Array = rewardAry;
         _itemBox.removeAllChild();
         for each(var _loc4_:CommonDropSortInfo in rewardAry)
         {
            _loc2_ = new CrossGuildCommonRewardItem(showType);
            _loc2_.clean();
            _loc2_.setTitleText(_loc4_.rankTitle);
            _loc2_.data = _loc4_.dropAry;
            _itemBox.addChild(_loc2_);
         }
         _scrollPanel.beginChanges();
         _scrollPanel.invalidateViewport();
         _scrollPanel.commitChanges();
      }
      
      private function get rewardAry() : Array
      {
         var _loc1_:Array = null;
         if(showType == 1)
         {
            _loc1_ = TempleteManager.instance.crossGuildRewardTempCate.getTemplatesAry();
         }
         else if(showType == 2)
         {
            _loc1_ = TempleteManager.instance.crossGuildSingleRewardTempCate.getTemplatesAry();
         }
         else if(showType == 3)
         {
            _loc1_ = TempleteManager.instance.crossGuildContributionRewardTempCate.getTemplatesAry();
         }
         return _loc1_;
      }
      
      private function get model() : CrossGuildModel
      {
         return CrossGuildManager.instance.model;
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

