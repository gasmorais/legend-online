package yishi.view.frame.giftdonatio
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   
   public class FriendItemBtn extends Sprite implements Disposeable, ISelectable
   {
      
      private var _bg:ScaleFrameImage;
      
      private var _nameText:FilterFrameText;
      
      private var _selected:Boolean = false;
      
      private var _friendName:String = "";
      
      public function FriendItemBtn()
      {
         super();
         initView();
         addEvent();
      }
      
      public function get friendName() : String
      {
         return _friendName;
      }
      
      public function set friendName(param1:String) : void
      {
         _friendName = param1;
         _nameText.text = _friendName;
      }
      
      private function addEvent() : void
      {
         this.addEventListener("rollOver",__onRollOver);
         this.addEventListener("rollOut",__onRollOut);
         this.addEventListener("click",__onClick);
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("rollOver",__onRollOver);
         this.removeEventListener("rollOut",__onRollOut);
         this.removeEventListener("click",__onClick);
      }
      
      protected function __onClick(param1:MouseEvent) : void
      {
         NotificationManager.instance.dispatchEvent(new NotificationEvent("SELECT_FRIEND",[this.friendName]));
      }
      
      protected function __onRollOver(param1:MouseEvent) : void
      {
         _bg.setFrame(2);
      }
      
      private function __onRollOut(param1:MouseEvent) : void
      {
         _bg.setFrame(1);
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("friends.FriendsItemBg");
         _bg.setFrame(1);
         _bg.width = 150;
         _bg.mouseChildren = false;
         _bg.mouseEnabled = false;
         addChild(_bg);
         _nameText = ComponentFactory.Instance.creatComponentByStylename("shop.Combox_TextStyle");
         _nameText.mouseEnabled = false;
         _nameText.text = name;
         addChild(_nameText);
      }
      
      private function unInit() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         unInit();
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         if(_selected == param1)
         {
            return;
         }
         _selected = param1;
         if(_selected)
         {
            _bg.setFrame(3);
            _nameText.setFrame(2);
         }
         else
         {
            _bg.setFrame(1);
            _nameText.setFrame(1);
         }
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      override public function get height() : Number
      {
         return _bg.height - 5;
      }
   }
}

