package yishi.view.community
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import managers.MopupManager;
   import managers.OfferRewardManager;
   import managers.RingTaskManager;
   import mvc.module.marry.MarrySender;
   import mvc.module.marry.MarryTask;
   import mvc.module.offerreward.BaseOfferReward;
   import mvc.module.ringtask.RingTask;
   import mvc.module.task.TaskTemplate;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   
   public class CompleteTaskTip extends Sprite implements Disposeable
   {
      
      private var _taskIcon:ScaleFrameImage;
      
      private var _newTaskMc:MovieClip;
      
      private var _commitText:FilterFrameText;
      
      private var _title:FilterFrameText;
      
      private var _timerId:uint;
      
      private var _taskInfo:Object;
      
      public var isMouseOver:Boolean;
      
      public function CompleteTaskTip(param1:Object)
      {
         super();
         _taskInfo = param1;
         initView();
      }
      
      private function initView() : void
      {
         setClickEnable(false);
         _newTaskMc = ComponentFactory.Instance.creatCustomObject("asset.taskextra.TaskCompleteEffect");
         _taskIcon = ComponentFactory.Instance.creatComponentByStylename("taskextra.TaskIcon");
         _title = ComponentFactory.Instance.creatComponentByStylename("taskextra.Title");
         _commitText = ComponentFactory.Instance.creatComponentByStylename("taskextra.CommitText");
         _newTaskMc.gotoAndStop(1);
         _newTaskMc.mouseEnabled = _newTaskMc.mouseChildren = false;
         _commitText.text = LanguageMgr.GetTranslation("yishi.view.CompleteTaskTip.commitText.text");
         addChild(_newTaskMc);
      }
      
      private function uninit() : void
      {
         clearTimeout(_timerId);
         ObjectUtils.disposeObject(_newTaskMc);
         _newTaskMc = null;
         ObjectUtils.disposeObject(_commitText);
         _commitText = null;
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_taskIcon);
         _taskIcon = null;
         _taskInfo = null;
      }
      
      private function addEvent() : void
      {
         addEventListener("addedToStage",__onAdded);
         this.addEventListener("click",__onClickHandler);
         this.addEventListener("rollOver",__mouseOverHandler);
         this.addEventListener("rollOut",__mouseOutHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("addedToStage",__onAdded);
         this.removeEventListener("click",__onClickHandler);
         this.removeEventListener("rollOver",__mouseOverHandler);
         this.removeEventListener("rollOut",__mouseOutHandler);
      }
      
      private function __mouseOverHandler(param1:MouseEvent) : void
      {
         isMouseOver = true;
      }
      
      private function __mouseOutHandler(param1:MouseEvent) : void
      {
         isMouseOver = false;
      }
      
      public function get commitText() : FilterFrameText
      {
         return _commitText;
      }
      
      private function __onClickHandler(param1:MouseEvent) : void
      {
         if(!_taskInfo || MopupManager.instance.model.isMopup)
         {
            dispose();
            return;
         }
         if(_taskInfo is TaskTemplate)
         {
            FrameControllerManager.instance.taskControler.sendGetTaskReward(_taskInfo.TemplateId,0);
         }
         else if(_taskInfo is BaseOfferReward)
         {
            OfferRewardManager.instance.sendFinishRewardTask(_taskInfo.rewardID);
         }
         else if(_taskInfo is RingTask)
         {
            RingTaskManager.instance.submitRingTask();
         }
         else if(_taskInfo is MarryTask)
         {
            MarrySender.opMarryTask(2002);
         }
         dispose();
      }
      
      public function show() : void
      {
         addEvent();
         LayerManager.Instance.addToLayer(this,2,false,false);
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function __onAdded(param1:Event) : void
      {
         removeEventListener("addedToStage",__onAdded);
         if(!_commitText.parent)
         {
            _newTaskMc["back"].addChild(_commitText);
         }
         if(!_title.parent)
         {
            _newTaskMc["back"].addChild(_title);
         }
         if(!_taskIcon.parent)
         {
            _newTaskMc["back"].addChild(_taskIcon);
         }
         buttonMode = true;
         refreshView();
         if(_newTaskMc)
         {
            _newTaskMc.gotoAndPlay(1);
         }
         _timerId = setTimeout(setClickEnable,1000,true);
      }
      
      private function setClickEnable(param1:Boolean) : void
      {
         clearTimeout(_timerId);
         this.mouseEnabled = this.mouseChildren = param1;
      }
      
      private function refreshView() : void
      {
         if(!_taskInfo)
         {
            dispose();
            return;
         }
         if(_taskInfo is TaskTemplate)
         {
            switch(_taskInfo.TemplateType)
            {
               case 0:
                  _title.text = LanguageMgr.GetTranslation("yishi.view.CompleteTaskTip.title0",_taskInfo.Title);
                  break;
               case 1:
                  _title.text = LanguageMgr.GetTranslation("yishi.view.CompleteTaskTip.title1",_taskInfo.Title);
                  break;
               case 2:
                  _title.text = LanguageMgr.GetTranslation("yishi.view.CompleteTaskTip.title2",_taskInfo.Title);
                  break;
               case 3:
                  _title.text = LanguageMgr.GetTranslation("yishi.view.CompleteTaskTip.title3",_taskInfo.Title);
               case 4:
                  _title.text = LanguageMgr.GetTranslation("yishi.view.CompleteTaskTip.title6",_taskInfo.Title);
            }
            _taskIcon.setFrame(1);
         }
         else if(_taskInfo is BaseOfferReward)
         {
            _title.text = LanguageMgr.GetTranslation("yishi.view.CompleteTaskTip.title4",_taskInfo.Title);
            _taskIcon.setFrame(2);
         }
         else if(_taskInfo is RingTask)
         {
            _title.text = LanguageMgr.GetTranslation("yishi.view.CompleteTaskTip.title5",_taskInfo.Title);
            _taskIcon.setFrame(1);
         }
         else if(_taskInfo is MarryTask)
         {
            _title.text = LanguageMgr.GetTranslation("yishi.view.community.CompleteTaskTip.MarryTaskTitle",_taskInfo.Title);
            _taskIcon.setFrame(1);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninit();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

