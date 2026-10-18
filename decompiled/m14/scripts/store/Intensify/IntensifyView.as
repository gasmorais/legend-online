package store.Intensify
{
   import bag.events.BagEvent;
   import bag.helper.GoodsCheck;
   import cell.view.storebag.StoreIntensifyCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.store.StoreRspMsg;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.controler.StoreControler;
   import mvc.module.store.StoreModel;
   import yishi.comm.PackageIn;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.ResourceManager;
   import yishi.manager.SharedManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.GoodsHelp;
   import yishi.utils.SimpleDictionary;
   import yishi.utils.StoreHelper;
   import yishi.utils.StringHelper;
   import yishi.view.community.BaseItemView;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class IntensifyView extends Sprite implements Disposeable
   {
      
      private var _bg:MutipleImage;
      
      private var _needGodlImg:Image;
      
      private var _successImg:Image;
      
      private var _maxImg:Bitmap;
      
      private var _intensifyBtn:IconButton;
      
      private var _neededGold:FilterFrameText;
      
      private var _successratesTxt:FilterFrameText;
      
      private var _equip1:StoreIntensifyCell;
      
      private var _equip2:StoreIntensifyCell;
      
      private var _effectMC:MovieClip;
      
      private var _goodsEffectMc:MovieClip;
      
      private var _successWord:MovieClip;
      
      private var _failWord:MovieClip;
      
      private var _itemDic:SimpleDictionary;
      
      private var _storeFrameEquipBg:MovieClip;
      
      private var _storeFrameEquipBg2:MovieClip;
      
      private var _equipFortify1:Bitmap;
      
      private var _equipFortify2:Bitmap;
      
      private var _equipFortify3:Bitmap;
      
      private var _endLookBmp:Bitmap;
      
      private var _endLookBmp1:Bitmap;
      
      private var _endLookBmp2:Bitmap;
      
      private var _equipNatureTxt1:FilterFrameText;
      
      private var _equipAddNatureTxt1:FilterFrameText;
      
      private var _equipNatureTxt2:FilterFrameText;
      
      private var _equipAddNatureTxt2:FilterFrameText;
      
      private var _equipName:FilterFrameText;
      
      private var _equipNameAdd:FilterFrameText;
      
      private var _blessBar:MovieImage;
      
      private var _blessTxt:FilterFrameText;
      
      private var _blessValueTxt:FilterFrameText;
      
      private var _propTxt:FilterFrameText;
      
      private var _endLookBaseItem:BaseItemView;
      
      private var lastEquipId:int = 0;
      
      private var _propIsEnough:Boolean = false;
      
      public function IntensifyView()
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
         _bg = ComponentFactory.Instance.creatComponentByStylename("store.IntensifyViewBg");
         _needGodlImg = ComponentFactory.Instance.creatComponentByStylename("store.IntensifyNeededGoldTxtImg");
         _successImg = ComponentFactory.Instance.creatComponentByStylename("store.IntensifySuccessratesTxtImg");
         _maxImg = ComponentFactory.Instance.creatBitmap("asset.store.StrengMux");
         _effectMC = ComponentFactory.Instance.creatCustomObject("asset.store.intensifyEffectMC");
         _effectMC.gotoAndStop(1);
         _effectMC.addFrameScript(15,createEffect);
         _effectMC.addFrameScript(23,createSuccessWord);
         _effectMC.addFrameScript(_effectMC.totalFrames - 1,cleanEffect);
         _effectMC.mouseChildren = _effectMC.mouseEnabled = false;
         _successWord = ComponentFactory.Instance.creatCustomObject("asset.store.intensifyEffectMCSuccessWord");
         _failWord = ComponentFactory.Instance.creatCustomObject("asset.store.intensifyEffectMCFailWord");
         _successWord.gotoAndStop(1);
         _successWord.mouseChildren = _successWord.mouseEnabled = false;
         _failWord.gotoAndStop(1);
         _failWord.mouseChildren = _failWord.mouseEnabled = false;
         _failWord.addFrameScript(_failWord.totalFrames - 1,cleanEffect);
         _goodsEffectMc = ComponentFactory.Instance.creatCustomObject("asset.store.intensifyGoodsEffectMC");
         _goodsEffectMc.gotoAndStop(1);
         _goodsEffectMc.addFrameScript(_goodsEffectMc.totalFrames - 1,goodsEffectEnd);
         _goodsEffectMc.mouseChildren = _goodsEffectMc.mouseEnabled = false;
         _goodsEffectMc.y = 60;
         _intensifyBtn = ComponentFactory.Instance.creatComponentByStylename("store.StrengthenBtn");
         _neededGold = ComponentFactory.Instance.creatComponentByStylename("store.IntensifyNeededGoldTxt");
         _successratesTxt = ComponentFactory.Instance.creatComponentByStylename("store.IntensifySuccessratesTxt");
         _equip1 = ComponentFactory.Instance.creatCustomObject("store.StoreIntensifyCell1");
         _equip2 = ComponentFactory.Instance.creatCustomObject("store.StoreIntensifyCell2");
         _storeFrameEquipBg = ComponentFactory.Instance.creatCustomObject("store.StoreFrameEquipBg");
         _storeFrameEquipBg2 = ComponentFactory.Instance.creatCustomObject("store.StoreFrameEquipBg");
         _equipName = ComponentFactory.Instance.creatComponentByStylename("store.IntensifyEquipNameTxt");
         _equipNameAdd = ComponentFactory.Instance.creatComponentByStylename("store.IntensifyEquipAddNatureTxt");
         _equipNatureTxt1 = ComponentFactory.Instance.creatComponentByStylename("store.IntensifyEquipNatureTxt");
         _equipNatureTxt2 = ComponentFactory.Instance.creatComponentByStylename("store.IntensifyEquipNatureTxt");
         _equipAddNatureTxt1 = ComponentFactory.Instance.creatComponentByStylename("store.IntensifyEquipAddNatureTxt");
         _equipAddNatureTxt2 = ComponentFactory.Instance.creatComponentByStylename("store.IntensifyEquipAddNatureTxt");
         _equipFortify1 = ComponentFactory.Instance.creatBitmap("asset.store.IntensifyFortify");
         _equipFortify2 = ComponentFactory.Instance.creatBitmap("asset.store.IntensifyFortify");
         _equipFortify3 = ComponentFactory.Instance.creatBitmap("asset.store.IntensifyFortify");
         _endLookBmp = ComponentFactory.Instance.creatBitmap("asset.store.CastTopPreviewEquipBg1");
         _endLookBmp1 = ComponentFactory.Instance.creatBitmap("asset.store.CastTopPreviewTxtImg");
         _endLookBmp2 = ComponentFactory.Instance.creatBitmap("asset.store.CastTopPreviewEquipBg2");
         _endLookBaseItem = ComponentFactory.Instance.creatCustomObject("store.IntensifyEquipItem");
         _blessBar = ComponentFactory.Instance.creatComponentByStylename("store.IntensifyBlessingBar");
         _blessTxt = ComponentFactory.Instance.creatComponentByStylename("store.IntensifyBlessingTxt");
         _blessValueTxt = ComponentFactory.Instance.creatComponentByStylename("store.IntensifyBlessingValueTxt");
         _propTxt = ComponentFactory.Instance.creatComponentByStylename("store.IntensifyPropTxt");
         _blessBar.tipData = LanguageMgr.GetTranslation("store.cast.CastView.BlessBarTips");
         _blessTxt.text = LanguageMgr.GetTranslation("store.cast.CastView.BlessTxt");
         _equip1.sonType = -1;
         _equip1.resetTip = "yishi.view.tips.IntensifyTip";
         _equip2.sonType = 204;
         _equip2.pos = 1;
         addChild(_bg);
         addChild(_needGodlImg);
         addChild(_successImg);
         addChild(_maxImg);
         addChild(_equip1);
         addChild(_equip2);
         addChild(_effectMC);
         addChild(_goodsEffectMc);
         addChild(_successWord);
         addChild(_failWord);
         addChild(_intensifyBtn);
         addChild(_neededGold);
         addChild(_successratesTxt);
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
         addChild(_blessBar);
         addChild(_blessTxt);
         addChild(_blessValueTxt);
         addChild(_propTxt);
         addChild(_equipName);
         addChild(_equipFortify1);
         addChild(_equipFortify2);
         _equipFortify2.y += 22;
         addChild(_equipFortify3);
         _equipFortify3.y += 44;
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
         addChild(_equipNatureTxt1);
         _equipNatureTxt1.y = 175;
         addChild(_equipNatureTxt2);
         _equipNatureTxt2.y = 195;
         addChild(_equipAddNatureTxt1);
         _equipAddNatureTxt1.y += 22;
         addChild(_equipAddNatureTxt2);
         _equipAddNatureTxt2.y += 44;
         __onIntensifyBtnOut(null);
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
         ObjectUtils.disposeObject(_endLookBmp);
         _endLookBmp = null;
         ObjectUtils.disposeObject(_endLookBmp1);
         _endLookBmp1 = null;
         ObjectUtils.disposeObject(_endLookBmp2);
         _endLookBmp2 = null;
         ObjectUtils.disposeObject(_endLookBaseItem);
         _endLookBaseItem = null;
         ObjectUtils.disposeObject(_goodsEffectMc);
         _goodsEffectMc = null;
         ObjectUtils.disposeObject(_successWord);
         _successWord = null;
         ObjectUtils.disposeObject(_failWord);
         _failWord = null;
         ObjectUtils.disposeObject(_intensifyBtn);
         _intensifyBtn = null;
         ObjectUtils.disposeObject(_neededGold);
         _neededGold = null;
         ObjectUtils.disposeObject(_successratesTxt);
         _successratesTxt = null;
         ObjectUtils.disposeObject(_blessBar);
         _blessBar = null;
         ObjectUtils.disposeObject(_blessTxt);
         _blessTxt = null;
         ObjectUtils.disposeObject(_blessValueTxt);
         _blessValueTxt = null;
         ObjectUtils.disposeObject(_propTxt);
         _propTxt = null;
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
         }
      }
      
      private function createFailWord() : void
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
         }
      }
      
      private function cleanEffect() : void
      {
         _effectMC.gotoAndStop(1);
         _goodsEffectMc.gotoAndStop(1);
         _successWord.gotoAndStop(1);
         _failWord.gotoAndStop(1);
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
         if(_intensifyBtn)
         {
            _intensifyBtn.addEventListener("mouseOut",__onIntensifyBtnOut);
         }
         if(_intensifyBtn)
         {
            _intensifyBtn.addEventListener("mouseOver",__onIntensifyBtnOver);
         }
         GoodsManager.instance.addEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__bagItemDeleteHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 86,__intensifyResult);
      }
      
      private function removeEvent() : void
      {
         if(_intensifyBtn)
         {
            _intensifyBtn.removeEventListener("click",__onIntensifyBtnHandler);
         }
         if(_intensifyBtn)
         {
            _intensifyBtn.removeEventListener("mouseOut",__onIntensifyBtnOut);
         }
         if(_intensifyBtn)
         {
            _intensifyBtn.removeEventListener("mouseOver",__onIntensifyBtnOver);
         }
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__bagItemDeleteHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 86,__intensifyResult);
      }
      
      private function __onIntensifyBtnOut(param1:MouseEvent) : void
      {
         _equipFortify1.visible = false;
         _equipFortify2.visible = false;
         _equipFortify3.visible = false;
         _equipNameAdd.text = "";
         _equipNatureTxt1.text = "";
         _equipNatureTxt2.text = "";
         _equipAddNatureTxt1.text = "";
         _equipAddNatureTxt2.text = "";
      }
      
      private function __onIntensifyBtnOver(param1:MouseEvent) : void
      {
         updateEquipNatureView();
      }
      
      private function __onOneKeyStrengthBtnOverHandler(param1:MouseEvent) : void
      {
      }
      
      private function __onOneKeyStrengthBtnOutHandler(param1:MouseEvent) : void
      {
      }
      
      private function __onIntensifyBtnHandler(param1:MouseEvent) : void
      {
         var _loc6_:Boolean = false;
         var _loc4_:Date = null;
         var _loc5_:Date = null;
         var _loc2_:Boolean = false;
         var _loc7_:Boolean = false;
         var _loc10_:TodayNotAlertFrame = null;
         var _loc8_:String = null;
         var _loc3_:String = null;
         var _loc9_:GoodsInfo = _equip1.data;
         if(_loc9_.isViceEquip)
         {
            strengthen();
         }
         else if(StoreHelper.getSuccessRate(_loc9_,_equip2.data) <= 50)
         {
            _loc6_ = Boolean(SharedManager.instance.getProperty("IS_STRENGTHEN"));
            _loc4_ = SharedManager.instance.getProperty("STRENGTHEN_CHECK_DATE") as Date;
            _loc5_ = new Date();
            _loc2_ = false;
            _loc7_ = Boolean(SharedManager.instance.resolveStrengthen);
            if(!_loc6_ || _loc4_ && _loc4_.month <= _loc5_.month && _loc4_.date < _loc5_.date)
            {
               _loc2_ = true;
            }
            if(_loc2_)
            {
               _loc10_ = ComponentFactory.Instance.creatComponentByStylename("store.ComposeTipFrameIsStrengthen");
               _loc8_ = LanguageMgr.GetTranslation("store.Intensify.IntensifyView.isStrengthen");
               _loc3_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
               _loc10_.show(_loc8_,_loc3_,strengthenAndSaveSO);
            }
            else
            {
               strengthen();
            }
         }
         else
         {
            strengthen();
         }
      }
      
      private function strengthen() : void
      {
         var _loc1_:String = null;
         var _loc2_:GoodsTemplateInfo = null;
         if(ResourceManager.instance.gold.count < int(StringHelper.trim(_neededGold.text)))
         {
            _loc1_ = LanguageMgr.GetTranslation("public.gold");
            MessageTipManager.instance().show(_loc1_);
            return;
         }
         cleanEffect();
         var _loc3_:GoodsInfo = _equip1.data;
         if(_loc3_)
         {
            _loc2_ = _loc3_.templateInfo;
            if(_loc2_.StrengthenMax == _loc3_.strengthenGrade)
            {
               _intensifyBtn.enable = false;
            }
            else
            {
               _intensifyBtn.enable = true;
            }
         }
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
         control.sendItemIntensify();
      }
      
      protected function __bagItemUpdateHandler(param1:BagEvent) : void
      {
         var _loc4_:int = 0;
         var _loc5_:GoodsInfo = param1.info;
         var _loc2_:GoodsInfo = copyGoods(_loc5_);
         var _loc3_:StoreIntensifyCell = _itemDic[_loc5_.pos + "_" + _loc5_.objectId + "_" + _loc5_.bagType];
         if(_equip2.data != null)
         {
            _loc4_ = int(GoodsManager.instance.getGoodsNumByTempId(_equip2.data.templateId));
            _propTxt.text = _loc4_ + "/" + _equip2.data.templateInfo.Property3;
            if(_loc4_ < _equip2.data.templateInfo.Property3)
            {
               _propIsEnough = false;
            }
            else
            {
               _propIsEnough = true;
            }
         }
         if(_loc3_ && model.selectedPanel == "STORE_PANEL_INTENSIFY")
         {
            _loc3_.data = _loc5_;
            if(_loc3_ == _equip1)
            {
               if(_loc3_.data.templateId != lastEquipId)
               {
                  PlayerManager.instance.moveBagToBag(_equip2.bagType,_equip2.objectId,_equip2.pos,1,0,0,1);
                  lastEquipId = _loc3_.data.templateId;
               }
               else if(_loc3_.data.templateId == lastEquipId)
               {
                  if(_equip2.data)
                  {
                     if(_loc3_.data.templateInfo.NeedChangeJob == 2)
                     {
                        if(_loc3_.data.strengthenGrade < 36 && _equip2.data.templateInfo.Property2 != 0)
                        {
                           PlayerManager.instance.moveBagToBag(_equip2.bagType,_equip2.objectId,_equip2.pos,1,0,0,1);
                        }
                        else if(_loc3_.data.strengthenGrade >= 36 && _equip2.data.templateInfo.Property2 != 1)
                        {
                           PlayerManager.instance.moveBagToBag(_equip2.bagType,_equip2.objectId,_equip2.pos,1,0,0,1);
                        }
                     }
                     else if(_loc3_.data.templateInfo.NeedChangeJob != 2)
                     {
                        if(_equip2.data.templateInfo.Property2 != 0)
                        {
                           PlayerManager.instance.moveBagToBag(_equip2.bagType,_equip2.objectId,_equip2.pos,1,0,0,1);
                        }
                     }
                  }
               }
            }
            if(_loc3_.data.templateInfo.SonType != 204)
            {
               if(_loc3_.data.templateInfo.NeedChangeJob == 2 && _loc5_.strengthenGrade == 36 && _equip2.data)
               {
                  PlayerManager.instance.moveBagToBag(_equip2.bagType,_equip2.objectId,_equip2.pos,1,0,0,1);
               }
               _loc2_.strengthenGrade = _loc5_.templateInfo.StrengthenMax;
               _endLookBaseItem.data = _loc2_;
            }
            updateView();
         }
      }
      
      private function __bagItemDeleteHandler(param1:BagEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:GoodsInfo = param1.info;
         var _loc2_:StoreIntensifyCell = _itemDic[_loc4_.pos + "_" + _loc4_.objectId + "_" + _loc4_.bagType];
         if(_equip2.data != null)
         {
            _loc3_ = int(GoodsManager.instance.getGoodsNumByTempId(_equip2.data.templateId));
            _propTxt.text = _loc3_ + "/" + _equip2.data.templateInfo.Property3;
            if(_loc3_ < _equip2.data.templateInfo.Property3)
            {
               _propIsEnough = false;
            }
            else
            {
               _propIsEnough = true;
            }
         }
         if(_loc2_ && model.selectedPanel == "STORE_PANEL_INTENSIFY")
         {
            if(_loc2_.data != null && _loc2_.data.templateInfo && _loc2_.data.templateInfo.SonType != 204)
            {
               _endLookBaseItem.data = null;
            }
            _loc2_.data = null;
            updateView();
         }
      }
      
      private function copyGoods(param1:GoodsInfo) : GoodsInfo
      {
         var _loc2_:GoodsInfo = new GoodsInfo();
         _loc2_.id = param1.id;
         _loc2_.pos = param1.pos;
         _loc2_.objectId = param1.objectId;
         _loc2_.templateId = param1.templateId;
         _loc2_.isBinds = param1.isBinds;
         _loc2_.validDate = param1.validDate;
         _loc2_.beginDate = param1.beginDate;
         _loc2_.strengthenGrade = param1.strengthenGrade;
         _loc2_.join1 = param1.join1;
         _loc2_.join2 = param1.join2;
         _loc2_.join3 = param1.join3;
         _loc2_.join4 = param1.join4;
         _loc2_.randomSkill1 = param1.randomSkill1;
         _loc2_.randomSkill2 = param1.randomSkill2;
         _loc2_.randomSkill3 = param1.randomSkill3;
         _loc2_.randomSkill4 = param1.randomSkill4;
         _loc2_.randomSkill5 = param1.randomSkill5;
         _loc2_.mouldGrade = param1.mouldGrade;
         _loc2_.blessValue = param1.blessValue;
         return _loc2_;
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
            createFailWord();
            createEffect();
         }
         updateEquipNatureView();
      }
      
      private function updateEquipNatureView() : void
      {
         var _loc1_:GoodsTemplateInfo = null;
         var _loc2_:GoodsInfo = _equip1.data;
         if(_loc2_ && !model.isIntensifing)
         {
            _loc1_ = _loc2_.templateInfo;
            if(_loc1_.StrengthenMax > _loc2_.strengthenGrade)
            {
               _equipFortify1.visible = true;
               _equipNameAdd.text = "1";
               initAttribute(_loc2_,_loc2_.templateInfo);
            }
         }
      }
      
      private function updateView() : void
      {
         var _loc1_:GoodsTemplateInfo = null;
         var _loc2_:* = 0;
         var _loc3_:GoodsInfo = _equip1.data;
         hideBlessInfo();
         if(_loc3_)
         {
            if(!model.isIntensifing)
            {
               _loc1_ = _loc3_.templateInfo;
               if(_loc1_.StrengthenMax > _loc3_.strengthenGrade)
               {
                  _neededGold.text = "" + GoodsCheck.getIntensifuGold(_loc3_);
                  _intensifyBtn.enable = true;
                  _needGodlImg.visible = true;
                  _successImg.visible = true;
                  _maxImg.visible = false;
                  _neededGold.visible = true;
                  _successratesTxt.visible = true;
                  _loc2_ = uint(StoreHelper.getSuccessRate(_loc3_,_equip2.data));
                  if(_loc3_.isViceEquip)
                  {
                     _blessValueTxt.text = _loc3_.strBlessValue + " / " + 100;
                     _blessBar.setFrame(_loc3_.strBlessValue);
                     showBlessInfo();
                     _loc2_ += _loc3_.strBlessValue;
                  }
                  if(_loc2_ > 100)
                  {
                     _loc2_ = 100;
                  }
                  _successratesTxt.text = _loc2_ + "%";
               }
               else
               {
                  _needGodlImg.visible = false;
                  _successImg.visible = false;
                  _maxImg.visible = true;
                  _neededGold.visible = false;
                  _successratesTxt.visible = false;
                  _neededGold.text = _successratesTxt.text = "--";
                  _intensifyBtn.enable = false;
               }
               _equipName.setFrame(_loc3_.templateInfo.Profile);
               _equipName.text = _loc3_.templateInfo.TemplateName + getStrengthenGrade(_loc3_);
            }
            else
            {
               _needGodlImg.visible = true;
               _successImg.visible = true;
               _maxImg.visible = false;
               _neededGold.visible = true;
               _successratesTxt.visible = true;
               _neededGold.text = _successratesTxt.text = "--";
               _equipName.text = "";
               if(_loc3_.isViceEquip)
               {
                  _blessValueTxt.text = _loc3_.strBlessValue + " / " + 100;
                  _blessBar.setFrame(_loc3_.strBlessValue);
                  showBlessInfo();
               }
            }
         }
         else
         {
            _needGodlImg.visible = true;
            _successImg.visible = true;
            _maxImg.visible = false;
            _intensifyBtn.enable = false;
            _neededGold.visible = true;
            _successratesTxt.visible = true;
            _neededGold.text = _successratesTxt.text = "--";
            _equipName.text = "";
         }
      }
      
      private function hideBlessInfo() : void
      {
         _blessTxt.visible = false;
         _blessValueTxt.visible = false;
         _blessBar.visible = false;
         _propTxt.visible = false;
         _needGodlImg.y = 250;
         _successImg.y = 220;
         _neededGold.y = 258;
         _successratesTxt.y = 220;
      }
      
      private function showBlessInfo() : void
      {
         _blessTxt.visible = true;
         _blessValueTxt.visible = true;
         _blessBar.visible = true;
         _propTxt.visible = true;
         _needGodlImg.y = 253;
         _successImg.y = 230;
         _neededGold.y = 258;
         _successratesTxt.y = 228;
      }
      
      public function get intensifyBtn() : BaseButton
      {
         return _intensifyBtn;
      }
      
      public function get equip1() : StoreIntensifyCell
      {
         return _equip1;
      }
      
      public function get equip2() : StoreIntensifyCell
      {
         return _equip2;
      }
      
      private function initAttribute(param1:GoodsInfo, param2:GoodsTemplateInfo) : void
      {
         var _loc3_:String = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip01") + ":";
         updateAttributeTxt(_loc3_,param2.Power,getCurr(param2.Power,param1),getNex(param2.Power,param1));
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip02") + ":";
         updateAttributeTxt(_loc3_,param2.Agility,getCurr(param2.Agility,param1),getNex(param2.Agility,param1));
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip03") + ":";
         updateAttributeTxt(_loc3_,param2.Intellect,getCurr(param2.Intellect,param1),getNex(param2.Intellect,param1));
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip04") + ":";
         updateAttributeTxt(_loc3_,param2.Physique,getCurr(param2.Physique,param1),getNex(param2.Physique,param1));
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip05") + ":";
         updateAttributeTxt(_loc3_,param2.Captain,getCurr(param2.Captain,param1),getNex(param2.Captain,param1));
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip13");
         updateAttributeTxt(_loc3_,param2.Attack,getCurr(param2.Attack,param1),getNex(param2.Attack,param1));
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip15");
         updateAttributeTxt(_loc3_,param2.MagicAttack,getCurr(param2.MagicAttack,param1),getNex(param2.MagicAttack,param1));
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip14");
         updateAttributeTxt(_loc3_,param2.Defence,getCurr(param2.Defence,param1),getNex(param2.Defence,param1));
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip16");
         updateAttributeTxt(_loc3_,param2.MagicDefence,getCurr(param2.MagicDefence,param1),getNex(param2.MagicDefence,param1));
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip19") + ":";
         updateAttributeTxt(_loc3_,param2.Parry,getCurr(param2.Parry,param1),getNex(param2.Parry,param1));
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip11") + ":";
         updateAttributeTxt(_loc3_,param2.Live,getCurr(param2.Live,param1),getNex(param2.Live,param1));
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip10") + ":";
         updateAttributeTxt(_loc3_,param2.ForceHit,getCurr(param2.ForceHit,param1),getNex(param2.ForceHit,param1));
         _loc3_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip17");
         updateAttributeTxt(_loc3_,param2.Conat,getCurr(param2.Conat,param1),getNex(param2.Conat,param1));
      }
      
      private function updateAttributeTxt(param1:String, param2:Number, param3:Number, param4:Number) : void
      {
         if(param2 != 0)
         {
            if(!_equipFortify2.visible)
            {
               _equipNatureTxt1.text = param1 + " " + (param2 + param3);
               _equipAddNatureTxt1.text = "" + param4;
               _equipFortify2.visible = true;
            }
            else
            {
               _equipNatureTxt2.text = param1 + " " + (param2 + param3);
               _equipAddNatureTxt2.text = "" + param4;
               _equipFortify3.visible = true;
            }
         }
      }
      
      private function getCurr(param1:int, param2:GoodsInfo) : int
      {
         return int(GoodsHelp.getStrengthenAddition(param1,param2.strengthenGrade));
      }
      
      private function getNex(param1:int, param2:GoodsInfo) : int
      {
         var _loc5_:GoodsInfo = getNextGrade(param2);
         var _loc3_:int = int(GoodsHelp.getStrengthenAddition(param1,_loc5_.strengthenGrade));
         var _loc4_:int = int(GoodsHelp.getStrengthenAddition(param1,param2.strengthenGrade));
         return _loc3_ - _loc4_;
      }
      
      private function getNextGrade(param1:GoodsInfo) : GoodsInfo
      {
         var _loc2_:GoodsInfo = new GoodsInfo();
         ObjectUtils.copyProperties(_loc2_,param1,true);
         _loc2_.strengthenGrade = param1.strengthenGrade + 1;
         return _loc2_;
      }
      
      private function getStrengthenGrade(param1:GoodsInfo) : Object
      {
         return param1.strengthenGrade > 0 ? "+" + param1.strengthenGrade : "";
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

