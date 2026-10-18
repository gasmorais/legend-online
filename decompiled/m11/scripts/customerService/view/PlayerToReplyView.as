package customerService.view
{
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import mvc.module.customerService.CustomerServiceModel;
   import yishi.manager.CustomerServiceManager;
   
   public class PlayerToReplyView extends CustomerServiceBaseView
   {
      
      private var _problemName:TextField;
      
      private var _lastBtn:BaseButton;
      
      public function PlayerToReplyView(param1:CustomerServiceModel)
      {
         super(param1);
         viewType = "PlayerToReplyView";
         initData();
      }
      
      override protected function initView() : void
      {
         _cantactBtn = creatBaseButton("customerservice.contactButton");
         _timeBar = creatTimeBar(12,97);
         _timeBar.mouseChildren = false;
         _timeBar.mouseEnabled = false;
         _problemName = creatInputText("asset.customerservice.ProblemTitleTxt",12,43,260,26);
         _problemName.type = "dynamic";
         _inputText = creatInputTextArea(449,189,12,120);
         _lastBtn = creatBaseButton("customerservice.LastStepButton");
         _submitBtn = creatBaseButton("customerservice.submitButton_right");
      }
      
      override protected function initEvent() : void
      {
         super.initEvent();
         _lastBtn.addEventListener("click",_lastBtnHandler);
      }
      
      private function initData() : void
      {
         if(!_model.currentReplyInfo)
         {
            return;
         }
         _timeBar.date = _model.currentReplyInfo.date;
         _problemName.text = _model.currentReplyInfo.title;
      }
      
      private function _lastBtnHandler(param1:MouseEvent) : void
      {
         control.frame["changeViewWith"]("ServiceReplyView");
      }
      
      override protected function _submitBtnHandler(param1:MouseEvent) : void
      {
         _model.data.question_content = _inputText.text;
         CustomerServiceManager.instance.sendServiceReply();
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         _lastBtn.removeEventListener("click",_lastBtnHandler);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

