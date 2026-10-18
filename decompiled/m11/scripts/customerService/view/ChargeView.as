package customerService.view
{
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import mvc.module.customerService.CustomerServiceModel;
   
   public class ChargeView extends CustomerServiceBaseView
   {
      
      private var _chargeIdTxt:TextField;
      
      private var _chargeMethodTxt:TextField;
      
      private var _chargeMoneyTxt:TextField;
      
      public function ChargeView(param1:CustomerServiceModel)
      {
         super(param1);
         viewType = "ChargeView";
      }
      
      override protected function initView() : void
      {
         super.initView();
         _timeBar = creatTimeBar(12,99);
         _chargeIdTxt = creatInputText("asset.customerservice.ChargeIdTxt",12,128,260,26);
         _chargeMethodTxt = creatInputText("asset.customerservice.ChargemethodTxt",12,153,260,26,false,26);
         _chargeMoneyTxt = creatInputText("asset.customerservice.ChargeMoneyTxt",12,178,260,26,false,26);
         _inputText = creatInputTextArea(449,115,12,208);
         _inputText.editable = true;
         _submitBtn = creatBaseButton("customerservice.submitButton");
         _closeBtn = creatBaseButton("customerservice.closeButton");
         _addPictureUploadBtn(373,208);
      }
      
      override protected function _submitBtnHandler(param1:MouseEvent) : void
      {
         _model.data.charge_order_id = _chargeIdTxt.text;
         _model.data.charge_method = _chargeMethodTxt.text;
         _model.data.charge_moneys = Number(_chargeMoneyTxt.text);
         _model.data.question_content = _inputText.text;
         super._submitBtnHandler(param1);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

