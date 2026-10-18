package marry.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleUpDownImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.clearTimeout;
   import managers.MarryManager;
   import mvc.module.marry.MarryProposeInfo;
   import ui.maintoolbar.MainToolBar;
   
   public class ProposeBoxView extends Sprite implements Disposeable
   {
      
      private static const MAXCOUNT:int = 30;
      
      private var _bg:ScaleUpDownImage;
      
      private var _cancleShineBtn:BaseButton;
      
      private var _itemVBox:VBox;
      
      private var _list:Array;
      
      public function ProposeBoxView()
      {
         super();
         initData();
         initView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("core.IMMsgBoxBg");
         _cancleShineBtn = ComponentFactory.Instance.creatComponentByStylename("core.IMMsgBoxCancleShineBtn");
         _itemVBox = ComponentFactory.Instance.creatComponentByStylename("core.IMMsgBoxItemVBox");
         addChild(_bg);
         addChild(_cancleShineBtn);
         addChild(_itemVBox);
      }
      
      private function initData() : void
      {
         _list = [];
         for each(var _loc1_:MarryProposeInfo in MarryManager.instance.model.proposeDic)
         {
            _list.push(_loc1_);
         }
         _list.sortOn("time",2 | 0x10);
      }
      
      private function addEvent() : void
      {
         addEventListener("rollOver",__rollOverHandler);
         addEventListener("rollOut",__rollOutHandler);
         _cancleShineBtn.addEventListener("click",__onCancleShineClick);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("rollOver",__rollOverHandler);
         removeEventListener("rollOut",__rollOutHandler);
         if(_cancleShineBtn)
         {
            _cancleShineBtn.removeEventListener("click",__onCancleShineClick);
         }
      }
      
      private function __rollOverHandler(param1:MouseEvent) : void
      {
         clearTimeout(MarryManager.instance.removeBoxTimeOut);
      }
      
      private function __rollOutHandler(param1:MouseEvent) : void
      {
         dispose();
      }
      
      private function __onCancleShineClick(param1:MouseEvent) : void
      {
         MarryManager.instance.model.needShine = false;
         MainToolBar.instance.setProposeBtnShine();
      }
      
      private function refreshView() : void
      {
         var _loc2_:int = 0;
         _itemVBox.disposeAllChildren();
         var _loc1_:int = int(_list.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            if(_loc2_ > 30)
            {
               break;
            }
            addMsgBoxItem(_list[_loc2_] as MarryProposeInfo);
            _loc2_++;
         }
         _bg.height = _itemVBox.y + _itemVBox.height + 20;
         this.y -= this.height;
      }
      
      private function addMsgBoxItem(param1:MarryProposeInfo) : void
      {
         var _loc2_:ProposeBoxItem = new ProposeBoxItem();
         _loc2_.data = param1;
         _itemVBox.addChild(_loc2_);
      }
      
      public function dispose() : void
      {
         removeEvent();
         _list = null;
         if(_bg)
         {
            _bg.dispose();
         }
         _bg = null;
         if(_cancleShineBtn)
         {
            _cancleShineBtn.dispose();
         }
         _cancleShineBtn = null;
         if(_itemVBox)
         {
            _itemVBox.dispose();
         }
         _itemVBox = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

