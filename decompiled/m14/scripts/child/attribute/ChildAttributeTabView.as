package child.attribute
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import managers.ChildManager;
   import mvc.module.children.ChildData;
   import mvc.module.children.ChildModel;
   import yishi.utils.MsgMan;
   
   public class ChildAttributeTabView extends Component
   {
      
      private var _showView:ChildShowView;
      
      private var _attributeView:ChildAttributeViewII;
      
      private var _gap:MutipleImage;
      
      private var _data:ChildData;
      
      public function ChildAttributeTabView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _showView = new ChildShowView(1);
         _attributeView = new ChildAttributeViewII();
         _gap = ComponentFactory.Instance.creatComponentByStylename("ChildAttributeTabView.gap");
         _showView.mouseEnabled = false;
         addChild(_showView);
         addChild(_attributeView);
         addChild(_gap);
         _attributeView.x = 373;
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
         MsgMan.addObserver("ChildEvent.HEAD_CHANGE",this,__changeHandler);
         MsgMan.addObserver("ChildEvent.CHILD_INFO",this,__infoHandler);
      }
      
      private function removeEvent() : void
      {
         MsgMan.removeObserver("ChildEvent.HEAD_CHANGE",this,__changeHandler);
         MsgMan.removeObserver("ChildEvent.CHILD_INFO",this,__infoHandler);
      }
      
      private function __changeHandler(param1:String, param2:Object) : void
      {
         if(model.selectedChild)
         {
            data = model.selectedChild;
         }
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
      
      private function get model() : ChildModel
      {
         return ChildManager.instance.model;
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

