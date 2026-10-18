package questionnaire
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.questionnarie.QuestionDataRspInfo;
   import com.road.yishi.proto.questionnarie.QuestionInfoMsg;
   import events.QuestionnaireEvent;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.questionnaire.QuestionnaireModel;
   import questionnaire.view.QuestionItem;
   import utils.LogicUtils;
   import yishi.manager.QuestionnaireManager;
   
   public class QuestionnaireFrame extends Frame implements IManualSize
   {
      
      private static const SEND_ANSWER:int = 1;
      
      private static const END_ANSWER:int = 2;
      
      private var _bgK:Scale9CornerImage;
      
      private var _bgLeft:Bitmap;
      
      private var _bgRight:Bitmap;
      
      private var _titleBack:Bitmap;
      
      private var _nextPageBtn:IconButton;
      
      private var _titleField:GradientText;
      
      private var _answerList:Array;
      
      private var _vBox:VBox;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _itemList:Array;
      
      private var _endAnswer:Boolean;
      
      private var _showDes:Boolean;
      
      private var _desText:FilterFrameText;
      
      public function QuestionnaireFrame()
      {
         super();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,604,578);
      }
      
      override protected function init() : void
      {
         super.init();
         _itemList = [];
         _showDes = true;
         titleText = LanguageMgr.GetTranslation("questionnaire.QuestionnaireFrame.titleText");
         _bgK = ComponentFactory.Instance.creatComponentByStylename("questionnaire.backgroundK");
         _bgLeft = ComponentFactory.Instance.creatBitmap("asset.questionnaire.Bg");
         _bgRight = ComponentFactory.Instance.creatBitmap("asset.questionnaire.Bg");
         _titleBack = ComponentFactory.Instance.creatBitmap("asset.questionnaire.TitleBack");
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("questionnaire.NextStepBtn");
         _titleField = ComponentFactory.Instance.creatComponentByStylename("questionnaire.Title");
         _desText = ComponentFactory.Instance.creatComponentByStylename("questionnaire.QuestionDescribeText");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("questionnaire.ScrollPanel");
         addToContent(_bgK);
         addToContent(_bgLeft);
         _bgRight.scaleX = -1;
         _bgRight.x = _bgLeft.x + _bgLeft.width * 2;
         addToContent(_bgRight);
         addToContent(_titleBack);
         addToContent(_nextPageBtn);
         _nextPageBtn.enable = false;
         addToContent(_titleField);
         addToContent(_scrollPanel);
         _titleField.text = LanguageMgr.GetTranslation("questionnaire.QuestionnaireFrame.titleField");
         _vBox = new VBox();
         _vBox.spacing = 10;
         _scrollPanel.setView(_vBox);
      }
      
      public function addQuestionItem(param1:QuestionInfoMsg) : void
      {
         var _loc2_:QuestionItem = new QuestionItem();
         _loc2_.questionId = param1.id;
         _loc2_.text = param1.title;
         if(param1.a)
         {
            _loc2_.addAnswer(param1.a,param1.type);
         }
         if(param1.b)
         {
            _loc2_.addAnswer(param1.b,param1.type);
         }
         if(param1.c)
         {
            _loc2_.addAnswer(param1.c,param1.type);
         }
         if(param1.d)
         {
            _loc2_.addAnswer(param1.d,param1.type);
         }
         if(param1.e)
         {
            _loc2_.addAnswer(param1.e,param1.type);
         }
         if(param1.f)
         {
            _loc2_.addAnswer(param1.f,param1.type);
         }
         if(param1.g)
         {
            _loc2_.addAnswer(param1.g,param1.type);
         }
         if(param1.h)
         {
            _loc2_.addAnswer(param1.h,param1.type);
         }
         if(param1.i)
         {
            _loc2_.addAnswer(param1.i,param1.type);
         }
         if(param1.j.slice(-1) == "1")
         {
            _loc2_.addInputAnswer(param1.j,param1.type);
         }
         _vBox.addChild(_loc2_);
         _itemList.push(_loc2_);
         refreshView();
      }
      
      public function cleanList() : void
      {
         var _loc1_:QuestionItem = null;
         _vBox.removeAllChild();
         while(_itemList.length > 0)
         {
            _loc1_ = _itemList.pop();
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
      }
      
      public function get answerList() : Array
      {
         var _loc2_:int = 0;
         var _loc1_:QuestionDataRspInfo = null;
         _answerList = [];
         _loc2_ = 0;
         while(_loc2_ < _itemList.length)
         {
            if(_itemList[_loc2_].answerData)
            {
               _loc1_ = new QuestionDataRspInfo();
               _loc1_.questId = _itemList[_loc2_].questionId;
               _loc1_.answer = _itemList[_loc2_].answerData;
               _answerList.push(_loc1_);
            }
            _loc2_++;
         }
         return _answerList;
      }
      
      public function refreshView() : void
      {
         _vBox.refreshChildPos();
         _scrollPanel.invalidateViewport();
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         if(_nextPageBtn)
         {
            _nextPageBtn.addEventListener("click",__clickNextPageHandler);
         }
         if(model)
         {
            model.addEventListener("QUESTIONNAIRE_FRESH",__refreshList);
         }
         model.addEventListener("QUESTIONNAIRE_CHECKED",__answerCheckHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_nextPageBtn)
         {
            _nextPageBtn.removeEventListener("click",__clickNextPageHandler);
         }
         model.removeEventListener("QUESTIONNAIRE_FRESH",__refreshList);
         model.removeEventListener("QUESTIONNAIRE_CHECKED",__answerCheckHandler);
      }
      
      private function __clickNextPageHandler(param1:MouseEvent) : void
      {
         _showDes = false;
         if(_endAnswer)
         {
            QuestionnaireManager.instance.sendQuestionAnswer(2,model.questionId,answerList);
            model.questionnaireVisible = false;
            dispose();
         }
         else
         {
            QuestionnaireManager.instance.sendQuestionAnswer(1,model.questionId,answerList);
         }
      }
      
      private function __refreshList(param1:QuestionnaireEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         _nextPageBtn.enable = false;
         cleanList();
         if(model.questionList && model.questionList.length > 0)
         {
            _loc3_ = 0;
            if(_showDes)
            {
               _vBox.addChild(_desText);
               _desText.text = model.questionContent;
            }
            _loc2_ = 0;
            while(_loc2_ < model.questionList.length)
            {
               if(_loc3_ == 0)
               {
                  _loc3_ = int(model.questionList[_loc2_].contenType);
                  addQuestionItem(model.questionList[_loc2_]);
                  if(_loc2_ == model.questionList.length - 1)
                  {
                     setEndBtn();
                  }
               }
               else if(_loc3_ == model.questionList[_loc2_].contenType)
               {
                  addQuestionItem(model.questionList[_loc2_]);
                  if(_loc2_ == model.questionList.length - 1)
                  {
                     setEndBtn();
                  }
               }
               else if(_loc3_ != model.questionList[_loc2_].contenType)
               {
               }
               _loc2_++;
            }
            refreshView();
         }
         else
         {
            model.questionnaireVisible = false;
            dispose();
         }
      }
      
      private function setEndBtn() : void
      {
         _endAnswer = true;
         model.removeEventListener("QUESTIONNAIRE_FRESH",__refreshList);
         _nextPageBtn.parent.removeChild(_nextPageBtn);
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("questionnaire.EndBtn");
         _nextPageBtn.addEventListener("click",__clickNextPageHandler);
         addToContent(_nextPageBtn);
         _nextPageBtn.enable = false;
      }
      
      private function __answerCheckHandler(param1:QuestionnaireEvent) : void
      {
         if(answerList.length >= _itemList.length)
         {
            _nextPageBtn.enable = true;
         }
         else
         {
            _nextPageBtn.enable = false;
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,0,0,true);
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function get model() : QuestionnaireModel
      {
         return QuestionnaireManager.instance.model;
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
         _vBox.removeAllChild();
         ObjectUtils.disposeObject(_bgK);
         _bgK = null;
         ObjectUtils.disposeObject(_bgLeft);
         _bgLeft = null;
         ObjectUtils.disposeObject(_bgRight);
         _bgRight = null;
         ObjectUtils.disposeObject(_titleBack);
         _titleBack = null;
         ObjectUtils.disposeObject(_nextPageBtn);
         _nextPageBtn = null;
         ObjectUtils.disposeObject(_titleField);
         _titleField = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeObject(_desText);
         _desText = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         ObjectUtils.disposeAllChildren(this);
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
      }
   }
}

