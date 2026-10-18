package customerService.view
{
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import mvc.module.customerService.CustomerServiceModel;
   
   public class GoodsMissView extends CustomerServiceBaseView
   {
      
      private var _getGoodsWay:TextField;
      
      private var _getGoodsTime:TextField;
      
      public function GoodsMissView(param1:CustomerServiceModel)
      {
         super(param1);
         viewType = "GoodsMissView";
      }
      
      override protected function initView() : void
      {
         super.initView();
         _timeBar = creatTimeBar(12,97);
         _inputText = creatInputTextArea(449,143,12,175);
         _submitBtn = creatBaseButton("customerservice.submitButton");
         _closeBtn = creatBaseButton("customerservice.closeButton");
         _getGoodsWay = creatInputText("asset.customerservice.GetGoodsWayTxt",12,123,260,26,false);
         _getGoodsTime = creatInputText("asset.customerservice.GetGoodsTimeTxt",12,150,260,26,false);
         _addPictureUploadBtn(373,175);
      }
      
      override protected function _submitBtnHandler(param1:MouseEvent) : void
      {
         _model.data.goods_get_method = _getGoodsWay.text;
         _model.data.goods_get_date = _getGoodsTime.text;
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

