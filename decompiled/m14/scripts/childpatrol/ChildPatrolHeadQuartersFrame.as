package childpatrol
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import events.ChildPatrolEvent;
   import manager.LanguageMgr;
   import managers.ChildPatrolManager;
   import mvc.module.childpatrol.ChildPatrolModel;
   import mvc.module.childpatrol.ChildPatrolTowerInfo;
   import yishi.datas.ComponentGroupType;
   
   public class ChildPatrolHeadQuartersFrame extends Frame
   {
      
      private var back:MutipleImage;
      
      private var leftView:ChildPatrolLeftListView;
      
      private var towerExpView:ChildPatrolTowerExpView;
      
      private var bottomView:ChildPatrolBottomView;
      
      private var _data:ChildPatrolTowerInfo;
      
      public function ChildPatrolHeadQuartersFrame()
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
         towerExpView = ComponentFactory.Instance.creatCustomObject("ChildPatrolTowerFrame.towerExpView");
         bottomView = ComponentFactory.Instance.creatCustomObject("ChildPatrolTowerFrame.bottomView");
         addToContent(back);
         addToContent(leftView);
         addToContent(towerExpView);
         addToContent(bottomView);
         leftView.frameType = ChildFunType.QATROL;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         ChildPatrolManager.instance.addEventListener("UPDATE_HEADQUARTERS_CHILDPATROL",__refreshHeadQuartersView);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         ChildPatrolManager.instance.removeEventListener("UPDATE_HEADQUARTERS_CHILDPATROL",__refreshHeadQuartersView);
      }
      
      private function __refreshHeadQuartersView(param1:ChildPatrolEvent) : void
      {
         var _loc2_:ChildPatrolTowerInfo = param1.data as ChildPatrolTowerInfo;
         if(model.curSelectTowerInfo && model.curSelectTowerInfo.towerId == _data.towerId)
         {
            data = param1.data as ChildPatrolTowerInfo;
         }
      }
      
      public function set data(param1:ChildPatrolTowerInfo) : void
      {
         _data = param1;
         model.curSelectTowerInfo = _data;
         if(_data)
         {
            if(towerExpView)
            {
               towerExpView.data = _data;
            }
            if(bottomView)
            {
               bottomView.type = ChildFunType.QATROL;
               bottomView.data = _data;
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
      
      private function get model() : ChildPatrolModel
      {
         return ChildPatrolManager.instance.model;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2);
         titleText = LanguageMgr.GetTranslation("childpatrol.ChildPatrolHeadQuartersFrame.titleText");
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
         ChildPatrolManager.instance.model.curSelectTowerInfo = null;
         _data = null;
         super.dispose();
      }
   }
}

