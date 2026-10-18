package dragontitan
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
   import managers.DragonTitanManager;
   import mvc.ModuleFrameInfo;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   
   public class DragonTitanInfoView extends Frame implements IManualSize
   {
      
      private var _currentFrame:DragonTitanInfoFrame;
      
      private var _selfFrame:DragonTitanInfoFrame;
      
      public function DragonTitanInfoView()
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
         _currentFrame = ComponentFactory.Instance.creatComponentByStylename("dragontitan.DragonTitanInfoFrame");
         _currentFrame.titleText = LanguageMgr.GetTranslation("dragontitan.DragonTitanFrame.title");
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
               this.x = (StageReferance.gameStageWidth - 403) / 2;
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
         if(thane.isChangeJob && DragonTitanManager.instance.model.templateId > 0)
         {
            return new Rectangle(0,0,846,495);
         }
         return new Rectangle(0,0,403,495);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         _currentFrame.data = FrameControllerManager.instance.dragonTitanControler.titanData;
         if(thane.isChangeJob && DragonTitanManager.instance.model.templateId > 0)
         {
            _selfFrame = ComponentFactory.Instance.creatComponentByStylename("dragontitan.DragonTitanInfoFrame");
            _selfFrame.titleText = LanguageMgr.GetTranslation("dragontitan.DragonTitanFrame.title1");
            addChild(_selfFrame);
            _selfFrame.x = 443;
            if(_selfFrame)
            {
               _selfFrame.addEventListener("response",__frameResponse);
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

