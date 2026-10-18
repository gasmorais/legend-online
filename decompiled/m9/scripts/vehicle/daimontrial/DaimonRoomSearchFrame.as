package vehicle.daimontrial
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.SoundManager;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.controler.VehicleDaimonTrialController;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.view.tips.MessageTipManager;
   
   public class DaimonRoomSearchFrame extends Frame
   {
      
      private var _back:ScaleBitmapImage;
      
      private var _idBack:ScaleBitmapImage;
      
      private var _passwdBack:ScaleFrameImage;
      
      private var _idText:FilterFrameText;
      
      private var _idValueText:FilterFrameText;
      
      private var _passwd:FilterFrameText;
      
      private var _passwdValue:FilterFrameText;
      
      private var _confirmBtn:IconButton;
      
      private var _cancelBtn:IconButton;
      
      private var _passwdEnable:Boolean;
      
      private var _alertString:String = LanguageMgr.GetTranslation("vehicle.InputTeamNumber");
      
      private var _controller:VehicleDaimonTrialController;
      
      public function DaimonRoomSearchFrame()
      {
         super();
         _controller = FrameControllerManager.instance.vehicleDaimonTrailController;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _titleText = LanguageMgr.GetTranslation("pveroomlist.view.PVERoomSearchFrame.title");
         _back = ComponentFactory.Instance.creatComponentByStylename("pvproomlist.SearchRoomBack");
         _idBack = ComponentFactory.Instance.creatComponentByStylename("pvproomlist.SearchRoomIdBack");
         _passwdBack = ComponentFactory.Instance.creatComponentByStylename("pvproomlist.SearchRoomPasswdBack");
         _idText = ComponentFactory.Instance.creatComponentByStylename("DaimonRoomSearchFrame.SearchRoomIdText");
         _idText.text = LanguageMgr.GetTranslation("vehicle.TeamNumber");
         _idValueText = ComponentFactory.Instance.creatComponentByStylename("pvproomlist.SearchRoomIdValueText");
         _idValueText.text = LanguageMgr.GetTranslation("vehicle.InputTeamNumber");
         _passwdValue = ComponentFactory.Instance.creatComponentByStylename("pvproomlist.SearchRoomPasswdValueTxt");
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("core.AlertButtonConfirm_2");
         _confirmBtn.text = LanguageMgr.GetTranslation("public.confirm");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("core.AlertButtonCancel_1");
         _cancelBtn.text = LanguageMgr.GetTranslation("public.cancel");
         _confirmBtn.x = 32;
         _confirmBtn.y = 112;
         _cancelBtn.x = 154;
         _cancelBtn.y = 112;
         addToContent(_back);
         addToContent(_idBack);
         addToContent(_idText);
         addToContent(_idValueText);
         addToContent(_confirmBtn);
         addToContent(_cancelBtn);
      }
      
      private function unitView() : void
      {
         _back = null;
         _idBack = null;
         _idText = null;
         _idValueText = null;
         _confirmBtn = null;
         _cancelBtn = null;
      }
      
      private function addEvent() : void
      {
         _confirmBtn.addEventListener("click",__confirmClickHandler);
         _cancelBtn.addEventListener("click",__cancelClickHandler);
         _idValueText.addEventListener("keyDown",__keyDownHandler);
         _idValueText.addEventListener("focusIn",__focusInHandler);
         addEventListener("response",__frameResponse);
      }
      
      private function removeEvent() : void
      {
         _confirmBtn.removeEventListener("click",__confirmClickHandler);
         _cancelBtn.removeEventListener("click",__cancelClickHandler);
         _idValueText.removeEventListener("keyDown",__keyDownHandler);
         _idValueText.removeEventListener("focusIn",__focusInHandler);
         removeEventListener("response",__frameResponse);
      }
      
      private function __confirmClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         SoundManager.instance.play("022");
         if(_idValueText.text == _alertString || _idValueText.text == "")
         {
            MessageTipManager.instance().show(_alertString);
            return;
         }
         var _loc3_:int = int(_idValueText.text);
         if(_loc3_ > 0)
         {
            _controller.searchRoom(_loc3_);
            dispose();
         }
         else if(_loc3_ == 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("pveroomlist.view.PVERoomSearchFrame.command01");
            MessageTipManager.instance().show(_loc2_);
         }
         else
         {
            MessageTipManager.instance().show(_alertString);
         }
      }
      
      private function __cancelClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         dispose();
      }
      
      private function __keyDownHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            __confirmClickHandler(null);
         }
         else if(param1.keyCode == 27)
         {
            dispose();
         }
         param1.stopPropagation();
      }
      
      private function __focusInHandler(param1:FocusEvent) : void
      {
         var _loc2_:FilterFrameText = param1.currentTarget as FilterFrameText;
         _loc2_.text = "";
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
               break;
            case 1:
               dispose();
               break;
            case 2:
               __confirmClickHandler(null);
         }
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("vehicle.findTeam");
         LayerManager.Instance.addToLayer(this,3,true,true,2);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         if(isDie)
         {
            return;
         }
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         unitView();
         super.dispose();
      }
   }
}

