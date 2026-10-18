package pet.equipstore
{
   import bag.events.BagEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import managers.PetEquipManager;
   import pet.advanced.PetEquipBagView;
   import pet.equipstore.godhead.GodHeadItemView;
   import pet.equipstore.streng.PetEquipStrengItem;
   import yishi.datas.goods.GoodsInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.SimpleDictionary;
   
   public class PetEquipGodHeadView extends Component
   {
      
      private var _bg:Bitmap;
      
      private var _itemBg:Image;
      
      private var _hBox:HBox;
      
      private var _item:Array;
      
      private var _equipBag:PetEquipBagView;
      
      private var _godheadItem:PetEquipStrengItem;
      
      private var _itemDic:SimpleDictionary;
      
      public function PetEquipGodHeadView()
      {
         super();
         initView();
         initEvent();
         initData();
         var _loc1_:Array = GoodsManager.instance.getGoodsByBagType(0);
         for each(var _loc2_:GoodsInfo in _loc1_)
         {
            PlayerManager.instance.moveBagToBag(_loc2_.bagType,_loc2_.objectId,_loc2_.pos,1,0,0,1);
         }
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:GodHeadItemView = null;
         _bg = ComponentFactory.Instance.creatBitmap("asset.pet.equipGodheadBg");
         _itemBg = ComponentFactory.Instance.creatComponentByStylename("pet.godHeadItemBg");
         addChild(_bg);
         addChild(_itemBg);
         _itemDic = new SimpleDictionary();
         _hBox = ComponentFactory.Instance.creatComponentByStylename("petEquipGodHeadView.hBox");
         addChild(_hBox);
         _item = [];
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_ = new GodHeadItemView();
            _loc1_.pos = _loc2_ + 1;
            _loc1_.state = 3;
            _hBox.addChild(_loc1_);
            _item.push(_loc1_);
            _loc2_++;
         }
         _equipBag = new PetEquipBagView(3,13,13,"pet.equipGodHeadScroll",false,"pet.petEquipBagViewBg02");
         _godheadItem = ComponentFactory.Instance.creatCustomObject("pet.petEquipGodHeadItem");
         _equipBag.x = 3;
         _equipBag.y = 242;
         addChild(_equipBag);
         addChild(_godheadItem);
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_hBox);
         _hBox = null;
         ObjectUtils.disposeObject(_equipBag);
         _equipBag = null;
         ObjectUtils.disposeObject(_godheadItem);
         _godheadItem = null;
         ObjectUtils.disposeObject(_itemBg);
         _itemBg = null;
         _item = null;
      }
      
      private function initEvent() : void
      {
         GoodsManager.instance.addEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__bagItemDeleteHandler);
         NotificationManager.instance.addEventListener("PETEQUIPSTOREDATACHANGE",__itemDataChangeHandler);
         NotificationManager.instance.addEventListener("PETEQUIPDROPSTART",__showEffect);
         NotificationManager.instance.addEventListener("PETEQUIPDROPOVER",__hideEffect);
      }
      
      private function removeEvent() : void
      {
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__bagItemDeleteHandler);
         NotificationManager.instance.removeEventListener("PETEQUIPSTOREDATACHANGE",__itemDataChangeHandler);
         NotificationManager.instance.removeEventListener("PETEQUIPDROPSTART",__showEffect);
         NotificationManager.instance.removeEventListener("PETEQUIPDROPOVER",__hideEffect);
      }
      
      private function initData() : void
      {
         _itemDic.add("0_0_0",_godheadItem);
         updateView();
      }
      
      private function __bagItemUpdateHandler(param1:BagEvent) : void
      {
         var _loc3_:GoodsInfo = param1.info;
         var _loc2_:PetEquipStrengItem = _itemDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         if(_loc2_ && PetEquipManager.currSelectedPage == "EquipStoreView" && PetEquipManager.currSelectedView == "PetEquipGodHeadView")
         {
            _loc2_.data = _loc3_;
            PetEquipManager.currGodHeadItem = _loc3_;
            updateView();
         }
      }
      
      private function __bagItemDeleteHandler(param1:BagEvent) : void
      {
         var _loc3_:GoodsInfo = param1.info;
         var _loc2_:PetEquipStrengItem = _itemDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         if(_loc2_ && PetEquipManager.currSelectedPage == "EquipStoreView" && PetEquipManager.currSelectedView == "PetEquipGodHeadView")
         {
            _loc2_.data = null;
            PetEquipManager.currGodHeadItem = null;
            updateView();
         }
      }
      
      private function __showEffect(param1:NotificationEvent) : void
      {
         var _loc2_:GoodsInfo = param1.data as GoodsInfo;
         if(_loc2_)
         {
            if(_loc2_.templateInfo.MasterType == 5)
            {
               _godheadItem.setSelectedEff();
            }
         }
      }
      
      private function __hideEffect(param1:NotificationEvent) : void
      {
         _godheadItem.setNotSelectedEff();
      }
      
      private function updateView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:GodHeadItemView = null;
         var _loc4_:GoodsInfo = null;
         var _loc5_:int = 0;
         var _loc1_:GodHeadItemView = null;
         var _loc6_:GoodsInfo = _godheadItem.data;
         if(_loc6_)
         {
            _loc3_ = 0;
            while(_loc3_ < 4)
            {
               _loc2_ = _item[_loc3_] as GodHeadItemView;
               _loc2_.data = null;
               if(_loc6_["join" + (_loc3_ + 1)] == -1)
               {
                  if(_loc6_.templateInfo.Profile - 1 > _loc3_)
                  {
                     _loc2_.state = 1;
                  }
                  else
                  {
                     _loc2_.state = 0;
                  }
               }
               else if(_loc6_["join" + (_loc3_ + 1)] == 0)
               {
                  _loc2_.state = 2;
               }
               else if(_loc6_["join" + (_loc3_ + 1)] > 0)
               {
                  _loc2_.state = 2;
                  _loc4_ = new GoodsInfo();
                  _loc4_.templateId = _loc6_["join" + (_loc3_ + 1)];
                  _loc2_.data = _loc4_;
               }
               else
               {
                  _loc2_.state = 3;
               }
               _loc3_++;
            }
         }
         else
         {
            _loc5_ = 0;
            while(_loc5_ < 4)
            {
               _loc1_ = _item[_loc5_] as GodHeadItemView;
               _loc1_.data = null;
               _loc1_.state = 3;
               _loc5_++;
            }
         }
      }
      
      private function __itemDataChangeHandler(param1:NotificationEvent) : void
      {
      }
      
      override public function dispose() : void
      {
         uintView();
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         if(_itemDic)
         {
            _itemDic.clear();
         }
         _itemDic = null;
      }
   }
}

