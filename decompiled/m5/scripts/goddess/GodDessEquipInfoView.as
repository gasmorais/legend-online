package goddess
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
   import managers.GodDessManager;
   import mvc.ModuleFrameInfo;
   import mvc.module.goddess.GoddessInfo;
   import yishi.datas.ComponentGroupType;
   
   public class GodDessEquipInfoView extends Frame implements IManualSize
   {
      
      private var _currentFrame:GodDessEquipLookInfoFrame;
      
      private var _selfFrame:GodDessEquipLookInfoFrame;
      
      public function GodDessEquipInfoView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _currentFrame = ComponentFactory.Instance.creatComponentByStylename("playerinfo.GodDessEquipLookInfoFrame");
         _currentFrame.titleText = LanguageMgr.GetTranslation("playerinfo.GodDessEquipLookInfoFrame.title1");
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
         if(GodDessManager.instance.model.fightGoddess)
         {
            return new Rectangle(0,0,806,551);
         }
         return new Rectangle(0,0,403,551);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      public function show(param1:ModuleFrameInfo) : void
      {
         if(param1 && param1.frameData)
         {
            _currentFrame.data = param1.frameData as GoddessInfo;
            if(GodDessManager.instance.model.fightGoddess)
            {
               _selfFrame = ComponentFactory.Instance.creatComponentByStylename("playerinfo.GodDessEquipLookInfoFrame");
               _selfFrame.titleText = LanguageMgr.GetTranslation("playerinfo.GodDessEquipLookInfoFrame.title2");
               _selfFrame.data = GodDessManager.instance.model.fightGoddess;
               addChild(_selfFrame);
               _selfFrame.x = 420;
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

