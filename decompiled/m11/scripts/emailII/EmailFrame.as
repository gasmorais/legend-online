package emailII
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import emailII.view.EmailListView;
   import events.EmailEvent;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.controler.EmailControler;
   import mvc.module.emailII.EmailModel;
   import yishi.manager.ArmyManager;
   import yishi.manager.EmailManager;
   import yishi.manager.FrameControllerManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class EmailFrame extends Frame
   {
      
      private static const UNDERLEVEL:int = 6;
      
      private var _background:MutipleImage;
      
      private var _emailBtn:SelectedButton;
      
      private var _battleBtn:SelectedCheckButton;
      
      private var _buttongroup1:SelectedButtonGroup;
      
      private var _writeBtn:BaseButton;
      
      private var _allSelectBtn:TextButton;
      
      private var _deleteBtn:TextButton;
      
      private var _attachBtn:TextButton;
      
      private var _prePage:BaseButton;
      
      private var _nextPage:BaseButton;
      
      private var _pageText:FilterFrameText;
      
      private var _newEffect:MovieClip;
      
      private var _emailListView:EmailListView;
      
      public function EmailFrame()
      {
         super();
         initView();
         initData();
         initEvent();
         setdefaultType();
         __viewChangeHandler(null);
      }
      
      private function get control() : EmailControler
      {
         return FrameControllerManager.instance.emailControler;
      }
      
      private function get model() : EmailModel
      {
         return control.model;
      }
      
      private function initData() : void
      {
         EmailManager.instance.cate.sortMailList();
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         _titleText = LanguageMgr.GetTranslation("emailII.EmailFrame.title");
         _buttongroup1 = new SelectedButtonGroup();
         _background = ComponentFactory.Instance.creatComponentByStylename("email.ListBack");
         _emailBtn = ComponentFactory.Instance.creatComponentByStylename("email.EmailBtn");
         _battleBtn = ComponentFactory.Instance.creatComponentByStylename("email.BattleBtn");
         _battleBtn.text = LanguageMgr.GetTranslation("emailII.EmailFrame.battle");
         _buttongroup1.addSelectItem(_emailBtn);
         _buttongroup1.addSelectItem(_battleBtn);
         _allSelectBtn = ComponentFactory.Instance.creatComponentByStylename("email.AllSelectedBtn");
         _allSelectBtn.text = LanguageMgr.GetTranslation("emailII.EmailFrame.allSelect");
         _deleteBtn = ComponentFactory.Instance.creatComponentByStylename("email.DeleteBtn");
         _deleteBtn.text = LanguageMgr.GetTranslation("emailII.EmailFrame.delete");
         _attachBtn = ComponentFactory.Instance.creatComponentByStylename("email.AttachBtn");
         _attachBtn.text = LanguageMgr.GetTranslation("emailII.EmailFrame.attach");
         _prePage = ComponentFactory.Instance.creatComponentByStylename("email.PrePageBtn");
         _nextPage = ComponentFactory.Instance.creatComponentByStylename("email.NextPageBtn");
         _pageText = ComponentFactory.Instance.creatComponentByStylename("email.PageText");
         _writeBtn = ComponentFactory.Instance.creatComponentByStylename("email.WriteBtn");
         _newEffect = ComponentFactory.Instance.creatCustomObject("email.NewEffect");
         addToContent(_background);
         addToContent(_emailBtn);
         addToContent(_battleBtn);
         addToContent(_allSelectBtn);
         addToContent(_deleteBtn);
         addToContent(_attachBtn);
         addToContent(_prePage);
         addToContent(_nextPage);
         addToContent(_pageText);
         addToContent(_writeBtn);
         addToContent(_newEffect);
         _newEffect.gotoAndStop(1);
         _newEffect.visible = false;
         _newEffect.mouseEnabled = _newEffect.mouseChildren = false;
         _emailListView = ComponentFactory.Instance.creatCustomObject("email.EmailListView");
         addToContent(_emailListView);
         _buttongroup1.selectIndex = 0;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _allSelectBtn.addEventListener("click",__allSelectedHandler);
         _deleteBtn.addEventListener("click",__deleteHandler);
         _attachBtn.addEventListener("click",__attachHandler);
         _prePage.addEventListener("click",__prePageHandler);
         _nextPage.addEventListener("click",__nextPageHandler);
         _writeBtn.addEventListener("click",__writeHandler);
         _buttongroup1.addEventListener("change",__panelChangeHandler);
         model.addEventListener("VIEW_EMAILTYPE_CHANGE",__viewChangeHandler);
         model.addEventListener("VIEW_PAGE_CHANGE",__viewChangeHandler);
         model.addEventListener("VIEW_READSTATE_CHANGE",__viewChangeHandler);
         model.addEventListener("DATA_EMAIL_DELETE",__viewChangeHandler);
         model.addEventListener("DATA_EMAIL_NEW",__viewChangeHandler);
         model.addEventListener("NEW_BATTLEREPORT_CHANGE",__newBattleChangeHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _allSelectBtn.removeEventListener("click",__allSelectedHandler);
         _deleteBtn.removeEventListener("click",__deleteHandler);
         _attachBtn.removeEventListener("click",__attachHandler);
         _prePage.removeEventListener("click",__prePageHandler);
         _nextPage.removeEventListener("click",__nextPageHandler);
         _writeBtn.removeEventListener("click",__writeHandler);
         _buttongroup1.removeEventListener("change",__panelChangeHandler);
         if(model)
         {
            model.removeEventListener("VIEW_EMAILTYPE_CHANGE",__viewChangeHandler);
            model.removeEventListener("VIEW_PAGE_CHANGE",__viewChangeHandler);
            model.removeEventListener("VIEW_READSTATE_CHANGE",__viewChangeHandler);
            model.removeEventListener("DATA_EMAIL_DELETE",__viewChangeHandler);
            model.removeEventListener("DATA_EMAIL_NEW",__viewChangeHandler);
            model.removeEventListener("NEW_BATTLEREPORT_CHANGE",__newBattleChangeHandler);
         }
      }
      
      private function __viewChangeHandler(param1:EmailEvent = null) : void
      {
         _pageText.text = model.currentPage + " / " + model.totalPage;
         _prePage.enable = model.currentPage != 1;
         _nextPage.enable = model.currentPage != model.totalPage;
         __newBattleChangeHandler(null);
      }
      
      private function __newBattleChangeHandler(param1:EmailEvent) : void
      {
         if(EmailManager.instance.existUnreadReport())
         {
            _newEffect.gotoAndPlay(1);
            _newEffect.visible = true;
         }
         else
         {
            _newEffect.gotoAndStop(1);
            _newEffect.visible = false;
         }
      }
      
      private function __panelChangeHandler(param1:Event) : void
      {
         var _loc2_:int = 0;
         SoundManager.instance.play("022");
         model.selectedMailId = 0;
         model.allSelected = false;
         switch(_buttongroup1.getSelectedItem())
         {
            case _emailBtn:
               _loc2_ = 1;
               _attachBtn.enable = true;
               break;
            case _battleBtn:
               _loc2_ = 3;
               _attachBtn.enable = false;
         }
         model.emailType = _loc2_;
         model.currentPage = 1;
         __viewChangeHandler();
      }
      
      private function __allSelectedHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         model.allSelected = !model.allSelected;
      }
      
      private function __deleteHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         SoundManager.instance.play("022");
         if(model.currentSelectedList.length > 0)
         {
            control.deleteEmails(model.currentSelectedList);
         }
         else if(model.selectedMailId > 0)
         {
            control.deleteEmails([model.selectedMailId]);
         }
         else
         {
            _loc2_ = LanguageMgr.GetTranslation("emailII.EmailFrame.command01");
            MessageTipManager.instance().show(_loc2_);
         }
      }
      
      private function __attachHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         SoundManager.instance.play("022");
         if(model.currentSelectedList.length > 0 || model.selectedMailId)
         {
            control.attachEmails();
         }
         else
         {
            _loc2_ = LanguageMgr.GetTranslation("emailII.EmailFrame.command01");
            MessageTipManager.instance().show(_loc2_);
         }
      }
      
      private function __prePageHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(model.totalPage == 1)
         {
            return;
         }
         model.allSelected = false;
         model.currentPage = model.currentPage - 1 <= 0 ? 1 : model.currentPage - 1;
         model.deleteSelectedAll();
      }
      
      private function __nextPageHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(model.totalPage == model.currentPage)
         {
            return;
         }
         model.allSelected = false;
         model.currentPage = model.currentPage + 1 >= model.totalPage ? model.totalPage : model.currentPage + 1;
         model.deleteSelectedAll();
      }
      
      private function __writeHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         SoundManager.instance.play("022");
         if(ArmyManager.instance.thane.grades < 6)
         {
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.prompt");
            _loc4_ = LanguageMgr.GetTranslation("emailII.EmailFrame.view.underSixLevel",6);
            SimpleAlertHelper.instance.data = [];
            SimpleAlertHelper.instance.popAlerFrame(_loc3_,_loc4_,_loc2_,"",true,false,false);
         }
         else
         {
            FrameControllerManager.instance.openControllerByInfo("writeemail","email.WriteEmailFrame","");
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      private function setdefaultType() : void
      {
         if(EmailManager.instance.existUnreadReport())
         {
            _newEffect.visible = true;
            _newEffect.gotoAndPlay(1);
         }
         _buttongroup1.selectIndex = 0;
         model.emailType = 1;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_background);
         ObjectUtils.disposeObject(_emailBtn);
         ObjectUtils.disposeObject(_battleBtn);
         ObjectUtils.disposeObject(_buttongroup1);
         ObjectUtils.disposeObject(_writeBtn);
         ObjectUtils.disposeObject(_allSelectBtn);
         ObjectUtils.disposeObject(_deleteBtn);
         ObjectUtils.disposeObject(_attachBtn);
         ObjectUtils.disposeObject(_prePage);
         ObjectUtils.disposeObject(_nextPage);
         ObjectUtils.disposeObject(_pageText);
         ObjectUtils.disposeObject(_newEffect);
         ObjectUtils.disposeObject(_deleteBtn);
         ObjectUtils.disposeObject(_emailListView);
         _background = null;
         _emailBtn = null;
         _battleBtn = null;
         _buttongroup1 = null;
         _writeBtn = null;
         _allSelectBtn = null;
         _deleteBtn = null;
         _attachBtn = null;
         _prePage = null;
         _nextPage = null;
         _pageText = null;
         _newEffect = null;
         _emailListView = null;
         super.dispose();
      }
   }
}

