package sevenyear.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.SevenYearEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.SevenYearManager;
   import mvc.module.sevenyear.SevenYearModel;
   import sevenyear.view.item.SevenYearAchievementItem;
   import utils.LogicUtils;
   import yishi.manager.TempleteManager;
   
   public class SevenYearAchievementView extends Component
   {
      
      private var _bg:MutipleImage;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _list:SimpleTileList;
      
      private var _itemList:Vector.<SevenYearAchievementItem>;
      
      private var _achievementTxt:FilterFrameText;
      
      private var _scoreTxt:FilterFrameText;
      
      public function SevenYearAchievementView()
      {
         super();
         initView();
         initEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("SevenYearAchievementView.bg");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("SevenYearAchievementView.scrollPanel");
         _list = ComponentFactory.Instance.creatCustomObject("SevenYearAchievementView.list",[3]);
         _achievementTxt = ComponentFactory.Instance.creatComponentByStylename("SevenYearAchievementView.achievementTxt");
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("SevenYearAchievementView.scoreTxt");
         addChild(_bg);
         addChild(_list);
         addChild(_achievementTxt);
         addChild(_scoreTxt);
         _scrollPanel.setView(_list);
         _scrollPanel.invalidateViewport();
         addChild(_scrollPanel);
         initItem();
      }
      
      private function initItem() : void
      {
         var _loc1_:SevenYearAchievementItem = null;
         _scrollPanel.beginChanges();
         _itemList = new Vector.<SevenYearAchievementItem>();
         for each(var _loc2_:int in typeDic)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("SevenYearAchievementView.item",[_loc2_]);
            _list.addChild(_loc1_);
            _itemList.push(_loc1_);
         }
         _scrollPanel.invalidateViewport();
      }
      
      private function refreshView() : void
      {
         var _loc2_:int = 0;
         for each(var _loc1_:SevenYearAchievementItem in _itemList)
         {
            _loc1_.refreshView();
            _loc2_ += _loc1_.achievedCount;
         }
         _achievementTxt.text = LanguageMgr.GetTranslation("SevenYearAchievementView.achievementTxt.text",_loc2_,model.achievementMaxCount);
         _scoreTxt.text = LanguageMgr.GetTranslation("SevenYearAchievementView.achievementTxt.text",model.achievementTotalScore,model.achievementMaxScore);
      }
      
      private function initEvent() : void
      {
         model.addEventListener("UPDATE_USER_INFO",__updateUserInfoHandler);
      }
      
      private function removeEvent() : void
      {
         model.removeEventListener("UPDATE_USER_INFO",__updateUserInfoHandler);
      }
      
      private function __updateUserInfoHandler(param1:SevenYearEvent) : void
      {
         refreshView();
      }
      
      private function get model() : SevenYearModel
      {
         return SevenYearManager.instance.model;
      }
      
      private function get typeDic() : Dictionary
      {
         return TempleteManager.instance.sevenYearAchievementTempCate.getTypeTemplates();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         ObjectUtils.disposeObject(_list);
         _list = null;
         ObjectUtils.disposeObject(_achievementTxt);
         _achievementTxt = null;
         ObjectUtils.disposeObject(_scoreTxt);
         _scoreTxt = null;
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
         super.dispose();
      }
   }
}

