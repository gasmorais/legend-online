package theseusgodhead.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import managers.TheseussoulManager;
   import theseusgodhead.item.TheseusGodheadTaskItem;
   import yishi.datas.templates.TheseusSlateTaskInfo;
   import yishi.events.NotificationEvent;
   
   public class TheseusGodheadTaskView extends Sprite
   {
      
      private var _taskList:Vector.<TheseusSlateTaskInfo>;
      
      private var _taskItems:Vector.<TheseusGodheadTaskItem>;
      
      private var _vBox:VBox;
      
      private var _panel:ScrollPanel;
      
      public function TheseusGodheadTaskView()
      {
         super();
         initData();
         initView();
         initEvent();
      }
      
      private function initData() : void
      {
         _taskList = new Vector.<TheseusSlateTaskInfo>();
         _taskItems = new Vector.<TheseusGodheadTaskItem>();
         var _loc1_:Array = TheseussoulManager.Instance.modelGodhead.getSlateTasks();
         if(_loc1_ && _loc1_.length > 0)
         {
            for each(var _loc2_:TheseusSlateTaskInfo in _loc1_)
            {
               _taskList.push(_loc2_);
            }
            _taskList.sort(sortNumbers);
         }
      }
      
      private function sortNumbers(param1:TheseusSlateTaskInfo, param2:TheseusSlateTaskInfo) : Number
      {
         if(param1.state == 1 && param2.state != 1)
         {
            return -1;
         }
         if(param1.state != 1 && param2.state == 1)
         {
            return 1;
         }
         if(param1.state == 2 && param2.state != 2)
         {
            return 1;
         }
         if(param1.state != 2 && param2.state == 2)
         {
            return -1;
         }
         return param1.TemplateId - param2.TemplateId;
      }
      
      private function initView() : void
      {
         var _loc1_:TheseusGodheadTaskItem = null;
         _vBox = ComponentFactory.Instance.creatComponentByStylename("theseusgodhead.taskVBox");
         _panel = ComponentFactory.Instance.creatComponentByStylename("theseusgodhead.taskPanel");
         for each(var _loc2_:TheseusSlateTaskInfo in _taskList)
         {
            _loc1_ = new TheseusGodheadTaskItem();
            _loc1_.info = _loc2_;
            _vBox.addChild(_loc1_);
            _taskItems.push(_loc1_);
         }
         _panel.setView(_vBox);
         addChild(_panel);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         TheseussoulManager.Instance.addEventListener("EVENT_SLATE_UPDATE",_onSlateUpdate);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         TheseussoulManager.Instance.removeEventListener("EVENT_SLATE_UPDATE",_onSlateUpdate);
      }
      
      private function refreshTaskList() : void
      {
         var _loc1_:int = 0;
         if(_taskList)
         {
            _taskList.sort(sortNumbers);
         }
         _loc1_ = 0;
         while(_loc1_ < _taskItems.length)
         {
            if(_loc1_ < _taskList.length)
            {
               _taskItems[_loc1_].info = _taskList[_loc1_];
            }
            _loc1_++;
         }
      }
      
      private function _onSlateUpdate(param1:NotificationEvent) : void
      {
         refreshTaskList();
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
      
      public function dispose() : void
      {
         removeEvent();
         for each(var _loc1_:TheseusGodheadTaskItem in _taskItems)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _taskItems = null;
         _taskList = null;
         ObjectUtils.disposeObject(_vBox);
         ObjectUtils.disposeObject(_panel);
      }
   }
}

