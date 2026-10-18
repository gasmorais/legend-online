package answer.view
{
   import answer.view.base.AnswerQuestionItem;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.SoundManager;
   import events.AnswerEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.controler.AnswerControler;
   import mvc.module.answer.AnswerItemData;
   import mvc.module.answer.AnswerModel;
   import yishi.manager.FrameControllerManager;
   import yishi.utils.NumberViewUtils;
   
   public class AnswerView extends Component
   {
      
      private var _title:FilterFrameText;
      
      private var _bg:Bitmap;
      
      private var _bgRect:ScaleBitmapImage;
      
      private var _line:Bitmap;
      
      private var _line2:Bitmap;
      
      private var _line3:Bitmap;
      
      private var _answerVec:Vector.<AnswerQuestionItem> = new Vector.<AnswerQuestionItem>();
      
      private var _data:AnswerItemData;
      
      private var _itemH:int = 40;
      
      private var _readQuestion:FilterFrameText;
      
      private var _readQuestionValue:FilterFrameText;
      
      private var _rightCount:FilterFrameText;
      
      private var _rightCountValue:FilterFrameText;
      
      private var _lastCount:FilterFrameText;
      
      private var _lastCountValue:FilterFrameText;
      
      private var _item21:IconButton;
      
      private var _item22:IconButton;
      
      private var _item23:IconButton;
      
      private var _tipTxt:FilterFrameText;
      
      private var _helpBtn:BaseButton;
      
      private var _numberPanel:Sprite;
      
      private var _numberBtmData:BitmapData;
      
      private var _result:Bitmap;
      
      private var _vip1:Bitmap;
      
      private var _vip2:Bitmap;
      
      private var _vip3:Bitmap;
      
      private var _addCount1:FilterFrameText;
      
      private var _addCount2:FilterFrameText;
      
      private var _addCount3:FilterFrameText;
      
      private var _itemCount21:FilterFrameText;
      
      private var _itemCount22:FilterFrameText;
      
      private var _itemCount23:FilterFrameText;
      
      private var _time1:MovieClip;
      
      private var _time2:MovieClip;
      
      private var _curMc:MovieClip;
      
      private var _curFrame:int;
      
      private var _framePro:int;
      
      private var _totalFrame:int;
      
      private var _perFrame:int = 6;
      
      public function AnswerView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bgRect = ComponentFactory.Instance.creatComponentByStylename("answer.bgrect2");
         _bg = ComponentFactory.Instance.creatBitmap("asset.answer.bg");
         _line = ComponentFactory.Instance.creatBitmap("asset.answer.line");
         _line2 = ComponentFactory.Instance.creatBitmap("asset.answer.line");
         _line3 = ComponentFactory.Instance.creatBitmap("asset.answer.line");
         _readQuestion = ComponentFactory.Instance.creatComponentByStylename("answer.readquestion_txt");
         _readQuestionValue = ComponentFactory.Instance.creatComponentByStylename("answer.readquestionvalue_txt");
         _rightCount = ComponentFactory.Instance.creatComponentByStylename("answer.rightcount_txt");
         _rightCountValue = ComponentFactory.Instance.creatComponentByStylename("answer.rightcountvalue_txt");
         _lastCount = ComponentFactory.Instance.creatComponentByStylename("answer.lastcount_txt");
         _lastCountValue = ComponentFactory.Instance.creatComponentByStylename("answer.lastcountvalue_txt");
         _line2.y = 285;
         _line3.y = 410;
         _title = ComponentFactory.Instance.creatComponentByStylename("answer.answer_title_txt");
         _item21 = ComponentFactory.Instance.creatComponentByStylename("answer.item_0");
         _item22 = ComponentFactory.Instance.creatComponentByStylename("answer.item_1");
         _item23 = ComponentFactory.Instance.creatComponentByStylename("answer.item_2");
         _vip1 = ComponentFactory.Instance.creatBitmap("asset.answer.vip_icon");
         _vip2 = ComponentFactory.Instance.creatBitmap("asset.answer.vip_icon");
         _vip3 = ComponentFactory.Instance.creatBitmap("asset.answer.vip_icon");
         _addCount1 = ComponentFactory.Instance.creatComponentByStylename("answer.addCount");
         _addCount2 = ComponentFactory.Instance.creatComponentByStylename("answer.addCount");
         _addCount3 = ComponentFactory.Instance.creatComponentByStylename("answer.addCount");
         _itemCount21 = ComponentFactory.Instance.creatComponentByStylename("answer.item_txt");
         _itemCount22 = ComponentFactory.Instance.creatComponentByStylename("answer.item_txt");
         _itemCount23 = ComponentFactory.Instance.creatComponentByStylename("answer.item_txt");
         _tipTxt = ComponentFactory.Instance.creatComponentByStylename("answer.tips_txt");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("answer.HelpBtn");
         _tipTxt.text = LanguageMgr.GetTranslation("answer.view.tipsTxt.text");
         _readQuestion.text = LanguageMgr.GetTranslation("answer.view.state.read");
         _rightCount.text = LanguageMgr.GetTranslation("answer.view.rightcount");
         _lastCount.text = LanguageMgr.GetTranslation("answer.view.lastcount");
         _addCount1.text = "(+1)";
         _addCount2.text = "(+1)";
         _addCount3.text = "(+2)";
         _numberBtmData = ComponentFactory.Instance.creatBitmapData("asset.core.number_img_07").clone();
         _numberPanel = ComponentFactory.Instance.creatCustomObject("answer.answer.scorepanel");
         _time1 = ComponentFactory.Instance.creat("asset.answer.time01");
         _time2 = ComponentFactory.Instance.creat("asset.answer.time02");
         _item21.tipData = LanguageMgr.GetTranslation("answer.view.item21tip");
         _item22.tipData = LanguageMgr.GetTranslation("answer.view.item22tip");
         _item23.tipData = LanguageMgr.GetTranslation("answer.view.item23tip");
         _readQuestionValue.x = _readQuestion.x + _readQuestion.textWidth + 5;
         _lastCountValue.x = _lastCount.x + _lastCount.textWidth + 5;
         _rightCountValue.x = _rightCount.x + _rightCount.textWidth + 5;
         _vip1.x = 50;
         _vip2.x = 200;
         _vip3.x = 350;
         _addCount1.x = 90;
         _addCount2.x = 240;
         _addCount3.x = 390;
         addChild(_bgRect);
         addChild(_bg);
         addChild(_line);
         addChild(_line2);
         addChild(_line3);
         addChild(_title);
         addChild(_readQuestion);
         addChild(_readQuestionValue);
         addChild(_rightCount);
         addChild(_rightCountValue);
         addChild(_lastCount);
         addChild(_lastCountValue);
         addChild(_item21);
         addChild(_item22);
         addChild(_item23);
         _item21.addChild(_itemCount21);
         _item22.addChild(_itemCount22);
         _item23.addChild(_itemCount23);
         addChild(_vip1);
         addChild(_vip2);
         addChild(_vip3);
         addChild(_addCount1);
         addChild(_addCount2);
         addChild(_addCount3);
         addChild(_tipTxt);
         addChild(_helpBtn);
         addChild(_numberPanel);
         _time1.x = 380;
         _time1.y = 1;
         _time2.x = 380;
         _time2.y = 0;
         _time1.visible = _time2.visible = false;
         _time1.stop();
         _time2.stop();
         addChild(_time1);
         addChild(_time2);
         _readQuestion.visible = false;
         _readQuestionValue.visible = false;
      }
      
      private function initEvent() : void
      {
         _helpBtn.addEventListener("click",__onClickHandler);
         _item21.addEventListener("click",__onItemDoubleClickHandler);
         _item22.addEventListener("click",__onItemHeartClickHandler);
         _item23.addEventListener("click",__onItemEyeClickHandler);
      }
      
      private function removeEvent() : void
      {
         _helpBtn.removeEventListener("click",__onClickHandler);
         _item21.removeEventListener("click",__onItemDoubleClickHandler);
         _item22.removeEventListener("click",__onItemHeartClickHandler);
         _item23.removeEventListener("click",__onItemEyeClickHandler);
         removeEventListener("enterFrame",__onEnterFrameHandler);
      }
      
      private function __onEnterFrameHandler(param1:Event) : void
      {
         _framePro = _framePro + 1;
         if(_curMc && _framePro >= _perFrame)
         {
            _framePro = 0;
            _curFrame = _curFrame + 1;
            _curFrame = _curFrame > _totalFrame ? _totalFrame : _curFrame;
            _curMc.gotoAndStop(_curFrame);
         }
      }
      
      private function get control() : AnswerControler
      {
         return FrameControllerManager.instance.answerController;
      }
      
      private function get model() : AnswerModel
      {
         return FrameControllerManager.instance.answerController.model;
      }
      
      private function __onItemDoubleClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         selectItem(21);
      }
      
      private function __onItemHeartClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         selectItem(22);
      }
      
      private function __onItemEyeClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         selectItem(23);
      }
      
      private function __onClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         control.showHelpFrame();
      }
      
      public function get data() : AnswerItemData
      {
         return _data;
      }
      
      public function setItemCout(param1:int, param2:int, param3:Boolean) : void
      {
         if(this["_itemCount" + param1])
         {
            if(this["_itemCount" + param1] is FilterFrameText)
            {
               (this["_itemCount" + param1] as FilterFrameText).text = param2 + "";
               (this["_item" + param1] as IconButton).enable = param3;
            }
         }
      }
      
      public function updateState(param1:int, param2:int) : void
      {
         _perFrame = 0;
         switch(param1 - 1)
         {
            case 0:
               _readQuestion.text = LanguageMgr.GetTranslation("answer.view.state.ready");
               _readQuestion.visible = false;
               _readQuestionValue.visible = true;
               if(hasEventListener("enterFrame"))
               {
                  removeEventListener("enterFrame",__onEnterFrameHandler);
               }
               break;
            case 1:
               _time1.visible = true;
               _time2.visible = false;
               _curMc = _time1;
               if(param2 > 5)
               {
                  param2 = 5;
               }
               _totalFrame = _time1.totalFrames;
               _perFrame = 25 / (_totalFrame / 5);
               _curFrame = _totalFrame * (5 - param2) / 5;
               _time1.gotoAndStop(_curFrame);
               if(!hasEventListener("enterFrame"))
               {
                  addEventListener("enterFrame",__onEnterFrameHandler);
               }
               _readQuestion.text = LanguageMgr.GetTranslation("answer.view.state.read");
               if(_result)
               {
                  if(_result.parent)
                  {
                     _result.parent.removeChild(_result);
                  }
               }
               if(_numberPanel)
               {
                  NumberViewUtils.refreshValue(-1,_numberPanel,_numberBtmData);
               }
               _readQuestion.visible = false;
               _readQuestionValue.visible = false;
               break;
            case 2:
               if(!hasEventListener("enterFrame"))
               {
                  addEventListener("enterFrame",__onEnterFrameHandler);
               }
               _readQuestion.text = LanguageMgr.GetTranslation("answer.view.state.ask");
               _readQuestion.visible = false;
               _readQuestionValue.visible = false;
               _time2.visible = true;
               _time1.visible = false;
               _curMc = _time2;
               if(param2 > 15)
               {
                  param2 = 15;
               }
               _totalFrame = _time2.totalFrames;
               _perFrame = 25 / (_totalFrame / 15);
               _curFrame = _totalFrame * (15 - param2) / 15;
               _time2.gotoAndStop(_curFrame);
               break;
            case 3:
               _readQuestion.text = LanguageMgr.GetTranslation("answer.view.state.next");
               if(hasEventListener("enterFrame"))
               {
                  removeEventListener("enterFrame",__onEnterFrameHandler);
               }
               _readQuestion.visible = false;
               _readQuestionValue.visible = false;
               _time1.visible = false;
               _time2.visible = false;
               break;
            default:
               if(hasEventListener("enterFrame"))
               {
                  removeEventListener("enterFrame",__onEnterFrameHandler);
               }
         }
         _rightCountValue.text = model.sucCount + "";
         _lastCountValue.text = model.systemLastNum + "";
      }
      
      public function result(param1:int, param2:int) : void
      {
         switch(param1)
         {
            case 0:
               _result = ComponentFactory.Instance.creatBitmap("asset.answer.wrong_txt");
               break;
            case 1:
               _result = ComponentFactory.Instance.creatBitmap("asset.answer.right_txt");
               NumberViewUtils.refreshValue(param2,_numberPanel,_numberBtmData);
         }
         addChild(_result);
      }
      
      public function set data(param1:AnswerItemData) : void
      {
         var _loc2_:int = 0;
         var _loc3_:AnswerQuestionItem = null;
         _data = param1;
         _title.text = _data.topic;
         _loc2_ = 0;
         while(_loc2_ < _data.answerVec.length)
         {
            if(_loc2_ == _answerVec.length)
            {
               _loc3_ = new AnswerQuestionItem();
               _loc3_.x = 10;
               _loc3_.y = _loc2_ * _itemH + 100;
               _loc3_.fun = selectAnswer;
               _answerVec[_loc2_] = _loc3_;
            }
            _answerVec[_loc2_].data = _data.answerVec[_loc2_];
            if(null == _answerVec[_loc2_].parent)
            {
               addChild(_answerVec[_loc2_]);
            }
            _loc2_++;
         }
      }
      
      private function selectAnswer(param1:int) : void
      {
         model.dispatchEvent(new AnswerEvent("SELECT_ANSWER",param1));
      }
      
      private function selectItem(param1:int) : void
      {
         model.dispatchEvent(new AnswerEvent("SELECT_ITEM",param1));
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
      }
   }
}

