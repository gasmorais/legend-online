package theseus
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.VersionSwitch;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.RoyaltyBossManager;
   
   public class TheseusOtherFrame extends Frame implements IManualSize
   {
      
      private var _currentFrame:ThereusLookEquipFrame;
      
      private var _selfFrame:ThereusLookEquipFrame;
      
      public function TheseusOtherFrame()
      {
         super();
         TheseussoulManager.Instance.doSomething(1);
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         var _loc1_:Boolean = RoyaltyBossManager.instance.model.royaltyLevel > 0;
         _loc1_ = _loc1_ && Boolean(VersionSwitch.THESESOUL) && ArmyManager.instance.thane.vocationIndex > 0;
         if(_loc1_)
         {
            return new Rectangle(0,0,850,522);
         }
         return new Rectangle(0,0,405,522);
      }
      
      private function initView() : void
      {
         _currentFrame = ComponentFactory.Instance.creatComponentByStylename("playerinfo.ThereusLookEquipFrame",[0]);
         _currentFrame.titleText = LanguageMgr.GetTranslation("playerinfo.theseusFrame.title1");
         _selfFrame = ComponentFactory.Instance.creatComponentByStylename("playerinfo.ThereusLookEquipFrame",[1]);
         _selfFrame.titleText = LanguageMgr.GetTranslation("playerinfo.theseusFrame.title2");
         _selfFrame.x = 440;
         addToContent(_currentFrame);
         addToContent(_selfFrame);
      }
      
      private function initEvent() : void
      {
         if(_currentFrame)
         {
            _currentFrame.addEventListener("response",__frameResponse);
         }
         if(_selfFrame)
         {
            _selfFrame.addEventListener("response",__frameResponse);
         }
         TheseussoulManager.Instance.addEventListener("EVENT_YI_UPDATE",yiUpdateHandler);
         TheseussoulManager.Instance.addEventListener("EVENT_WAR_EQUIP",warListInfoHandler);
      }
      
      private function removeEvent() : void
      {
         if(_currentFrame)
         {
            _currentFrame.removeEventListener("response",__frameResponse);
         }
         if(_selfFrame)
         {
            _selfFrame.removeEventListener("response",__frameResponse);
         }
         TheseussoulManager.Instance.removeEventListener("EVENT_YI_UPDATE",yiUpdateHandler);
         TheseussoulManager.Instance.removeEventListener("EVENT_WAR_EQUIP",warListInfoHandler);
      }
      
      private function yiUpdateHandler(param1:Event) : void
      {
         updateSelf();
      }
      
      private function warListInfoHandler(param1:Event) : void
      {
         updateSelf();
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               if(_selfFrame)
               {
                  _selfFrame.x = 0;
               }
               ObjectUtils.disposeObject(param1.currentTarget);
               this.x = (StageReferance.gameStageWidth - 405) / 2;
         }
         if(_currentFrame && !_currentFrame.isDie)
         {
            StageReferance.stage.focus = _currentFrame;
         }
         if(_selfFrame && !_selfFrame.isDie)
         {
            StageReferance.stage.focus = _selfFrame;
         }
         if((_currentFrame == null || Boolean(_currentFrame.isDie)) && (_selfFrame == null || Boolean(_selfFrame.isDie) || !_selfFrame.visible))
         {
            dispose();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_currentFrame);
         _currentFrame = null;
         ObjectUtils.disposeObject(_selfFrame);
         _selfFrame = null;
         super.dispose();
      }
      
      public function updateSelfFrame(param1:int) : void
      {
         if(_selfFrame.isDie)
         {
            _selfFrame = ComponentFactory.Instance.creatComponentByStylename("playerinfo.ThereusLookEquipFrame",[1]);
            _selfFrame.titleText = LanguageMgr.GetTranslation("playerinfo.theseusFrame.title2");
            _selfFrame.x = 440;
            addToContent(_selfFrame);
            this.x = (StageReferance.gameStageWidth - 810) / 2;
            if(_selfFrame)
            {
               _selfFrame.addEventListener("response",__frameResponse);
            }
         }
         updateSelf();
         if(_selfFrame.visible)
         {
            _selfFrame.btnGroup.selectIndex = param1;
         }
      }
      
      public function show(param1:ThaneInfo) : void
      {
         if(param1)
         {
            _currentFrame.initData(param1);
            updateSelf();
         }
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function updateSelf() : void
      {
         if(!thane.theseusInfo)
         {
            thane.theseusInfo = TheseussoulManager.Instance.model;
         }
         if(!thane.warSoulInfo)
         {
            thane.warSoulInfo = TheseussoulManager.Instance.warsoulModel;
         }
         if(_selfFrame)
         {
            _selfFrame.initData(thane);
            updateSelfShow();
         }
      }
      
      private function updateSelfShow() : void
      {
         var _loc1_:Boolean = RoyaltyBossManager.instance.model.royaltyLevel > 0;
         _loc1_ = _loc1_ && Boolean(VersionSwitch.THESESOUL) && thane.vocationIndex > 0;
         _loc1_ &&= _currentFrame.btnGroup.selectIndex != 2;
         _selfFrame.visible = _loc1_;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
   }
}

