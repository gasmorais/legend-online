package yishi.view.guild
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.manager.SharedManager;
   
   public class QteUpgradeTipFrame extends Frame
   {
      
      private var _checkBtm:SelectedButton;
      
      private var _describeTitleTxt:FilterFrameText;
      
      private var _describeTxt:FilterFrameText;
      
      private var _text:FilterFrameText;
      
      private var _info:AlertInfo;
      
      private var _describeTitle:String;
      
      private var _textSp:Sprite;
      
      public function QteUpgradeTipFrame()
      {
         super();
         initView();
         initEvent();
         titleText = LanguageMgr.GetTranslation("public.prompt");
      }
      
      private function initView() : void
      {
         _checkBtm = ComponentFactory.Instance.creatComponentByStylename("novice.QteCheckBtn");
         _describeTitleTxt = ComponentFactory.Instance.creatComponentByStylename("novice.QteDescribeTitleTxt");
         _describeTxt = ComponentFactory.Instance.creatComponentByStylename("novice.QteDescribeTxt");
         _text = ComponentFactory.Instance.creatComponentByStylename("novice.QteCheckTxt");
         _text.text = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
         _textSp = new Sprite();
         _textSp.addChild(_text);
         _textSp.buttonMode = true;
         addToContent(_describeTitleTxt);
         addToContent(_describeTxt);
         addToContent(_textSp);
         addToContent(_checkBtm);
      }
      
      public function set info(param1:AlertInfo) : void
      {
         _info = param1;
      }
      
      public function describeTitle(param1:String) : void
      {
         _describeTitle = param1;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _textSp.addEventListener("click",__onClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _textSp.removeEventListener("click",__onClickHandler);
      }
      
      private function __onClickHandler(param1:MouseEvent) : void
      {
         _checkBtm.selected = !_checkBtm.selected;
      }
      
      private function __confirmkHandler(param1:MouseEvent) : void
      {
         SharedManager.instance.qteUpgrade = _checkBtm.selected;
         SharedManager.instance.qteUpgradeCheckDate = new Date();
         SharedManager.instance.saveQteUpgradeCheck();
         dispose();
      }
      
      public function show(param1:int = 1) : void
      {
         _describeTxt.text = _info.data as String;
         _checkBtm.y = _describeTxt.y + _describeTxt.textHeight + 12;
         _describeTitleTxt.text = _describeTitle;
         _text.y = _describeTxt.y + _describeTxt.textHeight + 14;
         height = _text.y + 70;
         LayerManager.Instance.addToLayer(this,3);
      }
      
      protected function __frameResponse(param1:FrameEvent) : void
      {
         switch(param1.responseCode)
         {
            case 0:
            case 1:
               __confirmkHandler(null);
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

