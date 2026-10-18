package theseusdoublepvproom
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.MarryManager;
   import managers.RoomManager;
   import map.campaign.CampaignManager;
   import mvc.module.room.RoomInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.PlayerManager;
   import yishi.utils.StringHelper;
   import yishi.utils.WorldBossHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class TheseusRoomPasswordFrame extends Frame
   {
      
      private var _alertTxt:Bitmap;
      
      private var _inputBack:ScaleBitmapImage;
      
      private var _inputTxt:FilterFrameText;
      
      private var _warmTxt:FilterFrameText;
      
      private var _confirmBtn:IconButton;
      
      private var _cancelBtn:IconButton;
      
      private var _backCall:Function;
      
      private var _roonId:int;
      
      private var _change:Boolean;
      
      public function TheseusRoomPasswordFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      public function set backCall(param1:Function) : void
      {
         _backCall = param1;
      }
      
      private function initView() : void
      {
         var _loc1_:String = null;
         _alertTxt = ComponentFactory.Instance.creatBitmap("asset.core.RoomPasswdAlertTxt");
         _inputBack = ComponentFactory.Instance.creatComponentByStylename("core.RoomPasswdInputBack");
         _inputTxt = ComponentFactory.Instance.creatComponentByStylename("core.RoomPasswdInputTxt");
         _warmTxt = ComponentFactory.Instance.creatComponentByStylename("core.RoomPasswdWarmTxt");
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("core.RoomPasswdConfirmBtn");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("core.RoomPasswdCancelBtn");
         addToContent(_alertTxt);
         addToContent(_inputBack);
         addToContent(_inputTxt);
         _inputTxt.restrict = "0-9";
         _inputTxt.maxChars = 6;
         _inputTxt.displayAsPassword = true;
         addToContent(_warmTxt);
         _warmTxt.text = LanguageMgr.GetTranslation("yishi.view.RoomPasswordFrame.warmTxt.text");
         addToContent(_confirmBtn);
         addToContent(_cancelBtn);
         if(inWedding)
         {
            _loc1_ = "";
            if(MarryManager.instance.model.roomInfo)
            {
               if(!StringHelper.isNullOrEmpty(MarryManager.instance.model.roomInfo.property5))
               {
                  _loc1_ = MarryManager.instance.model.roomInfo.property5;
               }
            }
            _inputTxt.text = _loc1_;
         }
         else if(roomInfo && roomInfo.houseOwnerId == playerInfo.userId)
         {
            _inputTxt.text = RoomManager.instance.roomInfo.password;
         }
         _inputTxt.setSelection(_inputTxt.length,_inputTxt.length);
         this.titleText = LanguageMgr.GetTranslation("yishi.view.RoomPasswordFrame.titleTxt");
      }
      
      private function get roomInfo() : RoomInfo
      {
         return RoomManager.instance.roomInfo;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get inWedding() : Boolean
      {
         return WorldBossHelper.checkWedding(CampaignManager.instance.mapId);
      }
      
      protected function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         addEventListener("addedToStage",__onAddedToStage);
         _confirmBtn.addEventListener("click",__confirmHandler);
         _cancelBtn.addEventListener("click",__cancelHandler);
         _inputTxt.addEventListener("keyDown",__keyDownHandler);
         if(_inputTxt)
         {
            _inputTxt.addEventListener("change",__textChange);
         }
      }
      
      protected function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         removeEventListener("addedToStage",__onAddedToStage);
         if(_confirmBtn)
         {
            _confirmBtn.removeEventListener("click",__confirmHandler);
         }
         if(_cancelBtn)
         {
            _cancelBtn.removeEventListener("click",__cancelHandler);
         }
         if(_inputTxt)
         {
            _inputTxt.removeEventListener("keyDown",__keyDownHandler);
         }
         if(_inputTxt)
         {
            _inputTxt.removeEventListener("change",__textChange);
         }
      }
      
      protected function __onAddedToStage(param1:Event) : void
      {
         removeEventListener("addedToStage",__onAddedToStage);
         stage.focus = _inputTxt;
      }
      
      private function __keyDownHandler(param1:KeyboardEvent) : void
      {
         switch(int(param1.keyCode) - 13)
         {
            case 0:
               __confirmHandler(null);
               break;
            case 14:
               dispose();
         }
         param1.stopPropagation();
      }
      
      private function __textChange(param1:Event) : void
      {
         _change = true;
      }
      
      private function __confirmHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_inputTxt.text == "" && roomInfo == null)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("yishi.view.RoomPasswordFrame.nullPassword"));
         }
         if(_backCall != null && _change)
         {
            _backCall(_roonId,_inputTxt.text);
         }
         dispose();
      }
      
      private function __cancelHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         dispose();
      }
      
      protected function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
               break;
            case 2:
               __confirmHandler(null);
         }
      }
      
      public function show(param1:int) : void
      {
         _roonId = param1;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         _backCall = null;
         ObjectUtils.disposeObject(_inputTxt);
         _inputTxt = null;
         super.dispose();
      }
   }
}

