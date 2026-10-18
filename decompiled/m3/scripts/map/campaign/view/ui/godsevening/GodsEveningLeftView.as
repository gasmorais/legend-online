package map.campaign.view.ui.godsevening
{
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class GodsEveningLeftView extends Component
   {
      
      private var _hbox:HBox;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _btnServer:SelectedIconButton;
      
      private var _btnPersonal:SelectedIconButton;
      
      private var _serverView:GodsEveningLeftServerView;
      
      private var _personalView:GodsEveningLeftPersonView;
      
      private var _switchBtn:Sprite;
      
      private var _arrowImg:Bitmap;
      
      private var _showState:Boolean = true;
      
      public function GodsEveningLeftView()
      {
         super();
         initView();
         addEvent();
         _btnGroup.selectIndex = 0;
      }
      
      private function initView() : void
      {
         _serverView = ComponentFactory.Instance.creatCustomObject("campaign.GodsEveningLeftServerView");
         _personalView = ComponentFactory.Instance.creatCustomObject("campaign.GodsEveningLeftPersonView");
         _btnServer = ComponentFactory.Instance.creatComponentByStylename("campaign.GodsEveningLeftView.ServerBtn");
         _btnPersonal = ComponentFactory.Instance.creatComponentByStylename("campaign.GECheckRewardFrame.PersonalBtn");
         _hbox = ComponentFactory.Instance.creatComponentByStylename("campaign.GodsEveningLeftView.hbox");
         addChild(_serverView);
         addChild(_personalView);
         addChild(_hbox);
         _hbox.addChild(_btnServer);
         _hbox.addChild(_btnPersonal);
         _arrowImg = ComponentFactory.Instance.creatBitmap("asset.campaign.GVGManageViewArrowImg");
         _switchBtn = new Sprite();
         _switchBtn.graphics.beginFill(16777215,0);
         _switchBtn.graphics.drawRect(0,0,31,70);
         _switchBtn.graphics.endFill();
         _switchBtn.buttonMode = true;
         _switchBtn.x = 332;
         _switchBtn.y = 55;
         _switchBtn.addChild(_arrowImg);
         _arrowImg.x = 6;
         addChild(_switchBtn);
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_btnServer);
         _btnGroup.addSelectItem(_btnPersonal);
      }
      
      private function unInitView() : void
      {
         ObjectUtils.disposeObject(_btnServer);
         _btnServer = null;
         ObjectUtils.disposeObject(_btnPersonal);
         _btnPersonal = null;
         ObjectUtils.disposeObject(_hbox);
         _hbox = null;
         ObjectUtils.disposeObject(_btnGroup);
         _btnGroup = null;
         ObjectUtils.disposeObject(_serverView);
         _serverView = null;
         ObjectUtils.disposeObject(_personalView);
         _personalView = null;
         ObjectUtils.disposeObject(_arrowImg);
         _arrowImg = null;
         ObjectUtils.disposeObject(_switchBtn);
         _switchBtn = null;
      }
      
      private function addEvent() : void
      {
         _btnGroup.addEventListener("change",__selectedChangHandler);
         _switchBtn.addEventListener("click",__onSwitchClick);
      }
      
      private function removeEvent() : void
      {
         _btnGroup.removeEventListener("change",__selectedChangHandler);
         _switchBtn.removeEventListener("click",__onSwitchClick);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         unInitView();
         TweenMax.killTweensOf(this);
         super.dispose();
      }
      
      private function __onSwitchClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         showState = !showState;
      }
      
      public function set showState(param1:Boolean) : void
      {
         _showState = param1;
         if(_showState)
         {
            _arrowImg.scaleX = 1;
            _arrowImg.x = 6;
            doShow();
         }
         else
         {
            _arrowImg.scaleX = -1;
            _arrowImg.x = 24;
            doHide();
         }
      }
      
      public function get showState() : Boolean
      {
         return _showState;
      }
      
      private function doShow() : void
      {
         TweenMax.killTweensOf(this);
         TweenMax.to(this,0.5,{"x":0});
      }
      
      private function doHide() : void
      {
         TweenMax.killTweensOf(this);
         TweenMax.to(this,0.5,{"x":-335});
      }
      
      private function __selectedChangHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         switch(_btnGroup.getSelectedItem())
         {
            case _btnServer:
               _serverView.visible = true;
               _personalView.visible = false;
               break;
            case _btnPersonal:
               _serverView.visible = false;
               _personalView.visible = true;
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,4,false,false);
      }
   }
}

