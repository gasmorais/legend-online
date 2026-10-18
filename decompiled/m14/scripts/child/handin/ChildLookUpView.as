package child.handin
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
   import managers.ChildManager;
   import mvc.ModuleFrameInfo;
   import mvc.module.children.ChildData;
   import mvc.module.children.ChildModel;
   import yishi.datas.ComponentGroupType;
   
   public class ChildLookUpView extends Frame implements IManualSize
   {
      
      private var _currentFrame:ChildLookUpFrame;
      
      private var _selfFrame:ChildLookUpFrame;
      
      public function ChildLookUpView()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         if(ChildManager.instance.model.getEnterWar())
         {
            return new Rectangle(0,0,800,442);
         }
         return new Rectangle(0,0,400,442);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _currentFrame = ComponentFactory.Instance.creatComponentByStylename("child.enterWarChildFrame");
         _currentFrame.isSelf = false;
         _currentFrame.titleText = LanguageMgr.GetTranslation("ThaneAttributeTip.child01");
         _currentFrame.isEnterWar = false;
         addChild(_currentFrame);
         if(ChildManager.instance.model.getEnterWar())
         {
            _selfFrame = ComponentFactory.Instance.creatComponentByStylename("child.enterWarChildFrame");
            _selfFrame.titleText = LanguageMgr.GetTranslation("ThaneAttributeTip.child02");
            _selfFrame.isSelf = true;
            _selfFrame.isEnterWar = true;
            addChild(_selfFrame);
            _selfFrame.x = 452;
         }
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
      
      private function set data(param1:ChildData) : void
      {
         if(_currentFrame)
         {
            _currentFrame.data = param1;
         }
         if(_selfFrame)
         {
            _selfFrame.data = ChildManager.instance.model.getEnterWar();
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
               this.x = (StageReferance.gameStageWidth - 400) / 2;
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
      
      public function show(param1:ModuleFrameInfo) : void
      {
         if(param1)
         {
            data = param1.frameData as ChildData;
         }
         if(param1.frameData.isSelfData)
         {
            _currentFrame.titleText = LanguageMgr.GetTranslation("ThaneAttributeTip.child01");
            if(_selfFrame)
            {
               _selfFrame.titleText = LanguageMgr.GetTranslation("ThaneAttributeTip.child02");
            }
         }
         else
         {
            _currentFrame.titleText = LanguageMgr.GetTranslation("ThaneAttributeTip.child03");
            if(_selfFrame)
            {
               _selfFrame.titleText = LanguageMgr.GetTranslation("ThaneAttributeTip.child04");
            }
         }
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function get childModel() : ChildModel
      {
         return ChildManager.instance.model;
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

