package store.treasure
{
   import bag.events.BagEvent;
   import cell.view.storebag.StoreIntensifyCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.store.StoreRspMsg;
   import flash.display.Bitmap;
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
   import yishi.datas.templates.TheseusTreasureGrowupInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.SimpleDictionary;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class TreasureIntensifyView extends Sprite implements Disposeable
   {
      
      private var _bg:MutipleImage;
      
      private var _bg2:MutipleImage;
      
      private var _maxImg:Bitmap;
      
      private var _intensifyBtn:IconButton;
      
      private var _equip1:StoreIntensifyCell;
      
      private var _equip2:StoreIntensifyCell;
      
      private var _effectMC:MovieClip;
      
      private var _goodsEffectMc:MovieClip;
      
      private var _successWord:MovieClip;
      
      private var _itemDic:SimpleDictionary;
      
      private var _storeFrameEquipBg:MovieClip;
      
      private var _storeFrameEquipBg2:MovieClip;
      
      private var _storeFrameEquipBg3:MovieClip;
      
      private var _nextBg:ScaleBitmapImage;
      
      private var _equipFortify1:Bitmap;
      
      private var _endLookBmp:Bitmap;
      
      private var _endLookBmp1:Bitmap;
      
      private var _endLookBmp2:Bitmap;
      
      private var _equipName:FilterFrameText;
      
      private var _equipNameAdd:FilterFrameText;
      
      private var _propTxt:FilterFrameText;
      
      private var _propertyVBox:VBox;
      
      private var _newPropertyVBox:VBox;
      
      private var _storeBag:TreasureStoreBag;
      
      private var _nextBaseItem:BaseItemView;
      
      private var _endLookBaseItem:BaseItemView;
      
      public function TreasureIntensifyView()
      {
         super();
         initView();
         addEvent();
         initData();
      }
      
      private function get model() : StoreModel
      {
         return FrameControllerManager.instance.storeController.model;
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("store.IntensifyViewBg.treasure1");
         _bg2 = ComponentFactory.Instance.creatComponentByStylename("store.IntensifyViewBg.treasure2");
         _maxImg = ComponentFactory.Instance.creatBitmap("asset.store.StrengMux");
         _effectMC = ComponentFactory.Instance.creatCustomObject("asset.store.intensifyEffectMC");
         _effectMC.gotoAndStop(1);
         _effectMC.addFrameScript(15,createEffect);
         _effectMC.addFrameScript(23,createSuccessWord);
         _effectMC.addFrameScript(_effectMC.totalFrames - 1,cleanEffect);
         _effectMC.mouseChildren = _effectMC.mouseEnabled = false;
         _successWord = ComponentFactory.Instance.creatCustomObject("asset.store.intensifyEffectMCSuccessWord");
         _successWord.gotoAndStop(1);
         _successWord.mouseChildren = _successWord.mouseEnabled = false;
         _goodsEffectMc = ComponentFactory.Instance.creatCustomObject("asset.store.intensifyGoodsEffectMC");
         _goodsEffectMc.gotoAndStop(1);
         _goodsEffectMc.addFrameScript(_goodsEffectMc.totalFrames - 1,goodsEffectEnd);
         _goodsEffectMc.mouseChildren = _goodsEffectMc.mouseEnabled = false;
         _intensifyBtn = ComponentFactory.Instance.creatComponentByStylename("store.StrengthenBtn");
         _equip1 = ComponentFactory.Instance.creatCustomObject("store.StoreIntensifyCell.treasure");
         _equip2 = ComponentFactory.Instance.creatCustomObject("store.StoreIntensifyCell3");
         _storeFrameEquipBg = ComponentFactory.Instance.creatCustomObject("store.StoreFrameEquipBg");
         _storeFrameEquipBg2 = ComponentFactory.Instance.creatCustomObject("store.StoreFrameEquipBg");
         _storeFrameEquipBg3 = ComponentFactory.Instance.creatCustomObject("store.StoreFrameEquipBg");
         _equipName = ComponentFactory.Instance.creatComponentByStylename("store.IntensifyEquipNameTxt");
         _equipNameAdd = ComponentFactory.Instance.creatComponentByStylename("store.IntensifyEquipAddNatureTxt");
         _equipFortify1 = ComponentFactory.Instance.creatBitmap("asset.mainToolBar.IntensifyIcon");
         _endLookBmp = ComponentFactory.Instance.creatBitmap("asset.store.CastTopPreviewEquipBg1");
         _endLookBmp1 = ComponentFactory.Instance.creatBitmap("asset.store.CastTopPreviewTxtImg");
         _endLookBmp2 = ComponentFactory.Instance.creatBitmap("asset.store.CastTopPreviewEquipBg2");
         _nextBaseItem = ComponentFactory.Instance.creatCustomObject("store.IntensifyNextItem");
         _endLookBaseItem = ComponentFactory.Instance.creatCustomObject("store.IntensifyEquipItem");
         _propTxt = ComponentFactory.Instance.creatComponentByStylename("store.IntensifyPropTxt");
         _propertyVBox = ComponentFactory.Instance.creatCustomObject("store.propertyVBox");
         _newPropertyVBox = ComponentFactory.Instance.creatCustomObject("store.newPropertyVBox");
         _storeBag = ComponentFactory.Instance.creatCustomObject("StoreView1.StoreBag.treasure");
         _nextBg = ComponentFactory.Instance.creatComponentByStylename("store.IntensifyBack3");
         _equip1.sonType = -1;
         _equip1.resetTip = "yishi.view.tips.TreasureIntensifyTip";
         _equip2.sonType = 204;
         _equip2.pos = 1;
         _equip2.buttonMode = false;
         addChild(_bg);
         addChild(_bg2);
         _bg2.visible = false;
         addChild(_maxImg);
         _maxImg.y = 246;
         addChild(_equip1);
         addChild(_equip2);
         addChild(_effectMC);
         addChild(_goodsEffectMc);
         addChild(_successWord);
         _itemDic = new SimpleDictionary();
         addChild(_nextBg);
         addChild(_nextBaseItem);
         addChild(_storeFrameEquipBg);
         _storeFrameEquipBg.mouseEnabled = false;
         _storeFrameEquipBg.mouseChildren = true;
         _storeFrameEquipBg.x = 76;
         _storeFrameEquipBg.y = 49;
         addChild(_storeFrameEquipBg2);
         _storeFrameEquipBg2.mouseEnabled = false;
         _storeFrameEquipBg2.mouseChildren = true;
         _storeFrameEquipBg2.x = 269;
         _storeFrameEquipBg2.y = 49;
         addChild(_storeFrameEquipBg3);
         _storeFrameEquipBg3.mouseEnabled = false;
         _storeFrameEquipBg3.mouseChildren = false;
         _storeFrameEquipBg3.x = 170;
         _storeFrameEquipBg3.y = 150;
         addChild(_propTxt);
         addChild(_equipName);
         addChild(_equipFortify1);
         addChild(_endLookBmp2);
         addChild(_endLookBmp);
         addChild(_endLookBmp1);
         addChild(_endLookBaseItem);
         _endLookBmp.x = 310;
         _endLookBmp.y = 250;
         _endLookBmp1.x = 280;
         _endLookBmp1.y = 318;
         _endLookBmp2.x = 310;
         _endLookBmp2.y = 250;
         addChild(_equipNameAdd);
         addChild(_propertyVBox);
         addChild(_newPropertyVBox);
         __onIntensifyBtnOut(null);
         addChild(_intensifyBtn);
         addChild(_storeBag);
         _storeBag.y = 6;
         _storeBag.defaultView();
         _equipFortify1.x = 160;
         _equipFortify1.y = 140;
      }
      
      private function uninit() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_bg2);
         _bg2 = null;
         ObjectUtils.disposeObject(_effectMC);
         _effectMC = null;
         ObjectUtils.disposeObject(_equip1);
         _equip1 = null;
         ObjectUtils.disposeObject(_equip2);
         _equip2 = null;
         ObjectUtils.disposeObject(_endLookBmp);
         _endLookBmp = null;
         ObjectUtils.disposeObject(_endLookBmp1);
         _endLookBmp1 = null;
         ObjectUtils.disposeObject(_endLookBmp2);
         _endLookBmp2 = null;
         ObjectUtils.disposeObject(_nextBaseItem);
         _nextBaseItem = null;
         ObjectUtils.disposeObject(_nextBg);
         _nextBg = null;
         ObjectUtils.disposeObject(_endLookBaseItem);
         _endLookBaseItem = null;
         ObjectUtils.disposeObject(_goodsEffectMc);
         _goodsEffectMc = null;
         ObjectUtils.disposeObject(_successWord);
         _successWord = null;
         ObjectUtils.disposeObject(_intensifyBtn);
         _intensifyBtn = null;
         ObjectUtils.disposeObject(_propTxt);
         _propTxt = null;
         ObjectUtils.disposeObject(_storeBag);
         _storeBag = null;
         ObjectUtils.disposeAllChildren(this);
         _itemDic.clear();
         _itemDic = null;
      }
      
      public function createEffect() : void
      {
         _goodsEffectMc.gotoAndPlay(2);
      }
      
      private function goodsEffectEnd() : void
      {
         model.isIntensifing = false;
         _goodsEffectMc.gotoAndStop(1);
         updateView();
      }
      
      private function createSuccessWord() : void
      {
         if(!_equip1)
         {
            return;
         }
         if(!_equip1.data)
         {
            return;
         }
         if(_equip1.data.isViceEquip)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("store.Intensify.IntensifyView.successWord.text"));
         }
         else
         {
            _successWord.gotoAndPlay(2);
         }
      }
      
      private function cleanEffect() : void
      {
         _effectMC.gotoAndStop(1);
         _goodsEffectMc.gotoAndStop(1);
         _successWord.gotoAndStop(1);
      }
      
      private function initData() : void
      {
         _itemDic.add("0_0_0",_equip1);
         _itemDic.add("1_0_0",_equip2);
         updateView();
      }
      
      private function addEvent() : void
      {
         if(_intensifyBtn)
         {
            _intensifyBtn.addEventListener("click",__onIntensifyBtnHandler);
         }
         GoodsManager.instance.addEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__bagItemDeleteHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 86,__intensifyResult);
         NotificationManager.instance.addEventListener("STORE_TREASURE_BAG_UPDATE",__treasureBagUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         if(_intensifyBtn)
         {
            _intensifyBtn.removeEventListener("click",__onIntensifyBtnHandler);
         }
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__bagItemDeleteHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 86,__intensifyResult);
         NotificationManager.instance.removeEventListener("STORE_TREASURE_BAG_UPDATE",__treasureBagUpdateHandler);
      }
      
      private function __treasureBagUpdateHandler(param1:NotificationEvent) : void
      {
         _bg.visible = param1.data == 0;
         _bg2.visible = param1.data != 0;
         control.moveGoodsBack();
      }
      
      private function __onIntensifyBtnOut(param1:MouseEvent) : void
      {
         _equipFortify1.visible = false;
         _equipNameAdd.text = "";
         _propertyVBox.removeAllChild();
         _newPropertyVBox.removeAllChild();
      }
      
      private function __onIntensifyBtnOver(param1:MouseEvent) : void
      {
         updateEquipNatureView();
      }
      
      private function __onIntensifyBtnHandler(param1:MouseEvent) : void
      {
         strengthen();
      }
      
      private function strengthen() : void
      {
         cleanEffect();
         _intensifyBtn.enable = false;
         model.isIntensifing = true;
         sendItemIntensify();
         __onIntensifyBtnOut(null);
      }
      
      private function strengthenAndSaveSO(param1:Boolean) : void
      {
         var _loc2_:Date = new Date();
         SharedManager.instance.setProperty("IS_STRENGTHEN",param1,"STRENGTHEN_CHECK_DATE",_loc2_);
         strengthen();
      }
      
      private function __intensifyConfirm(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            _intensifyBtn.enable = false;
            model.isIntensifing = true;
            sendItemIntensify();
         }
         else
         {
            _intensifyBtn.enable = true;
            model.isIntensifing = false;
         }
      }
      
      private function sendItemIntensify() : void
      {
         StoreSocketOutManager.sendTreasureIntensify();
      }
      
      protected function __bagItemUpdateHandler(param1:BagEvent) : void
      {
         var _loc3_:GoodsInfo = param1.info;
         var _loc2_:StoreIntensifyCell = _itemDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         if(_loc2_)
         {
            _loc2_.data = _loc3_;
            updateView();
         }
      }
      
      private function __bagItemDeleteHandler(param1:BagEvent) : void
      {
         var _loc3_:GoodsInfo = param1.info;
         var _loc2_:StoreIntensifyCell = _itemDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         if(_loc2_)
         {
            if(_loc2_.data != null && _loc2_.data.templateInfo && _loc2_.data.templateInfo.SonType != 204)
            {
               _endLookBaseItem.data = null;
               _nextBaseItem.data = null;
            }
            _loc2_.data = null;
            updateView();
         }
      }
      
      protected function __intensifyResult(param1:SLGSocketEvent) : void
      {
         var _loc5_:GoodsInfo = null;
         var _loc3_:StoreIntensifyCell = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:StoreRspMsg = new StoreRspMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as StoreRspMsg;
         if(_loc2_.strengResult)
         {
            SoundManager.instance.play("013",true);
            _effectMC.gotoAndPlay(1);
            _loc5_ = GoodsManager.instance.getHideBagItemByPos(_loc2_.pos);
            _loc5_.objectId = _loc2_.objectId;
            _loc5_.bagType = _loc2_.bagType;
            _loc5_.strengthenGrade = _loc2_.strengthenGrade;
            _loc3_ = _itemDic[_loc5_.pos + "_" + _loc5_.objectId + "_" + _loc5_.bagType];
            if(_loc3_)
            {
               _loc3_.data = _loc5_;
            }
            GoodsManager.instance.dispatchEvent(new BagEvent("INTENSIFY_GOODS",null));
         }
         else
         {
            SoundManager.instance.play("012",true);
            createEffect();
         }
         updateEquipNatureView();
      }
      
      private function updateEquipNatureView() : void
      {
         var _loc1_:GoodsTemplateInfo = null;
         var _loc2_:int = 0;
         var _loc3_:GoodsInfo = _equip1.data;
         if(_loc3_ && !model.isIntensifing)
         {
            _loc1_ = _loc3_.templateInfo;
            if(_loc1_.StrengthenMax > _loc3_.strengthenGrade)
            {
               _equipFortify1.visible = true;
               _loc2_ = _loc3_.strengthenGrade + 1;
               _equipNameAdd.text = "" + _loc2_;
               initAttribute(_loc3_,_loc3_.templateInfo);
            }
         }
      }
      
      private function updateView() : void
      {
         var _loc1_:GoodsInfo = null;
         var _loc6_:TheseusTreasureGrowupInfo = null;
         var _loc2_:GoodsTemplateInfo = null;
         var _loc3_:GoodsInfo = null;
         var _loc5_:GoodsInfo = null;
         var _loc7_:GoodsInfo = _equip1.data;
         _propTxt.text = "";
         _propTxt.setFrame(1);
         _intensifyBtn.enable = false;
         var _loc4_:int = 0;
         if(_loc7_)
         {
            if(!model.isIntensifing)
            {
               _loc2_ = _loc7_.templateInfo;
               if(_loc2_.StrengthenMax > _loc7_.strengthenGrade)
               {
                  _loc6_ = getGrowupInfo(_loc7_.templateId,_loc7_.strengthenGrade);
                  if(_loc6_)
                  {
                     _loc4_ = int(GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(_loc6_.StrengthenItem));
                     _loc1_ = new GoodsInfo();
                     _loc1_.templateId = _loc6_.StrengthenItem;
                     _loc1_.count = _loc4_;
                     _equip2.data = _loc1_;
                     if(_loc1_)
                     {
                        _propTxt.text = _loc4_ + "/" + _loc6_.StrengthenItemNum;
                        if(_loc4_ >= _loc6_.StrengthenItemNum)
                        {
                           _propTxt.setFrame(1);
                           _intensifyBtn.enable = true;
                        }
                        else
                        {
                           _propTxt.setFrame(2);
                        }
                     }
                  }
                  _maxImg.visible = false;
               }
               else
               {
                  _maxImg.visible = true;
               }
               _equipName.setFrame(_loc7_.templateInfo.Profile);
               _equipName.text = _loc7_.templateInfo.TemplateName + getStrengthenGrade(_loc7_);
            }
            else
            {
               _maxImg.visible = false;
               _equipName.text = "";
            }
            _loc6_ = getGrowupInfo(_loc7_.templateId,_loc7_.templateInfo.StrengthenMax);
            _loc3_ = copyGoods(_loc7_,_loc6_);
            _endLookBaseItem.data = _loc3_;
            _loc6_ = getGrowupInfo(_loc7_.templateId,_loc7_.strengthenGrade + 1);
            if(!_loc6_)
            {
               _nextBg.visible = false;
               _nextBaseItem.data = null;
               _storeFrameEquipBg3.visible = false;
               return;
            }
            _nextBg.visible = true;
            _storeFrameEquipBg3.visible = true;
            _loc5_ = copyGoods(_loc7_,_loc6_);
            _nextBaseItem.data = _loc5_;
         }
         else
         {
            _equip2.data = null;
            _maxImg.visible = false;
            _equipName.text = "";
         }
      }
      
      private function copyGoods(param1:GoodsInfo, param2:TheseusTreasureGrowupInfo) : GoodsInfo
      {
         var _loc3_:GoodsInfo = new GoodsInfo();
         _loc3_.templateId = param2.TreasureId;
         _loc3_.strengthenGrade = param2.TreasureLevel;
         _loc3_.templateInfo.Attack = param2.PhyAttack;
         _loc3_.templateInfo.Defence = param2.PhyDefence;
         _loc3_.templateInfo.MagicAttack = param2.MagicAttack;
         _loc3_.templateInfo.MagicDefence = param2.MagicDefence;
         _loc3_.templateInfo.ForceHit = param2.ForceHit;
         _loc3_.templateInfo.Live = param2.Live;
         _loc3_.templateInfo.Parry = param2.Parry;
         _loc3_.templateInfo.Penetrate = param2.Penetrate;
         _loc3_.templateInfo.ReduceResi = param2.ReduceResi;
         _loc3_.templateInfo.FireResi = param2.FireResi;
         _loc3_.templateInfo.WaterResi = param2.WaterResi;
         _loc3_.templateInfo.ElectResi = param2.ElectResi;
         _loc3_.templateInfo.WindResi = param2.WindResi;
         _loc3_.templateInfo.DarkResi = param2.DarkResi;
         _loc3_.templateInfo.LightResi = param2.LightResi;
         _loc3_.templateInfo.ReduceResiAgainst = param2.ReduceResiAgainst;
         _loc3_.templateInfo.ResiPenetrate = param2.ResiPenetrate;
         _loc3_.randomSkill1 = param1.randomSkill1;
         _loc3_.randomSkill2 = param1.randomSkill2;
         _loc3_.randomSkill3 = param1.randomSkill3;
         _loc3_.randomSkill4 = param1.randomSkill4;
         _loc3_.randomSkill5 = param1.randomSkill5;
         return _loc3_;
      }
      
      private function initAttribute(param1:GoodsInfo, param2:GoodsTemplateInfo) : void
      {
         var _loc5_:FilterFrameText = null;
         _propertyVBox.removeAllChild();
         _newPropertyVBox.removeAllChild();
         var _loc3_:String = "";
         var _loc6_:int = 0;
         var _loc7_:TheseusTreasureGrowupInfo = getGrowupInfo(param1.templateId,param1.strengthenGrade);
         if(_loc7_)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc7_.attNames.length)
            {
               _loc3_ = _loc7_.attNames[_loc6_];
               _loc5_ = ComponentFactory.Instance.creatComponentByStylename("store.IntensifyEquipNatureTxt2");
               _loc5_.text = _loc3_ + " " + _loc7_.attValues[_loc6_];
               _propertyVBox.addChild(_loc5_);
               _loc6_++;
            }
         }
         var _loc4_:TheseusTreasureGrowupInfo = getGrowupInfo(param1.templateId,param1.strengthenGrade + 1);
         if(_loc4_)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc4_.attNames.length)
            {
               _loc5_ = ComponentFactory.Instance.creatComponentByStylename("store.IntensifyEquipAddNatureTxt2");
               _loc5_.text = "" + _loc4_.attValues[_loc6_];
               _newPropertyVBox.addChild(_loc5_);
               _loc6_++;
            }
         }
      }
      
      private function getGrowupInfo(param1:int, param2:int) : TheseusTreasureGrowupInfo
      {
         return TempleteManager.instance.theseusTreasureGrowupCate.getTempInfoByIdLevel(param1,param2);
      }
      
      private function getStrengthenGrade(param1:GoodsInfo) : Object
      {
         return param1.strengthenGrade > 0 ? "+" + param1.strengthenGrade : "";
      }
      
      private function get control() : StoreControler
      {
         return FrameControllerManager.instance.storeController;
      }
      
      public function dispose() : void
      {
         model.isIntensifing = false;
         removeEvent();
         uninit();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

