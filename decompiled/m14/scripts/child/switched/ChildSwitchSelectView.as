package child.switched
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import managers.ChildManager;
   import mvc.module.children.ChildModel;
   import utils.LogicUtils;
   import yishi.utils.MsgMan;
   
   public class ChildSwitchSelectView extends Component
   {
      
      private var _back:ScaleBitmapImage;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _itemList:SimpleTileList;
      
      private var _childList:Vector.<ChildSwitchSelectItemView>;
      
      private var col:int = 4;
      
      public function ChildSwitchSelectView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("ChildSwitchSelectView.back");
         _itemList = ComponentFactory.Instance.creatCustomObject("ChildSwitchSelectView.SimpleTileList",[col]);
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("ChildSwitchSelectView.scrollPanel");
         addChild(_back);
         addChild(_scrollPanel);
         _scrollPanel.setView(_itemList);
         _scrollPanel.invalidateViewport();
         _back.mouseChildren = _back.mouseEnabled = false;
      }
      
      private function addEvent() : void
      {
         MsgMan.addObserver("ChildEvent.CHILD_SWITCH_SELECT",this,__selectSwitchChildHandle);
      }
      
      private function removeEvent() : void
      {
         MsgMan.removeObserver("ChildEvent.CHILD_SWITCH_SELECT",this,__selectSwitchChildHandle);
      }
      
      private function __selectSwitchChildHandle(param1:String, param2:Object) : void
      {
         dispose();
      }
      
      public function show(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc2_:ChildSwitchSelectItemView = null;
         _childList = new Vector.<ChildSwitchSelectItemView>();
         var _loc4_:int = col * Math.ceil(param1.length / col);
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc2_ = new ChildSwitchSelectItemView();
            _loc2_.data = param1[_loc3_] ? param1[_loc3_] : null;
            _itemList.addChild(_loc2_);
            _childList.push(_loc2_);
            _loc3_++;
         }
         _itemList.commitChanges();
         _scrollPanel.width = 220;
         if(param1.length / col >= 4)
         {
            _scrollPanel.height = 210;
         }
         else
         {
            _scrollPanel.height = Math.ceil(param1.length / col) * 53;
         }
         _scrollPanel.invalidateViewport();
         _itemList.beginChanges();
         _back.height = _scrollPanel.height + 15;
         LayerManager.Instance.addToLayer(this,7);
      }
      
      private function get model() : ChildModel
      {
         return ChildManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         ObjectUtils.disposeObject(_itemList);
         _itemList = null;
         LogicUtils.disposeDisplayCollection(_childList);
         _childList = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

