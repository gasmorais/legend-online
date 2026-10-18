package im.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleUpDownImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.clearTimeout;
   import managers.IMManager;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.PlayerManager;
   
   public class IMMsgBoxView extends Sprite implements Disposeable
   {
      
      private var _bg:ScaleUpDownImage;
      
      private var _cancleShineBtn:BaseButton;
      
      private var _itemVBox:VBox;
      
      public function IMMsgBoxView()
      {
         super();
         initView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         this.x = 224;
         this.y = 278;
         _bg = ComponentFactory.Instance.creatComponentByStylename("core.IMMsgBoxBg");
         _cancleShineBtn = ComponentFactory.Instance.creatComponentByStylename("core.IMMsgBoxCancleShineBtn");
         _itemVBox = ComponentFactory.Instance.creatComponentByStylename("core.IMMsgBoxItemVBox");
         addChild(_bg);
         addChild(_cancleShineBtn);
         addChild(_itemVBox);
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
         clearTimeout(imManager.model.removeMsgBoxTimeOut);
      }
      
      private function __rollOutHandler(param1:MouseEvent) : void
      {
         dispose();
      }
      
      private function __onCancleShineClick(param1:MouseEvent) : void
      {
         imManager.model.isOpenFriendBtnShine = false;
         imManager.friendBtnShining = false;
      }
      
      private function refreshView() : void
      {
         cleanData();
         var _loc1_:int = 0;
         var _loc3_:Array = imManager.model.msgBoxList;
         for each(var _loc2_:ThaneInfo in _loc3_)
         {
            if(_loc1_ < 30)
            {
               addMsgBoxItem(_loc2_);
               _loc1_++;
            }
         }
         _bg.height = _itemVBox.y + _itemVBox.height + 20;
         this.y -= this.height;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function addMsgBoxItem(param1:ThaneInfo) : void
      {
         var _loc2_:IMMsgBoxItem = new IMMsgBoxItem();
         _loc2_.data = param1;
         _itemVBox.addChild(_loc2_);
      }
      
      private function cleanData() : void
      {
         var _loc1_:DisplayObject = null;
         if(_itemVBox)
         {
            while(_itemVBox.numChildren > 0)
            {
               _loc1_ = _itemVBox.getChildAt(0);
               _itemVBox.removeChild(_loc1_);
               ObjectUtils.disposeObject(_loc1_);
               _loc1_ = null;
            }
         }
      }
      
      private function get imManager() : IMManager
      {
         return IMManager.instance;
      }
      
      public function dispose() : void
      {
         removeEvent();
         clearTimeout(imManager.model.removeMsgBoxTimeOut);
         cleanData();
         ObjectUtils.disposeAllChildren(this);
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
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

