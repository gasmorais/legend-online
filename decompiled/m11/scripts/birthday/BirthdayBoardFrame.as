package birthday
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.active.ActiveMsgLeaveInfo;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import yishi.manager.BirthdayManager;
   import yishi.manager.FrameControllerManager;
   import yishi.view.tips.MessageTipManager;
   
   public class BirthdayBoardFrame extends Frame
   {
      
      private var _frameTitle:Bitmap;
      
      private var _wishBtn:IconButton;
      
      private var _getBuffBtn:IconButton;
      
      private var _refreshBtn:IconButton;
      
      private var _curEvolveTimeStamp:int = 0;
      
      private var _msgTipList:Vector.<MessageTip> = new Vector.<MessageTip>();
      
      private const MAX_MESSAGE_COUNT:uint = 12;
      
      private const BTN_GAP:uint = 50;
      
      private const CLICK_THRESHOLD:uint = 500;
      
      public function BirthdayBoardFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         var _loc6_:MovieClip = null;
         var _loc5_:MessageTip = null;
         var _loc4_:* = 0;
         var _loc1_:ComponentFactory = ComponentFactory.Instance;
         _frameTitle = _loc1_.creatBitmap("asset.birthday.boardTitle");
         _wishBtn = _loc1_.creatComponentByStylename("birthday.wishBtn");
         _getBuffBtn = _loc1_.creatComponentByStylename("birthday.getBuffBtn");
         _refreshBtn = _loc1_.creatComponentByStylename("birthday.refreshBtn");
         _getBuffBtn.x = _wishBtn.x + _wishBtn.width + 50;
         _refreshBtn.x = _getBuffBtn.x + _getBuffBtn.width + 50;
         _getBuffBtn.y = _wishBtn.y;
         addToContent(_frameTitle);
         addToContent(_wishBtn);
         addToContent(_getBuffBtn);
         addToContent(_refreshBtn);
         var _loc2_:MovieClip = ComponentFactory.Instance.creatCustomObject("asset.birthday.recordPosMc");
         var _loc3_:String = LanguageMgr.GetTranslation("birthday.BirthdayBoardFrame.defaultTip");
         _loc4_ = 0;
         while(_loc4_ < 12)
         {
            _loc5_ = new MessageTip();
            _msgTipList.push(_loc5_);
            _loc6_ = _loc2_.getChildByName("pos_" + _loc4_) as MovieClip;
            _loc5_.x = _loc6_.x;
            _loc5_.y = _loc6_.y;
            _loc5_.updateUI(_loc3_);
            addToContent(_loc5_);
            _loc4_++;
         }
         ObjectUtils.disposeAllChildren(_loc2_);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",frameEventHandler);
         _wishBtn.addEventListener("click",onWishClickHandler);
         _getBuffBtn.addEventListener("click",onGetBuffClickHandler);
         _refreshBtn.addEventListener("click",onRefreshClickHandler);
         BirthdayManager.instance.model.addEventListener("MODEL_UPDATE_EVENT",onMessageUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",frameEventHandler);
         _wishBtn.removeEventListener("click",onWishClickHandler);
         _getBuffBtn.removeEventListener("click",onGetBuffClickHandler);
         _refreshBtn.removeEventListener("click",onRefreshClickHandler);
         BirthdayManager.instance.model.removeEventListener("MODEL_UPDATE_EVENT",onMessageUpdateHandler);
      }
      
      private function onWishClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("birthday","MESSAGE_INPUT_FRAME");
      }
      
      private function onGetBuffClickHandler(param1:MouseEvent) : void
      {
         BirthdayManager.instance.sendOperationToServer(103,1);
      }
      
      private function onRefreshClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = getTimer();
         if(_loc2_ - _curEvolveTimeStamp < 500)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.view.ActivityItem.command01"));
         }
         else
         {
            _curEvolveTimeStamp = _loc2_;
            BirthdayManager.instance.sendOperationToServer(100,1);
         }
      }
      
      private function frameEventHandler(param1:FrameEvent) : void
      {
         var _loc2_:int = int(param1.responseCode);
         if(_loc2_ == 0 || _loc2_ == 1)
         {
            dispose();
         }
      }
      
      private function onMessageUpdateHandler(param1:Event) : void
      {
         var _loc6_:* = 0;
         var _loc5_:MessageTip = null;
         var _loc2_:ActiveMsgLeaveInfo = null;
         var _loc3_:String = null;
         var _loc4_:* = 0;
         var _loc7_:Array = BirthdayManager.instance.model.activeMsgLeaveInfoList;
         if(_loc7_ != null && _loc7_.length > 0)
         {
            _loc6_ = _loc7_.length;
            _loc3_ = LanguageMgr.GetTranslation("birthday.BirthdayBoardFrame.defaultTip");
            _loc4_ = 0;
            while(_loc4_ < 12)
            {
               _loc5_ = _msgTipList[_loc4_];
               if(_loc4_ < _loc6_)
               {
                  _loc2_ = _loc7_[_loc4_];
                  _loc5_.updateUI(_loc2_.msgStr,_loc2_.nickName);
               }
               else
               {
                  _loc5_.updateUI(_loc3_);
               }
               _loc4_++;
            }
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
         BirthdayManager.instance.sendOperationToServer(100,1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(this.parent != null)
         {
            this.parent.removeChild(this);
         }
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

import com.pickgliss.ui.ComponentFactory;
import com.pickgliss.ui.text.FilterFrameText;
import flash.display.Sprite;

class MessageTip extends Sprite
{
   
   private var _messageTxt:FilterFrameText;
   
   private var _playerNameTxt:FilterFrameText;
   
   public function MessageTip()
   {
      super();
      this.mouseChildren = this.mouseEnabled = false;
      var _loc1_:ComponentFactory = ComponentFactory.Instance;
      _messageTxt = _loc1_.creatComponentByStylename("birthday.messageText");
      _messageTxt.wordWrap = true;
      _messageTxt.multiline = true;
      _playerNameTxt = _loc1_.creatComponentByStylename("birthday.playerNameText");
      _playerNameTxt.y = _messageTxt.height;
      _playerNameTxt.width = _messageTxt.width;
      addChild(_messageTxt);
      addChild(_playerNameTxt);
   }
   
   public function updateUI(param1:String, param2:String = "") : void
   {
      _messageTxt.text = param1;
      _playerNameTxt.text = param2;
   }
}
