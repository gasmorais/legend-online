package customerService.view
{
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.customerService.CustomerServiceModel;
   import yishi.view.tips.MessageTipManager;
   
   public class CustomerServiceSelectedView extends CustomerServiceBaseView
   {
      
      public function CustomerServiceSelectedView(param1:CustomerServiceModel)
      {
         super(param1);
         viewType = "CustomerServiceSelectedView";
      }
      
      override protected function initView() : void
      {
         super.initView();
         _timeBar = creatTimeBar(12,100);
         _inputText = creatInputTextArea(449,189,12,130);
         _submitBtn = creatBaseButton("customerservice.submitButton");
         _closeBtn = creatBaseButton("customerservice.closeButton");
         _addPictureUploadBtn(373,128);
      }
      
      override protected function _submitBtnHandler(param1:MouseEvent) : void
      {
         if(viewType == "CustomerServiceSelectedView")
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("customerservice.CustomerServiceSelectedView.content"));
         }
         else
         {
            _model.data.question_content = _inputText.text;
            super._submitBtnHandler(param1);
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

