package water.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import farm.FarmManager;
   import farm.FarmModel;
   import farm.event.FarmEvent;
   import flash.display.Sprite;
   import water.data.WaterTreeModel;
   import water.events.WaterEvent;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.WaterManager;
   
   public class WaterView extends Sprite implements Disposeable
   {
      
      private var _waterExpView:WaterExpItem;
      
      private var _contain:WaterViewContainer;
      
      public function WaterView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get farmModel() : FarmModel
      {
         return FarmManager.instance.model;
      }
      
      private function get model() : WaterTreeModel
      {
         return WaterManager.instance.model;
      }
      
      private function initView() : void
      {
         _contain = new WaterViewContainer();
         _waterExpView = ComponentFactory.Instance.creatCustomObject("water.WaterExpView");
         addChild(_contain);
         addChild(_waterExpView);
      }
      
      private function uninit() : void
      {
         ObjectUtils.disposeObject(_contain);
         _contain = null;
         ObjectUtils.disposeObject(_waterExpView);
         _waterExpView = null;
      }
      
      private function initEvent() : void
      {
         farmModel.addEventListener("SELECTED_CHANGE",__selectedFarmChange);
         WaterManager.instance.addEventListener("TREE_UPDATE",__treeInfoUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         farmModel.removeEventListener("SELECTED_CHANGE",__selectedFarmChange);
         WaterManager.instance.removeEventListener("TREE_UPDATE",__treeInfoUpdateHandler);
      }
      
      private function __treeInfoUpdateHandler(param1:WaterEvent) : void
      {
         _contain.mouseEnabled = _contain.mouseChildren = !!model.currentSelectedTreeInfo;
         _waterExpView.data = model.currentSelectedTreeInfo;
      }
      
      private function __selectedFarmChange(param1:FarmEvent) : void
      {
         _contain.mouseEnabled = _contain.mouseChildren = !model.currentSelectedTreeInfo.notHasTree;
         _waterExpView.data = model.currentSelectedTreeInfo;
      }
      
      public function get contain() : WaterViewContainer
      {
         return _contain;
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninit();
         ObjectUtils.disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}

