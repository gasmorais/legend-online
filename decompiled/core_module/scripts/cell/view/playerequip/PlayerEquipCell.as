package cell.view.playerequip
{
   import bag.helper.GoodsCheck;
   import cell.mediator.playerbag.PlayerBagCellLightMediator;
   import cell.mediator.playerequip.PlayerEquipBagCellClickMediator;
   import cell.mediator.playerequip.PlayerEquipBagCellDropMediator;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.MediatorMananger;
   import yishi.manager.PlayerManager;
   import yishi.view.community.BaseItemView;
   
   public class PlayerEquipCell extends BaseItemView
   {
      
      public static const P_effectStyle:String = "effectStyle";
      
      public static const P_activeStyle:String = "activeStyle";
      
      public static const ENTER_EFFECT:String = "enterEffect";
      
      public static const ACCEPT_DROP:String = "acceptDrop";
      
      public static const NAME:String = "cell.view.playerequip.PlayerEquipCell";
      
      private var _enterEffect:Boolean;
      
      protected var _acceptDrop:Boolean;
      
      protected var _activeBack:MovieImage;
      
      protected var _effect:MovieImage;
      
      protected var _sonType:int;
      
      private var _activeStyle:String;
      
      private var _registed:Boolean;
      
      private var _mediatorKey:String;
      
      private var _upgradeButton:SelectedButton;
      
      private var _effectStyle:String;
      
      public var preTemp:int;
      
      public function PlayerEquipCell()
      {
         super();
         bagType = 4;
         buttonMode = true;
      }
      
      public function set activeStyle(param1:String) : void
      {
         _activeStyle = param1;
         onPropertiesChanged("activeStyle");
      }
      
      public function set effectStyle(param1:String) : void
      {
         _effectStyle = param1;
         onPropertiesChanged("effectStyle");
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["activeStyle"])
         {
            _activeBack = ComponentFactory.Instance.creatComponentByStylename(_activeStyle);
            _activeBack.visible = false;
            _activeBack.movie.gotoAndStop(1);
            _activeBack.mouseChildren = false;
            _activeBack.mouseEnabled = false;
         }
         if(_changedPropeties["effectStyle"])
         {
            _effect = ComponentFactory.Instance.creatComponentByStylename(_effectStyle);
            _effect.movie.gotoAndStop(1);
            _effect.mouseChildren = false;
            _effect.mouseEnabled = false;
         }
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_activeBack)
         {
            addChild(_activeBack);
         }
         if(_effect)
         {
            addChild(_effect);
         }
      }
      
      override public function set data(param1:GoodsInfo) : void
      {
         if(data)
         {
            preTemp = data.id;
         }
         else
         {
            preTemp = 0;
         }
         super.data = param1;
         mouseEnabled = true;
         mouseChildren = true;
         setNormalFilter();
         if(!_registed && _acceptDrop)
         {
            registerMediator();
         }
         if(data && data.templateInfo && data.templateInfo.isCanbeUpgrade && data.userId == ArmyManager.instance.thane.userId)
         {
            if(data.templateInfo.upGradeComposeTemId && GoodsManager.instance.checkEquipUpgrade(data.templateInfo.upGradeComposeTemId))
            {
               addUpgradeBtn(2);
            }
            else
            {
               addUpgradeBtn(1);
            }
         }
         else
         {
            clearUpgradeBtn();
         }
      }
      
      private function registerMediator() : void
      {
         _registed = true;
         var _loc1_:Array = [PlayerEquipBagCellDropMediator,PlayerEquipBagCellClickMediator,PlayerBagCellLightMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"cell.view.playerequip.PlayerEquipCell");
      }
      
      private function unRegisterMediator() : void
      {
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
      }
      
      public function setNormal() : void
      {
         if(_activeBack)
         {
            _activeBack.visible = false;
            _activeBack.movie.stop();
         }
      }
      
      public function setFocus() : void
      {
         if(_activeBack)
         {
            _activeBack.visible = true;
            _activeBack.movie.play();
         }
      }
      
      public function set acceptDrop(param1:Boolean) : void
      {
         _acceptDrop = _icon.buttonMode = param1;
      }
      
      public function set sonType(param1:int) : void
      {
         _sonType = param1;
      }
      
      public function get sonType() : int
      {
         return _sonType;
      }
      
      public function showEffect(param1:Boolean = true) : void
      {
         if(_effect)
         {
            _effect.movie.gotoAndPlay(1);
         }
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      override protected function setTipStyle(param1:GoodsTemplateInfo) : void
      {
         if(param1.MasterType == 1 || param1.MasterType == 3)
         {
            if(_acceptDrop)
            {
               _icon.tipStyle = "yishi.view.tips.goods.EquipTip";
            }
            else
            {
               _icon.tipStyle = "yishi.view.tips.goods.EquipContrastTips";
            }
         }
         else if(param1.MasterType == 2 || param1.MasterType == 4)
         {
            if(param1.SonType == 214)
            {
               _icon.tipStyle = "yishi.view.tips.goods.RuneTip";
            }
            else
            {
               _icon.tipStyle = "yishi.view.tips.goods.PropTips";
            }
         }
         if(GoodsCheck.isFashion(param1))
         {
            _icon.tipStyle = "yishi.view.tips.goods.FashionCardTip";
         }
      }
      
      private function addUpgradeBtn(param1:int) : void
      {
         if(!_upgradeButton)
         {
            _upgradeButton = ComponentFactory.Instance.creatComponentByStylename("core.UpgradeEquipBtn");
         }
         _upgradeButton.selected = param1 == 2;
         addChild(_upgradeButton);
         _upgradeButton.addEventListener("click",_upgradeEquip);
      }
      
      private function clearUpgradeBtn() : void
      {
         if(_upgradeButton)
         {
            _upgradeButton.removeEventListener("click",_upgradeEquip);
            ObjectUtils.disposeObject(_upgradeButton);
            _upgradeButton = null;
         }
      }
      
      private function _upgradeEquip(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.storeController.startFrameByType("STORE_PANEL_COMPOSE",data);
      }
      
      override public function dispose() : void
      {
         unRegisterMediator();
         ObjectUtils.disposeObject(_activeBack);
         _activeBack = null;
         ObjectUtils.disposeObject(_effect);
         _effect = null;
         _acceptDrop = false;
         super.dispose();
      }
   }
}

