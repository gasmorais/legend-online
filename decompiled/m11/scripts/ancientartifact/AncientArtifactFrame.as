package ancientartifact
{
   import ancientartifact.view.AncientArtifactList;
   import ancientartifact.view.AncientMiddleView;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.ancientartifact.AncientArtifactModel;
   import yishi.datas.VersionSwitch;
   import yishi.manager.AncientArtifactManager;
   
   public class AncientArtifactFrame extends Frame implements IManualSize
   {
      
      private var _back:DisplayObject;
      
      private var _bg:DisplayObject;
      
      private var _propertyBtn:SelectedIconButton;
      
      private var _advancedBtn:SelectedIconButton;
      
      private var _resonateBtn:SelectedIconButton;
      
      private var _tabGroup:SelectedButtonGroup;
      
      private var _listView:AncientArtifactList;
      
      private var _middleView:AncientMiddleView;
      
      private var _currentView:Component;
      
      public function AncientArtifactFrame()
      {
         super();
         initView();
         addEvent();
         _tabGroup.selectIndex = 0;
         AncientArtifactManager.instance.OperateArtifactReq(AncientArtifactManager.OPEN);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,846,565);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("ancientartifact.AncientArtifactFrame.titleText");
         _back = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.bgBorder");
         _bg = ComponentFactory.Instance.creatBitmap("asset.ancientartifact.middleBg");
         _propertyBtn = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.PropertyBtn");
         _advancedBtn = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.AdvancedBtn");
         _resonateBtn = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.resonateBtn");
         _listView = ComponentFactory.Instance.creatCustomObject("ancientartifact.AncientArtifactList");
         _middleView = ComponentFactory.Instance.creatCustomObject("ancientartifact.AncientMiddleView");
         _tabGroup = new SelectedButtonGroup();
         _tabGroup.addSelectItem(_propertyBtn);
         _tabGroup.addSelectItem(_advancedBtn);
         addToContent(_propertyBtn);
         addToContent(_advancedBtn);
         if(VersionSwitch.ARMORY_AND_RESONATE_SHOW)
         {
            _tabGroup.addSelectItem(_resonateBtn);
            addToContent(_resonateBtn);
         }
         addToContent(_back);
         addToContent(_bg);
         addToContent(_listView);
         addToContent(_middleView);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _tabGroup.addEventListener("change",__panelChangeHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_tabGroup)
         {
            _tabGroup.removeEventListener("change",__panelChangeHandler);
         }
      }
      
      private function __panelChangeHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         ObjectUtils.disposeObject(_currentView);
         _currentView = null;
         var _loc2_:Boolean = false;
         AncientArtifactManager.instance.isDrag = false;
         model.currentArmoryIndx = 0;
         if(_tabGroup.selectIndex == 0)
         {
            _currentView = ComponentFactory.Instance.creatCustomObject("ancientartifact.AncientPropertyView");
         }
         else if(_tabGroup.selectIndex == 1)
         {
            _currentView = ComponentFactory.Instance.creatCustomObject("ancientartifact.AncientStrengthenView");
         }
         else if(_tabGroup.selectIndex == 2)
         {
            _loc2_ = true;
            AncientArtifactManager.instance.isDrag = true;
            _currentView = ComponentFactory.Instance.creatCustomObject("ancientartifact.AncientArmoryView");
         }
         addToContent(_currentView);
         _listView.selectDispatchEvent();
         _bg.visible = !_loc2_;
         _middleView.visible = !_loc2_;
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
      
      private function get model() : AncientArtifactModel
      {
         return AncientArtifactManager.instance.model;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,0,0,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_tabGroup);
         _tabGroup = null;
         ObjectUtils.disposeObject(_propertyBtn);
         _propertyBtn = null;
         ObjectUtils.disposeObject(_advancedBtn);
         _advancedBtn = null;
         ObjectUtils.disposeObject(_resonateBtn);
         _resonateBtn = null;
         ObjectUtils.disposeObject(_listView);
         _listView = null;
         ObjectUtils.disposeObject(_middleView);
         _middleView = null;
         ObjectUtils.disposeObject(_currentView);
         _currentView = null;
         super.dispose();
      }
   }
}

