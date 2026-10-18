package consortia.view.club
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.TextArea;
   import com.pickgliss.utils.SoundManager;
   import consortia.net.ConsortiaSocektSendManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.consortia.ConsortiaInfo;
   import yishi.datas.ComponentGroupType;
   import yishi.keyboard.KeyBoardRegister;
   
   public class ConsortiaInfoFrame extends Frame
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _txtBg:MutipleImage;
      
      private var _nameTxtImg:MutipleImage;
      
      private var _bg1:Bitmap;
      
      private var _discriptionTxtImg:Bitmap;
      
      private var _lineImg:Bitmap;
      
      private var _wordBg:Bitmap;
      
      private var _nameTxt:FilterFrameText;
      
      private var _chairmanTxt:FilterFrameText;
      
      private var _levelTxt:FilterFrameText;
      
      private var _wealthTxt:FilterFrameText;
      
      private var _numTxt:FilterFrameText;
      
      private var _honorTxt:FilterFrameText;
      
      private var _discriptionTxt:TextArea;
      
      private var _applyBtn:IconButton;
      
      private var _data:ConsortiaInfo;
      
      public function ConsortiaInfoFrame()
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
         titleText = LanguageMgr.GetTranslation("consortia.view.club.ConsortiaInfoFrame.title");
         _bg = ComponentFactory.Instance.creatComponentByStylename("lookconsortiainfo.ConsortiaInfoFrameDescribeBackground");
         _txtBg = ComponentFactory.Instance.creatComponentByStylename("lookconsortiainfo.ConsortiaInfoFrameTxtBg");
         _nameTxtImg = ComponentFactory.Instance.creatComponentByStylename("lookconsortiainfo.ConsortiaInfoFrameTxtImg");
         _bg1 = ComponentFactory.Instance.creatBitmap("asset.lookconsortiainfo.consortia.infoFrameBg");
         _wordBg = ComponentFactory.Instance.creatBitmap("asset.lookconsortiainfo.consortia.infoFrameWordBg");
         _discriptionTxtImg = ComponentFactory.Instance.creatBitmap("asset.lookconsortiainfo.consortia.infoFrameDiscriptionBg");
         _lineImg = ComponentFactory.Instance.creatBitmap("asset.lookconsortiainfo.consortia.infoFrameLineImg");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("lookconsortiainfo.ConsortiaInfoFrameNameTextStyle");
         _chairmanTxt = ComponentFactory.Instance.creatComponentByStylename("lookconsortiainfo.ConsortiaInfoFrameChairmanTextStyle");
         _levelTxt = ComponentFactory.Instance.creatComponentByStylename("lookconsortiainfo.ConsortiaInfoFrameLevelTextStyle");
         _wealthTxt = ComponentFactory.Instance.creatComponentByStylename("lookconsortiainfo.ConsortiaInfoFrameWealthTextStyle");
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("lookconsortiainfo.ConsortiaInfoFrameNumTextStyle");
         _honorTxt = ComponentFactory.Instance.creatComponentByStylename("lookconsortiainfo.ConsortiaInfoFrameHonorTextStyle");
         _discriptionTxt = ComponentFactory.Instance.creatComponentByStylename("lookconsortiainfo.InfoFrameTextArea");
         _applyBtn = ComponentFactory.Instance.creatComponentByStylename("lookconsortiainfo.InfoFrameApplyBtn");
         addToContent(_bg);
         addToContent(_txtBg);
         addToContent(_nameTxtImg);
         addToContent(_bg1);
         addToContent(_wordBg);
         addToContent(_discriptionTxtImg);
         addToContent(_lineImg);
         addToContent(_nameTxt);
         addToContent(_chairmanTxt);
         addToContent(_levelTxt);
         addToContent(_wealthTxt);
         addToContent(_numTxt);
         addToContent(_honorTxt);
         addToContent(_discriptionTxt);
         addToContent(_applyBtn);
      }
      
      private function uninit() : void
      {
         _applyBtn = null;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _applyBtn.addEventListener("click",__onApplyHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_applyBtn)
         {
            _applyBtn.removeEventListener("click",__onApplyHandler);
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
               break;
            case 1:
               dispose();
         }
      }
      
      private function __onApplyHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         ConsortiaSocektSendManager.applyJoinConsortia(_data.consortiaId);
         dispose();
      }
      
      public function set data(param1:ConsortiaInfo) : void
      {
         _data = param1;
         _nameTxt.text = _data.consortiaName;
         _chairmanTxt.text = _data.chairmanName;
         _levelTxt.text = _data.levels.toString();
         _wealthTxt.text = _data.offer.toString();
         _numTxt.text = _data.currentCount.toString();
         _honorTxt.text = _data.honor.toString();
         _discriptionTxt.text = _data.description;
         if(!_discriptionTxt.vScrollbar.visible)
         {
            _discriptionTxt.x = 3;
         }
      }
      
      public function get data() : ConsortiaInfo
      {
         return _data;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         uninit();
         super.dispose();
      }
   }
}

