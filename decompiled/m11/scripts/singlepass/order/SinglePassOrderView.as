package singlepass.order
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import managers.SinglePassManager;
   import mvc.module.singlepass.SinglePassModel;
   
   public class SinglePassOrderView extends Sprite implements Disposeable
   {
      
      private var _model:SinglePassModel = SinglePassManager.instance.model;
      
      private var _listPanel:ListPanel;
      
      private var _orderTitlsTxt:FilterFrameText;
      
      private var _orderNameTxt:FilterFrameText;
      
      private var _orderLayerTxt:FilterFrameText;
      
      public function SinglePassOrderView()
      {
         super();
         initView();
         refreshList();
      }
      
      private function initView() : void
      {
         _orderTitlsTxt = ComponentFactory.Instance.creatComponentByStylename("singlepass.order.ItemTextStyle1");
         _orderNameTxt = ComponentFactory.Instance.creatComponentByStylename("singlepass.order.ItemTextStyle2");
         _orderLayerTxt = ComponentFactory.Instance.creatComponentByStylename("singlepass.order.ItemTextStyle3");
         _listPanel = ComponentFactory.Instance.creatComponentByStylename("singlepass.order.PlayerListPanel");
         addChild(_orderTitlsTxt);
         addChild(_orderNameTxt);
         addChild(_orderLayerTxt);
         addChild(_listPanel);
         _orderTitlsTxt.text = LanguageMgr.GetTranslation("maze.order.MazeOrderView.Titls");
         _orderNameTxt.text = LanguageMgr.GetTranslation("maze.order.MazeOrderView.Name");
         _orderLayerTxt.text = LanguageMgr.GetTranslation("maze.order.MazeOrderView.Layer");
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_orderTitlsTxt);
         _orderTitlsTxt = null;
         ObjectUtils.disposeObject(_orderNameTxt);
         _orderNameTxt = null;
         ObjectUtils.disposeObject(_orderLayerTxt);
         _orderLayerTxt = null;
         ObjectUtils.disposeObject(_listPanel);
         _listPanel = null;
         ObjectUtils.disposeAllChildren(this);
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
      
      public function dispose() : void
      {
         uninitView();
      }
   }
}

