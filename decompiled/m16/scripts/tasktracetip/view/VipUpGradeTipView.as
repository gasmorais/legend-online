package tasktracetip.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.TaskTraceTipManager;
   import managers.VIPManager;
   import mvc.module.vip.VIPModel;
   import tasktracetip.data.TipMessageData;
   import yishi.manager.FrameControllerManager;
   
   public class VipUpGradeTipView extends TaskTraceTipView
   {
      
      private var _contentTxt:FilterFrameText;
      
      public function VipUpGradeTipView()
      {
         super();
      }
      
      override protected function initView() : void
      {
         super.initView();
         _back.setFrame(1);
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.ContentTxt");
         _textBtn = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.UpGradeBtn");
         var _loc1_:int = int(VIPManager.Instance.model.vipInfo.VipGrade);
         _contentTxt.htmlText = LanguageMgr.GetTranslation("tasktracetip.view.VipUpGradeTipView.ContentTxt",_loc1_);
         _textBtn.text = LanguageMgr.GetTranslation("tasktracetip.view.VipUpGradeTipView.BtnTxt");
         _textBtn.width = 140;
         _textBtn.x = 40;
         addChild(_contentTxt);
         addChild(_textBtn);
      }
      
      override public function set data(param1:TipMessageData) : void
      {
         super.data = param1;
         _contentTxt.height = _contentTxt.textHeight + _contentTxt.numLines * 4;
         _contentTxt.y = 55 - (_contentTxt.numLines - 1) * 10;
      }
      
      override protected function __btnHandler(param1:Event) : void
      {
         super.__btnHandler(param1);
         FrameControllerManager.instance.openControllerByInfo("vip",VIPModel.OPEN_PRIVILEGE_FRAME);
         TaskTraceTipManager.instance.cleanByType(data.type);
      }
      
      override protected function check() : Boolean
      {
         return false;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

