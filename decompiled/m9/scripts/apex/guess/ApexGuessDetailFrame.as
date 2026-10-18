package apex.guess
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import yishi.datas.ComponentGroupType;
   
   public class ApexGuessDetailFrame extends Frame
   {
      
      private var _btnGuessDetail:IconButton;
      
      private var _bit0:Bitmap;
      
      private var _txtGuessDetailInput:FilterFrameText;
      
      private var _txtGuessDetailHint:FilterFrameText;
      
      private var _bit1:Bitmap;
      
      private var _bg:MutipleImage;
      
      public function ApexGuessDetailFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("apex.guess.detail.framebg");
         _btnGuessDetail = ComponentFactory.Instance.creatComponentByStylename("ui.apex.btnGuessDetail");
         _bit0 = ComponentFactory.Instance.creatBitmap("asset.apex.guess.str3");
         _txtGuessDetailInput = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtGuessDetailInput");
         _txtGuessDetailHint = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtGuessDetailHint");
         _bit1 = ComponentFactory.Instance.creatBitmap("asset.apex.guess.bg2");
         addChild(_bg);
         addChild(_bit1);
         addChild(_btnGuessDetail);
         addChild(_bit0);
         addChild(_txtGuessDetailInput);
         addChild(_txtGuessDetailHint);
         titleText = LanguageMgr.GetTranslation("apex.guess.detail.title");
         _txtGuessDetailHint.text = LanguageMgr.GetTranslation("apex.guess.detail.str1");
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
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_btnGuessDetail);
         _btnGuessDetail = null;
         ObjectUtils.disposeObject(_bit0);
         _bit0 = null;
         ObjectUtils.disposeObject(_txtGuessDetailInput);
         _txtGuessDetailInput = null;
         ObjectUtils.disposeObject(_txtGuessDetailHint);
         _txtGuessDetailHint = null;
         ObjectUtils.disposeObject(_bit1);
         _bit1 = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

