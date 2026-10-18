package child.nursingspirit
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import managers.ChildManager;
   import mvc.module.children.ChildData;
   import mvc.module.children.ChildNursingSpiritModel;
   import yishi.utils.MsgMan;
   
   public class ChildNSTreasureMostView extends Component
   {
      
      private var _conversionBtn:SelectedIconButton;
      
      private var _castingBtn:SelectedIconButton;
      
      private var _group:SelectedButtonGroup;
      
      private var _hbox:HBox;
      
      private var _childTreasureMostInfoView:ChildNSMostConversionInfoView;
      
      private var _data:ChildData;
      
      public function ChildNSTreasureMostView()
      {
         super();
         initView();
         initEvent();
         mouseEnabled = false;
         _group.selectIndex = 0;
      }
      
      private function initView() : void
      {
         _conversionBtn = ComponentFactory.Instance.creatComponentByStylename("childTreasureMostView.conversionBtn");
         _castingBtn = ComponentFactory.Instance.creatComponentByStylename("childTreasureMostView.castingBtn");
         _hbox = ComponentFactory.Instance.creatComponentByStylename("childTreasureMostView.hbox");
         _group = new SelectedButtonGroup();
         _childTreasureMostInfoView = ComponentFactory.Instance.creatCustomObject("childTreasureMostView.childSkill");
         _group.addSelectItem(_conversionBtn);
         addChild(_hbox);
         _hbox.addChild(_conversionBtn);
         addChild(_childTreasureMostInfoView);
      }
      
      private function initEvent() : void
      {
         MsgMan.addObserver("ChildEvent.CHILD_NS_INFO_SELECT",this,__changeHandler);
         MsgMan.addObserver("ChildEvent.CHILD_INFO",this,__infoHandler);
         if(_group)
         {
            _group.addEventListener("change",__groupChangeHandler);
         }
      }
      
      private function removeEvent() : void
      {
         MsgMan.removeObserver("ChildEvent.CHILD_NS_INFO_SELECT",this,__changeHandler);
         MsgMan.removeObserver("ChildEvent.CHILD_INFO",this,__infoHandler);
         if(_group)
         {
            _group.removeEventListener("change",__groupChangeHandler);
         }
      }
      
      private function __groupChangeHandler(param1:Event) : void
      {
      }
      
      private function __changeHandler(param1:String, param2:Object) : void
      {
         data = nsModel.selectedNsChild;
      }
      
      private function __infoHandler(param1:String, param2:Object) : void
      {
         refreshView();
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
      
      private function refreshView() : void
      {
         if(_childTreasureMostInfoView)
         {
            _childTreasureMostInfoView.data = _data;
         }
      }
      
      private function get nsModel() : ChildNursingSpiritModel
      {
         return ChildManager.instance.nsModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_group)
         {
            ObjectUtils.disposeObject(_group);
         }
         _group = null;
         if(_conversionBtn)
         {
            ObjectUtils.disposeObject(_conversionBtn);
         }
         _conversionBtn = null;
         if(_castingBtn)
         {
            ObjectUtils.disposeObject(_castingBtn);
         }
         _castingBtn = null;
         if(_childTreasureMostInfoView)
         {
            ObjectUtils.disposeObject(_childTreasureMostInfoView);
         }
         _childTreasureMostInfoView = null;
         if(_hbox)
         {
            ObjectUtils.disposeObject(_hbox);
         }
         _hbox = null;
         super.dispose();
      }
   }
}

