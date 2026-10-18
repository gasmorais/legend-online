package oldplayerreturn
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.oldplayerreturn.OldPlayerReturnModel;
   import oldplayerreturn.alliance.OldPlayerReturnAllianceView;
   import oldplayerreturn.milestone.OldPlayerReturnMilestoneView;
   import oldplayerreturn.shop.OldPlayerReturnShopView;
   import oldplayerreturn.task.OldPlayerReturnTaskView;
   import yishi.datas.ComponentGroupType;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.OldPlayerReturnManager;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class OldPlayerReturnFrame extends Frame implements IManualSize
   {
      
      private var _border:Scale9CornerImage;
      
      private var _bg:Bitmap;
      
      private var _line:Bitmap;
      
      private var _taskBtn:SelectedTextButton;
      
      private var _allianceBtn:SelectedTextButton;
      
      private var _milestoneBtn:SelectedTextButton;
      
      private var _shopBtn:SelectedTextButton;
      
      private var _group:SelectedButtonGroup;
      
      private var _taskView:OldPlayerReturnTaskView;
      
      private var _allianceView:OldPlayerReturnAllianceView;
      
      private var _milestoneView:OldPlayerReturnMilestoneView;
      
      private var _shopView:OldPlayerReturnShopView;
      
      private var _vBox:VBox;
      
      private var _helpBtn:BaseButton;
      
      public function OldPlayerReturnFrame()
      {
         super();
         initView();
         addEvent();
         _group.selectIndex = 0;
         refreshView();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,895,575);
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("oldPlayerReturnFrame.titleText.text1");
         _border = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnFrame.border");
         _bg = ComponentFactory.Instance.creatBitmap("asset.OldPlayerReturnFrame.leftBg");
         _line = ComponentFactory.Instance.creatBitmap("asset.OldPlayerReturnFrame.leftLine");
         _taskBtn = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnFrame.taskBtn");
         _allianceBtn = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnFrame.allianceBtn");
         _milestoneBtn = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnFrame.milestoneBtn");
         _shopBtn = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnFrame.shopBtn");
         _taskView = ComponentFactory.Instance.creatCustomObject("oldPlayerReturnFrame.taskView");
         _allianceView = ComponentFactory.Instance.creatCustomObject("oldPlayerReturnFrame.allianceView");
         _milestoneView = ComponentFactory.Instance.creatCustomObject("oldPlayerReturnFrame.milestoneView");
         _shopView = ComponentFactory.Instance.creatCustomObject("oldPlayerReturnFrame.shopView");
         _vBox = ComponentFactory.Instance.creatCustomObject("oldPlayerReturnFrame.vBox");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnFrame.helpBtn");
         addToContent(_border);
         addToContent(_bg);
         addToContent(_line);
         addToContent(_vBox);
         if(model.isReturnPlayer && Boolean(model.isOpen))
         {
            _vBox.addChild(_taskBtn);
         }
         if(model.isOpen)
         {
            _vBox.addChild(_allianceBtn);
         }
         if(model.isReturnPlayer && Boolean(model.isOpen))
         {
            _vBox.addChild(_milestoneBtn);
         }
         _vBox.addChild(_shopBtn);
         addToContent(_taskView);
         addToContent(_allianceView);
         addToContent(_milestoneView);
         addToContent(_shopView);
         addToContent(_helpBtn);
         _group = new SelectedButtonGroup();
         if(model.isReturnPlayer && Boolean(model.isOpen))
         {
            _group.addSelectItem(_taskBtn);
         }
         if(model.isOpen)
         {
            _group.addSelectItem(_allianceBtn);
         }
         if(model.isReturnPlayer && Boolean(model.isOpen))
         {
            _group.addSelectItem(_milestoneBtn);
         }
         _group.addSelectItem(_shopBtn);
         _taskBtn.text = LanguageMgr.GetTranslation("oldPlayerReturnFrame.taskBtn.text");
         _allianceBtn.text = LanguageMgr.GetTranslation("oldPlayerReturnFrame.allianceBtn.text");
         _milestoneBtn.text = LanguageMgr.GetTranslation("oldPlayerReturnFrame.milestoneBtn.text");
         _shopBtn.text = LanguageMgr.GetTranslation("oldPlayerReturnFrame.shopBtn.text");
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _group.addEventListener("change",__groupChangeHandler);
         NotificationManager.instance.addEventListener("USER_DATA_EVENT",__userDataUpdateHandler);
         _helpBtn.addEventListener("click",__helpClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _group.removeEventListener("change",__groupChangeHandler);
         NotificationManager.instance.removeEventListener("USER_DATA_EVENT",__userDataUpdateHandler);
         _helpBtn.removeEventListener("click",__helpClickHandler);
      }
      
      private function __helpClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnFrame.helperFrame");
         _loc2_.show();
      }
      
      private function __userDataUpdateHandler(param1:NotificationEvent) : void
      {
         refreshView();
      }
      
      private function __groupChangeHandler(param1:Event) : void
      {
         model.currentPage = 1;
         switch(_group.getSelectedItem())
         {
            case _taskBtn:
               _taskView.visible = true;
               _allianceView.visible = false;
               _milestoneView.visible = false;
               _shopView.visible = false;
               break;
            case _allianceBtn:
               _taskView.visible = false;
               _allianceView.visible = true;
               _milestoneView.visible = false;
               _shopView.visible = false;
               break;
            case _milestoneBtn:
               _taskView.visible = false;
               _allianceView.visible = false;
               _milestoneView.visible = true;
               _shopView.visible = false;
               break;
            case _shopBtn:
               _taskView.visible = false;
               _allianceView.visible = false;
               _milestoneView.visible = false;
               _shopView.visible = true;
               _shopView.refreshView();
         }
      }
      
      public function refreshView() : void
      {
         _taskView.refreshView();
         _allianceView.refreshView();
         _milestoneView.refreshView();
         _shopView.refreshView();
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
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function get model() : OldPlayerReturnModel
      {
         return OldPlayerReturnManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_line);
         _line = null;
         ObjectUtils.disposeObject(_taskBtn);
         _taskBtn = null;
         ObjectUtils.disposeObject(_allianceBtn);
         _allianceBtn = null;
         ObjectUtils.disposeObject(_milestoneBtn);
         _milestoneBtn = null;
         ObjectUtils.disposeObject(_shopBtn);
         _shopBtn = null;
         ObjectUtils.disposeObject(_taskView);
         _taskView = null;
         ObjectUtils.disposeObject(_allianceView);
         _allianceView = null;
         ObjectUtils.disposeObject(_milestoneView);
         _milestoneView = null;
         ObjectUtils.disposeObject(_shopView);
         _shopView = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

