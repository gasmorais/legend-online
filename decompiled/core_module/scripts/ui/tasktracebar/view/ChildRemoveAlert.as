package ui.tasktracebar.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import yishi.datas.ComponentGroupType;
   import yishi.view.tips.MessageTipManager;
   
   public class ChildRemoveAlert extends Frame implements IManualSize
   {
      
      private var _content:FilterFrameText;
      
      private var _arrowImg1:Bitmap;
      
      private var _text01:FilterFrameText;
      
      private var _arrowImg2:Bitmap;
      
      private var _text02:FilterFrameText;
      
      private var _text03:FilterFrameText;
      
      private var _inputBg:ScaleBitmapImage;
      
      private var _text04:FilterFrameText;
      
      private var _sureBtn:IconButton;
      
      private var _cancleBtn:IconButton;
      
      public var backFun:Function;
      
      public var cancleFun:Function;
      
      public var param:String;
      
      private var _showStr:String;
      
      public function ChildRemoveAlert()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _content = ComponentFactory.Instance.creatComponentByStylename("ChildRemoveAlert.content");
         _arrowImg1 = ComponentFactory.Instance.creatBitmap("asset.taskTrace.ItemTitleIcon1");
         _text01 = ComponentFactory.Instance.creatComponentByStylename("ChildRemoveAlert.text1");
         _arrowImg2 = ComponentFactory.Instance.creatBitmap("asset.taskTrace.ItemTitleIcon1");
         _text02 = ComponentFactory.Instance.creatComponentByStylename("ChildRemoveAlert.text2");
         _text03 = ComponentFactory.Instance.creatComponentByStylename("ChildRemoveAlert.text3");
         _text04 = ComponentFactory.Instance.creatComponentByStylename("ChildRemoveAlert.text4");
         _inputBg = ComponentFactory.Instance.creatComponentByStylename("ChildRemoveAlert.ConfirmSellInputBack");
         _sureBtn = ComponentFactory.Instance.creatComponentByStylename("ChildRemoveAlert.sureButton");
         _cancleBtn = ComponentFactory.Instance.creatComponentByStylename("ChildRemoveAlert.cancelButton");
         addToContent(_content);
         _content.htmlText = LanguageMgr.GetTranslation("ui.tasktracebar.view.ChildRemoveAlert.content","XXX");
         addToContent(_arrowImg1);
         _arrowImg1.x = -13;
         _arrowImg1.y = 46;
         addToContent(_arrowImg2);
         _arrowImg2.x = -13;
         _arrowImg2.y = 69;
         addToContent(_text01);
         _text01.text = LanguageMgr.GetTranslation("ui.tasktracebar.view.ChildRemoveAlert.text01");
         addToContent(_text02);
         _text02.text = LanguageMgr.GetTranslation("ui.tasktracebar.view.ChildRemoveAlert.text02");
         addToContent(_text03);
         _text03.htmlText = LanguageMgr.GetTranslation("ui.tasktracebar.view.ChildRemoveAlert.text03");
         addToContent(_inputBg);
         _inputBg.x = 65;
         _inputBg.y = 129;
         addToContent(_text04);
         addToContent(_sureBtn);
         addToContent(_cancleBtn);
         this.titleText = LanguageMgr.GetTranslation("ui.tasktracebar.view.ChildRemoveAlert.title");
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _sureBtn.addEventListener("click",__sureBtnHandler);
         _cancleBtn.addEventListener("click",__cancleBtnHandler);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,300,280);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _sureBtn.removeEventListener("click",__sureBtnHandler);
         _cancleBtn.removeEventListener("click",__cancleBtnHandler);
      }
      
      public function set showStr(param1:String) : void
      {
         _showStr = param1;
         _content.htmlText = LanguageMgr.GetTranslation("ui.tasktracebar.view.ChildRemoveAlert.content",_showStr);
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(param1.responseCode)
         {
            case 0:
            case 1:
               __cancleBtnHandler(null);
               break;
            case 2:
               __sureBtnHandler(null);
         }
      }
      
      private function __sureBtnHandler(param1:MouseEvent) : void
      {
         if(_text04.text.toLocaleLowerCase() != "yes")
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("ui.tasktracebar.view.ChildRemoveAlert.text04"));
            return;
         }
         if(backFun != null)
         {
            if(param)
            {
               backFun(param);
            }
            else
            {
               backFun();
            }
         }
         dispose();
      }
      
      private function __cancleBtnHandler(param1:MouseEvent) : void
      {
         if(cancleFun != null)
         {
            cancleFun();
         }
         dispose();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         if(cancleFun != null)
         {
            cancleFun();
         }
         ObjectUtils.disposeObject(_content);
         _content = null;
         ObjectUtils.disposeObject(_arrowImg1);
         _arrowImg1 = null;
         ObjectUtils.disposeObject(_text01);
         _text01 = null;
         ObjectUtils.disposeObject(_arrowImg2);
         _arrowImg2 = null;
         ObjectUtils.disposeObject(_text02);
         _text02 = null;
         ObjectUtils.disposeObject(_text03);
         _text03 = null;
         ObjectUtils.disposeObject(_inputBg);
         _inputBg = null;
         ObjectUtils.disposeObject(_text04);
         _text04 = null;
         ObjectUtils.disposeObject(_sureBtn);
         _sureBtn = null;
         ObjectUtils.disposeObject(_cancleBtn);
         _cancleBtn = null;
         backFun = null;
         cancleFun = null;
      }
   }
}

