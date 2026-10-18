package monsterexplore
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.MonsterExploreManager;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class MonsterSweepFrame extends Frame
   {
      
      protected var _item:BaseItemView;
      
      private var _confirmBtn:BaseButton;
      
      private var _cancelBtn:BaseButton;
      
      private var _alertText:FilterFrameText;
      
      protected var _numberText:FilterFrameText;
      
      private var _inputBack:Bitmap;
      
      private var _confirmStyle:String;
      
      private var _describeTxt:FilterFrameText;
      
      private var _data:Object;
      
      public function MonsterSweepFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("mosterSweepFrame.title");
         _inputBack = ComponentFactory.Instance.creatBitmap("asset.core.SpliteInputBack");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("worldboss.RiverNotAlert_confirmStyle_2");
         _describeTxt = ComponentFactory.Instance.creatComponentByStylename("MonsterSweepFrame.Desc");
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("worldboss.RiverNotAlert_cancelStyle_2");
         _alertText = ComponentFactory.Instance.creatComponentByStylename("MonsterSweepFrame.numDesc");
         _numberText = ComponentFactory.Instance.creatComponentByStylename("core.InputTextStyle");
         _numberText.selectable = true;
         _alertText.htmlText = LanguageMgr.GetTranslation("mosterSweepFrame.numdesc");
         addToContent(_inputBack);
         if(_confirmBtn)
         {
            addToContent(_confirmBtn);
         }
         if(_cancelBtn)
         {
            addToContent(_cancelBtn);
         }
         if(_describeTxt)
         {
            addToContent(_describeTxt);
         }
         addToContent(_alertText);
         addToContent(_numberText);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         if(_confirmBtn)
         {
            _confirmBtn.addEventListener("click",__confirmHandler);
         }
         if(_cancelBtn)
         {
            _cancelBtn.addEventListener("click",__cancelHandler);
         }
         _numberText.addEventListener("keyDown",__keydownHandler);
         _numberText.addEventListener("change",__textChangHandler);
         _numberText.addEventListener("focusIn",__inHandler);
      }
      
      protected function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_confirmBtn)
         {
            _confirmBtn.removeEventListener("click",__confirmHandler);
         }
         if(_cancelBtn)
         {
            _cancelBtn.removeEventListener("click",__cancelHandler);
         }
         _numberText.removeEventListener("keyDown",__keydownHandler);
         _numberText.removeEventListener("change",__textChangHandler);
         _numberText.removeEventListener("focusIn",__inHandler);
      }
      
      private function __inHandler(param1:FocusEvent) : void
      {
         _numberText.setSelection(0,_numberText.text.length);
      }
      
      private function __textChangHandler(param1:Event) : void
      {
         var _loc2_:int = int(_numberText.text);
         if(_loc2_ == 0)
         {
            _numberText.text = "";
         }
         else
         {
            _numberText.text = Math.min(_loc2_,_data.num).toString();
         }
      }
      
      private function __keydownHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            __cancelHandler(null);
         }
         param1.stopPropagation();
      }
      
      protected function __confirmHandler(param1:MouseEvent) : void
      {
         dispose();
      }
      
      public function set data(param1:*) : void
      {
         _data = {};
         _data.ChapterId = param1.ChapterId;
         _data.NodeId = param1.NodeId;
         _data.num = param1.num;
         _numberText.text = "1";
         _describeTxt.htmlText = LanguageMgr.GetTranslation("MonsterExploreNodeDetailView.content.txt",param1.num);
      }
      
      private function layoutContent() : void
      {
         var _loc1_:int = int(_describeTxt.y);
         _describeTxt.height = _describeTxt.textHeight + 10;
         _describeTxt.y = -25;
         _loc1_ += _describeTxt.height;
         if(_inputBack)
         {
            _inputBack.y = _loc1_ + 8;
         }
         _inputBack.scaleX = 0.5;
         _inputBack.x = 127;
         if(_numberText)
         {
            _numberText.y = _loc1_ + 12;
         }
         _numberText.x = 161;
         _confirmBtn.y = _loc1_ + 61;
         _cancelBtn.y = _loc1_ + 61;
         _height = _describeTxt.height + 170;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2);
         KeyBoardRegister.instance.keyEnable = false;
         _numberText.setFocus();
         layoutContent();
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
               break;
            case 2:
               __cancelHandler(null);
         }
      }
      
      private function __cancelHandler(param1:MouseEvent) : void
      {
         if(!_numberText)
         {
            return;
         }
         var _loc2_:int = int(_numberText.text);
         if(_loc2_ <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("mosterSweepFrame.numtip"));
            return;
         }
         MonsterExploreManager.instance.sendMopupBoss(_data.ChapterId,_data.NodeId,_loc2_);
         dispose();
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         10;
         9;
         8;
         7;
         6;
         5;
         4;
         3;
         2;
         1;
         ObjectUtils.disposeObject(_describeTxt);
         _describeTxt = null;
         ObjectUtils.disposeObject(_cancelBtn);
         _cancelBtn = null;
         ObjectUtils.disposeObject(_confirmBtn);
         _confirmBtn = null;
         ObjectUtils.disposeObject(_alertText);
         _alertText = null;
         ObjectUtils.disposeObject(_numberText);
         _numberText = null;
         ObjectUtils.disposeObject(_inputBack);
         _inputBack = null;
         _item = null;
         super.dispose();
      }
   }
}

