package groupfb
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.ModuleFrameInfo;
   import mvc.module.groupfb.GroupfbSender;
   import yishi.datas.ComponentGroupType;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.view.tips.MessageTipManager;
   
   public class GroupfbRoomSearchFrame extends Frame
   {
      
      private var _back:ScaleBitmapImage;
      
      private var _idBack:ScaleBitmapImage;
      
      private var _idText:FilterFrameText;
      
      private var _idValueText:FilterFrameText;
      
      private var _confirmBtn:SelectedCheckButton;
      
      private var _cancelBtn:SelectedCheckButton;
      
      private var _passwdEnable:Boolean;
      
      private var _alertString:String = LanguageMgr.GetTranslation("pveroomlist.view.PVERoomSearchFrame.alert");
      
      public function GroupfbRoomSearchFrame()
      {
         super();
         enterEnable = true;
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,355,250);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _titleText = LanguageMgr.GetTranslation("pveroomlist.view.PVERoomSearchFrame.title");
         _back = ComponentFactory.Instance.creatComponentByStylename("pvproomlist.SearchRoomBack");
         _idBack = ComponentFactory.Instance.creatComponentByStylename("pvproomlist.SearchRoomIdBack");
         _idText = ComponentFactory.Instance.creatComponentByStylename("pvproomlist.SearchRoomIdText");
         _idText.text = LanguageMgr.GetTranslation("pveroomlist.view.PVERoomSearchFrame.id");
         _idValueText = ComponentFactory.Instance.creatComponentByStylename("pvproomlist.SearchRoomIdValueText");
         _idValueText.text = _alertString;
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("pvproomlist.SearchRoomConfirmBtn");
         _confirmBtn.text = LanguageMgr.GetTranslation("public.confirm");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("pvproomlist.SearchRoomCancelBtn");
         _cancelBtn.text = LanguageMgr.GetTranslation("public.cancel");
         addToContent(_back);
         addToContent(_idBack);
         addToContent(_idText);
         addToContent(_idValueText);
         addToContent(_confirmBtn);
         addToContent(_cancelBtn);
      }
      
      protected function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _confirmBtn.addEventListener("click",__confirmClickHandler);
         _cancelBtn.addEventListener("click",__cancelClickHandler);
         _idValueText.addEventListener("keyDown",__keyDownHandler);
         _idValueText.addEventListener("focusIn",__focusInHandler);
      }
      
      protected function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_confirmBtn)
         {
            _confirmBtn.removeEventListener("click",__confirmClickHandler);
         }
         if(_cancelBtn)
         {
            _cancelBtn.removeEventListener("click",__cancelClickHandler);
         }
         if(_idValueText)
         {
            _idValueText.removeEventListener("focusIn",__focusInHandler);
         }
         if(_idValueText)
         {
            _idValueText.removeEventListener("keyDown",__keyDownHandler);
         }
      }
      
      private function __focusInHandler(param1:FocusEvent) : void
      {
         var _loc2_:FilterFrameText = param1.currentTarget as FilterFrameText;
         _loc2_.text = "";
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
      
      private function __confirmClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_idValueText.text == _alertString || _idValueText.text == "")
         {
            MessageTipManager.instance().show(_alertString);
            return;
         }
         var _loc2_:int = int(_idValueText.text);
         sendSearch(_loc2_);
      }
      
      private function __cancelClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispose();
      }
      
      private function sendSearch(param1:int) : void
      {
         var _loc2_:String = null;
         if(param1 > 0)
         {
            GroupfbSender.searchRoom(param1);
            dispose();
         }
         else if(param1 == 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("pveroomlist.view.PVERoomSearchFrame.command01");
            MessageTipManager.instance().show(_loc2_);
         }
         else
         {
            MessageTipManager.instance().show(_alertString);
         }
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
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         ObjectUtils.disposeObject(_back);
         ObjectUtils.disposeObject(_idBack);
         ObjectUtils.disposeObject(_idText);
         ObjectUtils.disposeObject(_idValueText);
         ObjectUtils.disposeObject(_confirmBtn);
         ObjectUtils.disposeObject(_cancelBtn);
         _back = null;
         _idBack = null;
         _idText = null;
         _idValueText = null;
         _cancelBtn = null;
         _confirmBtn = null;
         super.dispose();
      }
   }
}

