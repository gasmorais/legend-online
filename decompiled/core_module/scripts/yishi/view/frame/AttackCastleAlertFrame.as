package yishi.view.frame
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.SharedManager;
   
   public class AttackCastleAlertFrame extends Frame
   {
      
      private var _confirmBtn:SelectedCheckButton;
      
      private var _cancelBtn:SelectedCheckButton;
      
      private var _checkBtm:SelectedButton;
      
      private var _describeTxt:FilterFrameText;
      
      private var _text:FilterFrameText;
      
      private var _back:Function;
      
      private var _disclist:Vector.<String>;
      
      private var _textSp:Sprite;
      
      public function AttackCastleAlertFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("core.ThewConfirmBtn");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("core.ThewCancelBtn");
         _checkBtm = ComponentFactory.Instance.creatComponentByStylename("core.ThewCheckBtn");
         _describeTxt = ComponentFactory.Instance.creatComponentByStylename("core.ThewDescribeTxt");
         _text = ComponentFactory.Instance.creatComponentByStylename("core.ThewCheckTxt");
         _text.text = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
         _confirmBtn.text = LanguageMgr.GetTranslation("public.confirm");
         _cancelBtn.text = LanguageMgr.GetTranslation("public.cancel");
         _textSp = new Sprite();
         _textSp.addChild(_text);
         _textSp.buttonMode = true;
         addToContent(_describeTxt);
         addToContent(_textSp);
         addToContent(_checkBtm);
         addToContent(_confirmBtn);
         addToContent(_cancelBtn);
         _disclist = new Vector.<String>();
         _disclist[0] = LanguageMgr.GetTranslation("yishi.view.base.AttackAlertFrame.content");
         titleText = LanguageMgr.GetTranslation("public.prompt");
         _checkBtm.selected = SharedManager.instance.attackCastleCheck;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _confirmBtn.addEventListener("click",__confirmkHandler);
         _cancelBtn.addEventListener("click",__cancelHandler);
         _textSp.addEventListener("click",__onClickHandler);
         _checkBtm.addEventListener("click",__checkHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _confirmBtn.removeEventListener("click",__confirmkHandler);
         _cancelBtn.removeEventListener("click",__cancelHandler);
         _textSp.removeEventListener("click",__onClickHandler);
         _checkBtm.removeEventListener("click",__checkHandler);
      }
      
      private function __onClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _checkBtm.selected = !_checkBtm.selected;
      }
      
      private function __checkHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         SharedManager.instance.attackCastleCheck = _checkBtm.selected;
         SharedManager.instance.attackCastleCheckDate = new Date();
         SharedManager.instance.saveAttackCastleCheck();
      }
      
      private function __confirmkHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         __checkHandler(null);
         if(_back != null)
         {
            _back();
         }
         dispose();
      }
      
      private function __cancelHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispose();
      }
      
      public function show(param1:int, param2:Function = null) : void
      {
         _back = param2;
         _describeTxt.text = _disclist[param1];
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      protected function __frameResponse(param1:FrameEvent) : void
      {
         switch(param1.responseCode)
         {
            case 0:
            case 1:
               dispose();
               break;
            case 2:
               __confirmkHandler(null);
         }
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         _back = null;
         ObjectUtils.disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

