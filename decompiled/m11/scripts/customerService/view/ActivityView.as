package customerService.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconTextButton;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import manager.LanguageMgr;
   import mvc.module.customerService.CustomerServiceModel;
   import yishi.utils.StringHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class ActivityView extends CustomerServiceBaseView
   {
      
      private var _activityName:TextField;
      
      private var _isNormalBmp:Bitmap;
      
      private var _normalBtn:SelectedIconTextButton;
      
      private var _notNormalBtn:SelectedIconTextButton;
      
      private var _tapGroup:SelectedButtonGroup;
      
      public function ActivityView(param1:CustomerServiceModel)
      {
         super(param1);
         viewType = "ActivityView";
      }
      
      override protected function initView() : void
      {
         super.initView();
         _isNormalBmp = ComponentFactory.Instance.creatBitmap("asset.customerservice.IsActivityNormalImg");
         addChild(_isNormalBmp);
         _timeBar = creatTimeBar(12,100);
         _inputText = creatInputTextArea(449,171,12,154);
         _submitBtn = creatBaseButton("customerservice.submitButton");
         _closeBtn = creatBaseButton("customerservice.closeButton");
         _activityName = creatInputText("asset.customerservice.ActivityNameImg",237,127,100,26);
         _normalBtn = ComponentFactory.Instance.creatComponentByStylename("customerservice.ActivityBtn_1");
         _notNormalBtn = ComponentFactory.Instance.creatComponentByStylename("customerservice.ActivityBtn_0");
         _normalBtn.text = LanguageMgr.GetTranslation("public.yes");
         _notNormalBtn.text = LanguageMgr.GetTranslation("public.no");
         _tapGroup = new SelectedButtonGroup();
         _tapGroup.addSelectItem(_normalBtn);
         _tapGroup.addSelectItem(_notNormalBtn);
         _tapGroup.selectIndex = 0;
         addChild(_normalBtn);
         addChild(_notNormalBtn);
         _addPictureUploadBtn(373,154);
         var _loc1_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.customerservice.SignMust");
         _loc1_.x = 455;
         _loc1_.y = 132;
         addChild(_loc1_);
      }
      
      override protected function _submitBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(!StringHelper.trimAll(_activityName.text))
         {
            _loc2_ = LanguageMgr.GetTranslation("CustomerServiceManger.activityNameNull");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         _model.data.question_content = _inputText.text;
         _model.data.activity_name = _activityName.text;
         _model.data.activity_is_error = _tapGroup.getSelectedItem() == _normalBtn ? 1 : 0;
         super._submitBtnHandler(null);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _activityName = null;
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

