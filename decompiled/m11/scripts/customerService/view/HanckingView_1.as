package customerService.view
{
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.customerService.CustomerServiceModel;
   
   public class HanckingView_1 extends CustomerServiceBaseView
   {
      
      private var _nextStepBtn:BaseButton;
      
      public function HanckingView_1(param1:CustomerServiceModel)
      {
         super(param1);
         viewType = "HanckingView_1";
      }
      
      override protected function initView() : void
      {
         var _loc2_:int = 0;
         super.initView();
         var _loc1_:String = "";
         _loc2_ = 1;
         while(_loc2_ <= 15)
         {
            _loc1_ += LanguageMgr.GetTranslation("customerservice.HanckingView_1.content" + _loc2_);
            _loc2_++;
         }
         _timeBar = creatTimeBar(12,97);
         _inputText = creatInputTextArea(449,198,12,125);
         _inputText.textField.height = 650;
         _inputText.invalidateViewport();
         _inputText.textField.type = "dynamic";
         _inputText.textField.htmlText = "<textformat leading=\'5\'><font face=\'Arial\' color=\'#ffefbf\' size = \'12\'>" + _loc1_ + "</font></textformat>";
         _nextStepBtn = creatBaseButton("customerservice.NextStepButton");
         _closeBtn = creatBaseButton("customerservice.closeButton");
      }
      
      override protected function initEvent() : void
      {
         super.initEvent();
         _nextStepBtn.addEventListener("click",_nextStepBtnHandler);
      }
      
      private function _nextStepBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         control.frame["changeViewWith"]("HanckingView_2");
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         _nextStepBtn.removeEventListener("click",_nextStepBtnHandler);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

