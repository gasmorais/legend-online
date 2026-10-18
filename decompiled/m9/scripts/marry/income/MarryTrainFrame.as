package marry.income
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.ModuleFrameInfo;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class MarryTrainFrame extends Frame implements IManualSize
   {
      
      private var _marryRingButton:SelectedIconButton;
      
      private var _satisfactoryButton:SelectedIconButton;
      
      private var _currentSelectedBtn:SelectedIconButton;
      
      private var _marrySatisfactoryRateView:MarrySatisfactoryRateView;
      
      private var _marryRingView:MarryRingUpgradeView;
      
      public function MarryTrainFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,843,530);
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("marry.income.MarryTrainFrame.title");
         _marryRingButton = ComponentFactory.Instance.creatComponentByStylename("marry.marryRingButton");
         _satisfactoryButton = ComponentFactory.Instance.creatComponentByStylename("marry.satisfactoryButton");
         addToContent(_marryRingButton);
         addToContent(_satisfactoryButton);
      }
      
      private function initEvent() : void
      {
         _marryRingButton.addEventListener("click",__switchPanelHandler);
         _satisfactoryButton.addEventListener("click",__switchPanelHandler);
         this.addEventListener("response",__frameResponse);
      }
      
      private function __switchPanelHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _marryRingButton.selected = false;
         _satisfactoryButton.selected = false;
         var _loc2_:SelectedIconButton = param1.currentTarget as SelectedIconButton;
         _loc2_.selected = true;
         if(_currentSelectedBtn == _loc2_)
         {
            return;
         }
         switch(_loc2_)
         {
            case _marryRingButton:
               if(!_marryRingView)
               {
                  _marryRingView = new MarryRingUpgradeView();
                  addToContentAt(_marryRingView,0);
               }
               _marryRingView.visible = true;
               if(_marrySatisfactoryRateView)
               {
                  _marrySatisfactoryRateView.visible = false;
               }
               break;
            case _satisfactoryButton:
               if(!_marrySatisfactoryRateView)
               {
                  _marrySatisfactoryRateView = new MarrySatisfactoryRateView();
                  addToContentAt(_marrySatisfactoryRateView,0);
               }
               if(_marryRingView)
               {
                  _marryRingView.visible = false;
               }
               _marrySatisfactoryRateView.visible = true;
         }
      }
      
      private function __onHelperBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("marry.marryTrainHelpFrame");
         _loc2_.show();
      }
      
      public function show(param1:ModuleFrameInfo) : void
      {
         setDefaultPanel();
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      private function setDefaultPanel() : void
      {
         _satisfactoryButton.dispatchEvent(new MouseEvent("click"));
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
      
      private function removeEvent() : void
      {
         this.removeEventListener("response",__frameResponse);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_marryRingView);
         _marryRingView = null;
         ObjectUtils.disposeObject(_marrySatisfactoryRateView);
         _marrySatisfactoryRateView = null;
         if(_marryRingButton)
         {
            _marryRingButton.dispose();
         }
         _marryRingButton = null;
         if(_satisfactoryButton)
         {
            _satisfactoryButton.dispose();
         }
         _satisfactoryButton = null;
         super.dispose();
      }
   }
}

