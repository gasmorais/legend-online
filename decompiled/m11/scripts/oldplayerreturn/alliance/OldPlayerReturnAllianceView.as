package oldplayerreturn.alliance
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import mvc.module.oldplayerreturn.OldPlayerReturnModel;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.OldPlayerReturnManager;
   
   public class OldPlayerReturnAllianceView extends Component
   {
      
      private var _line:Bitmap;
      
      private var _allianceBtn:SelectedIconButton;
      
      private var _oracleTaskBtn:SelectedIconButton;
      
      private var _allianceTaskBtn:SelectedIconButton;
      
      private var _group:SelectedButtonGroup;
      
      private var _leftView:OldPlayerReturnLeftView;
      
      private var _contractView:OldPlayerReturnContractView;
      
      private var _oracleTaskView:OldPlayerReturnOracleTaskView;
      
      private var _alliTaskView:OldPlayerReturnAlliTaskView;
      
      public function OldPlayerReturnAllianceView()
      {
         super();
         initView();
         addEvent();
         _group.selectIndex = 0;
      }
      
      private function initView() : void
      {
         _line = ComponentFactory.Instance.creatBitmap("asset.OldPlayerReturnAllianceView.line");
         _allianceBtn = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnAllianceView.allianceBtn");
         _oracleTaskBtn = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnAllianceView.oracleTaskBtn");
         _allianceTaskBtn = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnAllianceView.allianceTaskBtn");
         _leftView = ComponentFactory.Instance.creatCustomObject("oldPlayerReturnAllianceView.leftView");
         _contractView = ComponentFactory.Instance.creatCustomObject("oldPlayerReturnAllianceView.contractView");
         _oracleTaskView = ComponentFactory.Instance.creatCustomObject("oldPlayerReturnAllianceView.oracleTaskView");
         _alliTaskView = ComponentFactory.Instance.creatCustomObject("oldPlayerReturnAllianceView.alliTaskView");
         addChild(_line);
         addChild(_allianceBtn);
         addChild(_oracleTaskBtn);
         addChild(_allianceTaskBtn);
         addChild(_leftView);
         addChild(_contractView);
         addChild(_oracleTaskView);
         addChild(_alliTaskView);
         _group = new SelectedButtonGroup();
         _group.addSelectItem(_allianceBtn);
         _group.addSelectItem(_oracleTaskBtn);
         _group.addSelectItem(_allianceTaskBtn);
      }
      
      private function addEvent() : void
      {
         _group.addEventListener("change",__groupChangeHandler);
         NotificationManager.instance.addEventListener("SELECTED_ALLYID_EVENT",__selectedAllyIdDataUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         _group.removeEventListener("change",__groupChangeHandler);
         NotificationManager.instance.removeEventListener("SELECTED_ALLYID_EVENT",__selectedAllyIdDataUpdateHandler);
      }
      
      private function __selectedAllyIdDataUpdateHandler(param1:NotificationEvent) : void
      {
         if(!model.isReturnPlayer)
         {
            _contractView.refreshView();
         }
         _alliTaskView.refreshAllyId();
      }
      
      private function __groupChangeHandler(param1:Event) : void
      {
         switch(int(_group.selectIndex))
         {
            case 0:
               _contractView.visible = true;
               _oracleTaskView.visible = false;
               _alliTaskView.visible = false;
               break;
            case 1:
               _contractView.visible = false;
               _oracleTaskView.visible = true;
               _alliTaskView.visible = false;
               break;
            case 2:
               _contractView.visible = false;
               _oracleTaskView.visible = false;
               _alliTaskView.visible = true;
         }
      }
      
      public function refreshView() : void
      {
         _allianceBtn.enable = model.allyList.length > 0;
         _oracleTaskBtn.enable = model.allyList.length > 0;
         _allianceTaskBtn.enable = model.allyList.length > 0;
         _leftView.refreshView();
         _contractView.refreshView();
         if(model.allyList.length > 0)
         {
            _oracleTaskView.refreshView();
            _alliTaskView.refreshAllyId();
         }
         else if(_group.selectIndex == 0)
         {
            __groupChangeHandler(null);
         }
         else
         {
            _group.selectIndex = 0;
         }
      }
      
      private function get model() : OldPlayerReturnModel
      {
         return OldPlayerReturnManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_line);
         _line = null;
         ObjectUtils.disposeObject(_allianceBtn);
         _allianceBtn = null;
         ObjectUtils.disposeObject(_oracleTaskBtn);
         _oracleTaskBtn = null;
         ObjectUtils.disposeObject(_allianceTaskBtn);
         _allianceTaskBtn = null;
         ObjectUtils.disposeObject(_leftView);
         _leftView = null;
         ObjectUtils.disposeObject(_contractView);
         _contractView = null;
         ObjectUtils.disposeObject(_oracleTaskView);
         _oracleTaskView = null;
         ObjectUtils.disposeObject(_alliTaskView);
         _alliTaskView = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

