package poker
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   
   public class PokerChatList extends Sprite implements Disposeable
   {
      
      private var _back:DisplayObject;
      
      private var _vBox:VBox;
      
      private var _itemList:Array = [];
      
      private var _msg:String;
      
      private var _clickTime:Number;
      
      public function PokerChatList()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         var _loc2_:TextButton = null;
         var _loc1_:int = 0;
         _back = ComponentFactory.Instance.creat("core.commonTipBg");
         _back.width = 365;
         _vBox = ComponentFactory.Instance.creatComponentByStylename("ChatItemMenu.VBox");
         addChild(_back);
         addChild(_vBox);
         _loc1_ = 0;
         while(_loc1_ < 9)
         {
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("poker.addfriendSelectBtn");
            _loc2_.addEventListener("click",__itemClickHandler);
            _loc2_.text = LanguageMgr.GetTranslation("poker.chatData.text" + (_loc1_ + 1));
            _vBox.addChild(_loc2_);
            _itemList.push(_loc2_);
            _loc1_++;
         }
         _back.height = _vBox.height + 10;
         _msg = "";
      }
      
      private function __itemClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:TextButton = param1.currentTarget as TextButton;
         _msg = _loc2_.text;
         dispose();
      }
      
      public function get msgStr() : String
      {
         return _msg;
      }
      
      public function dispose() : void
      {
         var _loc1_:TextButton = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         if(_itemList)
         {
            while(_itemList.length)
            {
               _loc1_ = _itemList.pop();
               _loc1_.removeEventListener("click",__itemClickHandler);
               ObjectUtils.disposeObject(_loc1_);
            }
            _itemList = null;
         }
         ObjectUtils.disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         dispatchEvent(new Event("dispose"));
      }
   }
}

