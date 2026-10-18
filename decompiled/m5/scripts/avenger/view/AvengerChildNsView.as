package avenger.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import managers.ChildManager;
   import mvc.module.avenger.AvengerModel;
   import mvc.module.children.ChildNursingSpiritModel;
   import yishi.manager.AvengerManager;
   
   public class AvengerChildNsView extends Component
   {
      
      private var _bg:Bitmap;
      
      private var _listView:AvengerChildNsListView;
      
      private var _nsSwordView:AvengerChildNsSwordView;
      
      public function AvengerChildNsView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.AvengerChildNsView.bg");
         _nsSwordView = ComponentFactory.Instance.creatCustomObject("AvengerChildNsView.nsSwordView");
         _listView = ComponentFactory.Instance.creatCustomObject("AvengerChildNsView.listView");
         addChild(_bg);
         addChild(_listView);
         addChild(_nsSwordView);
      }
      
      private function get nsModel() : ChildNursingSpiritModel
      {
         return ChildManager.instance.nsModel;
      }
      
      private function get model() : AvengerModel
      {
         return AvengerManager.instance.model;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_listView);
         _listView = null;
         ObjectUtils.disposeObject(_nsSwordView);
         _nsSwordView = null;
         nsModel.selectedNsChildTemp = null;
         nsModel.selectedNsChild = null;
         super.dispose();
      }
   }
}

