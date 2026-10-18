package customerService.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.TextArea;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import mvc.module.customerService.CustomerServiceModel;
   
   public class ServiceReplyView extends CustomerServiceBaseView implements Disposeable
   {
      
      public var problemName:TextField;
      
      public var playerProblemText:TextArea;
      
      public var severceReplyText:TextArea;
      
      private var _continueSubmitBtn:BaseButton;
      
      private var _resultPostedBtn:BaseButton;
      
      public function ServiceReplyView(param1:CustomerServiceModel)
      {
         super(param1);
         viewType = "ServiceReplyView";
         initData();
      }
      
      override protected function initView() : void
      {
         _cantactBtn = creatBaseButton("customerservice.contactButton");
         _titleBitmap = ComponentFactory.Instance.creatBitmap("asset.customerservice.DescribeTxt_1");
         _titleBitmap.x = 21;
         _titleBitmap.y = 20;
         addChild(_titleBitmap);
         _timeBar = creatTimeBar(20,93);
         _timeBar.mouseEnabled = false;
         _timeBar.mouseChildren = false;
         problemName = creatInputText("asset.customerservice.ProblemTitleTxt",20,52,260,26,false,6);
         playerProblemText = creatInputTextArea(212,170,20,138);
         severceReplyText = creatInputTextArea(212,170,248,138,"customerservice.serviceReplyTextArea");
         problemName.type = "dynamic";
         playerProblemText.editable = false;
         severceReplyText.editable = false;
         _continueSubmitBtn = creatBaseButton("customerservice.ContinueSubmitButton");
         _resultPostedBtn = creatBaseButton("customerservice.ResultPostedButton");
         if(_model.stopReply)
         {
            _continueSubmitBtn.enable = false;
         }
      }
      
      override protected function initEvent() : void
      {
         super.initEvent();
         _continueSubmitBtn.addEventListener("click",_continueSubmitHandler);
         _resultPostedBtn.addEventListener("click",_resultPostedHandler);
      }
      
      private function initData() : void
      {
         if(!_model.currentReplyInfo)
         {
            return;
         }
         problemName.text = _model.currentReplyInfo.title;
         playerProblemText.text = _model.currentReplyInfo.content;
         playerProblemText.textField.height = playerProblemText.textField.textHeight + 15;
         playerProblemText.invalidateViewport();
         severceReplyText.text = _model.currentReplyInfo.replayContent;
         severceReplyText.textField.height = severceReplyText.textField.textHeight + 15;
         severceReplyText.invalidateViewport();
         date = _model.currentReplyInfo.date;
      }
      
      private function _continueSubmitHandler(param1:MouseEvent) : void
      {
         control.frame["changeViewWith"]("PlayerToReplyView");
      }
      
      private function _resultPostedHandler(param1:MouseEvent) : void
      {
         control.frame["changeViewWith"]("EvaluationPlayersView");
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         _continueSubmitBtn.removeEventListener("click",_continueSubmitHandler);
         _resultPostedBtn.removeEventListener("click",_resultPostedHandler);
      }
      
      public function set date(param1:Date) : void
      {
         _timeBar.date = param1;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

