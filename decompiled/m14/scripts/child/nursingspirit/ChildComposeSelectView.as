package child.nursingspirit
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import utils.LogicUtils;
   import yishi.utils.MsgMan;
   
   public class ChildComposeSelectView extends Component
   {
      
      private var noChildText:FilterFrameText;
      
      private var back:ScaleBitmapImage;
      
      private var scrollPanel:ScrollPanel;
      
      private var itemList:SimpleTileList;
      
      private var childList:Vector.<ChildComposeSelectItem>;
      
      private var showType:int;
      
      private var col:int = 4;
      
      public function ChildComposeSelectView(param1:int)
      {
         super();
         showType = param1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         back = ComponentFactory.Instance.creatComponentByStylename("ChildComposeSelectView.back");
         noChildText = ComponentFactory.Instance.creatComponentByStylename("ChildComposeSelectView.noChildText");
         scrollPanel = ComponentFactory.Instance.creatComponentByStylename("ChildComposeSelectView.scrollPanel");
         itemList = ComponentFactory.Instance.creatCustomObject("ChildComposeSelectView.SimpleTileList",[col]);
         addChild(back);
         addChild(noChildText);
         addChild(scrollPanel);
         scrollPanel.setView(itemList);
         scrollPanel.invalidateViewport();
         back.mouseChildren = back.mouseEnabled = false;
         noChildText.text = LanguageMgr.GetTranslation("ChildComposeSelectView.noChildText.text");
      }
      
      private function addEvent() : void
      {
         MsgMan.addObserver("ChildEvent.CHILD_COMPOSE_SELECT",this,__selectComposeChildHandle);
      }
      
      private function removeEvent() : void
      {
         MsgMan.removeObserver("ChildEvent.CHILD_COMPOSE_SELECT",this,__selectComposeChildHandle);
      }
      
      private function __selectComposeChildHandle(param1:String, param2:Object) : void
      {
         dispose();
      }
      
      public function show(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc2_:ChildComposeSelectItem = null;
         childList = new Vector.<ChildComposeSelectItem>();
         var _loc4_:int = col * Math.ceil(param1.length / col);
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc2_ = new ChildComposeSelectItem(showType);
            _loc2_.data = param1[_loc3_] ? param1[_loc3_] : null;
            itemList.addChild(_loc2_);
            childList.push(_loc2_);
            _loc3_++;
         }
         itemList.commitChanges();
         scrollPanel.width = 220;
         if(param1.length / col >= 4)
         {
            scrollPanel.height = 210;
         }
         else
         {
            scrollPanel.height = Math.ceil(param1.length / col) * 53;
         }
         scrollPanel.invalidateViewport();
         itemList.beginChanges();
         noChildText.visible = _loc4_ <= 0;
         if(_loc4_ <= 0)
         {
            back.width = 295;
            back.height = 40;
         }
         else
         {
            back.width = 240;
            back.height = scrollPanel.height + 15;
         }
         LayerManager.Instance.addToLayer(this,7);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(noChildText);
         noChildText = null;
         ObjectUtils.disposeObject(back);
         back = null;
         ObjectUtils.disposeObject(itemList);
         itemList = null;
         ObjectUtils.disposeObject(scrollPanel);
         scrollPanel = null;
         LogicUtils.disposeDisplayCollection(childList);
         childList = null;
         super.dispose();
      }
   }
}

