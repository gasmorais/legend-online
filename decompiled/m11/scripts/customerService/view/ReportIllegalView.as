package customerService.view
{
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import mvc.module.customerService.CustomerServiceModel;
   
   public class ReportIllegalView extends CustomerServiceBaseView
   {
      
      public var reportName:TextField;
      
      public var reportUserName:TextField;
      
      public function ReportIllegalView(param1:CustomerServiceModel)
      {
         super(param1);
         viewType = "ReportIllegalView";
      }
      
      override protected function initView() : void
      {
         super.initView();
         _timeBar = creatTimeBar(12,100);
         _inputText = creatInputTextArea(449,130,12,186);
         _submitBtn = creatBaseButton("customerservice.submitButton");
         _closeBtn = creatBaseButton("customerservice.closeButton");
         reportName = creatInputText("asset.customerservice.ReportName",12,128,200,26,false,14);
         reportUserName = creatInputText("asset.customerservice.ReportUserImg",12,156,200,26,false,29);
         _addPictureUploadBtn(373,186);
      }
      
      override protected function _submitBtnHandler(param1:MouseEvent) : void
      {
         _model.data.question_content = _inputText.text;
         _model.data.report_user_name = reportUserName.text;
         _model.data.report_url = reportName.text;
         super._submitBtnHandler(param1);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

