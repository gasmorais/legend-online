package ancientartifact
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
   import mvc.module.ancientartifact.AncientArtifactInfo;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.playerinfo.ArtifactThaneInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.AncientArtifactManager;
   import yishi.manager.ArmyManager;
   
   public class AncientEquipView extends Frame implements IManualSize
   {
      
      private var _currentFrame:AncientEquipFrame;
      
      private var _selfFrame:AncientEquipFrame;
      
      public function AncientEquipView()
      {
         super();
         initView();
         initEvent();
      }
      
      private static function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function initView() : void
      {
         _currentFrame = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.AncientEquipFrame");
         _currentFrame.titleText = LanguageMgr.GetTranslation("ancientartifact.AncientEquipFrame.titleText");
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
               this.x = (StageReferance.gameStageWidth - 593) / 2;
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
         if(thane.vocationGrades > 0 && info)
         {
            return new Rectangle(0,0,1226,505);
         }
         return new Rectangle(0,0,593,505);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      public function show(param1:ArtifactThaneInfo) : void
      {
         if(param1)
         {
            _currentFrame.data = param1;
            if(thane.vocationGrades > 0 && info)
            {
               _selfFrame = ComponentFactory.Instance.creatComponentByStylename("ancientartifact.AncientEquipFrame");
               _selfFrame.titleText = LanguageMgr.GetTranslation("ancientartifact.AncientEquipFrame.titleText1");
               _selfFrame.data = null;
               addChild(_selfFrame);
               _selfFrame.x = 633;
               if(_selfFrame)
               {
                  _selfFrame.addEventListener("response",__frameResponse);
               }
            }
         }
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function get info() : AncientArtifactInfo
      {
         return AncientArtifactManager.instance.model.getEquipArtifactInfo();
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

