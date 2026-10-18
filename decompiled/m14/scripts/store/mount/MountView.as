package store.mount
{
   import bag.events.BagEvent;
   import bag.helper.BagHelper;
   import cell.view.storebag.StoreJewelCell;
   import cell.view.storebag.StoreMountCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.controler.StoreControler;
   import mvc.module.store.StoreModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.CursorManagerII;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.utils.SimpleDictionary;
   import yishi.view.community.BaseItemView;
   
   public class MountView extends Sprite implements Disposeable
   {
      
      private var _bg1:MutipleImage;
      
      private var _equip:StoreMountCell;
      
      private var _jewelItem1:StoreJewelCell;
      
      private var _jewelItem2:StoreJewelCell;
      
      private var _jewelItem3:StoreJewelCell;
      
      private var _jewelItem4:StoreJewelCell;
      
      private var _removeJewelBtn:BaseButton;
      
      private var _itemDic:SimpleDictionary;
      
      private var _jewelList:Vector.<StoreJewelCell>;
      
      private var _storeFrameEquipBg:MovieClip;
      
      private var _jobTipIcon:Bitmap;
      
      private var _jobTipTxt:FilterFrameText;
      
      private var _epicTipTxt:FilterFrameText;
      
      public function MountView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function get model() : StoreModel
      {
         return control.model;
      }
      
      private function get control() : StoreControler
      {
         return FrameControllerManager.instance.storeController;
      }
      
      private function initView() : void
      {
         _jewelList = new Vector.<StoreJewelCell>();
         _bg1 = ComponentFactory.Instance.creatComponentByStylename("store.MountViewBg");
         _jewelItem1 = ComponentFactory.Instance.creatCustomObject("store.mount.JewelItem1",[1]);
         _jewelItem2 = ComponentFactory.Instance.creatCustomObject("store.mount.JewelItem2",[2]);
         _jewelItem3 = ComponentFactory.Instance.creatCustomObject("store.mount.JewelItem3",[3]);
         _jewelItem4 = ComponentFactory.Instance.creatCustomObject("store.mount.JewelItem4",[4]);
         _equip = ComponentFactory.Instance.creatCustomObject("store.MountEquiItem");
         _equip.sonType = -1;
         _equip.pos = 0;
         _removeJewelBtn = ComponentFactory.Instance.creatComponentByStylename("store.MountRemoveJewelBtn");
         _storeFrameEquipBg = ComponentFactory.Instance.creatCustomObject("store.StoreFrameEquipBg");
         _jobTipIcon = ComponentFactory.Instance.creatBitmap("asset.store.MountJobTipIcon");
         _jobTipTxt = ComponentFactory.Instance.creatComponentByStylename("store.MountJobTipTxt");
         _epicTipTxt = ComponentFactory.Instance.creatComponentByStylename("store.MountEpicTipTxt");
         addChild(_bg1);
         addChild(_jewelItem1);
         addChild(_jewelItem2);
         addChild(_jewelItem3);
         addChild(_jewelItem4);
         _jewelList.push(_jewelItem1);
         _jewelList.push(_jewelItem2);
         _jewelList.push(_jewelItem3);
         _jewelList.push(_jewelItem4);
         addChild(_equip);
         addChild(_removeJewelBtn);
         _itemDic = new SimpleDictionary(true);
         _itemDic.add("0_0_0",_equip);
         _itemDic.add("1_0_0",_jewelItem1);
         _itemDic.add("2_0_0",_jewelItem2);
         _itemDic.add("3_0_0",_jewelItem3);
         _itemDic.add("4_0_0",_jewelItem4);
         addChild(_storeFrameEquipBg);
         _storeFrameEquipBg.mouseEnabled = false;
         _storeFrameEquipBg.mouseChildren = true;
         _storeFrameEquipBg.x = 170;
         _storeFrameEquipBg.y = 117;
         addChild(_jobTipIcon);
         addChild(_jobTipTxt);
         refreshJobTip();
         addChild(_epicTipTxt);
         _epicTipTxt.visible = false;
         updateView();
      }
      
      private function uninit() : void
      {
         CursorManagerII.instance.resetCursor();
         ObjectUtils.disposeAllChildren(this);
         _itemDic = null;
         _removeJewelBtn = null;
         _jewelList = null;
         _equip = null;
      }
      
      private function refreshJobTip() : void
      {
         switch(int(thane.templateInfo.Job) - 1)
         {
            case 0:
               _jobTipTxt.text = LanguageMgr.GetTranslation("store.view.mount.MountView.JobTipTxt2");
               break;
            case 1:
               _jobTipTxt.text = LanguageMgr.GetTranslation("store.view.mount.MountView.JobTipTxt3");
               break;
            case 2:
               _jobTipTxt.text = LanguageMgr.GetTranslation("store.view.mount.MountView.JobTipTxt1");
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function setJeweTip() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            if(!_jewelList[_loc1_].lock)
            {
               if(_equip.data && _loc1_ == 3)
               {
                  if(_equip.data.isViceEquip && _equip.data.templateInfo.Profile < 4)
                  {
                     _epicTipTxt.text = LanguageMgr.GetTranslation("store.view.mount.MountView.epicLockVice");
                     _epicTipTxt.visible = true;
                  }
                  else if(!_equip.data.isViceEquip && _equip.data.templateInfo.Profile < 5)
                  {
                     _epicTipTxt.text = LanguageMgr.GetTranslation("store.view.mount.MountView.epicLock");
                     _epicTipTxt.visible = true;
                  }
                  else
                  {
                     _epicTipTxt.visible = false;
                  }
               }
               if(getTipData(_loc1_ + 1) == "")
               {
                  ShowTipManager.Instance.hideTip(_jewelList[_loc1_]);
                  _jewelList[_loc1_].tipData = null;
               }
               else
               {
                  _jewelList[_loc1_].tipData = getTipData(_loc1_ + 1);
               }
            }
            _loc1_++;
         }
      }
      
      private function getTipData(param1:int) : String
      {
         if(!_equip.data)
         {
            return "";
         }
         return this["_jewelItem" + param1].notOpen ? LanguageMgr.GetTranslation("store.view.mount.MountView.lock") : "";
      }
      
      private function addEvent() : void
      {
         _removeJewelBtn.addEventListener("click",__onRemoveJewelHandler);
         GoodsManager.instance.addEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__bagItemDeleteHandler);
      }
      
      private function removeEvent() : void
      {
         _removeJewelBtn.removeEventListener("click",__onRemoveJewelHandler);
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__bagItemDeleteHandler);
      }
      
      protected function __onRemoveJewelHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         BagHelper.instance.removeJewel();
      }
      
      protected function __bagItemUpdateHandler(param1:BagEvent) : void
      {
         var _loc3_:GoodsInfo = param1.info;
         var _loc2_:BaseItemView = _itemDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         if(_loc2_ && visible)
         {
            _loc2_.data = _loc3_;
            updateView();
         }
      }
      
      private function __bagItemDeleteHandler(param1:BagEvent) : void
      {
         var _loc3_:GoodsInfo = param1.info;
         var _loc2_:BaseItemView = _itemDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         if(_loc2_)
         {
            _loc2_.data = null;
            updateView();
         }
      }
      
      private function __isViceHeroChangeHandler(param1:PlayerEvent) : void
      {
         refreshJobTip();
      }
      
      private function updateView() : void
      {
         if(_equip.data)
         {
            setJewel();
            control.mountViewEquipIsBinds = _equip.data.isBinds;
         }
         else
         {
            clearJewel();
         }
         setJeweTip();
      }
      
      private function clearJewel() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            _jewelList[_loc1_].data = null;
            _loc1_++;
         }
      }
      
      private function setJewel() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            _jewelList[_loc1_].data = _equip.data;
            _loc1_++;
         }
      }
      
      private function getGoodsInfo(param1:int) : GoodsInfo
      {
         var _loc2_:GoodsInfo = new GoodsInfo();
         _loc2_.templateId = param1;
         _loc2_.isBinds = true;
         return _loc2_;
      }
      
      public function get equip() : StoreMountCell
      {
         return _equip;
      }
      
      public function get jewelItem1() : StoreJewelCell
      {
         return _jewelItem1;
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninit();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

