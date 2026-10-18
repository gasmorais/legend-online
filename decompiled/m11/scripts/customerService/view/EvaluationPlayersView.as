package customerService.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconTextButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.customerService.CustomerServiceModel;
   import yishi.manager.CustomerServiceManager;
   import yishi.view.tips.MessageTipManager;
   
   public class EvaluationPlayersView extends CustomerServiceBaseView
   {
      
      private var _titleBackBmp:Image;
      
      private var _titleTextBmp:Bitmap;
      
      private var _replyText:Bitmap;
      
      private var _tapButtonGroup:SelectedButtonGroup;
      
      private var _evaluateVeryGoodBtn:SelectedIconTextButton;
      
      private var _evaluateGoodBtn:SelectedIconTextButton;
      
      private var _evaluateGeneralBtn:SelectedIconTextButton;
      
      private var _evaluatePoorBtn:SelectedIconTextButton;
      
      private var _evaluateGrade:int = 0;
      
      public function EvaluationPlayersView(param1:CustomerServiceModel)
      {
         super(param1);
         viewType = "EvaluationPlayersView";
      }
      
      override protected function initView() : void
      {
         _cantactBtn = creatBaseButton("customerservice.contactButton");
         _submitBtn = creatBaseButton("customerservice.EvaluateSubmitButton");
         _titleBackBmp = ComponentFactory.Instance.creatComponentByStylename("customerservice.BackStyle_3");
         _titleTextBmp = ComponentFactory.Instance.creatBitmap("asset.customerservice.EvaluateTxt");
         _replyText = ComponentFactory.Instance.creatBitmap("asset.customerservice.ReplyEvaluationTxt");
         _inputText = creatInputTextArea(449,145,12,164);
         _evaluateVeryGoodBtn = ComponentFactory.Instance.creatComponentByStylename("customerservice.evaluate_1");
         _evaluateGoodBtn = ComponentFactory.Instance.creatComponentByStylename("customerservice.evaluate_2");
         _evaluateGeneralBtn = ComponentFactory.Instance.creatComponentByStylename("customerservice.evaluate_3");
         _evaluatePoorBtn = ComponentFactory.Instance.creatComponentByStylename("customerservice.evaluate_4");
         _tapButtonGroup = new SelectedButtonGroup();
         _tapButtonGroup.addSelectItem(_evaluateVeryGoodBtn);
         _evaluateVeryGoodBtn.text = LanguageMgr.GetTranslation("customerservice.EvaluationPlayersView.veryGood");
         _tapButtonGroup.addSelectItem(_evaluateGoodBtn);
         _evaluateGoodBtn.text = LanguageMgr.GetTranslation("customerservice.EvaluationPlayersView.good");
         _tapButtonGroup.addSelectItem(_evaluateGeneralBtn);
         _evaluateGeneralBtn.text = LanguageMgr.GetTranslation("customerservice.EvaluationPlayersView.general");
         _tapButtonGroup.addSelectItem(_evaluatePoorBtn);
         _evaluatePoorBtn.text = LanguageMgr.GetTranslation("customerservice.EvaluationPlayersView.poor");
         addChild(_titleBackBmp);
         addChild(_titleTextBmp);
         addChild(_replyText);
         addChild(_evaluateVeryGoodBtn);
         addChild(_evaluateGoodBtn);
         addChild(_evaluateGeneralBtn);
         addChild(_evaluatePoorBtn);
      }
      
      override protected function initEvent() : void
      {
         super.initEvent();
         _tapButtonGroup.addEventListener("change",_tapButtonGroupHandler);
      }
      
      private function _tapButtonGroupHandler(param1:Event) : void
      {
         var _loc2_:ISelectable = _tapButtonGroup.getSelectedItem();
         switch(_loc2_)
         {
            case _evaluateVeryGoodBtn:
               _evaluateGrade = 4;
               break;
            case _evaluateGoodBtn:
               _evaluateGrade = 3;
               break;
            case _evaluateGeneralBtn:
               _evaluateGrade = 2;
               break;
            case _evaluatePoorBtn:
               _evaluateGrade = 1;
         }
      }
      
      override protected function _submitBtnHandler(param1:MouseEvent) : void
      {
         if(checkBlank())
         {
            return;
         }
         if(_submitDelay())
         {
            _model.data.appraisal_grade = _evaluateGrade;
            _model.data.question_content = _inputText.text;
            CustomerServiceManager.instance.sendEvaluate();
         }
      }
      
      private function checkBlank() : Boolean
      {
         if(_evaluateGrade == 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("customerService.view.EvaluationPlayerView.content01"));
            return true;
         }
         return false;
      }
      
      override protected function removeEvent() : void
      {
         super.removeEvent();
         _tapButtonGroup.removeEventListener("change",_tapButtonGroupHandler);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

