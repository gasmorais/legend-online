package customerService.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import yishi.keyboard.KeyBoardRegister;
   
   public class ContactFrame extends Frame implements Disposeable
   {
      
      private var _phoneNumberText:FilterFrameText;
      
      private var _describeBack:ScaleBitmapImage;
      
      private var _phoneNumberBack:Image;
      
      private var _phoneNumberTitle:Bitmap;
      
      public function ContactFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("customerservice.view.ContactFrame.title");
         _describeBack = ComponentFactory.Instance.creatComponentByStylename("customerservice.contactFrameBack");
         _phoneNumberBack = ComponentFactory.Instance.creatComponentByStylename("customerservice.contactFramegroup_1");
         _phoneNumberTitle = ComponentFactory.Instance.creatBitmap("asset.customerservice.PhoneNumberTxt");
         _phoneNumberText = ComponentFactory.Instance.creatComponentByStylename("customerservice.phoneNumberText");
         addChildren();
         addToContent(_describeBack);
         addToContent(_phoneNumberBack);
         addToContent(_phoneNumberTitle);
         addToContent(_phoneNumberText);
         _phoneNumberText.text = "0755-61886777";
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,false,2);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         super.dispose();
         ObjectUtils.disposeObject(_phoneNumberBack);
         _phoneNumberBack = null;
         ObjectUtils.disposeObject(_phoneNumberTitle);
         _phoneNumberTitle = null;
         ObjectUtils.disposeObject(_phoneNumberText);
         _phoneNumberText = null;
         ObjectUtils.disposeObject(_describeBack);
         _describeBack = null;
      }
   }
}

