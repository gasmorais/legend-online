package childpatrol
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import events.ChildPatrolEvent;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.ChildPatrolManager;
   import mvc.module.childpatrol.ChildPatrolModel;
   import mvc.module.childpatrol.ChildPatrolTowerInfo;
   import yishi.datas.ComponentGroupType;
   
   public class ChildPatrolTowerFrame extends Frame
   {
      
      private var back:MutipleImage;
      
      private var leftView:ChildPatrolLeftListView;
      
      private var taskView:ChildPatrolTaskView;
      
      private var towerExpView:ChildPatrolTowerExpView;
      
      private var exploreView:ChildPatrolExploreView;
      
      private var bottomView:ChildPatrolBottomView;
      
      private var levelUpBtn:SelectedIconButton;
      
      private var taskBtn:SelectedIconButton;
      
      private var exploreBtn:SelectedIconButton;
      
      private var btnGrounp:SelectedButtonGroup;
      
      private var _data:ChildPatrolTowerInfo;
      
      public function ChildPatrolTowerFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         back = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolTowerFrame.back");
         leftView = ComponentFactory.Instance.creatCustomObject("ChildPatrolTowerFrame.leftView");
         taskView = ComponentFactory.Instance.creatCustomObject("ChildPatrolTowerFrame.taskView");
         towerExpView = ComponentFactory.Instance.creatCustomObject("ChildPatrolTowerFrame.towerExpView");
         exploreView = ComponentFactory.Instance.creatCustomObject("ChildPatrolTowerFrame.ChildPatrolExploreView");
         bottomView = ComponentFactory.Instance.creatCustomObject("ChildPatrolTowerFrame.bottomView");
         taskBtn = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolTowerFrame.taskBtn");
         levelUpBtn = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolTowerFrame.levelUpBtn");
         exploreBtn = ComponentFactory.Instance.creatComponentByStylename("ChildPatrolTowerFrame.exploreBtn");
         addToContent(back);
         addToContent(taskBtn);
         addToContent(levelUpBtn);
         addToContent(exploreBtn);
         addToContent(leftView);
         addToContent(towerExpView);
         towerExpView.visible = false;
         addToContent(taskView);
         taskView.visible = true;
         addToContent(exploreView);
         exploreView.visible = false;
         addToContent(bottomView);
         bottomView.type = 3;
         leftView.frameType = 3;
         btnGrounp = new SelectedButtonGroup();
         btnGrounp.addSelectItem(taskBtn);
         btnGrounp.addSelectItem(levelUpBtn);
         btnGrounp.addSelectItem(exploreBtn);
         btnGrounp.selectIndex = 0;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         btnGrounp.addEventListener("change",__btnChangeHandler);
         ChildPatrolManager.instance.addEventListener("UPDATE_TOWERINFO_CHILDPATROL",__refreshTowerView);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         btnGrounp.removeEventListener("change",__btnChangeHandler);
         ChildPatrolManager.instance.removeEventListener("UPDATE_TOWERINFO_CHILDPATROL",__refreshTowerView);
      }
      
      private function __refreshTowerView(param1:ChildPatrolEvent) : void
      {
         var _loc2_:Array = param1.data as Array;
         if(model.curSelectTowerInfo)
         {
            for each(var _loc3_:ChildPatrolTowerInfo in _loc2_)
            {
               if(model.curSelectTowerInfo.towerId == _loc3_.towerId)
               {
                  data = _loc3_;
               }
            }
         }
      }
      
      private function __btnChangeHandler(param1:Event) : void
      {
         if(btnGrounp.selectIndex == 1)
         {
            towerExpView.visible = true;
            taskView.visible = false;
            exploreView.visible = false;
            bottomView.type = ChildFunType.UP_LEVEL;
            leftView.frameType = ChildFunType.UP_LEVEL;
         }
         else if(btnGrounp.selectIndex == 0)
         {
            towerExpView.visible = false;
            taskView.visible = true;
            exploreView.visible = false;
            bottomView.type = ChildFunType.TASK;
            leftView.frameType = ChildFunType.TASK;
         }
         else if(btnGrounp.selectIndex == 2)
         {
            towerExpView.visible = false;
            taskView.visible = false;
            exploreView.visible = true;
            bottomView.type = ChildFunType.EXPLORE;
            leftView.frameType = ChildFunType.EXPLORE;
         }
         if(bottomView)
         {
            bottomView.data = _data;
         }
         if(towerExpView)
         {
            towerExpView.data = _data;
         }
         if(taskView)
         {
            taskView.data = _data;
         }
         if(exploreView)
         {
            exploreView.data = _data;
         }
         leftView.refreshListView();
      }
      
      public function set data(param1:ChildPatrolTowerInfo) : void
      {
         _data = param1;
         model.curSelectTowerInfo = _data;
         if(_data)
         {
            titleText = LanguageMgr.GetTranslation("childpatrol.ChildPatrolTowerFrame.titleText") + _data.towerId;
            if(bottomView)
            {
               bottomView.data = _data;
            }
            if(towerExpView)
            {
               towerExpView.data = _data;
            }
            if(taskView)
            {
               taskView.data = _data;
            }
            if(exploreView)
            {
               exploreView.data = _data;
            }
            leftView.refreshListView();
         }
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
         LayerManager.Instance.addToLayer(this,3,true,true,2);
      }
      
      private function get model() : ChildPatrolModel
      {
         return ChildPatrolManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(back)
         {
            ObjectUtils.disposeObject(back);
         }
         back = null;
         if(leftView)
         {
            ObjectUtils.disposeObject(leftView);
         }
         leftView = null;
         if(taskView)
         {
            ObjectUtils.disposeObject(taskView);
         }
         taskView = null;
         if(exploreView)
         {
            ObjectUtils.disposeObject(exploreView);
         }
         exploreView = null;
         if(towerExpView)
         {
            ObjectUtils.disposeObject(towerExpView);
         }
         towerExpView = null;
         if(bottomView)
         {
            ObjectUtils.disposeObject(bottomView);
         }
         bottomView = null;
         if(levelUpBtn)
         {
            ObjectUtils.disposeObject(levelUpBtn);
         }
         levelUpBtn = null;
         if(taskBtn)
         {
            ObjectUtils.disposeObject(taskBtn);
         }
         taskBtn = null;
         if(exploreBtn)
         {
            ObjectUtils.disposeObject(exploreBtn);
         }
         taskBtn = null;
         btnGrounp = null;
         ChildPatrolManager.instance.model.curSelectTowerInfo = null;
         super.dispose();
      }
   }
}

