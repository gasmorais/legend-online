package funny.groupbuy
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.keyboard.KeyBoardRegister;
   
   public class ZuanshiView extends Component
   {
      
      private var _frame:Frame;
      
      private var _confirmBtn:SelectedCheckButton;
      
      private var _buyNum:int;
      
      private var _txt1:FilterFrameText;
      
      private var _recall:Function;
      
      public function ZuanshiView(param1:int, param2:Function)
      {
         _recall = param2;
         _buyNum = param1;
         super();
         initUI();
         addEvents();
      }
      
      private function initUI() : void
      {
         _frame = ComponentFactory.Instance.creatComponentByStylename("groupbuy.Alert2");
         addChild(_frame);
         _frame.titleText = LanguageMgr.GetTranslation("public.prompt");
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("core.AlertConfirmBtn_2");
         _frame.addToContent(_confirmBtn);
         _confirmBtn.x = 111;
         _confirmBtn.y = 63;
         _txt1 = ComponentFactory.Instance.creatComponentByStylename("groupbuy.txt1");
         _frame.addToContent(_txt1);
         _txt1.height = 50;
         _txt1.x = -22;
         _txt1.y = -3;
         _txt1.htmlText = LanguageMgr.GetTranslation("funny.groupbuy.zuanshiconfirm",_buyNum);
      }
      
      private function addEvents() : void
      {
         _frame.addEventListener("response",__frameResponseHandler);
         _confirmBtn.addEventListener("click",__confirmClick);
      }
      
      private function removeEvents() : void
      {
         _frame.removeEventListener("response",__frameResponseHandler);
         _confirmBtn.removeEventListener("click",__confirmClick);
      }
      
      private function __frameResponseHandler(param1:FrameEvent) : void
      {
         switch(param1.responseCode - 2)
         {
            case 0:
               if(_recall != null)
               {
                  _recall.call(null);
                  _recall = null;
               }
               dispose();
               break;
            default:
               dispose();
         }
      }
      
      private function __confirmClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_recall != null)
         {
            _recall.call(null);
            _recall = null;
         }
         dispose();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2,0,false,1);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvents();
         ObjectUtils.disposeObject(_frame);
         _frame = null;
         ObjectUtils.disposeObject(_confirmBtn);
         _confirmBtn = null;
         ObjectUtils.disposeObject(_txt1);
         _txt1 = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

