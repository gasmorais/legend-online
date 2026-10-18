package customerService.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import manager.LanguageMgr;
   import mvc.module.customerService.CustomerServiceModel;
   import yishi.utils.StringHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class HanckingView_2 extends CustomerServiceBaseView
   {
      
      private var _lastBtn:BaseButton;
      
      private var _getGoodsWay:TextField;
      
      private var _getGoodsTime:TextField;
      
      public function HanckingView_2(param1:CustomerServiceModel)
      {
         super(param1);
         viewType = "HanckingView_2";
      }
      
      override protected function initView() : void
      {
         super.initView();
         _timeBar = creatTimeBar(12,99);
         _inputText = creatInputTextArea(449,143,12,177);
         _lastBtn = creatBaseButton("customerservice.LastStepButton");
         _submitBtn = creatBaseButton("customerservice.submitButton_right");
         _getGoodsTime = creatInputText("asset.customerservice.GetGoodsTimeTxt",12,126,260,26);
         _getGoodsWay = creatInputText("asset.customerservice.GetGoodsWayTxt",12,150,260,26);
         _addPictureUploadBtn(373,175);
         var _loc1_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.customerservice.SignMust");
         _loc1_.x = 388;
         _loc1_.y = 132;
         addChild(_loc1_);
         _loc1_ = new Bitmap(_loc1_.bitmapData);
         _loc1_.x = 388;
         _loc1_.y = 156;
         addChild(_loc1_);
      }
      
      override protected function initEvent() : void
      {
         super.initEvent();
         _lastBtn.addEventListener("click",_lastBtnHandler);
      }
      
      private function _lastBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         control.frame["changeViewWith"]("HanckingView_1");
      }
      
      override protected function _submitBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(!StringHelper.trimAll(_getGoodsTime.text))
         {
            _loc2_ = LanguageMgr.GetTranslation("CustomerServiceManger.goodsTimeNull");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(!StringHelper.trimAll(_getGoodsWay.text))
         {
            _loc2_ = LanguageMgr.GetTranslation("CustomerServiceManger.goodsWayNull");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         _model.data.goods_get_method = _getGoodsWay.text;
         _model.data.goods_get_date = _getGoodsTime.text;
         _model.data.question_content = _inputText.text;
         super._submitBtnHandler(null);
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

