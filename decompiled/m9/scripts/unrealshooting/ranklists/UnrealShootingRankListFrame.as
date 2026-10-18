package unrealshooting.ranklists
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import yishi.keyboard.KeyBoardRegister;
   
   public class UnrealShootingRankListFrame extends Frame implements IManualSize
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _rankBtn:SelectedIconButton;
      
      private var _rewardBtn:SelectedIconButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _rankView:UnrealShootingRankView;
      
      private var _rewardView:UnrealShootingRewardView;
      
      public function UnrealShootingRankListFrame()
      {
         super();
         initView();
         addEvent();
         _btnGroup.selectIndex = 0;
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,655,560);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingRankListFrame.bg");
         _rankBtn = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingRankListFrame.rankBtn");
         _rewardBtn = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingRankListFrame.rewardBtn");
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_rankBtn);
         _btnGroup.addSelectItem(_rewardBtn);
         addToContent(_bg);
         addToContent(_rankBtn);
         addToContent(_rewardBtn);
         titleText = LanguageMgr.GetTranslation("unrealshooting.UnrealShootingRankListFrame.title");
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_rankBtn);
         _rankBtn = null;
         ObjectUtils.disposeObject(_rewardBtn);
         _rewardBtn = null;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _btnGroup.addEventListener("change",__btnSelectedHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _btnGroup.removeEventListener("change",__btnSelectedHandler);
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
      
      private function __btnSelectedHandler(param1:Event) : void
      {
         var _loc2_:SelectedIconButton = _btnGroup.getSelectedItem() as SelectedIconButton;
         switch(_loc2_)
         {
            case _rankBtn:
               if(_rewardView != null)
               {
                  _rewardView.visible = false;
               }
               if(_rankView == null)
               {
                  _rankView = ComponentFactory.Instance.creatCustomObject("unrealshooting.UnrealShootingRankView");
                  addToContent(_rankView);
               }
               _rankView.visible = true;
               break;
            case _rewardBtn:
               if(_rankView != null)
               {
                  _rankView.visible = false;
               }
               if(_rewardView == null)
               {
                  _rewardView = ComponentFactory.Instance.creatCustomObject("unrealshooting.UnrealShootingRewardView");
                  addToContent(_rewardView);
               }
               _rewardView.visible = true;
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         if(isDie)
         {
            return;
         }
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

