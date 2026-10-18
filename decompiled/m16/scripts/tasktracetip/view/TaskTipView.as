package tasktracetip.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.events.Event;
   import flash.net.FileReference;
   import flash.net.URLRequest;
   import manager.LanguageMgr;
   import managers.TaskTraceTipManager;
   import tasktracetip.data.TipMessageData;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   
   public class TaskTipView extends TaskTraceTipView
   {
      
      private var _contentTxt:FilterFrameText;
      
      public function TaskTipView()
      {
         super();
      }
      
      override protected function __btnHandler(param1:Event) : void
      {
         var _loc7_:String = null;
         var _loc3_:String = null;
         var _loc6_:String = null;
         var _loc4_:String = null;
         var _loc2_:URLRequest = null;
         var _loc5_:FileReference = null;
         super.__btnHandler(param1);
         if(data != null && data.data != null && data.data.TemplateId == 150)
         {
            _loc7_ = PathManager.getClientLoginPath();
            _loc3_ = PathManager.getClientLoginName() + ".exe";
            if(_loc7_.substr(-3) != "exe")
            {
               _loc6_ = PlayerManager.instance.currentPlayerModel.userInfo.user;
               _loc4_ = PlayerManager.instance.currentPlayerModel.userInfo.site;
               if(_loc7_.indexOf("?") == -1)
               {
                  _loc7_ += "?";
               }
               else
               {
                  _loc7_ += "&";
               }
               _loc7_ += "u=" + _loc6_ + "&site=" + _loc4_;
            }
            _loc7_ = encodeURI(_loc7_);
            _loc2_ = new URLRequest(_loc7_);
            _loc5_ = new FileReference();
            _loc5_.download(_loc2_,_loc3_);
         }
         TaskTraceTipManager.instance.cleanByType(data.type);
      }
      
      override protected function check() : Boolean
      {
         return super.check();
      }
      
      override public function set data(param1:TipMessageData) : void
      {
         super.data = param1;
         _contentTxt.htmlText = LanguageMgr.GetTranslation("tasktracetip.view.TaskTipView.content" + param1.data.TemplateId);
         _textBtn.text = LanguageMgr.GetTranslation("tasktracetip.view.TaskTipView.btnText" + param1.data.TemplateId);
      }
      
      override public function dispose() : void
      {
         _contentTxt = null;
         super.dispose();
      }
      
      override protected function initView() : void
      {
         super.initView();
         _textBtn = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.TaskTip_Login");
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.ContentTxt");
         _textBtn.x = 63;
         _textBtn.y = 120;
         _contentTxt.y = 54;
         _contentTxt.height = 60;
         _contentTxt.wordWrap = true;
         addChild(_contentTxt);
         addChild(_textBtn);
      }
   }
}

