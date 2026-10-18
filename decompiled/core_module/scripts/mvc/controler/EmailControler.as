package mvc.controler
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.road.yishi.proto.mail.MailDelReqMsg;
   import events.EmailEvent;
   import manager.LanguageMgr;
   import managers.EmailSocketOutManager;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   import mvc.module.emailII.EmailInfo;
   import mvc.module.emailII.EmailModel;
   import yishi.comm.PackageIn;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.EmailManager;
   import yishi.manager.ResourceManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.EmailHelp;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.StringHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class EmailControler extends FrameController
   {
      
      public static const EMAIL_FRAME:String = "email.EmailFrame";
      
      public static const WRITE_EMAIL_FRAME:String = "email.WriteEmailFrame";
      
      private var _typeFrame:String;
      
      private var _model:EmailModel;
      
      private var _readFrame:Frame;
      
      private var _writeFrame:Frame;
      
      public var isOpened:Boolean;
      
      private var _alert:BaseAlerFrame;
      
      private var _list:Array;
      
      public function EmailControler()
      {
         super();
         _model = new EmailModel();
         addEvent();
      }
      
      override public function get frameClassName() : String
      {
         return _typeFrame;
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         _typeFrame = String(param1.openType);
         filterOutDateEmails();
         super.start(param1);
      }
      
      override protected function showFrame() : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc1_:String = null;
         super.showFrame();
         switch(_typeFrame)
         {
            case "email.EmailFrame":
               _frame["show"]();
               if(EmailManager.instance.cate.allBattleList.length + EmailManager.instance.cate.allMailList.length >= 300 && EmailManager.instance.cate.totalLength >= 300 && !isOpened)
               {
                  _loc2_ = LanguageMgr.GetTranslation("emailII.EmailControler.prompt");
                  _loc3_ = LanguageMgr.GetTranslation("emailII.EmailControler.content01");
                  SimpleAlertHelper.instance.data = [];
                  SimpleAlertHelper.instance.popAlerFrame(_loc2_,_loc3_);
               }
               break;
            case "email.WriteEmailFrame":
               setPreFrame("email","email.EmailFrame");
               _writeFrame = _frame;
               _writeFrame["show"](this,_model);
               if(_data)
               {
                  _loc1_ = !StringHelper.isNullOrEmpty(_data.frameData as String) ? String(_data.frameData) : "";
               }
               _writeFrame["sendEmailToPerson"](_loc1_);
               break;
            default:
               _frame["show"]();
         }
         isOpened = true;
      }
      
      override protected function exitFrame() : void
      {
         super.exitFrame();
         closeReadFrame();
         resetDate();
         isOpened = false;
         EmailManager.instance.dispatchEvent(new EmailEvent("EMAIL_CLOSE"));
      }
      
      private function filterOutDateEmails() : void
      {
         for each(var _loc1_:EmailInfo in EmailManager.instance.cate)
         {
            if(_loc1_.remainTime() <= 0)
            {
               EmailManager.instance.cate.removeEmail(_loc1_.Id);
            }
         }
      }
      
      private function resetDate() : void
      {
         _model.allSelected = false;
         _model.currentPage = 1;
         _model.selectedMailId = 0;
         EmailManager.instance.cate.refreshMail();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4132,__mailDelResult);
      }
      
      private function __mailDelResult(param1:SLGSocketEvent) : void
      {
         var _loc3_:String = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:MailDelReqMsg = new MailDelReqMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as MailDelReqMsg;
         if(_loc2_.delList.length != 0)
         {
            _model.currentSelectedList.splice(0,_model.currentSelectedList.length);
            setSelectedMail(_loc2_.delList);
            EmailManager.instance.removeEmail(_loc2_.delList);
         }
         else
         {
            _loc3_ = LanguageMgr.GetTranslation("emailII.EmailControler.command01");
            MessageTipManager.instance().show(_loc3_);
         }
      }
      
      private function setSelectedMail(param1:Array) : void
      {
         if(param1.indexOf(_model.selectedMailId) != -1)
         {
            _model.selectedMailId = 0;
         }
      }
      
      public function openReadMailFrame() : void
      {
         if(_readFrame)
         {
            return;
         }
         _readFrame = ComponentFactory.Instance.creatComponentByStylename("email.ReadFrame");
         _readFrame["show"](this,_model,_frame);
      }
      
      public function closeReadFrame() : void
      {
         if(_readFrame)
         {
            _readFrame.dispose();
            _readFrame = null;
         }
         if(_frame)
         {
            StageReferance.stage.focus = _frame;
         }
         else
         {
            _readFrame = null;
            _writeFrame = null;
         }
      }
      
      public function deleteEmails(param1:Array) : void
      {
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc2_:String = null;
         _list = param1;
         var _loc3_:Boolean = false;
         for each(var _loc4_:int in param1)
         {
            if(EmailManager.instance.cate.getEmailById(_loc4_).hasGoods)
            {
               _loc3_ = true;
               break;
            }
         }
         if(!_loc3_)
         {
            EmailSocketOutManager.deleteMail(_list);
            _list = null;
         }
         else
         {
            _loc5_ = LanguageMgr.GetTranslation("emailII.EmailControler.prompt");
            _loc6_ = LanguageMgr.GetTranslation("emailII.EmailControler.content");
            _loc2_ = LanguageMgr.GetTranslation("public.cancel");
            _alert = AlertManager.Instance.simpleAlert(_loc5_,_loc6_,"",_loc2_,false,false,true);
            _alert.addEventListener("response",__alertResponseHandler);
         }
      }
      
      private function __alertResponseHandler(param1:FrameEvent) : void
      {
         _alert.removeEventListener("response",__alertResponseHandler);
         _alert.dispose();
         _alert = null;
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            EmailSocketOutManager.deleteMail(_list);
            _list = null;
         }
      }
      
      public function attachEmails() : void
      {
         if(_model.currentSelectedList.length > 0)
         {
            if(checkAttach(_model.currentSelectedList))
            {
               EmailSocketOutManager.getAttached(_model.currentSelectedList,0);
            }
         }
         else if(_model.selectedMailId > 0 && checkAttach([_model.selectedMailId]))
         {
            EmailSocketOutManager.getAttached([_model.selectedMailId],0);
         }
      }
      
      private function checkAttach(param1:Array) : Boolean
      {
         var _loc4_:int = 0;
         for each(var _loc3_:int in param1)
         {
            _loc4_ = EmailManager.instance.getEmailById(_loc3_).MailType;
            if(EmailManager.instance.getEmailById(_loc3_).hasGoods)
            {
               if(_loc4_ == 4)
               {
                  return EmailHelp.checkCanGetStart() != -1;
               }
               return EmailHelp.checkCanGetGoods() != -1;
            }
         }
         var _loc2_:String = LanguageMgr.GetTranslation("emailII.EmailControler.command02");
         MessageTipManager.instance().show(_loc2_);
         return false;
      }
      
      public function readEmail(param1:int) : void
      {
         EmailManager.instance.getMailList(param1.toString(),1);
         openReadMailFrame();
      }
      
      public function getAttached(param1:int, param2:int) : void
      {
         EmailSocketOutManager.getAttached([param1],param2);
      }
      
      public function sendEmail(param1:Array, param2:String, param3:String) : void
      {
         var _loc4_:String = null;
         if(ResourceManager.instance.gold.count < 100)
         {
            _loc4_ = LanguageMgr.GetTranslation("public.gold");
            MessageTipManager.instance().show(_loc4_);
            return;
         }
         EmailSocketOutManager.sendEmail(param1,param2,param3,1);
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
      
      public function get model() : EmailModel
      {
         return _model;
      }
   }
}

