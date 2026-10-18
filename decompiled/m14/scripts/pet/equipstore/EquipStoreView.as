package pet.equipstore
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import managers.PetEquipManager;
   import mvc.module.pet.PetData;
   import yishi.datas.goods.GoodsInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   
   public class EquipStoreView extends Component
   {
      
      private var _topBg:Bitmap;
      
      private var _strengBtn:SelectedIconButton;
      
      private var _refineryBtn:SelectedIconButton;
      
      private var _godHeadBtn:SelectedIconButton;
      
      private var _upgradeBtn:SelectedIconButton;
      
      private var _hbox:HBox;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _strengView:PetEquipStrengView;
      
      private var _refineryView:PetEquipRefineryView;
      
      private var _godHeadView:PetEquipGodHeadView;
      
      private var _upgradeView:PetEquipUpgradeView;
      
      private var defaultViewIndex:int = 0;
      
      private var _data:PetData;
      
      public function EquipStoreView()
      {
         super();
         initView();
         initEvent();
         showDefaultView();
      }
      
      public function get data() : PetData
      {
         return _data;
      }
      
      public function set data(param1:PetData) : void
      {
         if(_data && param1 && _data.petId == param1.petId && _data.isBind == param1.isBind)
         {
            return;
         }
         _data = param1;
         PetEquipManager.currSelectedPetData = _data;
         var _loc2_:Array = GoodsManager.instance.getGoodsByBagType(0);
         for each(var _loc3_:GoodsInfo in _loc2_)
         {
            PlayerManager.instance.moveBagToBag(_loc3_.bagType,_loc3_.objectId,_loc3_.pos,1,0,0,1);
         }
         NotificationManager.instance.dispatchEvent(new NotificationEvent("PETSELECTEDCHANGE"));
      }
      
      private function initView() : void
      {
         _topBg = ComponentFactory.Instance.creatBitmap("asset.pet.equipTopBg");
         _strengBtn = ComponentFactory.Instance.creatComponentByStylename("pet.equipStrengBtn");
         _refineryBtn = ComponentFactory.Instance.creatComponentByStylename("pet.equipRefineryBtn");
         _godHeadBtn = ComponentFactory.Instance.creatComponentByStylename("pet.equipGodHeadBtn");
         _upgradeBtn = ComponentFactory.Instance.creatComponentByStylename("pet.equipUpgradeBtn");
         _hbox = ComponentFactory.Instance.creatComponentByStylename("pet.equipBtnHbox");
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_strengBtn);
         _btnGroup.addSelectItem(_refineryBtn);
         _btnGroup.addSelectItem(_godHeadBtn);
         _btnGroup.addSelectItem(_upgradeBtn);
         addChild(_topBg);
         _hbox.addChild(_strengBtn);
         _hbox.addChild(_refineryBtn);
         _hbox.addChild(_godHeadBtn);
         _hbox.addChild(_upgradeBtn);
         addChild(_hbox);
         _btnGroup.selectIndex = 0;
      }
      
      private function initEvent() : void
      {
         if(_btnGroup)
         {
            _btnGroup.addEventListener("change",__changeViewHandler);
         }
      }
      
      private function __changeViewHandler(param1:Event) : void
      {
         var _loc2_:int = 0;
         if(_btnGroup)
         {
            _loc2_ = int(_btnGroup.selectIndex);
         }
         defaultViewIndex = _loc2_;
         showDefaultView();
      }
      
      private function showDefaultView() : void
      {
         var _loc1_:Array = GoodsManager.instance.getGoodsByBagType(0);
         for each(var _loc2_:GoodsInfo in _loc1_)
         {
            PlayerManager.instance.moveBagToBag(_loc2_.bagType,_loc2_.objectId,_loc2_.pos,1,0,0,1);
         }
         switch(defaultViewIndex)
         {
            case 0:
               PetEquipManager.currSelectedView = "PetEquipStrengView";
               if(_strengView == null || Boolean(_strengView.isDie))
               {
                  _strengView = new PetEquipStrengView();
                  _strengView.x = 2;
                  _strengView.y = 36;
                  addChild(_strengView);
               }
               if(_refineryView)
               {
                  _refineryView.dispose();
               }
               _refineryView = null;
               if(_godHeadView)
               {
                  _godHeadView.dispose();
               }
               _godHeadView = null;
               if(_upgradeView)
               {
                  _upgradeView.dispose();
               }
               _upgradeView = null;
               break;
            case 1:
               PetEquipManager.currSelectedView = "PetEquipRefineryView";
               if(_refineryView == null || Boolean(_refineryView.isDie))
               {
                  _refineryView = new PetEquipRefineryView();
                  _refineryView.x = 2;
                  _refineryView.y = 36;
                  addChild(_refineryView);
               }
               if(_strengView)
               {
                  _strengView.dispose();
               }
               _strengView = null;
               if(_godHeadView)
               {
                  _godHeadView.dispose();
               }
               _godHeadView = null;
               if(_upgradeView)
               {
                  _upgradeView.dispose();
               }
               _upgradeView = null;
               break;
            case 2:
               PetEquipManager.currSelectedView = "PetEquipGodHeadView";
               if(_godHeadView == null || Boolean(_godHeadView.isDie))
               {
                  _godHeadView = new PetEquipGodHeadView();
                  _godHeadView.x = 2;
                  _godHeadView.y = 36;
                  addChild(_godHeadView);
               }
               if(_strengView)
               {
                  _strengView.dispose();
               }
               _strengView = null;
               if(_refineryView)
               {
                  _refineryView.dispose();
               }
               _refineryView = null;
               if(_upgradeView)
               {
                  _upgradeView.dispose();
               }
               _upgradeView = null;
               break;
            case 3:
               PetEquipManager.currSelectedView = "PetEquipUpgradeView";
               if(_upgradeView == null || Boolean(_upgradeView.isDie))
               {
                  _upgradeView = new PetEquipUpgradeView();
                  _upgradeView.x = 2;
                  _upgradeView.y = 36;
                  addChild(_upgradeView);
               }
               if(_strengView)
               {
                  _strengView.dispose();
               }
               _strengView = null;
               if(_refineryView)
               {
                  _refineryView.dispose();
               }
               _refineryView = null;
               if(_godHeadView)
               {
                  _godHeadView.dispose();
               }
               _godHeadView = null;
         }
         NotificationManager.instance.dispatchEvent(new NotificationEvent("PETSTORECHANGEPAGE"));
      }
      
      private function removeEvent() : void
      {
         if(_btnGroup)
         {
            _btnGroup.removeEventListener("change",__changeViewHandler);
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         PetEquipManager.currSelectedView = "";
         if(_strengView)
         {
            _strengView.dispose();
         }
         _strengView = null;
         if(_refineryView)
         {
            _refineryView.dispose();
         }
         _refineryView = null;
         if(_godHeadView)
         {
            _godHeadView.dispose();
         }
         _godHeadView = null;
         if(_upgradeView)
         {
            _upgradeView.dispose();
         }
         _upgradeView = null;
         ObjectUtils.disposeAllChildren(this);
         _data = null;
         super.dispose();
      }
   }
}

