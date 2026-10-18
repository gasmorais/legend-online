package child.nursingspirit
{
   import child.attribute.ChildShowView;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import managers.ChildManager;
   import mvc.module.children.ChildData;
   import mvc.module.children.ChildNursingSpiritModel;
   import yishi.datas.VersionSwitch;
   import yishi.manager.PlayerManager;
   import yishi.utils.MsgMan;
   
   public class ChildNSAttributeView extends Component
   {
      
      private var _showView:ChildShowView;
      
      private var _attributeView:ChildNsAttValueView;
      
      private var _gap:MutipleImage;
      
      private var _data:ChildData;
      
      public function ChildNSAttributeView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _showView = new ChildShowView(2);
         _attributeView = new ChildNsAttValueView();
         if(VersionSwitch.CHILD_ASSIST && Boolean(PlayerManager.instance.currentPlayerModel.playerInfo.isAvenger))
         {
            _gap = ComponentFactory.Instance.creatComponentByStylename("ChildAttributeTabView.gap2");
         }
         else
         {
            _gap = ComponentFactory.Instance.creatComponentByStylename("ChildAttributeTabView.gap");
         }
         _showView.mouseEnabled = false;
         addChild(_showView);
         addChild(_attributeView);
         addChild(_gap);
         _attributeView.x = 373;
         this.mouseEnabled = false;
      }
      
      private function refreshView() : void
      {
         if(_showView)
         {
            _showView.data = _data;
         }
         if(_attributeView)
         {
            _attributeView.data = _data;
         }
         if(_data && _attributeView)
         {
            _attributeView.visible = _data.state == 1;
         }
      }
      
      private function initEvent() : void
      {
         MsgMan.addObserver("ChildEvent.CHILD_NS_INFO_SELECT",this,__changeHandler);
         MsgMan.addObserver("ChildEvent.CHILD_INFO",this,__infoHandler);
      }
      
      private function removeEvent() : void
      {
         MsgMan.removeObserver("ChildEvent.CHILD_NS_INFO_SELECT",this,__changeHandler);
         MsgMan.removeObserver("ChildEvent.CHILD_INFO",this,__infoHandler);
      }
      
      private function __changeHandler(param1:String, param2:Object) : void
      {
         data = nsModel.selectedNsChild;
      }
      
      private function __infoHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      public function get data() : ChildData
      {
         return _data;
      }
      
      public function set data(param1:ChildData) : void
      {
         if(param1 == null)
         {
            return;
         }
         _data = param1;
         refreshView();
      }
      
      private function get nsModel() : ChildNursingSpiritModel
      {
         return ChildManager.instance.nsModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_showView);
         _showView = null;
         ObjectUtils.disposeObject(_attributeView);
         _attributeView = null;
         ObjectUtils.disposeObject(_gap);
         _gap = null;
         _data = null;
         super.dispose();
      }
   }
}

