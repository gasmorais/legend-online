package yishi.view.base
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import utils.LogicUtils;
   
   public class PageSwitchTab extends Component
   {
      
      private var _leftBtn:BaseButton;
      
      private var _rightBtn:BaseButton;
      
      private var _txt:FilterFrameText;
      
      private var _txtBg:Bitmap;
      
      private var _leftBtnLink:String;
      
      private var _rightBtnLink:String;
      
      private var _txtLink:String;
      
      private var _txtBgLink:String;
      
      private var _btnTxtSpace:int = 6;
      
      private var _textValue:String = "";
      
      private var _leftBtnEnabled:Boolean = true;
      
      private var _rightBtnEnabled:Boolean = true;
      
      public var leftBtnClickHandler:Function;
      
      public var rightBtnClickHandler:Function;
      
      public function PageSwitchTab()
      {
         super();
      }
      
      public function set xy(param1:String) : void
      {
         var _loc2_:Array = param1.split(",");
         this.x = _loc2_[0];
         this.y = _loc2_[1];
      }
      
      public function set rightBtnEnabled(param1:Boolean) : void
      {
         if(_rightBtnEnabled != param1)
         {
            _rightBtnEnabled = param1;
            if(_rightBtn)
            {
               _rightBtn.enable = _rightBtnEnabled;
            }
         }
      }
      
      public function set leftBtnEnabled(param1:Boolean) : void
      {
         if(_leftBtnEnabled != param1)
         {
            _leftBtnEnabled = param1;
            if(_leftBtn)
            {
               _leftBtn.enable = _leftBtnEnabled;
            }
         }
      }
      
      public function set btnTxtSpace(param1:int) : void
      {
         if(_btnTxtSpace != param1)
         {
            _btnTxtSpace = param1;
            updateView();
         }
      }
      
      public function set text(param1:String) : void
      {
         if(_textValue != param1)
         {
            _textValue = param1;
            if(_txt)
            {
               _txt.text = _textValue;
            }
         }
      }
      
      public function set txtBgLink(param1:String) : void
      {
         if(_txtBgLink != param1)
         {
            _txtBgLink = param1;
            ObjectUtils.disposeObject(_txtBg);
            _txtBg = null;
            updateView();
         }
      }
      
      public function set txtLink(param1:String) : void
      {
         if(_txtLink != param1)
         {
            _txtLink = param1;
            ObjectUtils.disposeObject(_txt);
            _txt = null;
            updateView();
         }
      }
      
      public function set leftBtnLink(param1:String) : void
      {
         if(_leftBtnLink != param1)
         {
            _leftBtnLink = param1;
            disposeBtn(_leftBtn);
            _leftBtn = null;
            updateView();
         }
      }
      
      public function set rightBtnLink(param1:String) : void
      {
         if(_rightBtnLink != param1)
         {
            _rightBtnLink = param1;
            disposeBtn(_rightBtn);
            updateView();
         }
      }
      
      private function disposeBtn(param1:BaseButton) : void
      {
         if(param1)
         {
            param1.removeEventListener("click",__btnClickHandler);
            ObjectUtils.disposeObject(param1);
         }
      }
      
      private function updateView() : void
      {
         if(_leftBtnLink && _rightBtnLink && _txtLink)
         {
            LogicUtils.addToRender(this,render);
         }
      }
      
      private function render() : void
      {
         if(!_leftBtn)
         {
            _leftBtn = ComponentFactory.Instance.creatComponentByStylename(_leftBtnLink);
            _leftBtn.y = 0;
            _leftBtn.addEventListener("click",__btnClickHandler);
         }
         if(!_rightBtn)
         {
            _rightBtn = ComponentFactory.Instance.creatComponentByStylename(_rightBtnLink);
            _rightBtn.y = 0;
            _rightBtn.addEventListener("click",__btnClickHandler);
         }
         if(!_txt)
         {
            _txt = ComponentFactory.Instance.creatComponentByStylename(_txtLink);
         }
         if(!_txtBg && _txtBgLink)
         {
            _txtBg = new Bitmap(new (ClassUtils.getDefinition(_txtBgLink))());
         }
         this.addChild(_leftBtn);
         var _loc1_:int = _leftBtn.x + _leftBtn.width + _btnTxtSpace;
         if(_txtBg)
         {
            _txtBg.x = _loc1_;
            _txtBg.y = _leftBtn.height - _txtBg.height >> 1;
            _txt.width = _txtBg.width;
            this.addChild(_txtBg);
         }
         _txt.x = _loc1_;
         _txt.y = _leftBtn.height - _txt.height >> 1;
         _txt.text = _textValue;
         this.addChild(_txt);
         _rightBtn.x = _txt.x + _txt.width + _btnTxtSpace;
         this.addChild(_rightBtn);
      }
      
      private function __btnClickHandler(param1:MouseEvent) : void
      {
         if(param1.target == _leftBtn)
         {
            if(leftBtnClickHandler != null)
            {
               leftBtnClickHandler();
            }
         }
         else if(param1.target == _rightBtn)
         {
            if(rightBtnClickHandler != null)
            {
               rightBtnClickHandler();
            }
         }
      }
      
      override public function dispose() : void
      {
         disposeBtn(_leftBtn);
         _leftBtn = null;
         disposeBtn(_rightBtn);
         _rightBtn = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         ObjectUtils.disposeObject(_txtBg);
         _txtBg = null;
         leftBtnClickHandler = null;
         rightBtnClickHandler = null;
         super.dispose();
      }
   }
}

