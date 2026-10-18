package skyboxroad
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.SkyboxRoadManager;
   import mvc.module.skyboxroad.SkyboxRoadModel;
   import skyboxroad.rank.SkyBoxRoadRankRewardView;
   import skyboxroad.rank.SkyBoxRoadRankView;
   import yishi.datas.ComponentGroupType;
   import yishi.utils.MsgMan;
   
   public class SkyBoxRoadRankFrame extends Frame implements IManualSize
   {
      
      private var _selectedGroup:SelectedButtonGroup;
      
      private var _dayBtn:SelectedIconButton;
      
      private var _weekBtn:SelectedIconButton;
      
      private var _weekAwardBtn:SelectedIconButton;
      
      private var _rankView:SkyBoxRoadRankView;
      
      private var _rankAwardView:SkyBoxRoadRankRewardView;
      
      public function SkyBoxRoadRankFrame()
      {
         super();
         initView();
         addEvent();
         _selectedGroup.selectIndex = 0;
         SkyboxRoadManager.instance.sendRankListRequest();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,563,578);
      }
      
      private function initView() : void
      {
         _dayBtn = ComponentFactory.Instance.creatComponentByStylename("SkyBoxRoadRankFrame.rankDayButton");
         _weekBtn = ComponentFactory.Instance.creatComponentByStylename("SkyBoxRoadRankFrame.rankWeekButton");
         _weekAwardBtn = ComponentFactory.Instance.creatComponentByStylename("SkyBoxRoadRankFrame.rankWeekAwardButton");
         _rankView = ComponentFactory.Instance.creatCustomObject("SkyBoxRoadRankFrame.rankView");
         _rankAwardView = ComponentFactory.Instance.creatCustomObject("SkyBoxRoadRankFrame.rankAwardView");
         addToContent(_rankView);
         addToContent(_rankAwardView);
         addToContent(_dayBtn);
         addToContent(_weekBtn);
         addToContent(_weekAwardBtn);
         _selectedGroup = new SelectedButtonGroup();
         _selectedGroup.addSelectItem(_dayBtn);
         _selectedGroup.addSelectItem(_weekBtn);
         _selectedGroup.addSelectItem(_weekAwardBtn);
         _rankAwardView.visible = false;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _selectedGroup.addEventListener("change",__selectedChangHandler);
         MsgMan.addObserver("SKYBOX_ROAD_RANK_UPDATE",this,__rankListInfo);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _selectedGroup.removeEventListener("change",__selectedChangHandler);
         MsgMan.removeObserver("SKYBOX_ROAD_RANK_UPDATE",this,__rankListInfo);
      }
      
      private function __rankListInfo(param1:String, param2:Object) : void
      {
         _rankView.updateView();
      }
      
      private function __selectedChangHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         switch(_selectedGroup.getSelectedItem())
         {
            case _dayBtn:
               _rankView.visible = true;
               _rankAwardView.visible = false;
               _rankView.tableIndex = 0;
               break;
            case _weekBtn:
               _rankView.visible = true;
               _rankAwardView.visible = false;
               _rankView.tableIndex = 1;
               break;
            case _weekAwardBtn:
               _rankView.visible = false;
               _rankAwardView.visible = true;
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
      
      private function get model() : SkyboxRoadModel
      {
         return SkyboxRoadManager.instance.model;
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("skysecretareaView.rankTitle");
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_dayBtn);
         _dayBtn = null;
         ObjectUtils.disposeObject(_weekBtn);
         _weekBtn = null;
         ObjectUtils.disposeObject(_weekAwardBtn);
         _weekAwardBtn = null;
         ObjectUtils.disposeObject(_rankView);
         _rankView = null;
         ObjectUtils.disposeObject(_rankAwardView);
         _rankAwardView = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

