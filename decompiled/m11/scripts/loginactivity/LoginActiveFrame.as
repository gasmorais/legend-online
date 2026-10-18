package loginactivity
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import funny.FunnyEvent;
   import loginactivity.view.LoginContinueView;
   import loginactivity.view.LoginCountView;
   import manager.LanguageMgr;
   import managers.FunnyManager;
   import mvc.module.funny.FunnyModel;
   
   public class LoginActiveFrame extends Frame
   {
      
      private var _countView:LoginCountView;
      
      private var _continueView:LoginContinueView;
      
      public function LoginActiveFrame()
      {
         super();
         FunnyManager.instance.sendGetBag(1);
         initView();
         initEvent();
         __refreshHandler(null);
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      private function initView() : void
      {
         _countView = ComponentFactory.Instance.creatCustomObject("LoginActiveFrame.countView");
         addToContent(_countView);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__response);
         FunnyManager.instance.addEventListener("LOGIN_ACTIVE_CHANGE",__refreshHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__response);
         FunnyManager.instance.removeEventListener("LOGIN_ACTIVE_CHANGE",__refreshHandler);
      }
      
      private function __refreshHandler(param1:FunnyEvent) : void
      {
         if(_countView)
         {
            _countView.refreshView();
         }
         if(model.continueLoginData)
         {
            if(_continueView == null)
            {
               _continueView = ComponentFactory.Instance.creatCustomObject("LoginActiveFrame.continueView");
            }
            addToContent(_continueView);
            _continueView.refreshView();
            this.width = 840;
         }
         else
         {
            if(_continueView && _continueView.parent)
            {
               _continueView.parent.removeChild(_continueView);
            }
            this.width = 455;
         }
      }
      
      private function __response(param1:FrameEvent) : void
      {
         if(param1.responseCode == 1 || param1.responseCode == 0)
         {
            dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
         titleText = LanguageMgr.GetTranslation("loginactivity.LoginActiveFrame.titleText");
      }
      
      private function get model() : FunnyModel
      {
         return FunnyManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_countView);
         _countView = null;
         ObjectUtils.disposeObject(_continueView);
         _continueView = null;
         super.dispose();
      }
   }
}

