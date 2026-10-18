package ui.tasktracebar.view
{
   import com.greensock.TweenLite;
   import com.pickgliss.geom.IntPoint;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.SoundManager;
   import events.KingContractEvents;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.clearInterval;
   import flash.utils.clearTimeout;
   import flash.utils.setInterval;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import managers.MarryManager;
   import managers.MopupManager;
   import managers.OfferRewardManager;
   import managers.RingTaskManager;
   import mvc.module.buildings.OfferRewardModel;
   import mvc.module.marry.MarryTask;
   import mvc.module.offerreward.BaseOfferReward;
   import mvc.module.ringtask.RingTask;
   import mvc.module.ringtask.RingTaskModel;
   import mvc.module.task.TaskCategory;
   import mvc.module.task.TaskCondictionTemplate;
   import mvc.module.task.TaskTemplate;
   import yishi.events.NotificationEvent;
   import yishi.events.PlayerEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TaskManage;
   import yishi.scene.SceneManager;
   import yishi.utils.MsgMan;
   import yishi.utils.StringHelper;
   import yishi.view.component.MovieButton;
   import yishi.view.guild.NoviceArrowView;
   import yishi.view.tips.MessageTipManager;
   
   public class TaskTraceView extends Sprite
   {
      
      private var _container:Component;
      
      private var _title:Bitmap;
      
      private var _titleBack:ScaleBitmapImage;
      
      private var _taskBtn:MovieButton;
      
      private var _hideBtn:BaseButton;
      
      private var _taskItemBox:VBox;
      
      private var _traceItemList:Vector.<TaskTraceItem>;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _rect:Rectangle;
      
      private var _isHide:Boolean;
      
      private var _hideHeight:int = 36;
      
      private var _showHeight:int = 300;
      
      private var _totalTxt:FilterFrameText;
      
      private var _totalImage:Bitmap;
      
      private var _totlal:int;
      
      private var _noviceArrow:NoviceArrowView;
      
      private var _noviceArrowShow:Boolean;
      
      private var _refreshTimerId:uint = 0;
      
      private var delayTimeId:int = 0;
      
      public function TaskTraceView()
      {
         super();
         init();
         initEvent();
         delayRefreshView();
      }
      
      public function novicShine() : void
      {
         if(_traceItemList[0])
         {
            _traceItemList[0].tweenMaxByNovice();
         }
      }
      
      private function init() : void
      {
         _traceItemList = new Vector.<TaskTraceItem>();
         _container = ComponentFactory.Instance.creatComponentByStylename("taskTraceView.titleComponent");
         _titleBack = ComponentFactory.Instance.creatComponentByStylename("taskTraceView.titleBack");
         _title = ComponentFactory.Instance.creatBitmap("asset.taskTrace.Title");
         _taskBtn = ComponentFactory.Instance.creatComponentByStylename("taskTrace.TaskBtn");
         _hideBtn = ComponentFactory.Instance.creatComponentByStylename("taskTrace.HideBtn");
         _taskItemBox = ComponentFactory.Instance.creatComponentByStylename("taskTrace.TaskItemVbox");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("taskTrace.ScrollPanel");
         _totalTxt = ComponentFactory.Instance.creatComponentByStylename("taskTrace.TotalTxt");
         _totalImage = ComponentFactory.Instance.creatBitmap("asset.taskTrace.TotalImage");
         _container.tipData = LanguageMgr.GetTranslation("mainBar.view.TaskTraceView.taskBtn");
         _container.buttonMode = true;
         _taskBtn.isPlaying = false;
         _taskBtn.stopEffect();
         _totalTxt.text = "9";
         _scrollPanel.beginChanges();
         _scrollPanel.setView(_taskItemBox);
         _scrollPanel.invalidateViewport();
         _taskItemBox.commitChanges();
         _rect = new Rectangle(-255,-10,457,160);
         _totalTxt.visible = false;
         _totalImage.visible = false;
         initNoviceArrow();
         _container.addChild(_titleBack);
         _titleBack.alpha = 0;
         _container.addChild(_title);
         _container.addChild(_taskBtn);
         _container.addChild(_totalImage);
         _container.addChild(_totalTxt);
         addChild(_container);
         addChild(_hideBtn);
         addChild(_taskItemBox);
         addChild(_scrollPanel);
      }
      
      private function initNoviceArrow() : void
      {
         if(ArmyManager.instance.thane.grades < 20)
         {
            _noviceArrow = new NoviceArrowView(1,LanguageMgr.GetTranslation("yishi.utils.MaskUtils.arrowTipFindPath"),false);
            setArrowPosByTaskTempId();
            NotificationManager.instance.addEventListener("NOVICE_ARROW_STATE",__noviceArrowSwitchHandler);
         }
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
         _titleBack.alpha = 1;
      }
      
      private function __outHandler(param1:MouseEvent) : void
      {
         _titleBack.alpha = 0;
      }
      
      public function getTraceItemByIndex(param1:int) : TaskTraceItem
      {
         var _loc2_:TaskTraceItem = null;
         if(_traceItemList.length > param1)
         {
            return _traceItemList[param1];
         }
         _loc2_ = ComponentFactory.Instance.creatComponentByStylename("ui.tasktracebar.view.TaskTraceItem");
         _traceItemList.push(_loc2_);
         _loc2_.addEventListener("change",__taskChangeHandler);
         _taskItemBox.addChild(_loc2_);
         return _loc2_;
      }
      
      private function resetTraceItemListByLength(param1:int) : void
      {
         var _loc2_:TaskTraceItem = null;
         while(_traceItemList.length > param1)
         {
            _loc2_ = _traceItemList.pop();
            _loc2_.removeEventListener("change",__taskChangeHandler);
            _loc2_.dispose();
         }
      }
      
      private function initEvent() : void
      {
         _container.addEventListener("click",__onTaskAreaClick);
         _container.addEventListener("mouseOver",__overHandler);
         _container.addEventListener("mouseOut",__outHandler);
         cate.addEventListener("task_added",__taskChangeHandler);
         cate.addEventListener("task_remove",__taskFinishHandler);
         TaskManage.instance.addEventListener("task_detail_change",__taskChangeHandler);
         OfferRewardManager.instance.addEventListener("REWARD_TASK_ADD",__taskChangeHandler);
         OfferRewardManager.instance.addEventListener("REWARD_TASK_FINISH",__taskFinishHandler);
         RingTaskManager.instance.addEventListener("REFRESHTING",__taskChangeHandler);
         _hideBtn.addEventListener("click",__onHideBtnHandler);
         NotificationManager.instance.addEventListener("SWITCH_SCENE",__sceneSwitchHandler);
         NotificationManager.instance.addEventListener("UPDATE_KINGCONTRACT",__updateKingContractHandler);
         MsgMan.addObserver("MarryEventType.TASK_UPDATE",this,__marryTaskUpdateHandler);
         ArmyManager.instance.thane.addEventListener("THANE_LEVEL_UPDATE",__thaneLevelUpHandler);
         NotificationManager.instance.addEventListener("SecretAdEvent.updateTaskState",__secretmapHandler);
      }
      
      private function removeEvent() : void
      {
         _container.removeEventListener("click",__onTaskAreaClick);
         _container.removeEventListener("mouseOver",__overHandler);
         _container.removeEventListener("mouseOut",__outHandler);
         cate.removeEventListener("task_added",__taskChangeHandler);
         cate.removeEventListener("task_remove",__taskFinishHandler);
         TaskManage.instance.removeEventListener("task_detail_change",__taskChangeHandler);
         OfferRewardManager.instance.removeEventListener("REWARD_TASK_ADD",__taskChangeHandler);
         OfferRewardManager.instance.removeEventListener("REWARD_TASK_FINISH",__taskFinishHandler);
         RingTaskManager.instance.removeEventListener("REFRESHTING",__taskChangeHandler);
         _hideBtn.removeEventListener("click",__onHideBtnHandler);
         NotificationManager.instance.removeEventListener("SWITCH_SCENE",__sceneSwitchHandler);
         NotificationManager.instance.removeEventListener("NOVICE_ARROW_STATE",__noviceArrowSwitchHandler);
         NotificationManager.instance.removeEventListener("UPDATE_KINGCONTRACT",__updateKingContractHandler);
         MsgMan.removeObserver("MarryEventType.TASK_UPDATE",this,__marryTaskUpdateHandler);
         ArmyManager.instance.thane.removeEventListener("THANE_LEVEL_UPDATE",__thaneLevelUpHandler);
         NotificationManager.instance.removeEventListener("SecretAdEvent.updateTaskState",__secretmapHandler);
      }
      
      private function __marryTaskUpdateHandler(param1:String, param2:Object) : void
      {
         delayRefreshView();
      }
      
      private function __thaneLevelUpHandler(param1:PlayerEvent) : void
      {
         RingTaskManager.instance.updateRingTaskMsg();
      }
      
      private function __updateKingContractHandler(param1:KingContractEvents) : void
      {
         delayRefreshView();
      }
      
      private function __secretmapHandler(param1:NotificationEvent) : void
      {
         delayRefreshView();
      }
      
      private function __taskFinishHandler(param1:Event) : void
      {
         delayRefreshView();
      }
      
      private function __taskChangeHandler(param1:Event) : void
      {
         delayRefreshView();
      }
      
      private function __onTaskAreaClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         SoundManager.instance.play("022");
         if(MopupManager.instance.model.isMopup)
         {
            _loc2_ = LanguageMgr.GetTranslation("mopup.MopupManager.mopupTipData01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("task");
      }
      
      private function __sceneSwitchHandler(param1:NotificationEvent) : void
      {
         var _loc2_:String = SceneManager.instance.currentType;
         if(_loc2_ != "CAMPAIGN_MAP_SCENE")
         {
            noviceArrowByState({
               "type":0,
               "tip":LanguageMgr.GetTranslation("yishi.utils.MaskUtils.arrowTipNextStep")
            });
         }
      }
      
      private function __noviceArrowSwitchHandler(param1:NotificationEvent) : void
      {
         noviceArrowByState(param1.data);
      }
      
      private function noviceArrowByState(param1:Object) : void
      {
         if(!_noviceArrow)
         {
            return;
         }
         if(ArmyManager.instance.thane.grades >= 20)
         {
            NotificationManager.instance.removeEventListener("NOVICE_ARROW_STATE",__noviceArrowSwitchHandler);
            _noviceArrow.dispose();
            _noviceArrow = null;
            _noviceArrowShow = false;
            return;
         }
         if(!StringHelper.isNullOrEmpty(param1["tip"]))
         {
            _noviceArrow.tip = param1["tip"];
         }
         else
         {
            _noviceArrow.tip = LanguageMgr.GetTranslation("yishi.utils.MaskUtils.arrowTipFindPath");
         }
         switch(param1["type"])
         {
            case 1:
               if(!_noviceArrow.parent)
               {
                  if(!_isHide)
                  {
                     addChild(_noviceArrow);
                     setArrowPosByTaskTempId();
                  }
                  _noviceArrow.showTween();
                  _noviceArrow.playEffect();
                  _noviceArrowShow = true;
               }
               break;
            case 0:
               _noviceArrow.stopEffect();
               if(_noviceArrow.parent)
               {
                  _noviceArrow.parent.removeChild(_noviceArrow);
               }
               _noviceArrowShow = false;
         }
      }
      
      private function __onHideBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         if(param1)
         {
            param1.stopPropagation();
         }
         _isHide = !_isHide;
         if(_isHide)
         {
            _totalImage.visible = true;
            _totalTxt.visible = true;
            _loc3_ = -307;
            _hideBtn.scaleX = -1;
            this.buttonMode = true;
            TweenLite.to(_hideBtn,0.5,{"x":150});
            TweenLite.to(_rect,0.5,{
               "x":_loc3_,
               "height":_hideHeight,
               "onUpdate":updateRec
            });
            if(_noviceArrow && _noviceArrow.parent)
            {
               _noviceArrow.parent.removeChild(_noviceArrow);
            }
         }
         else
         {
            _totalImage.visible = false;
            _totalTxt.visible = false;
            _loc3_ = -255;
            _hideBtn.scaleX = 1;
            this.buttonMode = false;
            TweenLite.to(_hideBtn,0.5,{"x":184});
            TweenLite.to(_rect,0.5,{
               "x":_loc3_,
               "height":_showHeight,
               "onUpdate":updateRec
            });
            if(_noviceArrowShow && _noviceArrow)
            {
               addChild(_noviceArrow);
            }
         }
      }
      
      private function updateRec() : void
      {
         scrollRect = _rect;
         if(_isHide)
         {
            _titleBack.x = -62;
            _titleBack.width = 194;
         }
         else
         {
            _titleBack.x = -62;
            _titleBack.width = 248;
         }
      }
      
      private function get cate() : TaskCategory
      {
         return TaskManage.instance.cate;
      }
      
      private function clean() : void
      {
         _taskItemBox.beginChanges();
         _taskItemBox.removeAllChild();
         _taskItemBox.refreshChildPos();
         _taskItemBox.commitChanges();
      }
      
      private function delayRefreshView() : void
      {
         if(delayTimeId)
         {
            clearTimeout(delayTimeId);
         }
         delayTimeId = 0;
         delayTimeId = setTimeout(refreshView,20);
      }
      
      private function refreshView() : void
      {
         var _loc2_:TaskTraceItem = null;
         var _loc8_:int = 0;
         if(delayTimeId)
         {
            clearTimeout(delayTimeId);
         }
         delayTimeId = 0;
         if(PlayerManager.instance.newbieProcess >= 19000 && PlayerManager.instance.isExistNewbieMask)
         {
            if(_refreshTimerId == 0)
            {
               _refreshTimerId = setInterval(checkRefreshCall,50);
            }
            return;
         }
         var _loc1_:Array = [];
         if(MarryManager.instance.model.hasAccessList.getList().length > 0)
         {
            for each(var _loc10_:MarryTask in MarryManager.instance.model.hasAccessList.getList())
            {
               _loc1_.push(_loc10_);
            }
         }
         if(RingTaskManager.instance.getRingTask())
         {
            for each(var _loc9_:RingTask in ringTaskModel.hasAccessList.getList())
            {
               _loc1_.push(_loc9_);
            }
         }
         else
         {
            for each(var _loc3_:RingTask in RingTaskManager.instance._defaultList)
            {
               _loc1_.push(_loc3_);
            }
         }
         var _loc6_:Array = cate.acceptedList;
         for each(var _loc11_:TaskTemplate in _loc6_)
         {
            _loc1_.push(_loc11_);
         }
         _loc6_ = rewardModel.baseRewardDic.getList();
         for each(var _loc5_:BaseOfferReward in _loc6_)
         {
            _loc1_.push(_loc5_);
         }
         var _loc7_:int = 0;
         _loc7_ = 0;
         while(_loc7_ < _loc1_.length)
         {
            _loc1_[_loc7_].sortFlag = _loc1_[_loc7_].isCompleted;
            _loc7_++;
         }
         _loc1_.sortOn(["sortFlag","changeDate","TemplateType","Sort"],[2,2 | 0x10,16,16]);
         _loc7_ = 0;
         while(_loc7_ < _loc1_.length)
         {
            if(_loc1_[_loc7_] is TaskTemplate)
            {
               for each(var _loc4_:TaskCondictionTemplate in _loc1_[_loc7_].conditionList)
               {
                  if(_loc4_.CondictionType == 48)
                  {
                     setMobileToTop(_loc1_,_loc7_);
                  }
               }
            }
            _loc7_++;
         }
         _totlal = _loc1_.length;
         resetTraceItemListByLength(_totlal);
         _totalTxt.text = _totlal.toString();
         _loc8_ = 0;
         while(_loc8_ < _totlal)
         {
            _loc2_ = getTraceItemByIndex(_loc8_);
            _loc2_.data = _loc1_[_loc8_];
            _loc8_++;
         }
         _scrollPanel.beginChanges();
         _scrollPanel.vScrollbar.scrollValue = 0;
         _taskItemBox.refreshChildPos();
         _scrollPanel.invalidateViewport();
         setHideView();
      }
      
      private function checkRefreshCall() : void
      {
         if(PlayerManager.instance.isExistNewbieMask == false)
         {
            clearInterval(_refreshTimerId);
            _refreshTimerId = 0;
            delayRefreshView();
         }
      }
      
      private function setMobileToTop(param1:Array, param2:int) : void
      {
         var _loc3_:* = 0;
         var _loc4_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            if(param1[_loc4_].isCompleted == false)
            {
               _loc3_ = _loc4_;
               break;
            }
            _loc4_++;
         }
         var _loc5_:TaskTemplate = param1[param2] as TaskTemplate;
         param1.splice(param2,1);
         if(_loc5_.isCompleted == false)
         {
            param1.splice(_loc3_,0,_loc5_);
         }
         else
         {
            param1.splice(0,0,_loc5_);
         }
      }
      
      private function setHideView() : void
      {
         if(!_isHide)
         {
            _rect.height = _showHeight;
         }
         updateRec();
         if(cate.hasCompletedTask() || rewardModel.hasCompletedTask)
         {
            if(_isHide)
            {
               __onHideBtnHandler(null);
            }
         }
      }
      
      public function getTraceItemByTaskTempId(param1:int) : TaskTraceItem
      {
         for each(var _loc2_:TaskTraceItem in _traceItemList)
         {
            if(_loc2_.data)
            {
               switch(_loc2_.data["TemplateType"])
               {
                  case -3:
                     if(_loc2_.data["marryTaskTemp"]["TemplateId"] == param1)
                     {
                        return _loc2_;
                     }
                  case -2:
                     if(_loc2_.data["currTaskId"] == param1)
                     {
                        return _loc2_;
                     }
                     break;
                  case -1:
                     if(_loc2_.data["rewardID"] == param1)
                     {
                        return _loc2_;
                     }
                     break;
                  default:
                     if(_loc2_.data["taskId"] == param1)
                     {
                        return _loc2_;
                     }
               }
            }
         }
         return null;
      }
      
      public function scrollToItemByTaskTempId(param1:int) : void
      {
         var _loc3_:IntPoint = null;
         if(!_scrollPanel || !_scrollPanel.viewPort)
         {
            return;
         }
         var _loc2_:TaskTraceItem = getTraceItemByTaskTempId(param1);
         if(_loc2_)
         {
            _loc3_ = new IntPoint();
            _loc3_.x = _loc2_.x > 0 ? _loc2_.x : 0;
            _loc3_.y = _loc2_.y > 0 ? _loc2_.y : 0;
            _scrollPanel.viewPort.viewPosition = _loc3_;
         }
      }
      
      public function setArrowPosByTaskTempId(param1:int = 0) : void
      {
         var _loc2_:TaskTraceItem = null;
         var _loc3_:Point = null;
         if(!_noviceArrow)
         {
            return;
         }
         if(param1 <= 0)
         {
            _noviceArrow.x = -253;
            _noviceArrow.y = 15;
         }
         else
         {
            if(!_noviceArrow.parent)
            {
               return;
            }
            _loc2_ = getTraceItemByTaskTempId(param1);
            if(_loc2_ && _loc2_.parent)
            {
               _loc3_ = new Point(_loc2_.x,_loc2_.y);
               _loc3_ = _loc2_.parent.localToGlobal(_loc3_);
               _loc3_ = _noviceArrow.parent.globalToLocal(_loc3_);
               _noviceArrow.x = -253;
               _noviceArrow.y = _loc3_.y - 10;
            }
         }
      }
      
      public function transferShine() : void
      {
         var _loc1_:TaskTraceItem = getTraceItemByTaskTempId(757);
         if(_loc1_)
         {
            _loc1_.tweenMaxByNovice();
         }
      }
      
      private function sortComplete(param1:TaskTemplate, param2:TaskTemplate) : int
      {
         if(param1.isCompleted && !param2.isCompleted)
         {
            return -1;
         }
         if(!param1.isCompleted && param2.isCompleted)
         {
            return 1;
         }
         return 0;
      }
      
      public function getTaskItem1_title() : FilterFrameText
      {
         if(_traceItemList[0])
         {
            return _traceItemList[0].getTitle();
         }
         return null;
      }
      
      public function get taskBtn() : MovieButton
      {
         return _taskBtn;
      }
      
      private function get rewardModel() : OfferRewardModel
      {
         return OfferRewardManager.instance.model;
      }
      
      private function get ringTaskModel() : RingTaskModel
      {
         return RingTaskManager.instance.model;
      }
   }
}

