package mainBar
{
   import com.pickgliss.effect.IEffect;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.HBox;
   import flash.display.Sprite;
   import flash.events.Event;
   import mainBar.view.MessageBtnListView;
   import tasktracetip.event.TaskTraceTipEvent;
   import ui.events.UIBarEvent;
   import yishi.datas.consant.ArmyPanelEnum;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   
   public class TipsBar extends Sprite
   {
      
      private static var _instance:TipsBar;
      
      private var _skillBtn:BaseButton;
      
      private var _propertyBtn:BaseButton;
      
      private var _effect1:IEffect;
      
      private var _effect2:IEffect;
      
      private var _isHeroFrameOpened:Boolean;
      
      private var _hBox:HBox;
      
      public var messageBtnList:MessageBtnListView;
      
      public function TipsBar()
      {
         super();
         initView();
         addEvent();
         initDate();
      }
      
      public static function get instance() : TipsBar
      {
         if(!_instance)
         {
            _instance = new TipsBar();
         }
         return _instance;
      }
      
      private function initView() : void
      {
         _hBox = new HBox();
         messageBtnList = ComponentFactory.Instance.creatCustomObject("taskTrace.MessageBtnListView");
         addChild(_hBox);
         _hBox.spacing = 10;
         __onHeroPropChange(null);
         __onResize(null);
      }
      
      private function addEvent() : void
      {
         StageReferance.stage.addEventListener("resize",__onResize);
         thane.addEventListener("THANE_INFO_UPDATE",__onHeroPropChange);
         messageBtnList.addEventListener("UPDATE_TASK_TRACE_TIP",__updateMessageBtnList);
         NotificationManager.instance.addEventListener("heroFrameOpened",__heroFrameOpenHandler);
      }
      
      private function initDate() : void
      {
         _hBox.refreshChildPos();
         LayerManager.Instance.addToLayer(this,4,false,false,0,2);
      }
      
      private function __onResize(param1:Event) : void
      {
         x = StageReferance.stage.stageWidth / 2;
         y = StageReferance.stage.stageHeight - 100;
      }
      
      private function __onHeroPropChange(param1:PlayerEvent) : void
      {
         if(!_isHeroFrameOpened)
         {
            setHeroBtnEffect();
         }
      }
      
      private function __updateMessageBtnList(param1:TaskTraceTipEvent) : void
      {
         if(messageBtnList.hBox.numChildren)
         {
            _hBox.isReverAdd = false;
            _hBox.addChild(messageBtnList);
         }
         else
         {
            _hBox.removeChild(messageBtnList);
         }
         _hBox.refreshChildPos();
      }
      
      private function __skillBtnClick(param1:Event) : void
      {
         FrameControllerManager.instance.armyController.startFrameByType(ArmyPanelEnum.SKILL_PANEL);
         removeSkillBtn();
      }
      
      private function __levelUpgradeHandler(param1:PlayerEvent) : void
      {
      }
      
      private function __heroFrameOpenHandler(param1:UIBarEvent) : void
      {
         _isHeroFrameOpened = true;
      }
      
      private function __heroFrameCloseHandler(param1:UIBarEvent) : void
      {
         _isHeroFrameOpened = false;
         setHeroBtnEffect();
      }
      
      private function setHeroBtnEffect() : void
      {
      }
      
      private function removeSkillBtn() : void
      {
      }
      
      private function removePropertyBtn() : void
      {
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function show() : void
      {
         visible = true;
      }
      
      public function hide() : void
      {
         visible = false;
      }
      
      public function get skillBtn() : BaseButton
      {
         return _skillBtn;
      }
      
      public function get propertyBtn() : BaseButton
      {
         return _propertyBtn;
      }
   }
}

