package store.treasure
{
   import bag.events.BagEvent;
   import cell.view.storebag.StoreRefreshCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.store.RefreshPropertyRepMsg;
   import com.road.yishi.proto.store.SmithFreshRspMsg;
   import events.StoreEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.StoreSocketOutManager;
   import mvc.controler.StoreControler;
   import yishi.comm.PackageIn;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.SimpleDictionary;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class TreasureRefreshView extends Component
   {
      
      private static var _len:int = 5;
      
      private var _bg:MutipleImage;
      
      private var _equip:StoreRefreshCell;
      
      private var _mate:TreasureRefreshNeededMaterialItem;
      
      private var _refreshAttribute:Bitmap;
      
      private var _refreshAttributeBtn:IconButton;
      
      private var _refreshReplaceBtn:IconButton;
      
      private var _refreshIcon:Bitmap;
      
      private var _itemDic:SimpleDictionary;
      
      private var _refreshAttriList:Array;
      
      private var _lockCount:int;
      
      private var _storeFrameEquipBg:MovieClip;
      
      private var _needMaterialCount:int;
      
      private var _ownMaterialCount:int;
      
      private var refreshArr:Array;
      
      private var _storeBag:TreasureStoreBag;
      
      public function TreasureRefreshView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:TreasureRefreshAttriItem = null;
         _bg = ComponentFactory.Instance.creatComponentByStylename("store.RefreshViewBg.treasure");
         _equip = ComponentFactory.Instance.creatCustomObject("store.RefreshEquiItem.treasure");
         _mate = ComponentFactory.Instance.creatCustomObject("refresh.RefreshNeededMaterialItem.treasure");
         _refreshAttribute = ComponentFactory.Instance.creatBitmap("asset.store.TreasureRefreshAttributeBg");
         _refreshAttributeBtn = ComponentFactory.Instance.creatComponentByStylename("store.RefreshAttribute.treasure");
         _refreshReplaceBtn = ComponentFactory.Instance.creatComponentByStylename("store.RefreshReplace.treasure");
         _refreshIcon = ComponentFactory.Instance.creatBitmap("asset.mainToolBar.IntensifyIcon");
         _storeFrameEquipBg = ComponentFactory.Instance.creatCustomObject("store.StoreFrameEquipBg");
         _storeBag = ComponentFactory.Instance.creatCustomObject("StoreView1.StoreBag.treasure");
         addChild(_bg);
         addChild(_refreshAttribute);
         addChild(_equip);
         _equip.sonType = -1;
         addChild(_mate);
         addChild(_refreshAttributeBtn);
         _refreshAttributeBtn.enable = false;
         addChild(_refreshReplaceBtn);
         _refreshReplaceBtn.enable = false;
         addChild(_refreshIcon);
         _refreshIcon.x = 186;
         _refreshIcon.y = 127;
         _refreshAttributeBtn.tipData = LanguageMgr.GetTranslation("store.view.refresh.RefreshView.refreshAttributeBtn");
         _refreshAttriList = [];
         _loc2_ = 0;
         while(_loc2_ < _len)
         {
            _loc1_ = new TreasureRefreshAttriItem();
            addChild(_loc1_);
            _loc1_.x = 38;
            _loc1_.y = 127 + _loc2_ * 27;
            _refreshAttriList.push(_loc1_);
            _loc2_++;
         }
         _itemDic = new SimpleDictionary(true);
         _itemDic.add("0_0_0",_equip);
         addChild(_storeFrameEquipBg);
         _storeFrameEquipBg.mouseEnabled = false;
         _storeFrameEquipBg.mouseChildren = true;
         _storeFrameEquipBg.x = 115;
         _storeFrameEquipBg.y = 28;
         addChild(_storeBag);
         _storeBag.y = 6;
         _storeBag.defaultView();
      }
      
      private function initEvent() : void
      {
         _refreshAttributeBtn.addEventListener("click",__refreshAttributeHandle);
         _refreshReplaceBtn.addEventListener("click",__refreshReplaceHandle);
         GoodsManager.instance.addEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__bagItemDeleteHandler);
         NotificationManager.instance.addEventListener("STORE_TREASURE_BAG_UPDATE",__treasureBagUpdateHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4258,__refreshSkillHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4368,__refreshProperty);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 115,__bagUpdateHandler);
         if(control && control.model)
         {
            control.model.addEventListener("REFRESH_LOCK_CHANGE",_itemLockHandler);
         }
      }
      
      private function __bagUpdateHandler(param1:SLGSocketEvent) : void
      {
      }
      
      public function removeEvent() : void
      {
         _refreshAttributeBtn.removeEventListener("click",__refreshAttributeHandle);
         _refreshReplaceBtn.removeEventListener("click",__refreshReplaceHandle);
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__bagItemDeleteHandler);
         NotificationManager.instance.removeEventListener("STORE_TREASURE_BAG_UPDATE",__treasureBagUpdateHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4258,__refreshSkillHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4368,__refreshProperty);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 115,__bagUpdateHandler);
         if(control && control.model)
         {
            control.model.removeEventListener("REFRESH_LOCK_CHANGE",_itemLockHandler);
         }
      }
      
      private function __treasureBagUpdateHandler(param1:NotificationEvent) : void
      {
         control.moveGoodsBack();
      }
      
      private function _itemLockHandler(param1:StoreEvent) : void
      {
         var _loc2_:int = 0;
         _lockCount = 0;
         _loc2_ = 0;
         while(_loc2_ < _len)
         {
            if(_refreshAttriList[_loc2_].selected)
            {
               _lockCount = _lockCount + 1;
            }
            _loc2_++;
         }
         updateMateMaterial();
      }
      
      private function __bagItemUpdateHandler(param1:BagEvent) : void
      {
         var _loc3_:GoodsInfo = param1.info;
         var _loc2_:BaseItemView = _itemDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         if(_loc2_)
         {
            _loc2_.data = _loc3_;
            updateRandomSkillView();
            StoreSocketOutManager.sendRefreshProperty(_loc2_.data.id);
         }
         updateMateMaterial();
      }
      
      private function __bagItemDeleteHandler(param1:BagEvent) : void
      {
         var _loc3_:GoodsInfo = param1.info;
         var _loc2_:BaseItemView = _itemDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         if(_loc2_)
         {
            _loc2_.data = null;
            updateRandomSkillView();
         }
         updateMateMaterial();
      }
      
      private function updateRandomSkillView() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _len)
         {
            _refreshAttriList[_loc1_].randomSkill = _equip.data ? _equip.data["randomSkill" + (_loc1_ + 1)] : -1;
            _refreshAttriList[_loc1_].randomNewSkill = -1;
            _loc1_++;
         }
         _refreshAttributeBtn.enable = false;
         _refreshReplaceBtn.enable = false;
         updateMateMaterial();
      }
      
      private function __refreshSkillHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:SmithFreshRspMsg = new SmithFreshRspMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as SmithFreshRspMsg;
         _loc3_ = 0;
         while(_loc3_ < _len)
         {
            _refreshAttriList[_loc3_].randomNewSkill = _loc2_.randomSkill[_loc3_];
            _loc3_++;
         }
         _refreshReplaceBtn.enable = true;
         updateMateMaterial();
      }
      
      private function __refreshProperty(param1:SLGSocketEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:RefreshPropertyRepMsg = new RefreshPropertyRepMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as RefreshPropertyRepMsg;
         if(_loc2_.result == 1)
         {
            _loc3_ = 0;
            while(_loc3_ < _len)
            {
               _refreshAttriList[_loc3_].randomNewSkill = _loc2_.randomSkill[_loc3_];
               _refreshAttriList[_loc3_].selected = _loc2_.lockPos[_loc3_];
               _loc3_++;
            }
            _refreshReplaceBtn.enable = true;
         }
         else
         {
            _refreshReplaceBtn.enable = false;
         }
         _refreshAttributeBtn.enable = checkIsShowBtn();
         _itemLockHandler(null);
      }
      
      private function updateMateMaterial() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Array = null;
         refreshArr = [];
         var _loc3_:GoodsInfo = _equip.data;
         if(_loc3_ && _loc3_.templateInfo)
         {
            _loc2_ = int(_loc3_.templateInfo.Refresh);
            _ownMaterialCount = GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(_loc2_);
            _needMaterialCount = _loc3_.templateInfo.Property6;
            _loc1_ = ConfigInfoManager.instance.treasureMeltingConst;
            if(_loc1_[_lockCount - 1])
            {
               _needMaterialCount += _loc3_.templateInfo.Property3 * _loc1_[_lockCount - 1];
            }
            _refreshAttributeBtn.enable = checkIsShowBtn();
         }
         else
         {
            _loc2_ = -1;
            _needMaterialCount = 0;
            _ownMaterialCount = 0;
            _refreshAttributeBtn.enable = false;
         }
         _mate.material(_loc2_,_needMaterialCount,_ownMaterialCount);
      }
      
      private function __refreshAttributeHandle(param1:MouseEvent) : void
      {
         refreshConfirm();
      }
      
      private function refreshConfirm() : void
      {
         var _loc1_:String = null;
         var _loc3_:int = 0;
         if(lockOverflow > 0 && _lockCount >= lockOverflow)
         {
            _loc1_ = LanguageMgr.GetTranslation("store.view.refresh.RefreshView.command01");
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         var _loc2_:Array = [];
         var _loc4_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _len)
         {
            _loc2_.push(_refreshAttriList[_loc3_].selected);
            if(_refreshAttriList[_loc3_].selected)
            {
               _loc4_++;
            }
            _loc3_++;
         }
         refreshArr = _loc2_;
         StoreSocketOutManager.sendRefreshforRandom(refreshArr,0,true);
      }
      
      private function get lockOverflow() : int
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         if(_equip && _equip.data)
         {
            _loc2_ = 1;
            while(_loc2_ < 6)
            {
               if(_equip.data["randomSkill" + _loc2_] > 0)
               {
                  _loc1_++;
               }
               _loc2_++;
            }
         }
         return _loc1_;
      }
      
      private function __refreshReplaceHandle(param1:MouseEvent) : void
      {
         StoreSocketOutManager.sendRefreshforReplace();
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get control() : StoreControler
      {
         return FrameControllerManager.instance.storeController;
      }
      
      private function checkIsShowBtn() : Boolean
      {
         if(!_equip.data)
         {
            return false;
         }
         if(_ownMaterialCount < _needMaterialCount)
         {
            return false;
         }
         return true;
      }
      
      override public function dispose() : void
      {
         control.clcikLockFirst = false;
         _itemDic = null;
         removeEvent();
         ObjectUtils.disposeObject(_storeBag);
         _storeBag = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

