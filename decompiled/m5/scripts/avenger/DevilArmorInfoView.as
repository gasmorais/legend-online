package avenger
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.ModuleFrameInfo;
   import mvc.module.avenger.AvengerModel;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.VersionSwitch;
   import yishi.manager.ArmyManager;
   import yishi.manager.AvengerManager;
   
   public class DevilArmorInfoView extends Frame implements IManualSize
   {
      
      private var _currentFrame:DevilArmorLookInfoFrame;
      
      private var _selfFrame:DevilArmorLookInfoFrame;
      
      public function DevilArmorInfoView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _currentFrame = ComponentFactory.Instance.creatComponentByStylename("playerinfo.devilArmorFrame");
         _currentFrame.titleText = LanguageMgr.GetTranslation("playerinfo.devilArmorFrame.title1");
         addChild(_currentFrame);
      }
      
      private function initEvent() : void
      {
         if(_currentFrame)
         {
            _currentFrame.addEventListener("response",__frameResponse);
         }
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
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
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
         if((_currentFrame == null || Boolean(_currentFrame.isDie)) && (_selfFrame == null || Boolean(_selfFrame.isDie)))
         {
            dispose();
         }
      }
      
      public function get viewRectangle() : Rectangle
      {
         if(VersionSwitch.AVENGER && Boolean(ArmyManager.instance.thane.isAvenger) && Boolean(VersionSwitch.DEVIL_ARMOR))
         {
            return new Rectangle(0,0,850,417);
         }
         return new Rectangle(0,0,405,417);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      public function show(param1:ModuleFrameInfo) : void
      {
         if(param1 && param1.frameData)
         {
            _currentFrame.data = (param1.frameData as AvengerModel).devilArmorInfo;
            if(VersionSwitch.AVENGER && Boolean(ArmyManager.instance.thane.isAvenger) && Boolean(VersionSwitch.DEVIL_ARMOR))
            {
               _selfFrame = ComponentFactory.Instance.creatComponentByStylename("playerinfo.devilArmorFrame");
               _selfFrame.titleText = LanguageMgr.GetTranslation("playerinfo.devilArmorFrame.title2");
               _selfFrame.data = AvengerManager.instance.model.devilArmorInfo;
               addChild(_selfFrame);
               _selfFrame.x = 440;
               if(_selfFrame)
               {
                  _selfFrame.addEventListener("response",__frameResponse);
               }
            }
         }
         LayerManager.Instance.addToLayer(this,3,true,true,1);
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
   }
}

