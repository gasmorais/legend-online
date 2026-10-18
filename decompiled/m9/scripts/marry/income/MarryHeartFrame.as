package marry.income
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.SoundManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import logging.LoggerSys;
   import manager.LanguageMgr;
   import managers.MarryManager;
   import mvc.ModuleFrameInfo;
   import mvc.module.marry.MarryModel;
   import mvc.module.marry.MarrySender;
   import mvc.module.marry.feels.MarryHeartInfo;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.HeartTemplateData;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.StringHelper;
   import yishi.view.community.BaseItemView;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class MarryHeartFrame extends Frame
   {
      
      private var _bg1:Scale9CornerImage;
      
      private var _bg2:MutipleImage;
      
      private var _question:FilterFrameText;
      
      private var _leftTime1:FilterFrameText;
      
      private var _leftTime2:FilterFrameText;
      
      private var _rateText:FilterFrameText;
      
      private var _group:SelectedButtonGroup;
      
      private var _answerTimeback:Image;
      
      private var _vBox1:VBox;
      
      private var _resultBox:HBox;
      
      private var _rewardsBox:HBox;
      
      private var _timer:Timer;
      
      private var _rewardItem:BaseItemView;
      
      private var _synchronizationText:FilterFrameText;
      
      private var _helpBtn:BaseButton;
      
      private var _answerList:Vector.<MarryHeartResultItem>;
      
      private var _rewardTempleteIds:Array = [208034,208036];
      
      private const ANSWERNUM:int = 10;
      
      public function MarryHeartFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,595,440);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:MarryHeartResultItem = null;
         _answerList = new Vector.<MarryHeartResultItem>();
         titleText = LanguageMgr.GetTranslation("marry.income.MarryHeartFrame.titleText");
         _bg1 = ComponentFactory.Instance.creatComponentByStylename("MarryHeartFrame.bg1");
         _bg2 = ComponentFactory.Instance.creatComponentByStylename("MarryHeartFrame.bg2");
         _question = ComponentFactory.Instance.creatComponentByStylename("MarryHeartFrame.question.textField");
         _leftTime1 = ComponentFactory.Instance.creatComponentByStylename("MarryHeartFrame.leftTime1");
         _leftTime2 = ComponentFactory.Instance.creatComponentByStylename("MarryHeartFrame.leftTime2");
         _rateText = ComponentFactory.Instance.creatComponentByStylename("MarryHeartFrame.rateText");
         _vBox1 = ComponentFactory.Instance.creatComponentByStylename("MarryHeartFrame.vBox1");
         _resultBox = ComponentFactory.Instance.creatComponentByStylename("MarryHeartFrame.resultBox");
         _rewardsBox = ComponentFactory.Instance.creatComponentByStylename("MarryHeartFrame.rewardsBox");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("MarryHeartFrame.HelpBtn");
         _answerTimeback = ComponentFactory.Instance.creatComponentByStylename("marry.heartTimeBack.scaleX");
         _synchronizationText = ComponentFactory.Instance.creatComponentByStylename("marry.heartTimeBack.synchronizationText");
         _helpBtn.tipData = LanguageMgr.GetTranslation("marry.income.MarryHeartFrame.helpBtn.Tip");
         _rateText.text = LanguageMgr.GetTranslation("marry.income.MarryHeartFrame.answerResult");
         _synchronizationText.text = LanguageMgr.GetTranslation("marry.income.MarryHeartFrame.synchronizationtext");
         addToContent(_bg1);
         addToContent(_bg2);
         addToContent(_question);
         addToContent(_leftTime1);
         addToContent(_leftTime2);
         addToContent(_rateText);
         addToContent(_answerTimeback);
         addToContent(_synchronizationText);
         addToContent(_vBox1);
         addToContent(_rewardsBox);
         addToContent(_resultBox);
         addToContent(_helpBtn);
         _group = new SelectedButtonGroup();
         _loc2_ = 0;
         while(_loc2_ < 10)
         {
            _loc1_ = new MarryHeartResultItem();
            _loc1_.order = _loc2_ + 1;
            _loc1_.enable = false;
            _answerList.push(_loc1_);
            _resultBox.addChild(_loc1_);
            _loc2_++;
         }
      }
      
      private function refreshView() : void
      {
         var _loc7_:int = 0;
         var _loc6_:GoodsInfo = null;
         var _loc5_:int = 0;
         var _loc3_:SelectedTextButton = null;
         _group.selectIndex = -1;
         _group.removeAllItem();
         _vBox1.disposeAllChildren();
         _rewardsBox.disposeAllChildren();
         _loc5_ = 0;
         while(_loc5_ < heartInfo.answeredList.length)
         {
            if(heartInfo.answeredList[_loc5_].result == 1)
            {
               _loc7_++;
            }
            (_answerList[_loc5_] as MarryHeartResultItem).data = heartInfo.answeredList[_loc5_];
            _loc5_++;
         }
         if(_loc7_ > 0)
         {
            _loc6_ = new GoodsInfo();
            _loc6_.templateId = _rewardTempleteIds[0];
            _loc6_.count = _loc7_ * 50;
            _rewardItem = ComponentFactory.Instance.creatCustomObject("MarryHeartFrame.rewardItem");
            _rewardItem.data = _loc6_;
            _rewardsBox.addChild(_rewardItem);
            if(int(_loc7_ / 2) >= 1)
            {
               _loc6_ = new GoodsInfo();
               _loc6_.templateId = _rewardTempleteIds[1];
               _loc6_.count = _loc7_ / 2;
               _rewardItem = ComponentFactory.Instance.creatCustomObject("MarryHeartFrame.rewardItem");
               _rewardItem.data = _loc6_;
               _rewardsBox.addChild(_rewardItem);
            }
         }
         if(heartInfo.curQuestion == null)
         {
            _question.text = "";
            _leftTime2.text = "";
            _leftTime1.text = LanguageMgr.GetTranslation("marry.income.MarryHeartFrame.endTxt2");
            _leftTime1.x = 169;
            return;
         }
         _leftTime1.text = LanguageMgr.GetTranslation("answer.view.state.ask");
         var _loc2_:HeartTemplateData = TempleteManager.instance.heartTemplateCate.getTemplatesById(heartInfo.curQuestion.templateId);
         if(_loc2_ == null)
         {
            LoggerSys.info("MarryHeartFrame模版不存在templateId{invalid_utf8=239}{invalid_utf8=188}?" + heartInfo.curQuestion.templateId);
            dispose();
            return;
         }
         var _loc4_:int = getAnswersNum(_loc2_);
         _loc5_ = 0;
         while(_loc5_ < heartInfo.curQuestion.options.length)
         {
            if(heartInfo.curQuestion.options[_loc5_] < _loc4_)
            {
               _loc3_ = ComponentFactory.Instance.creatComponentByStylename("MarryHeartFrame.selectedBtn");
               _loc3_.text = _loc2_["Option" + (heartInfo.curQuestion.options[_loc5_] + 1)];
               _group.addSelectItem(_loc3_);
               _vBox1.addChild(_loc3_);
            }
            _loc5_++;
         }
         var _loc1_:String = _loc2_.Question;
         if(heartInfo.curQuestion.random == 0)
         {
            _loc1_ = _loc1_.replace("{0}",LanguageMgr.GetTranslation("marry.income.MarryHeartFrame.You"));
         }
         else if(heartInfo.curQuestion.random == 1)
         {
            _loc1_ = _loc1_.replace("{0}",LanguageMgr.GetTranslation("marry.income.MarryHeartFrame.HeOrShe"));
         }
         _question.text = heartInfo.curQuestion.order + "." + _loc1_;
         if(_timer == null)
         {
            addTimer();
         }
      }
      
      private function getAnswersNum(param1:HeartTemplateData) : int
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         _loc3_ = 1;
         while(_loc3_ < 5)
         {
            if(!StringHelper.isNullOrEmpty(param1["Option" + _loc3_]))
            {
               _loc2_++;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function __timerHandler(param1:TimerEvent) : void
      {
         if(heartInfo.curQuestion)
         {
            if(heartInfo.curQuestion.remainTime > 0)
            {
               heartInfo.curQuestion.remainTime -= 1;
               _leftTime2.text = heartInfo.curQuestion.remainTime + " S";
            }
            else
            {
               MarrySender.opMarryHeartTimerComplete(heartInfo.curQuestion.order);
            }
         }
         else
         {
            removeTimer();
         }
      }
      
      private function addTimer() : void
      {
         _timer = new Timer(1000);
         _timer.addEventListener("timer",__timerHandler);
         _timer.start();
      }
      
      private function removeTimer() : void
      {
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__timerHandler);
            _timer = null;
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         if(_group)
         {
            _group.addEventListener("change",__selectedHandler);
         }
         if(_helpBtn)
         {
            _helpBtn.addEventListener("click",__openHelperFrameHandler);
         }
         MsgMan.addObserver("MarryEventType.QUESTION_INFO",this,__receiveHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_group)
         {
            _group.removeEventListener("change",__selectedHandler);
         }
         if(_helpBtn)
         {
            _helpBtn.removeEventListener("click",__openHelperFrameHandler);
         }
         MsgMan.removeObserver("MarryEventType.QUESTION_INFO",this,__receiveHandler);
      }
      
      private function __openHelperFrameHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("MarryHeartFrame.HelpFrame");
         if(_loc2_)
         {
            _loc2_.show(0);
         }
      }
      
      private function __receiveHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function __selectedHandler(param1:Event) : void
      {
         if(_group && heartInfo.curQuestion)
         {
            MarrySender.opMarryHeartAnswer(heartInfo.curQuestion.order,_group.selectIndex);
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               if(heartInfo.curQuestion)
               {
                  closeTip();
                  break;
               }
               dispose();
         }
      }
      
      private function closeTip() : void
      {
         SimpleAlertHelper.instance.data = [__callServerSccess];
         var _loc1_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc3_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc4_:String = LanguageMgr.GetTranslation("marry.income.MarryHeartFrame.CloseTip");
         AlertManager.Instance.layerType = 0;
         SimpleAlertHelper.instance.popAlerFrame(_loc3_,_loc4_,_loc1_,_loc2_,false,true,true);
         AlertManager.Instance.layerType = 1;
      }
      
      private function __callServerSccess(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            if(heartInfo.curQuestion)
            {
               MarrySender.opMarryHeartOp(3005);
            }
            dispose();
         }
      }
      
      private function get model() : MarryModel
      {
         return MarryManager.instance.model;
      }
      
      private function get heartInfo() : MarryHeartInfo
      {
         return model.selfMarryInfo.heartInfo;
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,0,true,true,1,0,true);
         refreshView();
      }
      
      override public function dispose() : void
      {
         var _loc1_:MarryHeartResultItem = null;
         removeTimer();
         removeEvent();
         KeyBoardRegister.instance.keyEnable = true;
         while(_answerList.length > 0)
         {
            _loc1_ = _answerList.pop();
            _loc1_.dispose();
            _loc1_ = null;
         }
         if(_answerTimeback)
         {
            _answerTimeback.dispose();
         }
         _answerTimeback = null;
         if(_synchronizationText)
         {
            _synchronizationText.dispose();
         }
         _synchronizationText = null;
         if(_bg1)
         {
            _bg1.dispose();
         }
         _bg1 = null;
         if(_bg2)
         {
            _bg2.dispose();
         }
         _bg2 = null;
         if(_question)
         {
            _question.dispose();
         }
         _question = null;
         if(_leftTime1)
         {
            _leftTime1.dispose();
         }
         _leftTime1 = null;
         if(_leftTime2)
         {
            _leftTime2.dispose();
         }
         _leftTime2 = null;
         if(_rateText)
         {
            _rateText.dispose();
         }
         _rateText = null;
         if(_group)
         {
            _group.dispose();
         }
         _group = null;
         if(_vBox1)
         {
            _vBox1.dispose();
         }
         _vBox1 = null;
         if(_resultBox)
         {
            _resultBox.dispose();
         }
         _resultBox = null;
         if(_rewardsBox)
         {
            _rewardsBox.dispose();
         }
         _rewardsBox = null;
         super.dispose();
      }
   }
}

