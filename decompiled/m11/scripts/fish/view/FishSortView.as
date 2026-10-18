package fish.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import managers.FishManager;
   import mvc.module.fish.FishModel;
   
   public class FishSortView extends Sprite implements Disposeable
   {
      
      private var _model:FishModel = FishManager.instance.model;
      
      private var _listPanel:ListPanel;
      
      private var _orderTitlsTxt:FilterFrameText;
      
      private var _orderNameTxt:FilterFrameText;
      
      private var _orderLevelTxt:FilterFrameText;
      
      private var _orderScoreTxt:FilterFrameText;
      
      private var _orderAppellTxt:FilterFrameText;
      
      public function FishSortView()
      {
         super();
         initView();
         refreshList();
      }
      
      private function initView() : void
      {
         _orderTitlsTxt = ComponentFactory.Instance.creatComponentByStylename("fish.FishSort.ItemTextStyle1");
         _orderNameTxt = ComponentFactory.Instance.creatComponentByStylename("fish.FishSort.ItemTextStyle2");
         _orderLevelTxt = ComponentFactory.Instance.creatComponentByStylename("fish.FishSort.ItemTextStyle3");
         _orderScoreTxt = ComponentFactory.Instance.creatComponentByStylename("fish.FishSort.ItemTextStyle4");
         _orderAppellTxt = ComponentFactory.Instance.creatComponentByStylename("fish.FishSort.ItemTextStyle5");
         _listPanel = ComponentFactory.Instance.creatComponentByStylename("fish.FishSort.ListPanel");
         _listPanel.vScrollbar.visible = false;
         addChild(_orderTitlsTxt);
         addChild(_orderNameTxt);
         addChild(_orderLevelTxt);
         addChild(_orderScoreTxt);
         addChild(_orderAppellTxt);
         addChild(_listPanel);
         _orderTitlsTxt.text = LanguageMgr.GetTranslation("fish.FishSort.Titls");
         _orderNameTxt.text = LanguageMgr.GetTranslation("fish.FishSort.Name");
         _orderLevelTxt.text = LanguageMgr.GetTranslation("fish.FishSort.Level");
         _orderScoreTxt.text = LanguageMgr.GetTranslation("fish.FishSort.Score");
         _orderAppellTxt.text = LanguageMgr.GetTranslation("fish.FishSort.Appell");
      }
      
      private function refreshList() : void
      {
         var _loc2_:int = 0;
         _listPanel.beginChanges();
         _listPanel.vectorListModel.clear();
         var _loc3_:int = int(_model.orderList.length);
         var _loc1_:int = _loc3_;
         if(_loc3_ < 8)
         {
            _loc1_ = 8;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            if(_loc2_ <= _loc3_ - 1)
            {
               _listPanel.vectorListModel.append(_model.orderList[_loc2_]);
            }
            else
            {
               _listPanel.vectorListModel.append(null);
            }
            _loc2_++;
         }
         _listPanel.commitChanges();
         _listPanel.invalidateViewport();
         _listPanel.list.updateListView();
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_orderTitlsTxt);
         _orderTitlsTxt = null;
         ObjectUtils.disposeObject(_orderNameTxt);
         _orderNameTxt = null;
         ObjectUtils.disposeObject(_orderLevelTxt);
         _orderLevelTxt = null;
         ObjectUtils.disposeObject(_orderScoreTxt);
         _orderScoreTxt = null;
         ObjectUtils.disposeObject(_orderAppellTxt);
         _orderAppellTxt = null;
         ObjectUtils.disposeObject(_listPanel);
         _listPanel = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      public function dispose() : void
      {
         uninitView();
      }
   }
}

