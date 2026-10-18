package answer.view.base
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import mvc.module.answer.AnswerData;
   
   public class AnswerQuestionItem extends Sprite implements Disposeable
   {
      
      public static const STATE_TEXTFORMAT_ARRAY:Array = ["answer.answer_normal_t","answer.answer_normal_t","answer.answer_selected_t","answer.answer_wrong_t","answer.answer_unselected_t","answer.answer_unselected_t"];
      
      private var _selectIcon:Bitmap;
      
      private var _resultIcon:Bitmap;
      
      private var _answerTxt:FilterFrameText;
      
      private var _state:int = -1;
      
      private var _data:AnswerData;
      
      private var _panel:Sprite;
      
      private const _indexArr:Array = ["A. ","B. ","C. ","D. "];
      
      private var _fun:Function;
      
      public function AnswerQuestionItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _panel = new Sprite();
         addChild(_panel);
         _selectIcon = ComponentFactory.Instance.creatBitmap("asset.answer.selected_no");
         _answerTxt = ComponentFactory.Instance.creatComponentByStylename("answer.answer_describe_Txt");
         _panel.addChild(_answerTxt);
      }
      
      private function addEvent() : void
      {
         addEventListener("click",__onClickHandler);
         addEventListener("mouseDown",__onMouseDownHandler);
         addEventListener("mouseUp",__onMouseUpHandler);
         addEventListener("mouseOver",__onMouseOverHandler);
         addEventListener("mouseOut",__onMouseOutHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__onClickHandler);
         removeEventListener("mouseDown",__onMouseDownHandler);
         removeEventListener("mouseUp",__onMouseUpHandler);
         removeEventListener("mouseOver",__onMouseOverHandler);
         removeEventListener("mouseOut",__onMouseOutHandler);
      }
      
      public function get fun() : Function
      {
         return _fun;
      }
      
      public function set fun(param1:Function) : void
      {
         _fun = param1;
      }
      
      private function __onClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_state == 0)
         {
            if(_fun != null)
            {
               _fun.apply(null,[_data.tmpIndex]);
            }
         }
      }
      
      private function __onMouseDownHandler(param1:MouseEvent) : void
      {
         if(_state == 0)
         {
            _panel.y = 2;
         }
      }
      
      private function __onMouseUpHandler(param1:MouseEvent) : void
      {
         if(_state == 0)
         {
            _panel.y = 0;
         }
      }
      
      private function __onMouseOverHandler(param1:MouseEvent) : void
      {
      }
      
      private function __onMouseOutHandler(param1:MouseEvent) : void
      {
      }
      
      public function get data() : AnswerData
      {
         return _data;
      }
      
      public function set data(param1:AnswerData) : void
      {
         if(param1 == null)
         {
            dispose();
            return;
         }
         _data = param1;
         _answerTxt.text = _indexArr[data.tmpIndex] + data.info;
         changeState(data.state);
      }
      
      public function changeState(param1:int) : void
      {
         if(param1 == _state)
         {
            return;
         }
         _state = param1;
         if(_selectIcon)
         {
            if(_selectIcon.parent)
            {
               _panel.removeChild(_selectIcon);
            }
         }
         switch(param1)
         {
            case 0:
               _selectIcon = ComponentFactory.Instance.creatBitmap("asset.answer.selected_no");
               if(_resultIcon)
               {
                  _resultIcon.visible = false;
               }
               break;
            case 1:
               _selectIcon = ComponentFactory.Instance.creatBitmap("asset.answer.selected");
               if(_resultIcon)
               {
                  _resultIcon.visible = false;
               }
               break;
            case 2:
               _selectIcon = ComponentFactory.Instance.creatBitmap("asset.answer.selected");
               if(_resultIcon)
               {
                  if(_resultIcon.parent)
                  {
                     _panel.removeChild(_resultIcon);
                  }
               }
               _resultIcon = ComponentFactory.Instance.creatBitmap("asset.answer.right_icon");
               break;
            case 3:
               _selectIcon = ComponentFactory.Instance.creatBitmap("asset.answer.selected_wrong");
               if(_resultIcon)
               {
                  if(_resultIcon.parent)
                  {
                     _panel.removeChild(_resultIcon);
                  }
               }
               _resultIcon = ComponentFactory.Instance.creatBitmap("asset.answer.wrong_icon");
               break;
            case 4:
            case 5:
               _selectIcon = ComponentFactory.Instance.creatBitmap("asset.answer.selected_un");
               if(_resultIcon)
               {
                  _resultIcon.visible = false;
               }
         }
         _answerTxt.textFormatStyle = STATE_TEXTFORMAT_ARRAY[param1];
         _panel.addChild(_selectIcon);
         if(_resultIcon)
         {
            _panel.addChild(_resultIcon);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_selectIcon);
         _selectIcon = null;
         ObjectUtils.disposeObject(_resultIcon);
         _resultIcon = null;
         if(_answerTxt)
         {
            _answerTxt.dispose();
         }
         _answerTxt = null;
         _data = null;
         _panel = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

