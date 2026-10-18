package christmas
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.christmas.ChristmasModel;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.ChristmasAnswersTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.ChristmasManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.view.community.HeadIconCell;
   import yishi.view.tips.MessageTipManager;
   
   public class ChristmasAnswerFrame extends Frame implements IManualSize
   {
      
      private var _back1:Bitmap;
      
      private var _back2:Bitmap;
      
      private var _titleBg:Bitmap;
      
      private var _timeBg:Bitmap;
      
      private var _descBg:Bitmap;
      
      private var _timeTxt:FilterFrameText;
      
      private var _txt:FilterFrameText;
      
      private var _descTxt:FilterFrameText;
      
      private var _previewBtn:IconButton;
      
      private var _answerBtn:IconButton;
      
      private var _sprite1:Sprite;
      
      private var _sprite2:Sprite;
      
      private var _cdTime:Bitmap;
      
      private var _countBg:Bitmap;
      
      private var _countTxt:FilterFrameText;
      
      private var _rightTxt:FilterFrameText;
      
      private var _progress:MovieClip;
      
      private var _cdTxt:FilterFrameText;
      
      private var _questionTxt:FilterFrameText;
      
      private var _answerA:FilterFrameText;
      
      private var _answerB:FilterFrameText;
      
      private var _cell:HeadIconCell;
      
      private var _allCount:int;
      
      private var _btn1:SelectedButton;
      
      private var _btn2:SelectedButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      public function ChristmasAnswerFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,1043,651);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         _back1 = ComponentFactory.Instance.creatBitmap("asset.ChristmasAnswerFrame.back1");
         _back2 = ComponentFactory.Instance.creatBitmap("asset.ChristmasAnswerFrame.back2");
         _titleBg = ComponentFactory.Instance.creatBitmap("asset.ChristmasAnswerFrame.titleBg");
         _timeBg = ComponentFactory.Instance.creatBitmap("asset.ChristmasAnswerFrame.timeBg");
         _descBg = ComponentFactory.Instance.creatBitmap("asset.ChristmasAnswerFrame.descBg");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("christmasAnswerFrame.timeTxt");
         _txt = ComponentFactory.Instance.creatComponentByStylename("christmasAnswerFrame.txt");
         _descTxt = ComponentFactory.Instance.creatComponentByStylename("christmasAnswerFrame.descTxt");
         _previewBtn = ComponentFactory.Instance.creatComponentByStylename("christmasAnswerFrame.previewBtn");
         _answerBtn = ComponentFactory.Instance.creatComponentByStylename("christmasAnswerFrame.answerBtn");
         _cdTime = ComponentFactory.Instance.creatBitmap("asset.ChristmasAnswerFrame.cdTime");
         _countBg = ComponentFactory.Instance.creatBitmap("asset.ChristmasAnswerFrame.countBg");
         _countTxt = ComponentFactory.Instance.creatComponentByStylename("christmasAnswerFrame.countTxt");
         _rightTxt = ComponentFactory.Instance.creatComponentByStylename("christmasAnswerFrame.rightTxt");
         _progress = ComponentFactory.Instance.creatCustomObject("christmasAnswerFrame.Progress");
         _cdTxt = ComponentFactory.Instance.creatComponentByStylename("christmasAnswerFrame.cdTxt");
         _questionTxt = ComponentFactory.Instance.creatComponentByStylename("christmasAnswerFrame.questionTxt");
         _answerA = ComponentFactory.Instance.creatComponentByStylename("christmasAnswerFrame.answerA");
         _answerB = ComponentFactory.Instance.creatComponentByStylename("christmasAnswerFrame.answerB");
         _cell = ComponentFactory.Instance.creatCustomObject("christmasAnswerFrame.Cell");
         _btn1 = ComponentFactory.Instance.creatComponentByStylename("christmasAnswerFrame.btn1");
         _btn2 = ComponentFactory.Instance.creatComponentByStylename("christmasAnswerFrame.btn2");
         _sprite1 = new Sprite();
         _sprite2 = new Sprite();
         addToContent(_sprite1);
         addToContent(_sprite2);
         addToContent(_titleBg);
         addToContent(_timeBg);
         addToContent(_timeTxt);
         addToContent(_txt);
         _sprite1.addChild(_back1);
         _sprite1.addChild(_descBg);
         _sprite1.addChild(_descTxt);
         _sprite1.addChild(_previewBtn);
         _previewBtn.icon.x = 34.5;
         _sprite1.addChild(_answerBtn);
         _sprite2.addChild(_back2);
         _sprite2.addChild(_cdTime);
         _sprite2.addChild(_countBg);
         _sprite2.addChild(_countTxt);
         _sprite2.addChild(_rightTxt);
         _sprite2.addChild(_progress);
         _sprite2.addChild(_cdTxt);
         _sprite2.addChild(_btn1);
         _sprite2.addChild(_btn2);
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_btn1);
         _btnGroup.addSelectItem(_btn2);
         _timeTxt.htmlText = LanguageMgr.GetTranslation("ChristmasFrame.timeTxt.text",model.openTimeStr,model.stopTimeStr);
         var _loc1_:Array = ConfigInfoManager.instance.christmasAnswerTime;
         var _loc2_:String = _loc1_[0];
         _loc2_ = _loc2_.replace(",","-");
         var _loc3_:String = _loc1_[1];
         _loc3_ = _loc3_.replace(",","-");
         _txt.htmlText = LanguageMgr.GetTranslation("ChristmasAnswerFrame.txt.text",_loc2_,_loc3_);
         _descTxt.text = LanguageMgr.GetTranslation("ChristmasAnswerFrame.descTxt.text");
         _sprite2.visible = false;
         _progress.gotoAndStop(13);
         initItem();
         _sprite2.addChild(_questionTxt);
         _sprite2.addChild(_answerA);
         _sprite2.addChild(_answerB);
         _sprite2.addChild(_cell);
         _cdTxt.text = DateFormatter.getCountDate(15,2,2);
         _cell.headId = thane.snsInfo.headId;
         _cell.visible = false;
      }
      
      private function initItem() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ChristmasAnswerItem = null;
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = new ChristmasAnswerItem(_loc2_ + 1);
            _loc1_.x = 570 + _loc2_ * 170;
            _loc1_.y = 482;
            _sprite2.addChild(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         ChristmasManager.instance.addEventListener("ANSWER_UPDATE",updateInfoHandler);
         _answerBtn.addEventListener("click",__answerBtnClickHandler);
         _btnGroup.addEventListener("change",__changeHandler);
         _previewBtn.addEventListener("click",__previewBtnClickHandler);
         NotificationManager.instance.addEventListener("REFRESH_TOPTOOLS",__refreshTopToolsHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         ChristmasManager.instance.removeEventListener("ANSWER_UPDATE",updateInfoHandler);
         _answerBtn.removeEventListener("click",__answerBtnClickHandler);
         _btnGroup.removeEventListener("change",__changeHandler);
         _previewBtn.removeEventListener("click",__previewBtnClickHandler);
         NotificationManager.instance.removeEventListener("REFRESH_TOPTOOLS",__refreshTopToolsHandler);
      }
      
      private function __refreshTopToolsHandler(param1:NotificationEvent) : void
      {
         if(!model.isOpen)
         {
            dispose();
         }
      }
      
      private function __previewBtnClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("christmas",11);
      }
      
      private function __changeHandler(param1:Event) : void
      {
         if(_btnGroup.selectIndex == -1)
         {
            return;
         }
         var _loc2_:int = _btnGroup.selectIndex + 1;
         ChristmasManager.instance.opRequest(10,_loc2_);
      }
      
      private function __answerBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc6_:Array = null;
         var _loc2_:Array = ConfigInfoManager.instance.christmasAnswerTime;
         var _loc3_:Array = getTimeArr(_loc2_);
         var _loc4_:Boolean = false;
         var _loc5_:int = 1;
         while(_loc5_ <= _loc3_.length)
         {
            _loc6_ = _loc3_[_loc5_ - 1];
            if(playerModel.sysCurTimeBySecond >= _loc6_[0] && playerModel.sysCurTimeBySecond < _loc6_[1])
            {
               _loc4_ = true;
               break;
            }
            _loc5_++;
         }
         if(_loc4_)
         {
            ChristmasManager.instance.opRequest(8);
            _sprite1.visible = false;
            _sprite2.visible = true;
         }
         else
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChristmasAnswerFrame.time.text"));
         }
      }
      
      private function getTimeArr(param1:Array) : Array
      {
         var _loc3_:int = 0;
         var _loc6_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc7_:Array = [];
         var _loc2_:Date = new Date(playerModel.sysCurtime.fullYear,playerModel.sysCurtime.month,playerModel.sysCurtime.date);
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc6_ = [];
            _loc4_ = param1[_loc3_].split(",");
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length)
            {
               _loc2_.hours = int(_loc4_[_loc5_].split(":")[0]);
               _loc2_.minutes = int(_loc4_[_loc5_].split(":")[1]);
               _loc6_.push(_loc2_.time / 1000);
               _loc5_++;
            }
            _loc7_.push(_loc6_);
            _loc3_++;
         }
         _loc7_.sort(sortByStartTime);
         return _loc7_;
      }
      
      private function sortByStartTime(param1:Array, param2:Array) : int
      {
         var _loc6_:Number = Number(param1[0]);
         var _loc5_:Number = Number(param2[0]);
         var _loc3_:Number = Number(param1[1]);
         var _loc4_:Number = Number(param2[1]);
         if(_loc6_ < _loc5_)
         {
            return -1;
         }
         if(_loc6_ > _loc5_)
         {
            return 1;
         }
         if(_loc3_ < _loc4_)
         {
            return -1;
         }
         return 1;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function updateInfoHandler(param1:NotificationEvent) : void
      {
         _allCount = ConfigInfoManager.instance.christmasAnswerCount;
         var _loc2_:int = _allCount - model.choiceNum;
         if(_loc2_ <= 0)
         {
            _sprite1.visible = true;
            _sprite2.visible = false;
            return;
         }
         _loc2_ = _loc2_ > _allCount ? _allCount : _loc2_;
         _cdTxt.text = DateFormatter.getCountDate(model.surplusSeconds,2,2);
         var _loc3_:ChristmasAnswersTempInfo = TempleteManager.instance.christmasAnswersTempCate.getTemplateByID(model.topicId);
         if(_loc3_)
         {
            _questionTxt.text = _loc3_.Topic;
            _answerA.text = LanguageMgr.GetTranslation("ChristmasAnswerFrame.answer.text",_loc3_.OptionA,model.optionANum);
            _answerB.text = LanguageMgr.GetTranslation("ChristmasAnswerFrame.answer.text",_loc3_.OptionB,model.optionBNum);
         }
         if(model.myOption == 1)
         {
            _cell.visible = true;
            _cell.x = 240;
         }
         else if(model.myOption == 2)
         {
            _cell.visible = true;
            _cell.x = 720;
         }
         else
         {
            _cell.visible = false;
            _btnGroup.selectIndex = -1;
         }
         _countTxt.htmlText = LanguageMgr.GetTranslation("ChristmasAnswerFrame.countTxt.text",_loc2_,_allCount);
         _rightTxt.htmlText = LanguageMgr.GetTranslation("ChristmasAnswerFrame.rightTxt.text",model.choiceRightNum);
         if(model.answerCorrectNum >= 12)
         {
            model.answerCorrectNum = 12;
         }
         if(model.answerCorrectNum == 0)
         {
            model.answerCorrectNum = 13;
         }
         _progress.gotoAndStop(model.answerCorrectNum);
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
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2,0,true);
      }
      
      private function get model() : ChristmasModel
      {
         return ChristmasManager.instance.model;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      override public function dispose() : void
      {
         ChristmasManager.instance.opRequest(15);
         removeEvent();
         ObjectUtils.disposeObject(_back1);
         _back1 = null;
         ObjectUtils.disposeObject(_back2);
         _back2 = null;
         ObjectUtils.disposeObject(_titleBg);
         _titleBg = null;
         ObjectUtils.disposeObject(_timeBg);
         _timeBg = null;
         ObjectUtils.disposeObject(_descBg);
         _descBg = null;
         ObjectUtils.disposeObject(_timeTxt);
         _timeTxt = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         ObjectUtils.disposeObject(_descTxt);
         _descTxt = null;
         ObjectUtils.disposeObject(_previewBtn);
         _previewBtn = null;
         ObjectUtils.disposeObject(_answerBtn);
         _answerBtn = null;
         ObjectUtils.disposeObject(_cdTime);
         _cdTime = null;
         ObjectUtils.disposeObject(_countBg);
         _countBg = null;
         ObjectUtils.disposeObject(_countTxt);
         _countTxt = null;
         ObjectUtils.disposeObject(_rightTxt);
         _rightTxt = null;
         ObjectUtils.disposeViolentMc(_progress);
         _progress = null;
         ObjectUtils.disposeObject(_cdTxt);
         _cdTxt = null;
         ObjectUtils.disposeObject(_questionTxt);
         _questionTxt = null;
         ObjectUtils.disposeObject(_answerA);
         _answerA = null;
         ObjectUtils.disposeObject(_answerB);
         _answerB = null;
         ObjectUtils.disposeObject(_cell);
         _cell = null;
         ObjectUtils.disposeObject(_btn1);
         _btn1 = null;
         ObjectUtils.disposeObject(_btn2);
         _btn2 = null;
         ObjectUtils.disposeObject(_btnGroup);
         _btnGroup = null;
         ObjectUtils.disposeAllChildren(_sprite2);
         _sprite2 = null;
         super.dispose();
      }
   }
}

