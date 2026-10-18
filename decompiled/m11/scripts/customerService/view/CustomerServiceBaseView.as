package customerService.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.TextArea;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import customerService.view.tool.TimeBar;
   import events.CustomerServiceEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import mvc.controler.CustomerServiceController;
   import mvc.module.customerService.CustomerServiceModel;
   import yishi.manager.ConfigManager;
   import yishi.manager.CustomerServiceManager;
   import yishi.manager.FrameControllerManager;
   import yishi.view.tips.MessageTipManager;
   
   public class CustomerServiceBaseView extends Sprite implements Disposeable
   {
      
      public static const TITLE_MAX_CHARS:int = 20;
      
      public static const MIN_CHARS:int = 8;
      
      public static const MAX_CHARS:int = 800;
      
      private var _viewType:String;
      
      protected var _titleText:TextField;
      
      protected var _model:CustomerServiceModel;
      
      protected var _cantactBtn:BaseButton;
      
      protected var _titleBitmap:Bitmap;
      
      protected var _timeBar:TimeBar;
      
      protected var _submitBtn:BaseButton;
      
      protected var _closeBtn:BaseButton;
      
      protected var _inputText:TextArea;
      
      private var _checkTextInput:FilterFrameText;
      
      private var _checkTextNumber:int = 800;
      
      private var _submitEnble:Boolean = true;
      
      private var _submitTimeId:uint;
      
      private var _tempTitle:String = "";
      
      private var _jpgUploadBtn:IconButton;
      
      private var _jpgUploadEnd:Bitmap;
      
      private var _jpgX:int;
      
      private var _jpgY:int;
      
      public function CustomerServiceBaseView(param1:CustomerServiceModel)
      {
         super();
         _model = param1;
         initView();
         initEvent();
      }
      
      public function get viewType() : String
      {
         return _viewType;
      }
      
      public function set viewType(param1:String) : void
      {
         _viewType = param1;
      }
      
      protected function get control() : CustomerServiceController
      {
         return FrameControllerManager.instance.customerServiceController;
      }
      
      protected function initView() : void
      {
         _titleBitmap = ComponentFactory.Instance.creatBitmap("asset.customerservice.DescribeTxt_1");
         addChild(_titleBitmap);
         _titleText = creatInputText("asset.customerservice.ProblemTitleTxt",12,72,300,26,true,11);
         _cantactBtn = creatBaseButton("customerservice.contactButton");
         if(ConfigManager.info.VOICE)
         {
            _cantactBtn.enable = true;
         }
         else
         {
            _cantactBtn.enable = false;
         }
         if(_model.data.question_title)
         {
            _titleText.text = _model.data.question_title;
         }
      }
      
      protected function initEvent() : void
      {
         if(_cantactBtn)
         {
            _cantactBtn.addEventListener("click",_cantactBtnHandler);
         }
         if(_submitBtn)
         {
            _submitBtn.addEventListener("click",_submitBtnHandler);
         }
         if(_closeBtn)
         {
            _closeBtn.addEventListener("click",_closeBtnHandler);
         }
         if(_inputText)
         {
            _inputText.maxChars = 800;
            _inputText.addEventListener("change",_textInputHandler);
            _checkTextInput = ComponentFactory.Instance.creatComponentByStylename("customerservice.CheckText");
            _checkTextInput.x = _inputText.x + 80;
            _checkTextInput.y = _inputText.y - 30;
            _checkTextInput.text = LanguageMgr.GetTranslation("customerservice.CustomerServiceBaseView.content01",_checkTextNumber);
            addChild(_checkTextInput);
         }
         CustomerServiceManager.instance.model.addEventListener("UPLOAD_SUCCESS",_uploadSuccess);
      }
      
      protected function removeEvent() : void
      {
         if(_cantactBtn)
         {
            _cantactBtn.removeEventListener("click",_cantactBtnHandler);
         }
         if(_submitBtn)
         {
            _submitBtn.removeEventListener("click",_submitBtnHandler);
         }
         if(_closeBtn)
         {
            _closeBtn.removeEventListener("click",_closeBtnHandler);
         }
         if(_inputText)
         {
            _inputText.removeEventListener("change",_textInputHandler);
         }
         if(_jpgUploadBtn)
         {
            _jpgUploadBtn.removeEventListener("click",_uploadJpgHandler);
         }
         CustomerServiceManager.instance.model.removeEventListener("UPLOAD_SUCCESS",_uploadSuccess);
      }
      
      private function _textInputHandler(param1:Event) : void
      {
         _checkTextNumber = 800 - _inputText.text.length;
         _checkTextInput.text = LanguageMgr.GetTranslation("customerservice.CustomerServiceBaseView.content01",_checkTextNumber);
         _inputText.textField.height = _inputText.textField.textHeight + 15;
         _inputText.invalidateViewport();
      }
      
      protected function _addPictureUploadBtn(param1:Number, param2:Number) : void
      {
         _jpgUploadBtn = ComponentFactory.Instance.creatComponentByStylename("customerservice.uploadPictureButton");
         _jpgUploadBtn.x = param1;
         _jpgUploadBtn.y = param2;
         _jpgX = param1;
         _jpgY = param2;
         _jpgUploadBtn.addEventListener("click",_uploadJpgHandler);
         addChild(_jpgUploadBtn);
      }
      
      private function _uploadSuccess(param1:CustomerServiceEvent) : void
      {
         if(_jpgUploadBtn && _jpgUploadBtn.parent)
         {
            _jpgUploadBtn.parent.removeChild(_jpgUploadBtn);
         }
         _jpgUploadEnd = ComponentFactory.Instance.creatBitmap("asset.customerservice.uploadSuccessTxt");
         _jpgUploadEnd.x = _jpgX;
         _jpgUploadEnd.y = _jpgY;
         addChild(_jpgUploadEnd);
      }
      
      private function _uploadJpgHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         CustomerServiceManager.instance.uploadJpg();
      }
      
      protected function _submitBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_submitDelay())
         {
            if(_titleText)
            {
               _model.data.question_title = _titleText.text;
            }
            if(_timeBar)
            {
               _model.data.occur_time = _timeBar.date;
            }
            CustomerServiceManager.instance.sendHttpRequest();
         }
      }
      
      protected function _submitDelay() : Boolean
      {
         if(_submitEnble)
         {
            _submitEnble = false;
            if(_submitTimeId > 0)
            {
               clearTimeout(_submitTimeId);
            }
            _submitTimeId = 0;
            _submitTimeId = setTimeout(_clearSumbitTimeId,5000);
            return true;
         }
         MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.view.ActivityItem.command01"));
         return false;
      }
      
      private function _clearSumbitTimeId() : void
      {
         if(_submitTimeId > 0)
         {
            clearTimeout(_submitTimeId);
         }
         _submitTimeId = 0;
         _submitEnble = true;
      }
      
      protected function _closeBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         control.frame.dispose();
      }
      
      public function viewChange() : void
      {
         if(_titleText)
         {
            _model.data.question_title = _titleText.text;
         }
      }
      
      private function _cantactBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:ContactFrame = ComponentFactory.Instance.creatComponentByStylename("customerservice.contactFrame");
         _loc2_.show();
      }
      
      public function creatTimeBar(param1:int = 0, param2:int = 0) : TimeBar
      {
         var _loc3_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.customerservice.OccurTimeTxt");
         _loc3_.x = param1;
         _loc3_.y = param2;
         var _loc4_:TimeBar = new TimeBar();
         _loc4_.date = _model.today;
         _loc4_.x = param1 + _loc3_.width + 4;
         _loc4_.y = param2 - 2;
         addChild(_loc3_);
         addChild(_loc4_);
         return _loc4_;
      }
      
      public function creatInputText(param1:String = null, param2:int = 0, param3:int = 0, param4:Number = 30, param5:Number = 22, param6:Boolean = false, param7:int = 11) : TextField
      {
         var _loc10_:Bitmap = null;
         var _loc8_:Bitmap = ComponentFactory.Instance.creatBitmap(param1);
         _loc8_.x = param2;
         _loc8_.y = param3;
         var _loc9_:ScaleLeftRightImage = ComponentFactory.Instance.creatComponentByStylename("customerservice.InputBack_style_01");
         var _loc11_:FilterFrameText = ComponentFactory.Instance.creatComponentByStylename("customerservice.TimeComboBoxListCellTxt");
         _loc11_.maxChars = 20;
         _loc11_.type = "input";
         _loc11_.wordWrap = false;
         _loc9_.width = param4;
         _loc9_.height = param5;
         _loc11_.width = param4 - 11;
         _loc11_.height = _loc9_.height = param5;
         _loc11_.x = param2 + _loc8_.width + param7 - 10 + 10;
         _loc11_.y = param3 + 2;
         _loc9_.x = _loc11_.x - 6;
         _loc9_.y = param3 - 2;
         if(param6)
         {
            _loc10_ = ComponentFactory.Instance.creatBitmap("asset.customerservice.SignMust");
            _loc10_.x = _loc9_.x + _loc9_.width;
            _loc10_.y = param3 + 5;
            addChild(_loc10_);
         }
         addChild(_loc8_);
         addChild(_loc9_);
         addChild(_loc11_);
         return _loc11_;
      }
      
      public function creatInputTextArea(param1:Number = 435, param2:Number = 119, param3:int = 0, param4:int = 0, param5:String = "customerservice.inPutTextArea") : TextArea
      {
         var _loc6_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.customerservice.DescribeTxt");
         var _loc7_:ScaleBitmapImage = ComponentFactory.Instance.creatComponentByStylename("customerservice.textInputBack");
         var _loc8_:TextArea = ComponentFactory.Instance.creatComponentByStylename(param5);
         _loc7_.width = param1;
         _loc8_.width = param1 - 11;
         _loc7_.height = param2;
         _loc8_.height = param2 - 53;
         _loc8_.textField.height = param2 - 50;
         _loc7_.x = _loc6_.x = param3;
         _loc6_.y = param4;
         _loc7_.y = _loc6_.height + param4 + 5;
         _loc8_.x = _loc7_.x + 5;
         _loc8_.y = _loc7_.y + 5;
         addChild(_loc6_);
         addChild(_loc7_);
         addChild(_loc8_);
         _loc8_.invalidateViewport();
         return _loc8_;
      }
      
      public function creatBaseButton(param1:String) : BaseButton
      {
         var _loc2_:BaseButton = ComponentFactory.Instance.creatComponentByStylename(param1);
         addChild(_loc2_);
         return _loc2_;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_titleText);
         _titleText = null;
         ObjectUtils.disposeObject(_cantactBtn);
         _cantactBtn = null;
         ObjectUtils.disposeObject(_titleBitmap);
         _titleBitmap = null;
         ObjectUtils.disposeObject(_timeBar);
         _timeBar = null;
         ObjectUtils.disposeObject(_submitBtn);
         _submitBtn = null;
         ObjectUtils.disposeObject(_closeBtn);
         _closeBtn = null;
         ObjectUtils.disposeObject(_inputText);
         _inputText = null;
         ObjectUtils.disposeObject(_jpgUploadBtn);
         _jpgUploadBtn = null;
         ObjectUtils.disposeObject(_jpgUploadEnd);
         _jpgUploadEnd = null;
         ObjectUtils.disposeObject(_checkTextInput);
         _checkTextInput = null;
         _model = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

