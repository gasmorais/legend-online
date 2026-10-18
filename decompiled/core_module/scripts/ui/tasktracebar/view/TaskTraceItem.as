package ui.tasktracebar.view
{
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.KingContractManager;
   import managers.MopupManager;
   import managers.OfferRewardManager;
   import managers.RingTaskManager;
   import mvc.module.kingcontract.KingContractInfo;
   import mvc.module.marry.MarrySender;
   import mvc.module.marry.MarryTask;
   import mvc.module.offerreward.BaseOfferReward;
   import mvc.module.ringtask.RingTask;
   import mvc.module.task.TaskTemplate;
   import yishi.SwitchPageHelp;
   import yishi.datas.templates.CampaignTemplate;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.OfferRewardConditionTemplate;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class TaskTraceItem extends Component implements Disposeable
   {
      
      public static var index:int = 2;
      
      private var _titleSprite:Sprite;
      
      private var _targetSprite:Sprite;
      
      private var _back1:Scale9CornerImage;
      
      private var _data:Object;
      
      private var _icon:ScaleFrameImage;
      
      private var _title:FilterFrameText;
      
      private var _targetVbox:VBox;
      
      private var _typeBtn:TextButton;
      
      private var _quickBtn:TextButton;
      
      private var _completTxt:String;
      
      private var _handIn:String;
      
      private var _ringNum:FilterFrameText;
      
      private var _flag:Boolean;
      
      private var _targetItemList:Array = [];
      
      public function TaskTraceItem()
      {
         super();
         initVIew();
         initEvent();
         buttonMode = true;
      }
      
      private function initVIew() : void
      {
         _titleSprite = new Sprite();
         _targetSprite = new Sprite();
         _back1 = ComponentFactory.Instance.creatComponentByStylename("taskTrace.ItemBack1");
         _icon = ComponentFactory.Instance.creatComponentByStylename("taskTrace.ItemTitleIcon");
         _title = ComponentFactory.Instance.creatComponentByStylename("taskTrace.ItemTitleTxt");
         _targetVbox = ComponentFactory.Instance.creatComponentByStylename("taskTrace.TargetVbox");
         _ringNum = ComponentFactory.Instance.creatComponentByStylename("taskTrace.ringNum");
         _titleSprite.addChild(_back1);
         _titleSprite.addChild(_icon);
         _titleSprite.addChild(_title);
         _titleSprite.addChild(_ringNum);
         addChild(_titleSprite);
         _targetSprite.x = 17;
         _targetSprite.y = 18;
         _targetSprite.addChild(_targetVbox);
         addChild(_targetSprite);
         _completTxt = LanguageMgr.GetTranslation("buildings.offerreward.data.BaseOfferReward.progress");
         _handIn = LanguageMgr.GetTranslation("YiShi.mainBar.view.TaskTraceItem.HandInText");
         _icon.setFrame(1);
         _back1.visible = false;
         _back1.mouseChildren = false;
      }
      
      private function initEvent() : void
      {
         addEventListener("click",__clickHandler);
         addEventListener("mouseOver",__overHandler);
         addEventListener("mouseOut",__outHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__clickHandler);
         removeEventListener("mouseOver",__overHandler);
         removeEventListener("mouseOut",__outHandler);
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
         _back1.visible = true;
      }
      
      private function __outHandler(param1:MouseEvent) : void
      {
         _back1.visible = false;
      }
      
      private function openTaskFrame() : void
      {
         var _loc1_:String = null;
         if(MopupManager.instance.model.isMopup)
         {
            _loc1_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01");
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         var _loc2_:Frame = FrameControllerManager.instance.taskControler.frame;
         if(!_loc2_)
         {
            FrameControllerManager.instance.openControllerByInfo("task",null,callBack);
         }
         else if(_loc2_.parent)
         {
            _loc2_["selectedByInfo"] = _data;
         }
      }
      
      private function callBack() : void
      {
         var _loc1_:Frame = FrameControllerManager.instance.taskControler.frame;
         if(_loc1_.parent)
         {
            _loc1_["selectedByInfo"] = _data;
         }
      }
      
      private function refresh() : void
      {
         setState();
         refreshCondition();
         refreshView();
      }
      
      private function refreshCondition() : void
      {
         var _loc8_:int = 0;
         var _loc3_:Object = null;
         var _loc5_:Boolean = false;
         var _loc11_:TraceTaskTargetItem = null;
         var _loc1_:String = null;
         var _loc9_:OfferRewardConditionTemplate = null;
         var _loc6_:GoodsTemplateInfo = null;
         var _loc4_:String = null;
         var _loc10_:CampaignTemplate = null;
         _flag = true;
         for each(var _loc2_:TraceTaskTargetItem in _targetItemList)
         {
            if(_loc2_.parent)
            {
               _loc2_.parent.removeChild(_loc2_);
            }
         }
         removeList();
         var _loc7_:Array = _data.getProgress();
         _loc8_ = 0;
         while(_loc8_ < _data.conditionList.length)
         {
            _loc3_ = _data.conditionList[_loc8_];
            _loc5_ = false;
            if(String(_loc7_[_loc8_]) != _completTxt)
            {
               _loc11_ = _targetItemList[_loc8_];
               if(!_loc11_)
               {
                  _loc11_ = new TraceTaskTargetItem();
                  _targetItemList.push(_loc11_);
               }
               if(_data is TaskTemplate)
               {
                  _loc11_.describeWith = 170;
               }
               else
               {
                  _loc11_.describeWith = 115;
               }
               _loc1_ = _loc3_.CondictionTitle;
               if(_data is RingTask)
               {
                  _loc9_ = RingTaskManager.instance.getCurrCondition();
                  if(RingTaskManager.instance.getRingTask())
                  {
                     switch(_loc9_.CondictionType - 18)
                     {
                        case 0:
                           _loc10_ = TempleteManager.instance.getCampaignTemplateById(_data.currTask.condition_2);
                           _loc1_ = _loc1_.replace("{0}",_loc10_.CampaignName);
                           break;
                        case 1:
                           _loc6_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_data.currTask.condition_3);
                           _loc4_ = _loc6_.TemplateName;
                           _loc1_ = _loc1_.replace("{0}",_loc4_);
                     }
                  }
                  else
                  {
                     _loc1_ = LanguageMgr.GetTranslation("ui.tasktracebar.view.TaskTraceItem.taskcontent");
                     _loc11_.describeWith = 170;
                     _loc5_ = true;
                  }
               }
               _loc11_.setCondition(_loc1_);
               if(!_loc5_)
               {
                  _loc11_.setConditionProgress(_loc7_[_loc8_]);
               }
               _targetVbox.addChild(_loc11_);
               _flag = false;
            }
            _loc8_++;
         }
         if(_flag)
         {
            _title.setFrame(2);
            _icon.setFrame(2);
            _title.appendText(_handIn);
            setCompleteEff();
         }
         else
         {
            _icon.setFrame(1);
            _title.setFrame(1);
            _title.text = _title.text.replace(_handIn,"");
         }
      }
      
      private function setState() : void
      {
         var _loc1_:int = 0;
         cleanBtn();
         if(!_data || !_title)
         {
            return;
         }
         if(!_data.Title)
         {
            _loc1_ = 0;
         }
         _title.text = _data.Title;
         tipData = _data;
         if(_data.isCompleted == true)
         {
            return;
         }
         if(_data is TaskTemplate)
         {
            if(_data.TemplateType == 2 || _data.TemplateType == 3 || _data.TemplateType == 4)
            {
               return;
            }
            if(_typeBtn == null)
            {
               _typeBtn = ComponentFactory.Instance.creatComponentByStylename("taskTrace.taskTypeBtn");
               _typeBtn.mouseEnabled = false;
            }
            addChild(_typeBtn);
            _typeBtn.visible = true;
            switch(_data.TemplateType)
            {
               case 0:
                  _typeBtn.text = LanguageMgr.GetTranslation("ui.tasktracebar.view.TaskTraceItem.mainLine");
                  _typeBtn.backgoundInnerRectString = "1,-1,-2,0";
                  _typeBtn.setFrame(1);
                  break;
               case 1:
                  _typeBtn.text = LanguageMgr.GetTranslation("ui.tasktracebar.view.TaskTraceItem.Daily");
                  _typeBtn.backgoundInnerRectString = "-1,-1,-2,0";
                  _typeBtn.setFrame(2);
            }
         }
         else if(_data is BaseOfferReward)
         {
            if(_typeBtn == null)
            {
               _typeBtn = ComponentFactory.Instance.creatComponentByStylename("taskTrace.taskTypeBtn");
               _typeBtn.mouseEnabled = false;
            }
            addChild(_typeBtn);
            _typeBtn.visible = true;
            _typeBtn.text = LanguageMgr.GetTranslation("ui.tasktracebar.view.TaskTraceItem.Reward");
            _typeBtn.backgoundInnerRectString = "3,-1,-2,0";
            _typeBtn.setFrame(3);
            if(_quickBtn == null)
            {
               _quickBtn = ComponentFactory.Instance.creatComponentByStylename("taskTrace.quickBtn");
               _quickBtn.text = LanguageMgr.GetTranslation("ui.tasktracebar.view.TaskTraceItem.CompletedImmediately");
            }
            addChild(_quickBtn);
            _quickBtn.visible = true;
            _quickBtn.addEventListener("click",__onQuickClick);
         }
         else if(_data is RingTask)
         {
            _ringNum.htmlText = "(" + (RingTaskManager.instance.model.rewardNum - 1) + " " + LanguageMgr.GetTranslation("ui.tasktracebar.view.ringTaskNum") + ")";
            if(RingTaskManager.instance.getRingTask())
            {
               if(_typeBtn == null)
               {
                  _typeBtn = ComponentFactory.Instance.creatComponentByStylename("taskTrace.taskTypeBtn");
                  _typeBtn.mouseEnabled = false;
               }
               addChild(_typeBtn);
               _typeBtn.visible = true;
               _typeBtn.text = LanguageMgr.GetTranslation("ui.tasktracebar.view.TaskTraceItem.ring");
               _typeBtn.backgoundInnerRectString = "0,-1,-2,0";
               _typeBtn.setFrame(4);
               if(_quickBtn == null)
               {
                  _quickBtn = ComponentFactory.Instance.creatComponentByStylename("taskTrace.quickBtn");
                  _quickBtn.text = LanguageMgr.GetTranslation("ui.tasktracebar.view.TaskTraceItem.CompletedImmediately");
               }
               addChild(_quickBtn);
               _quickBtn.visible = true;
               _quickBtn.addEventListener("click",__onQuickClick);
               _ringNum.htmlText = "(" + RingTaskManager.instance.model.rewardNum + " " + LanguageMgr.GetTranslation("ui.tasktracebar.view.ringTaskNum") + ")";
            }
            _title.text = _title.text + " " + _ringNum.text;
            _ringNum.visible = false;
            _ringNum.y = _title.y;
         }
      }
      
      private function __onQuickClick(param1:MouseEvent) : void
      {
         param1.stopPropagation();
         if(_data is BaseOfferReward)
         {
            if(kingInfo.leftTime <= 0 && todayNeedAlertForOpenKingContract)
            {
               showKingContractTip();
            }
         }
         else if(_data is RingTask)
         {
            ringTaskQuickHandler();
         }
      }
      
      private function ringTaskQuickHandler() : void
      {
         var _loc9_:TodayNotAlertFrame = null;
         var _loc7_:String = null;
         var _loc2_:String = null;
         var _loc8_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Boolean = true;
         var _loc5_:Boolean = SharedManager.instance.completeRingTaskFlag;
         var _loc1_:Boolean = SharedManager.instance.completeRingTaskUseBind;
         if(_loc5_)
         {
            _loc4_ = false;
         }
         var _loc6_:Array = GoodsManager.instance.getBagGoodsByTemplateId(2131021);
         if(_loc4_)
         {
            _loc9_ = ComponentFactory.Instance.creatComponentByStylename("task.RiverNotAlert");
            _loc7_ = LanguageMgr.GetTranslation("task.TaskFrameII.usePointPrompt",10);
            _loc2_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            if(_loc6_.length <= 0)
            {
               _loc8_ = 10;
            }
            _loc9_.show(_loc7_,_loc2_,quickSubmit,null,"center",1,true,_loc8_);
         }
         else
         {
            _loc3_ = PlayerManager.instance.currentPlayerModel.playerInfo.point;
            if(_loc1_)
            {
               _loc3_ = PlayerManager.instance.currentPlayerModel.playerInfo.allPoint;
            }
            if(_loc3_ >= 10 || _loc6_.length > 0)
            {
               RingTaskManager.instance.CompletedImmediately(_loc1_);
            }
            else
            {
               RechargeAlertMannager.show();
            }
         }
      }
      
      private function quickSubmit(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            SharedManager.instance.completeRingTaskFlag = param1;
            SharedManager.instance.completeRingTaskUseBind = param2;
         }
         var _loc3_:int = PlayerManager.instance.currentPlayerModel.playerInfo.point;
         if(param2)
         {
            _loc3_ = PlayerManager.instance.currentPlayerModel.playerInfo.allPoint;
         }
         var _loc4_:Array = GoodsManager.instance.getBagGoodsByTemplateId(2131021);
         if(_loc3_ >= 10 || _loc4_.length > 0)
         {
            RingTaskManager.instance.CompletedImmediately(param2);
         }
         else
         {
            RechargeAlertMannager.show();
         }
      }
      
      private function cleanBtn() : void
      {
         var _loc1_:int = 0;
         if(_data is RingTask)
         {
            _loc1_ = 0;
         }
         if(_quickBtn && _quickBtn.parent)
         {
            _quickBtn.parent.removeChild(_quickBtn);
         }
         if(_typeBtn && _typeBtn.parent)
         {
            _typeBtn.parent.removeChild(_typeBtn);
         }
         if(_ringNum)
         {
            _ringNum.text = "";
         }
      }
      
      private function refreshView() : void
      {
         var _loc1_:int = _title.numLines;
         _title.height = 20 * _loc1_;
         _targetVbox.y = 17 * (_loc1_ - 1);
         _back1.height = _targetVbox.displayHeight + 39 + 14 * (_loc1_ - 1);
      }
      
      public function tweenMaxByNovice() : void
      {
         _back1.alpha = 1;
         _back1.visible = true;
         TweenMax.to(_back1,0.8,{
            "alpha":0,
            "yoyo":true,
            "repeat":6,
            "onComplete":endShine
         });
      }
      
      private function endShine() : void
      {
         TweenMax.killTweensOf(_back1);
         _back1.alpha = 1;
         _back1.visible = false;
      }
      
      public function setCompleteEff() : void
      {
         if(!_flag)
         {
            return;
         }
         _title.setFrame(TaskTraceItem.index);
         _title.text = _title.text;
      }
      
      private function removeList() : void
      {
         _targetVbox.disposeAllChildren();
         _targetVbox.refreshChildPos();
         _targetVbox.y = 0;
      }
      
      private function clean() : void
      {
         if(_data && _data is TaskTemplate)
         {
            _data.removeEventListener("task_detail_change",__taskChangeHandler);
         }
         else if(_data && _data is BaseOfferReward)
         {
            _data.removeEventListener("REWARD_TASK_UPDATE",__taskChangeHandler);
         }
         else if(_data && _data is RingTask)
         {
            _data.removeEventListener("REFRESHTING",__taskChangeHandler);
         }
         else if(_data is MarryTask)
         {
            MsgMan.removeObserver("MarryEventType.TASK_UPDATE",this,__marryTaskUpdateHandler);
         }
      }
      
      public function set data(param1:Object) : void
      {
         clean();
         _data = param1;
         if(_data)
         {
            if(_data is TaskTemplate)
            {
               _data.addEventListener("task_detail_change",__taskChangeHandler);
            }
            else if(_data is BaseOfferReward)
            {
               _data.addEventListener("REWARD_TASK_UPDATE",__taskChangeHandler);
            }
            else if(_data is RingTask)
            {
               _data.addEventListener("REFRESHTING",__taskChangeHandler);
            }
            else if(_data is MarryTask)
            {
               MsgMan.addObserver("MarryEventType.TASK_UPDATE",this,__marryTaskUpdateHandler);
            }
            refresh();
         }
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      public function getTitle() : FilterFrameText
      {
         return _title;
      }
      
      private function __marryTaskUpdateHandler(param1:String, param2:Object) : void
      {
         __taskChangeHandler(null);
      }
      
      private function __taskChangeHandler(param1:Event) : void
      {
         refresh();
         dispatchEvent(new Event("change"));
      }
      
      private function get kingConInfo() : KingContractInfo
      {
         return KingContractManager.Instance.model.getInfoById(2);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         NotificationManager.instance.sendNotification("NOVICE_ARROW_STATE",{
            "type":0,
            "tip":null
         });
         if(MopupManager.instance.model.isMopup)
         {
            _loc2_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(checkTaskComplete(_data))
         {
            return;
         }
         SwitchPageHelp.skipPageByTaskCondictionType(_data,openTaskFrame);
      }
      
      private function checkTaskComplete(param1:Object) : Boolean
      {
         if(param1 is BaseOfferReward)
         {
            if(param1.isCompleted || kingConInfo.leftTime > 0)
            {
               OfferRewardManager.instance.sendFinishRewardTask(param1.rewardID);
               return true;
            }
         }
         else if(param1 is TaskTemplate)
         {
            if(param1.isCompleted)
            {
               FrameControllerManager.instance.taskControler.sendGetTaskReward(param1.TemplateId,0);
               return true;
            }
         }
         else if(param1 is RingTask)
         {
            if(param1.isCompleted)
            {
               RingTaskManager.instance.submitRingTask();
               return true;
            }
         }
         else if(param1 is MarryTask)
         {
            if(param1.isCompleted)
            {
               MarrySender.opMarryTask(2002);
               return true;
            }
         }
         return false;
      }
      
      private function showKingContractTip() : void
      {
         var _loc2_:TodayNotAlertFrame = ComponentFactory.Instance.creatComponentByStylename("offerreward.view.OfferTaskItem.showKingContractTip");
         var _loc3_:String = LanguageMgr.GetTranslation("offerreward.view.OfferTaskItem.KingContractTip");
         var _loc1_:String = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
         _loc2_.show(_loc3_,_loc1_,__showTipResult,null,"center",2,true);
      }
      
      private function __showTipResult(param1:Boolean) : void
      {
         if(param1)
         {
            SharedManager.instance.openKingContractAlertDate = new Date();
            SharedManager.instance.saveOpenKingContractAlertDate();
         }
         FrameControllerManager.instance.openControllerByInfo("kingcontract");
      }
      
      private function get todayNeedAlertForOpenKingContract() : Boolean
      {
         var _loc2_:Date = null;
         var _loc3_:Boolean = true;
         var _loc1_:Date = SharedManager.instance.openKingContractAlertDate;
         if(_loc1_)
         {
            _loc2_ = new Date();
            if(_loc2_.fullYear == _loc1_.fullYear && _loc2_.month == _loc1_.month && _loc2_.date == _loc1_.date)
            {
               _loc3_ = false;
            }
         }
         return _loc3_;
      }
      
      private function get kingInfo() : KingContractInfo
      {
         return KingContractManager.Instance.model.getInfoById(2);
      }
      
      override public function dispose() : void
      {
         while(_targetItemList && _targetItemList.length > 0)
         {
            ObjectUtils.disposeObject(_targetItemList.pop());
         }
         _targetItemList = null;
         if(_targetVbox)
         {
            removeList();
            _targetVbox.dispose();
            if(_targetVbox.parent)
            {
               _targetVbox.parent.removeChild(_targetVbox);
            }
            _targetVbox = null;
         }
         TweenMax.killTweensOf(_back1);
         removeEvent();
         clean();
         _data = null;
         if(_back1)
         {
            _back1.dispose();
         }
         _back1 = null;
         cleanBtn();
         if(_title)
         {
            _title.dispose();
         }
         _title = null;
         if(_icon)
         {
            _icon.dispose();
         }
         _icon = null;
         ObjectUtils.disposeObject(_quickBtn);
         _quickBtn = null;
         ObjectUtils.disposeObject(_typeBtn);
         _typeBtn = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}

