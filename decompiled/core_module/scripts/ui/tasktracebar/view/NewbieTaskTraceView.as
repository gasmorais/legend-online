package ui.tasktracebar.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mainBar.effects.MainToolBtnGlowEffect;
   import manager.LanguageMgr;
   import mvc.module.task.TaskCategory;
   import mvc.module.task.TaskTemplate;
   import yishi.SwitchPageHelp;
   import yishi.events.NotificationEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.TaskManage;
   import yishi.utils.StringHelper;
   
   public class NewbieTaskTraceView extends Sprite implements Disposeable
   {
      
      private var _bg:Bitmap;
      
      private var _taskItemBox:VBox;
      
      private var _traceItemList:Vector.<TaskTraceItem>;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _continueBtn:TextButton;
      
      private var _titleTxt:FilterFrameText;
      
      private var _noviceArrow:MovieClip;
      
      private var _noviceArrowShow:Boolean;
      
      private var _shineEffect:MainToolBtnGlowEffect;
      
      private var _isFirst:Boolean = true;
      
      public function NewbieTaskTraceView()
      {
         super();
         initView();
         initEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _traceItemList = new Vector.<TaskTraceItem>();
         _bg = ComponentFactory.Instance.creatBitmap("asset.taskTrace.NewbieBg");
         _bg.x = -50;
         _taskItemBox = ComponentFactory.Instance.creatComponentByStylename("taskTrace.TaskItemVbox");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("taskTrace.ScrollPanel");
         _continueBtn = ComponentFactory.Instance.creatComponentByStylename("tasktracebar.NewbieContinueBtn");
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("tasktracebar.NewbieTitleTxt");
         _titleTxt.text = LanguageMgr.GetTranslation("ui.tasktracebar.view.NewbieTaskTraceView.title");
         _scrollPanel.setView(_taskItemBox);
         _scrollPanel.x = 75;
         _scrollPanel.y = 55;
         initNoviceArrow();
         addChild(_bg);
         addChild(_titleTxt);
         addChild(_taskItemBox);
         addChild(_scrollPanel);
         addChild(_continueBtn);
      }
      
      private function initNoviceArrow() : void
      {
         if(ArmyManager.instance.thane.grades < 20)
         {
            _noviceArrow = ComponentFactory.Instance.creatCustomObject("tasktracebar.NewbieArrow");
            NotificationManager.instance.addEventListener("NOVICE_ARROW_STATE",__noviceArrowSwitchHandler);
         }
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
         taskCate.addEventListener("task_added",__taskChangeHandler);
         TaskManage.instance.addEventListener("task_detail_change",__taskChangeHandler);
         _continueBtn.addEventListener("click",__onContinueClick);
      }
      
      private function removeEvent() : void
      {
         taskCate.removeEventListener("task_added",__taskChangeHandler);
         TaskManage.instance.removeEventListener("task_detail_change",__taskChangeHandler);
         _continueBtn.removeEventListener("click",__onContinueClick);
         NotificationManager.instance.removeEventListener("NOVICE_ARROW_STATE",__noviceArrowSwitchHandler);
      }
      
      private function __taskChangeHandler(param1:Event) : void
      {
         refreshView();
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
            ObjectUtils.disposeObject(_noviceArrow);
            _noviceArrow = null;
            _noviceArrowShow = false;
            return;
         }
         if(!StringHelper.isNullOrEmpty(param1["tip"]))
         {
            _noviceArrow["arrow"]["tip"].text = param1["tip"];
         }
         else
         {
            _noviceArrow["arrow"]["tip"].text = LanguageMgr.GetTranslation("yishi.utils.MaskUtils.arrowTipFindPath");
         }
         switch(param1["type"])
         {
            case 1:
               if(!_noviceArrow.parent)
               {
                  addChild(_noviceArrow);
                  _noviceArrow.play();
                  _noviceArrowShow = true;
                  if(_isFirst)
                  {
                     _isFirst = false;
                     _shineEffect = new MainToolBtnGlowEffect(_continueBtn);
                     _shineEffect.play();
                  }
               }
               break;
            case 0:
               _noviceArrow.stop();
               if(_noviceArrow.parent)
               {
                  _noviceArrow.parent.removeChild(_noviceArrow);
               }
               _noviceArrowShow = false;
         }
      }
      
      private function __onContinueClick(param1:MouseEvent) : void
      {
         NotificationManager.instance.sendNotification("NOVICE_ARROW_STATE",{
            "type":0,
            "tip":null
         });
         if(_shineEffect)
         {
            _shineEffect.dispose();
         }
         _shineEffect = null;
         var _loc2_:TaskTemplate = firstMainTask;
         if(!_loc2_)
         {
            return;
         }
         if(_loc2_.isCompleted)
         {
            FrameControllerManager.instance.taskControler.sendGetTaskReward(_loc2_.TemplateId,0);
         }
         else
         {
            SwitchPageHelp.skipPageByTaskCondictionType(_loc2_,null);
         }
      }
      
      private function get firstMainTask() : TaskTemplate
      {
         return TaskManage.instance.cate.mainTaskList[0];
      }
      
      private function get taskCate() : TaskCategory
      {
         return TaskManage.instance.cate;
      }
      
      private function refreshView() : void
      {
         var _loc2_:TaskTraceItem = null;
         var _loc6_:int = 0;
         var _loc1_:Array = [];
         var _loc4_:Array = taskCate.acceptedList;
         for each(var _loc7_:TaskTemplate in _loc4_)
         {
            _loc1_.push(_loc7_);
         }
         var _loc3_:int = int(_loc1_.length);
         var _loc5_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc1_[_loc5_].sortFlag = _loc1_[_loc5_].isCompleted;
            _loc5_++;
         }
         _loc1_.sortOn(["sortFlag","changeDate","TemplateType","Sort"],[2,2 | 0x10,16,16]);
         resetTraceItemListByLength(_loc3_);
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc2_ = getTraceItemByIndex(_loc6_);
            _loc2_.data = _loc1_[_loc6_];
            _loc6_++;
         }
         _scrollPanel.beginChanges();
         _scrollPanel.vScrollbar.scrollValue = 0;
         _taskItemBox.refreshChildPos();
         _scrollPanel.invalidateViewport();
         if(firstMainTask && firstMainTask.isCompleted)
         {
            _continueBtn.text = LanguageMgr.GetTranslation("ui.tasktracebar.view.NewbieTaskTraceView.finishTask");
         }
         else
         {
            _continueBtn.text = LanguageMgr.GetTranslation("ui.tasktracebar.view.NewbieTaskTraceView.continueTask");
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_taskItemBox);
         _taskItemBox = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         ObjectUtils.disposeObject(_continueBtn);
         _continueBtn = null;
         ObjectUtils.disposeObject(_titleTxt);
         _titleTxt = null;
         ObjectUtils.disposeObject(_noviceArrow);
         _noviceArrow = null;
         ObjectUtils.disposeObject(_shineEffect);
         _shineEffect = null;
         if(_traceItemList)
         {
            _traceItemList.length = 0;
         }
         _traceItemList = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

