package store.enchant
{
   import bag.events.BagEvent;
   import cell.view.storebag.StoreEnchantCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.player.PlayerEnchantMsg;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.StoreSocketOutManager;
   import mvc.controler.StoreControler;
   import mvc.module.store.StoreModel;
   import yishi.comm.PackageIn;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.SimpleDictionary;
   import yishi.view.tips.MessageTipManager;
   
   public class EnchantView extends Sprite implements Disposeable
   {
      
      private var _bg:MutipleImage;
      
      private var _enchantBtn:IconButton;
      
      private var _equip1:StoreEnchantCell;
      
      private var _equip2:StoreEnchantCell;
      
      private var _effectMC:MovieClip;
      
      private var _goodsEffectMc:MovieClip;
      
      private var _itemDic:SimpleDictionary;
      
      private var _storeFrameEquipBg:MovieClip;
      
      private var _storeFrameEquipBg2:MovieClip;
      
      private var _equipName:FilterFrameText;
      
      private var _discribleText:FilterFrameText;
      
      public function EnchantView()
      {
         super();
         initView();
         addEvent();
         initData();
      }
      
      private function get control() : StoreControler
      {
         return FrameControllerManager.instance.storeController;
      }
      
      private function get model() : StoreModel
      {
         return FrameControllerManager.instance.storeController.model;
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("store.EnchantViewBg");
         _effectMC = ComponentFactory.Instance.creatCustomObject("asset.store.intensifyEffectMC");
         _effectMC.gotoAndStop(1);
         _effectMC.addFrameScript(15,createEffect);
         _effectMC.addFrameScript(_effectMC.totalFrames - 1,cleanEffect);
         _effectMC.mouseChildren = _effectMC.mouseEnabled = false;
         _goodsEffectMc = ComponentFactory.Instance.creatCustomObject("asset.store.intensifyGoodsEffectMC");
         _goodsEffectMc.gotoAndStop(1);
         _goodsEffectMc.addFrameScript(_goodsEffectMc.totalFrames - 1,goodsEffectEnd);
         _goodsEffectMc.mouseChildren = _goodsEffectMc.mouseEnabled = false;
         _enchantBtn = ComponentFactory.Instance.creatComponentByStylename("store.EnchantBtn");
         _equip1 = ComponentFactory.Instance.creatCustomObject("store.StoreEnchantCell1");
         _equip2 = ComponentFactory.Instance.creatCustomObject("store.StoreEnchantCell2");
         _storeFrameEquipBg = ComponentFactory.Instance.creatCustomObject("store.StoreFrameEquipBg");
         _storeFrameEquipBg2 = ComponentFactory.Instance.creatCustomObject("store.StoreFrameEquipBg");
         _equipName = ComponentFactory.Instance.creatComponentByStylename("store.IntensifyEquipNameTxt");
         _equip1.sonType = -1;
         _equip1.resetTip = "yishi.view.tips.IntensifyTip";
         _equip2.sonType = 236;
         _equip2.pos = 1;
         _discribleText = ComponentFactory.Instance.creatComponentByStylename("store.discribleTxt");
         addChild(_bg);
         addChild(_effectMC);
         addChild(_goodsEffectMc);
         addChild(_enchantBtn);
         addChild(_discribleText);
         _itemDic = new SimpleDictionary();
         addChild(_storeFrameEquipBg);
         _storeFrameEquipBg.mouseEnabled = false;
         _storeFrameEquipBg.mouseChildren = true;
         _storeFrameEquipBg.x = 76;
         _storeFrameEquipBg.y = 44;
         addChild(_storeFrameEquipBg2);
         _storeFrameEquipBg2.mouseEnabled = false;
         _storeFrameEquipBg2.mouseChildren = true;
         _storeFrameEquipBg2.x = 269;
         _storeFrameEquipBg2.y = 44;
         _enchantBtn.enable = false;
         _equip1.data = null;
         _equip2.data = null;
         addChild(_equip1);
         addChild(_equip2);
         addChild(_equipName);
      }
      
      private function uninit() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_effectMC);
         _effectMC = null;
         ObjectUtils.disposeObject(_equip1);
         _equip1 = null;
         ObjectUtils.disposeObject(_equip2);
         _equip2 = null;
         ObjectUtils.disposeObject(_goodsEffectMc);
         _goodsEffectMc = null;
         ObjectUtils.disposeObject(_enchantBtn);
         _enchantBtn = null;
         ObjectUtils.disposeObject(_discribleText);
         _discribleText = null;
         ObjectUtils.disposeAllChildren(this);
         if(_itemDic)
         {
            _itemDic.clear();
         }
         _itemDic = null;
      }
      
      public function createEffect() : void
      {
         _goodsEffectMc.gotoAndPlay(2);
      }
      
      private function goodsEffectEnd() : void
      {
         _goodsEffectMc.gotoAndStop(1);
         updateView();
      }
      
      private function cleanEffect() : void
      {
         _effectMC.gotoAndStop(1);
         _goodsEffectMc.gotoAndStop(1);
      }
      
      private function initData() : void
      {
         _itemDic.add("0_0_0",_equip1);
         _itemDic.add("1_0_0",_equip2);
         updateView();
      }
      
      private function addEvent() : void
      {
         if(_enchantBtn)
         {
            _enchantBtn.addEventListener("click",__onEnchantBtnHandler);
         }
         GoodsManager.instance.addEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__bagItemDeleteHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4788,__enchantResultHandler);
      }
      
      private function removeEvent() : void
      {
         if(_enchantBtn)
         {
            _enchantBtn.removeEventListener("click",__onEnchantBtnHandler);
         }
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__bagItemDeleteHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4788,__enchantResultHandler);
      }
      
      private function __onEnchantBtnHandler(param1:MouseEvent) : void
      {
         var _loc7_:String = null;
         var _loc5_:SkillTempInfo = null;
         var _loc4_:GoodsInfo = _equip1.data;
         var _loc8_:GoodsInfo = _equip2.data;
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc6_:String = LanguageMgr.GetTranslation("public.prompt");
         if(_loc4_.enchantSkillId == 0)
         {
            sendItemEnchant();
         }
         else
         {
            _loc5_ = TempleteManager.instance.getSkillById(_loc4_.enchantSkillId);
            SimpleAlertHelper.instance.data = [__enchantConfirm];
            if(_loc5_.MasterType == _loc8_.templateInfo.Property4)
            {
               _loc7_ = LanguageMgr.GetTranslation("Store.EnchantView.sameAlertTip");
            }
            else
            {
               _loc7_ = LanguageMgr.GetTranslation("Store.EnchantView.newAlertTip");
            }
            SimpleAlertHelper.instance.popAlerFrame(_loc6_,_loc7_,_loc2_,_loc3_,true,false,false);
         }
      }
      
      private function __enchantConfirm(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            sendItemEnchant();
         }
      }
      
      private function sendItemEnchant() : void
      {
         StoreSocketOutManager.sendEnchant(_equip1.data.templateId);
      }
      
      protected function __bagItemUpdateHandler(param1:BagEvent) : void
      {
         var _loc3_:GoodsInfo = param1.info;
         var _loc2_:StoreEnchantCell = _itemDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         if(_loc2_ && model.selectedPanel == "STORE_PANEL_ENCHANT")
         {
            _loc2_.data = _loc3_;
         }
         updateView();
      }
      
      private function __bagItemDeleteHandler(param1:BagEvent) : void
      {
         var _loc3_:GoodsInfo = param1.info;
         var _loc2_:StoreEnchantCell = _itemDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         if(_loc2_ && model.selectedPanel == "STORE_PANEL_ENCHANT")
         {
            _loc2_.data = null;
         }
         updateView();
      }
      
      protected function __enchantResultHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:PlayerEnchantMsg = new PlayerEnchantMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as PlayerEnchantMsg;
         SoundManager.instance.play("013",true);
         _effectMC.gotoAndPlay(1);
         var _loc5_:GoodsInfo = GoodsManager.instance.getHideBagItemByPos(_loc2_.pos);
         _loc5_.objectId = _loc2_.objectId;
         _loc5_.bagType = _loc2_.bagType;
         _loc5_.pos = _loc2_.pos;
         var _loc3_:StoreEnchantCell = _itemDic[_loc5_.pos + "_" + _loc5_.objectId + "_" + _loc5_.bagType];
         if(_loc3_)
         {
            _loc3_.data = _loc5_;
         }
         _equip1.data = _loc5_;
         _discribleText.visible = false;
         MessageTipManager.instance().show(LanguageMgr.GetTranslation("view.store.enchant.success"));
      }
      
      private function get enchantProp() : GoodsTemplateInfo
      {
         return TempleteManager.instance.goodsTemplateCate.getGoodsTemplatesBySonTypeAndProperty2(236,_equip1.data.templateInfo.Profile);
      }
      
      private function updateView() : void
      {
         if(_equip1 && _equip1.data)
         {
            _equipName.setFrame(_equip1.data.templateInfo.Profile);
            _equipName.text = _equip1.data.templateInfo.TemplateName;
            if(_equip2 && _equip2.data)
            {
               _enchantBtn.enable = true;
            }
            else
            {
               _enchantBtn.enable = false;
            }
         }
         else
         {
            _enchantBtn.enable = false;
            _equipName.text = "";
         }
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

