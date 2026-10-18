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
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.utils.NumberViewUtils;
   
   public class CheckView extends Component
   {
      
      private var _frame:Frame;
      
      private var _confirmBtn:SelectedCheckButton;
      
      private var _buyNum:int;
      
      private var _payNum:int;
      
      private var _getZuanshi:int;
      
      private var _img1:DisplayObject;
      
      private var _img2:DisplayObject;
      
      private var _numC:Sprite;
      
      private var _zuanshi:Bitmap;
      
      private var _zuanshiSmall:Bitmap;
      
      private var _getTxt:FilterFrameText;
      
      private var _txt1:FilterFrameText;
      
      private var _txt2:FilterFrameText;
      
      private var _txt3:FilterFrameText;
      
      public function CheckView(param1:int, param2:int, param3:int)
      {
         _buyNum = param1;
         _payNum = param2;
         _getZuanshi = param3;
         super();
         initUI();
         addEvents();
      }
      
      private function initUI() : void
      {
         _frame = ComponentFactory.Instance.creatComponentByStylename("groupbuy.Alert");
         addChild(_frame);
         _frame.titleText = LanguageMgr.GetTranslation("public.prompt");
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("core.AlertConfirmBtn_2");
         _frame.addToContent(_confirmBtn);
         _confirmBtn.x = 135;
         _confirmBtn.y = 86;
         _img1 = ComponentFactory.Instance.creat("asset.groupbuy.fanhuan");
         _frame.addToContent(_img1);
         _numC = ComponentFactory.Instance.creatCustomObject("groupbuy.fanhuizuanshiC");
         _frame.addToContent(_numC);
         _zuanshi = ComponentFactory.Instance.creat("asset.groupbuy.zuanshibig");
         _frame.addToContent(_zuanshi);
         fanhuiSet(_getZuanshi);
         if(_payNum == _getZuanshi)
         {
            _img2 = ComponentFactory.Instance.creat("asset.groupbuy.miandian");
            _frame.addToContent(_img2);
            _img2.x = 97;
            _img2.y = 0;
            _getTxt = ComponentFactory.Instance.creatComponentByStylename("groupbuy.huodetxt");
            _frame.addToContent(_getTxt);
            _getTxt.text = LanguageMgr.GetTranslation("funny.groupbuy.huode");
            _img1.x = 31;
            _img1.y = 45;
            _numC.x = 116;
            _numC.y = 46;
            _zuanshi.x = _numC.x + _numC.width;
            _zuanshi.y = 42;
         }
         else
         {
            _txt1 = ComponentFactory.Instance.creatComponentByStylename("groupbuy.txt1");
            _frame.addToContent(_txt1);
            _txt1.text = LanguageMgr.GetTranslation("funny.groupbuy.txt1");
            _txt2 = ComponentFactory.Instance.creatComponentByStylename("groupbuy.txt2");
            _frame.addToContent(_txt2);
            _txt2.htmlText = LanguageMgr.GetTranslation("funny.groupbuy.txt2",_buyNum);
            _txt3 = ComponentFactory.Instance.creatComponentByStylename("groupbuy.txt3");
            _frame.addToContent(_txt3);
            _txt3.htmlText = LanguageMgr.GetTranslation("funny.groupbuy.txt3",_payNum);
            _zuanshiSmall = ComponentFactory.Instance.creatBitmap("asset.core.SmallPointImg");
            _frame.addToContent(_zuanshiSmall);
            _zuanshiSmall.x = _txt3.x + _txt3.textWidth;
            _zuanshiSmall.y = 27;
            _img1.x = 93;
            _img1.y = 53;
            _numC.x = 180;
            _numC.y = 53;
            _zuanshi.x = _numC.x + _numC.width;
            _zuanshi.y = 47;
         }
      }
      
      private function fanhuiSet(param1:int) : void
      {
         var _loc2_:Bitmap = null;
         ObjectUtils.removeChildAllChildren(_numC);
         _loc2_ = ComponentFactory.Instance.creatBitmap("asset.groupbuy.num1");
         NumberViewUtils.getNumberView(param1,_numC,_loc2_.bitmapData,22,28,22,22,"0123456789.",1);
         ObjectUtils.disposeObject(_loc2_);
         _loc2_ = null;
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
               dispose();
               break;
            default:
               dispose();
         }
      }
      
      private function __confirmClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
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
         ObjectUtils.disposeObject(_img1);
         _img1 = null;
         ObjectUtils.disposeObject(_img2);
         _img2 = null;
         ObjectUtils.disposeObject(_numC);
         _numC = null;
         ObjectUtils.disposeObject(_zuanshi);
         _zuanshi = null;
         ObjectUtils.disposeObject(_zuanshiSmall);
         _zuanshiSmall = null;
         ObjectUtils.disposeObject(_getTxt);
         _getTxt = null;
         ObjectUtils.disposeObject(_txt1);
         _txt1 = null;
         ObjectUtils.disposeObject(_txt2);
         _txt2 = null;
         ObjectUtils.disposeObject(_txt3);
         _txt3 = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

