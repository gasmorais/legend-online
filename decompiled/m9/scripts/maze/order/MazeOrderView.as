package maze.order
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import mvc.module.maze.MazeModel;
   
   public class MazeOrderView extends Sprite implements Disposeable
   {
      
      private var _listPanel:ListPanel;
      
      private var _titleBg:MutipleImage;
      
      private var _orderTitlsTxt:FilterFrameText;
      
      private var _orderNameTxt:FilterFrameText;
      
      private var _orderLayerTxt:FilterFrameText;
      
      public function MazeOrderView()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _titleBg = ComponentFactory.Instance.creatComponentByStylename("maze.OrderItemBack1");
         addChild(_titleBg);
         _orderTitlsTxt = ComponentFactory.Instance.creatComponentByStylename("maze.order.ItemTextStyle1");
         addChild(_orderTitlsTxt);
         _orderTitlsTxt.text = LanguageMgr.GetTranslation("maze.order.MazeOrderView.Titls");
         _orderNameTxt = ComponentFactory.Instance.creatComponentByStylename("maze.order.ItemTextStyle2");
         addChild(_orderNameTxt);
         _orderNameTxt.text = LanguageMgr.GetTranslation("maze.order.MazeOrderView.Name");
         _orderLayerTxt = ComponentFactory.Instance.creatComponentByStylename("maze.order.ItemTextStyle3");
         addChild(_orderLayerTxt);
         _orderLayerTxt.text = LanguageMgr.GetTranslation("maze.order.MazeOrderView.Layer");
         _listPanel = ComponentFactory.Instance.creatComponentByStylename("maze.order.PlayerListPanel");
         _listPanel.vUnitIncrement = 20;
         addChild(_listPanel);
         refreshList();
      }
      
      private function refreshList() : void
      {
         var _loc1_:int = 0;
         _listPanel.beginChanges();
         _listPanel.vectorListModel.clear();
         var _loc2_:int = int(mazeModel.mazeOrderList.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _listPanel.vectorListModel.append(mazeModel.mazeOrderList[_loc1_]);
            _loc1_++;
         }
         _listPanel.commitChanges();
         _listPanel.invalidateViewport();
         _listPanel.list.updateListView();
      }
      
      private function get mazeModel() : MazeModel
      {
         return MazeModel.instance;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         if(_listPanel)
         {
            _listPanel.dispose();
         }
         _listPanel = null;
         ObjectUtils.disposeObject(_titleBg);
         _titleBg = null;
         if(_orderLayerTxt)
         {
            _orderLayerTxt.dispose();
         }
         _orderLayerTxt = null;
         if(_orderNameTxt)
         {
            _orderNameTxt.dispose();
         }
         _orderNameTxt = null;
         if(_orderTitlsTxt)
         {
            _orderTitlsTxt.dispose();
         }
         _orderTitlsTxt = null;
      }
   }
}

