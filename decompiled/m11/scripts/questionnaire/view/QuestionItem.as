package questionnaire.view
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextInput;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import utils.LogicUtils;
   import yishi.manager.QuestionnaireManager;
   
   public class QuestionItem extends Sprite implements Disposeable, IManualSize
   {
      
      public static const WIDTH:int = 537;
      
      public static const HEIGHT:int = 30;
      
      public static const OFFSET:int = 10;
      
      private var _titleString:String;
      
      private var _title:FilterFrameText;
      
      private var _selectAnswers:Array;
      
      private var _answersPosition:Array;
      
      private var _nextPos:Point;
      
      private var _inputAnswer:Sprite;
      
      private var _inputTitle:SelectText;
      
      private var _inputText:TextInput;
      
      private var _inputBack:Bitmap;
      
      public var questionId:int;
      
      private var _inputString:String;
      
      public function QuestionItem()
      {
         super();
         _selectAnswers = [];
         _answersPosition = [];
         _title = ComponentFactory.Instance.creatComponentByStylename("questionnaire.QuestionTitleText");
      }
      
      private function refreshView() : void
      {
         var _loc1_:* = null;
         var _loc2_:Point = new Point();
         if(_title)
         {
            addChild(_title);
            _loc2_ = new Point(10,_title.textHeight + 10);
         }
         for each(_loc1_ in _answersPosition)
         {
            _loc1_.x = _loc2_.x;
            _loc1_.y = _loc2_.y;
            if(_loc2_.x + _loc1_.width > 537 / 2)
            {
               _loc2_.x = 10;
               _loc2_.y += 30;
            }
            else
            {
               _loc2_.x += 537 / 2;
            }
            addChild(_loc1_);
         }
      }
      
      public function set titleStyle(param1:String) : void
      {
         if(_titleString == param1)
         {
            return;
         }
         _titleString = _titleString;
         if(_title)
         {
            ObjectUtils.disposeObject(_title);
         }
         _title = ComponentFactory.Instance.creatComponentByStylename(_titleString);
         _title.width = 537;
         addChild(_title);
      }
      
      public function set text(param1:String) : void
      {
         if(_title)
         {
            _title.text = param1;
         }
         refreshView();
      }
      
      public function addAnswer(param1:String, param2:int) : void
      {
         var _loc3_:SelectText = ComponentFactory.Instance.creatComponentByStylename("questionnaire.SelectText");
         if(param2)
         {
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("questionnaire.SelectText");
         }
         else
         {
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("questionnaire.SingleSelectText");
            _loc3_.addEventListener("click",__answerSingleChoiceHandler);
         }
         _loc3_.text = param1;
         _selectAnswers.push(_loc3_);
         _answersPosition.push(_loc3_);
         _loc3_.addEventListener("click",__answerChecked);
         refreshView();
      }
      
      public function addInputAnswer(param1:String, param2:int) : void
      {
         _inputAnswer = new Sprite();
         if(param2)
         {
            _inputTitle = ComponentFactory.Instance.creatComponentByStylename("questionnaire.SelectText");
         }
         else
         {
            _inputTitle = ComponentFactory.Instance.creatComponentByStylename("questionnaire.SingleSelectText");
            _inputTitle.addEventListener("click",__answerSingleChoiceHandler);
         }
         _inputText = ComponentFactory.Instance.creatComponentByStylename("questionnaire.InputTxt");
         _inputBack = ComponentFactory.Instance.creatBitmap("asset.core.InputBack_Style_03");
         _inputAnswer.addChild(_inputTitle);
         _inputAnswer.addChild(_inputBack);
         _inputBack.x = 62;
         _inputBack.y = 0;
         _inputAnswer.addChild(_inputText);
         _inputTitle.text = param1.slice(0,6);
         _selectAnswers.push(_inputTitle);
         _answersPosition.push(_inputAnswer);
         _inputTitle.addEventListener("click",__answerChecked);
         _inputText.addEventListener("textInput",__inputAnswerChecked);
         refreshView();
      }
      
      private function __answerSingleChoiceHandler(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         for each(_loc2_ in _selectAnswers)
         {
            _loc2_.selectBtnType = false;
         }
         param1.currentTarget.selectBtnType = true;
      }
      
      private function __answerChecked(param1:MouseEvent) : void
      {
         QuestionnaireManager.instance.model.questionnaireCheck();
      }
      
      private function __inputAnswerChecked(param1:TextEvent) : void
      {
         _inputString = param1.text;
         QuestionnaireManager.instance.model.questionnaireCheck();
      }
      
      public function get answerData() : String
      {
         var _loc3_:int = 0;
         var _loc2_:String = "";
         var _loc1_:String = LanguageMgr.GetTranslation("public.colon","other");
         _loc3_ = 0;
         while(_loc3_ < _selectAnswers.length)
         {
            if(_selectAnswers[_loc3_].selectBtnType && _selectAnswers[_loc3_].text != _loc1_)
            {
               _loc2_ += _selectAnswers[_loc3_].text + "|";
            }
            _loc3_++;
         }
         if(_inputTitle && _inputTitle.selectBtnType && _inputString)
         {
            _loc2_ += _inputString + "|";
            _inputString = "";
         }
         return _loc2_;
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,537,height + 10);
      }
      
      private function removeEvent() : void
      {
         if(_inputText)
         {
            _inputText.removeEventListener("textInput",__inputAnswerChecked);
         }
         if(_inputTitle)
         {
            _inputTitle.removeEventListener("click",__answerChecked);
         }
      }
      
      private function removeAnswerSingleHandler(param1:SelectText) : void
      {
         param1.removeEventListener("click",__answerSingleChoiceHandler);
      }
      
      public function dispose() : void
      {
         removeEvent();
         LogicUtils.disposeDisplayCollection(_answersPosition);
         _answersPosition = null;
         LogicUtils.disposeDisplayCollection(_selectAnswers,removeAnswerSingleHandler);
         _selectAnswers = null;
         ObjectUtils.disposeAllChildren(_inputAnswer);
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

