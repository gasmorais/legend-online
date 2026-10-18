package room.view.pve.instance
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import events.InstanceEvent;
   import manager.LanguageMgr;
   import managers.RoomManager;
   import mvc.module.room.RoomInfo;
   import mvc.module.selectcampaign.CampaignLandInfo;
   import room.net.RoomSocketOuterManager;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.CampaignTemplateManager;
   
   public class InstanceSelectFrame extends Frame implements Disposeable
   {
      
      private var _model:RoomInfo;
      
      private var _leftView:InstanceLeftView;
      
      private var _rightView:InstanceRightView;
      
      public function InstanceSelectFrame()
      {
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         _leftView = ComponentFactory.Instance.creatCustomObject("room.InstanceLeftView");
         _rightView = ComponentFactory.Instance.creatCustomObject("room.InstanceRightView");
         addToContent(_leftView);
         addToContent(_rightView);
         titleText = LanguageMgr.GetTranslation("room.view.pve.instance.InstanceSelectFrame.title");
         escEnable = true;
      }
      
      private function initEvents() : void
      {
         addEventListener("response",__response);
         _leftView.addEventListener("select_instance",__selectInstance);
         _rightView.addEventListener("confirm_instance",__confireInstance);
         _rightView.addEventListener("close_instance_frame",__closeFrame);
         _rightView.addEventListener("dont_select_instance",__dontSelect);
      }
      
      private function removeEvents() : void
      {
         removeEventListener("response",__response);
         _leftView.removeEventListener("select_instance",__selectInstance);
         _rightView.removeEventListener("confirm_instance",__confireInstance);
         _rightView.removeEventListener("close_instance_frame",__closeFrame);
         _rightView.removeEventListener("dont_select_instance",__dontSelect);
      }
      
      private function __response(param1:FrameEvent) : void
      {
         if(param1.responseCode == 1 || param1.responseCode == 0)
         {
            ObjectUtils.disposeObject(this);
         }
      }
      
      private function __confireInstance(param1:InstanceEvent) : void
      {
         model.selectedMapTemplate = param1.selectedMapInfo;
         var _loc2_:int = int(RoomManager.instance.roomInfo.id);
         RoomSocketOuterManager.updateRoomInfo(_loc2_,model.selectedMapTemplate.DungeonId,model.selectedMapTemplate.CampaignId);
      }
      
      private function __selectInstance(param1:InstanceEvent) : void
      {
         _rightView.selectedAreaInfo = param1.selectedAreaInfo;
      }
      
      private function __closeFrame(param1:InstanceEvent) : void
      {
         ObjectUtils.disposeObject(this);
      }
      
      private function __dontSelect(param1:InstanceEvent) : void
      {
         _leftView.palyInstanceItem();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      public function set model(param1:RoomInfo) : void
      {
         _model = param1;
         _leftView.landInfo = CampaignTemplateManager.instance.landDic[0] as CampaignLandInfo;
      }
      
      public function get model() : RoomInfo
      {
         return _model;
      }
      
      public function getInstanceItemByIndex(param1:int) : InstanceItem
      {
         return _leftView.getInstanceItem(param1);
      }
      
      public function onlyOpenOneItemInNovice() : void
      {
         _leftView.onlyOpenOneItemInNovice();
      }
      
      public function get rightView() : InstanceRightView
      {
         return _rightView;
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvents();
         if(_leftView)
         {
            ObjectUtils.disposeObject(_leftView);
         }
         _leftView = null;
         if(_rightView)
         {
            ObjectUtils.disposeObject(_rightView);
         }
         _rightView = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

