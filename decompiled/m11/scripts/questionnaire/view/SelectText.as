package questionnaire.view
{
   import com.pickgliss.geom.InnerRectangle;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.geom.Rectangle;
   
   public class SelectText extends Component
   {
      
      public static const P_text:String = "text";
      
      public static const P_selectBtnStyle:String = "selectBtnStyle";
      
      public static const P_textStyle:String = "textStyle";
      
      public static const P_innerRectString:String = "btnRectString";
      
      private var _selectBtnStyle:String;
      
      private var _text:String;
      
      private var _textStyle:String;
      
      private var _btnRectString:String;
      
      private var _textField:FilterFrameText;
      
      private var _selectBtn:SelectedButton;
      
      public function SelectText()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
      }
      
      override protected function addChildren() : void
      {
         if(_textField)
         {
            addChild(_textField);
         }
         if(_selectBtn)
         {
            addChild(_selectBtn);
         }
      }
      
      public function set selectBtnType(param1:Boolean) : void
      {
         if(_selectBtn.selected == param1)
         {
            return;
         }
         _selectBtn.selected = param1;
      }
      
      public function get selectBtnType() : Boolean
      {
         return _selectBtn.selected;
      }
      
      public function set selectBtnStyle(param1:String) : void
      {
         if(_selectBtnStyle == param1)
         {
            return;
         }
         _selectBtnStyle = param1;
         onPropertiesChanged("selectBtnStyle");
      }
      
      public function get text() : String
      {
         return _text;
      }
      
      public function set text(param1:String) : void
      {
         if(_text == param1)
         {
            return;
         }
         _text = param1;
         onPropertiesChanged("text");
      }
      
      public function set textStyle(param1:String) : void
      {
         if(_textStyle == param1)
         {
            return;
         }
         _textStyle = param1;
         onPropertiesChanged("textStyle");
      }
      
      override protected function onProppertiesUpdate() : void
      {
         var _loc1_:InnerRectangle = null;
         var _loc2_:Rectangle = null;
         super.onProppertiesUpdate();
         if(_changedPropeties["textStyle"])
         {
            if(_textField)
            {
               ObjectUtils.disposeObject(_textField);
            }
            _textField = ComponentFactory.Instance.creatComponentByStylename(_textStyle);
            if(_text)
            {
               _textField.text = _text;
            }
         }
         if(_changedPropeties["text"])
         {
            if(_textField)
            {
               _textField.text = _text;
            }
         }
         if(_changedPropeties["selectBtnStyle"])
         {
            if(_selectBtn)
            {
               ObjectUtils.disposeObject(_selectBtn);
            }
            _selectBtn = ComponentFactory.Instance.creatComponentByStylename(_selectBtnStyle);
         }
         if(_changedPropeties["btnRectString"])
         {
            _loc1_ = ClassUtils.CreatInstance("com.pickgliss.geom.InnerRectangle",ComponentFactory.parasArgs(_btnRectString));
            _loc2_ = _loc1_.getInnerRect(_width,_height);
            _selectBtn.x = _loc2_.x;
            _selectBtn.y = _loc2_.y;
            _selectBtn.width = _loc2_.width;
            _selectBtn.height = _loc2_.height;
         }
         _width = _textField.x + _textField.textWidth;
      }
      
      public function set btnRectString(param1:String) : void
      {
         if(_btnRectString == param1)
         {
            return;
         }
         _btnRectString = param1;
         onPropertiesChanged("btnRectString");
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ObjectUtils.disposeObject(_textField);
         _textField = null;
         ObjectUtils.disposeObject(_selectBtn);
         _selectBtn = null;
      }
   }
}

