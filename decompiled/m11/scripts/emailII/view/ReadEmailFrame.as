package emailII.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import events.EmailEvent;
   import manager.LanguageMgr;
   import mvc.controler.EmailControler;
   import mvc.module.emailII.EmailModel;
   
   public class ReadEmailFrame extends Frame
   {
      
      private var _control:EmailControler;
      
      private var _model:EmailModel;
      
      private var _emailView:ReadEmailView;
      
      private var _reportView:ReadBattleReportView;
      
      public function ReadEmailFrame()
      {
         super();
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _model.addEventListener("VIEW_CURRENTREAD_CHANGE",__viewChangeHandler);
         _model.addEventListener("VIEW_EMAILTYPE_CHANGE",__viewTypeChangeHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _model.removeEventListener("VIEW_CURRENTREAD_CHANGE",__viewChangeHandler);
         _model.removeEventListener("VIEW_EMAILTYPE_CHANGE",__viewTypeChangeHandler);
      }
      
      private function __viewTypeChangeHandler(param1:EmailEvent) : void
      {
         _control.closeReadFrame();
      }
      
      private function __viewChangeHandler(param1:EmailEvent) : void
      {
         if(!_model.currentReadEmail)
         {
            _control.closeReadFrame();
            return;
         }
         refreshView();
      }
      
      private function refreshView() : void
      {
         if(_model.currentReadEmail.MailType != 3)
         {
            titleText = LanguageMgr.GetTranslation("emailII.EmailFrame.title");
            if(_emailView)
            {
               if(_reportView && _reportView.parent)
               {
                  _reportView.parent.removeChild(_reportView);
               }
               _emailView.refreshData();
               addToContent(_emailView);
            }
         }
         else
         {
            titleText = LanguageMgr.GetTranslation("emailII.EmailFrame.battle");
            if(_reportView)
            {
               if(_emailView && _emailView.parent)
               {
                  _emailView.parent.removeChild(_emailView);
               }
               _reportView.refreshData();
               addToContent(_reportView);
            }
         }
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP"];
      }
      
      public function show(param1:EmailControler, param2:EmailModel, param3:Frame) : void
      {
         _control = param1;
         _model = param2;
         _emailView = ComponentFactory.Instance.creatCustomObject("email.ReadEmailView",[_control,_model]);
         _reportView = ComponentFactory.Instance.creatCustomObject("email.ReadReportView",[_control,_model]);
         initEvent();
         refreshView();
         LayerManager.Instance.addTolayerRelated(param3,this,3,true,false,0,-10);
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               _control.closeReadFrame();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_emailView)
         {
            _emailView.dispose();
         }
         _emailView = null;
         if(_reportView)
         {
            _reportView.dispose();
         }
         _reportView = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

