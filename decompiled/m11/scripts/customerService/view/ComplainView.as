package customerService.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import manager.LanguageMgr;
   import mvc.module.customerService.CustomerServiceModel;
   import yishi.utils.StringHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class ComplainView extends CustomerServiceBaseView
   {
      
      private var _playerName:TextField;
      
      private var _complainTitle:TextField;
      
      private var _playerPhone:TextField;
      
      private var _complainSource:TextField;
      
      public function ComplainView(param1:CustomerServiceModel)
      {
         super(param1);
         viewType = "ComplainView";
      }
      
      override protected function initView() : void
      {
         super.initView();
         _timeBar = creatTimeBar(12,97);
         _playerName = creatInputText("asset.customerservice.PlayerNameTxt",12,122,100,26);
         _playerPhone = creatInputText("asset.customerservice.PlayerPhoneTxt",260,122,100,26);
         _complainTitle = creatInputText("asset.customerservice.ComplaintTitleTxt",12,147,100,26);
         _complainSource = creatInputText("asset.customerservice.ComplainSourceTxt",260,147,100,26);
         _inputText = creatInputTextArea(449,143,12,175);
         _submitBtn = creatBaseButton("customerservice.submitButton");
         _closeBtn = creatBaseButton("customerservice.closeButton");
         _addPictureUploadBtn(373,175);
         var _loc1_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.customerservice.SignMust");
         _loc1_.x = 197;
         _loc1_.y = 128;
         addChild(_loc1_);
      }
      
      override protected function _submitBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(!StringHelper.trimAll(_playerName.text))
         {
            _loc2_ = LanguageMgr.GetTranslation("CustomerServiceManger.playerNameNull");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         _model.data.user_full_name = _playerName.text;
         _model.data.user_phone = _playerPhone.text;
         _model.data.complaints_title = _complainTitle.text;
         _model.data.complaints_source = _complainSource.text;
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

