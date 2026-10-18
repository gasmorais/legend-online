package yishi.view.frame
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.alert.SimpleAlert;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   
   public class ChatInvieAlert extends SimpleAlert
   {
      
      public static const P_chatInvieStyle:String = "chatInvieStyle";
      
      protected var _chatInvieBtn:SelectedCheckButton;
      
      protected var _chatInvieStyle:String;
      
      public function ChatInvieAlert()
      {
         super();
      }
      
      override public function dispose() : void
      {
         if(_chatInvieBtn)
         {
            ObjectUtils.disposeObject(_smallTipTxt);
            _chatInvieBtn = null;
         }
         super.dispose();
      }
      
      public function set chatInvieStyle(param1:String) : void
      {
         if(_chatInvieStyle == param1)
         {
            return;
         }
         _chatInvieStyle = param1;
         _chatInvieBtn = ComponentFactory.Instance.creatComponentByStylename(_chatInvieStyle);
         _chatInvieBtn.text = LanguageMgr.GetTranslation("room.view.pve.RoomRightView.alertConent");
      }
      
      public function get chatInvieStyle() : String
      {
         return _chatInvieStyle;
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_chatInvieBtn)
         {
            addChild(_chatInvieBtn);
            if(_info && _info.extraData && info.extraData.hasOwnProperty("income"))
            {
               _chatInvieBtn.selected = info.extraData["income"];
            }
            else
            {
               _chatInvieBtn.selected = true;
            }
         }
      }
      
      override protected function layoutFrameRect() : void
      {
         super.layoutFrameRect();
         if(_chatInvieBtn)
         {
            if(_smallTipTxt.text != "")
            {
               _chatInvieBtn.x = _textField.x + (_textField.width - _chatInvieBtn.width) / 2;
               _chatInvieBtn.y = _textField.y + _textField.textHeight + 15;
            }
            else
            {
               _textField.y = 30;
               _chatInvieBtn.x = _textField.x + (_textField.width - _chatInvieBtn.width) / 2;
               _chatInvieBtn.y = _textField.textHeight + 45;
            }
         }
      }
      
      override protected function __onSubmitClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         if(info.extraData)
         {
            if(info.extraData.hasOwnProperty("point"))
            {
               _loc2_ = int(info.extraData["point"]);
               _loc5_ = PlayerManager.instance.currentPlayerModel.playerInfo.point;
               _loc4_ = PlayerManager.instance.currentPlayerModel.playerInfo.giftToken;
               _loc3_ = PlayerManager.instance.currentPlayerModel.playerInfo.allPoint;
               if(_loc3_ < _loc2_)
               {
                  RechargeAlertMannager.show();
                  return;
               }
            }
            if(_submitSoundFunc != null)
            {
               _submitSoundFunc();
            }
            onResponse(3,_chatInvieBtn.selected);
            param1.stopPropagation();
         }
         else
         {
            if(_submitSoundFunc != null)
            {
               _submitSoundFunc();
            }
            onResponse(3,_chatInvieBtn.selected);
            param1.stopPropagation();
         }
      }
      
      override protected function __onCancelClick(param1:MouseEvent) : void
      {
         if(_submitSoundFunc != null)
         {
            _submitSoundFunc();
         }
         onResponse(0,_chatInvieBtn.selected);
         param1.stopPropagation();
         super.dispose();
      }
      
      override protected function __onCloseClick(param1:MouseEvent) : void
      {
         if(_submitSoundFunc != null)
         {
            _submitSoundFunc();
         }
         onResponse(4,_chatInvieBtn.selected);
         param1.stopPropagation();
         super.dispose();
      }
   }
}

