package friends.findfriend
{
   import chat.datas.ChatCellData;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.utils.Timer;
   import manager.LanguageMgr;
   import yishi.events.NotificationEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.utils.StringHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class ExactFindFriendView extends Sprite implements Disposeable
   {
      
      private var _inputTipTxt:FilterFrameText;
      
      private var _inputNameBg:ScaleBitmapImage;
      
      private var _inputNameTxt:FilterFrameText;
      
      private var _clickTipTxt:FilterFrameText;
      
      private var _addFriendBtn:TextButton;
      
      private var _clickTimer:Timer;
      
      private var _tempStr:String = "";
      
      public function ExactFindFriendView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _inputTipTxt = ComponentFactory.Instance.creatComponentByStylename("friends.ExactFindInputTipTxt");
         _inputNameBg = ComponentFactory.Instance.creatComponentByStylename("friends.ExactFindInputNameBg");
         _inputNameTxt = ComponentFactory.Instance.creatComponentByStylename("friends.ExactFindInputNameTxt");
         _clickTipTxt = ComponentFactory.Instance.creatComponentByStylename("friends.ExactFindClickTipTxt");
         _addFriendBtn = ComponentFactory.Instance.creatComponentByStylename("friends.addBtn");
         _clickTimer = new Timer(1000,1);
         _inputTipTxt.text = LanguageMgr.GetTranslation("friends.view.AddOrDeleteFriendFrame.alert");
         _clickTipTxt.text = LanguageMgr.GetTranslation("friends.view.AddOrDeleteFriendFrame.describt");
         _addFriendBtn.text = LanguageMgr.GetTranslation("yishi.view.PlayerMenu.addFriendBtnTxt");
         _inputNameTxt.setFocus();
         addChild(_inputTipTxt);
         addChild(_inputNameBg);
         addChild(_inputNameTxt);
         addChild(_clickTipTxt);
         addChild(_addFriendBtn);
      }
      
      private function addEvent() : void
      {
         NotificationManager.instance.addEventListener("PLAYER_NAME_CLICK",__getNameFromChatHandler);
         _addFriendBtn.addEventListener("click",__onAddFriendClick);
         _inputNameTxt.addEventListener("change",__inputNameChangeHandler);
         _inputNameTxt.addEventListener("keyDown",__keyDownHandler);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("PLAYER_NAME_CLICK",__getNameFromChatHandler);
         _addFriendBtn.removeEventListener("click",__onAddFriendClick);
         _inputNameTxt.removeEventListener("change",__inputNameChangeHandler);
         _inputNameTxt.removeEventListener("keyDown",__keyDownHandler);
      }
      
      private function __getNameFromChatHandler(param1:NotificationEvent) : void
      {
         var _loc2_:ChatCellData = null;
         if(param1.data && _inputNameTxt)
         {
            _loc2_ = param1.data as ChatCellData;
            _inputNameTxt.text = String(_loc2_.data);
         }
      }
      
      private function __keyDownHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            param1.stopPropagation();
            __onAddFriendClick(null);
         }
      }
      
      private function __inputNameChangeHandler(param1:Event) : void
      {
         if(StringHelper.checkStringLength(_inputNameTxt.text) > 12)
         {
            _inputNameTxt.text = _tempStr;
         }
         _tempStr = _inputNameTxt.text;
      }
      
      private function __onAddFriendClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_inputNameTxt)
         {
            if(_clickTimer && _clickTimer.running)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.view.ActivityItem.command01"));
               return;
            }
            if(StringHelper.isNullOrEmpty(_inputNameTxt.text))
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("friends.view.AddOrDeleteFriendFrame.command01"));
               return;
            }
            FrameControllerManager.instance.friendControler.sendAddFriendRequest(_inputNameTxt.text,1);
            reset();
            restartClickTimer();
         }
      }
      
      private function __onCancleClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         FrameControllerManager.instance.friendControler.closeFindFriendFrame();
      }
      
      private function restartClickTimer() : void
      {
         if(_clickTimer)
         {
            _clickTimer.reset();
            _clickTimer.start();
         }
      }
      
      public function reset() : void
      {
         _inputNameTxt.text = "";
         _inputNameTxt.setFocus();
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_clickTimer)
         {
            _clickTimer.stop();
         }
         _clickTimer = null;
         if(_inputTipTxt)
         {
            _inputTipTxt.dispose();
         }
         _inputTipTxt = null;
         if(_inputNameBg)
         {
            _inputNameBg.dispose();
         }
         _inputNameBg = null;
         if(_inputNameTxt)
         {
            _inputNameTxt.dispose();
         }
         _inputNameTxt = null;
         if(_clickTipTxt)
         {
            _clickTipTxt.dispose();
         }
         _clickTipTxt = null;
         if(_addFriendBtn)
         {
            _addFriendBtn.dispose();
         }
         _addFriendBtn = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

