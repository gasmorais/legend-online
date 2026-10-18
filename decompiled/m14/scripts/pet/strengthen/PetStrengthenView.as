package pet.strengthen
{
   import bag.events.BagEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.utils.clearTimeout;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import managers.PetSocketOut;
   import mvc.module.pet.PetData;
   import pet.property.PetShowView;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManager;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class PetStrengthenView extends Component
   {
      
      private var _back:DisplayObject;
      
      private var _showView:PetShowView;
      
      private var _goodsNumTxt:Sprite;
      
      private var _normalTrain:BaseButton;
      
      private var _numBitmapData:BitmapData;
      
      private var _strengthMc:MovieImage;
      
      private var _intellectMc:MovieImage;
      
      private var _staminaMc:MovieImage;
      
      private var _armorMc:MovieImage;
      
      private var _strengthTxt:FilterFrameText;
      
      private var _intellectTxt:FilterFrameText;
      
      private var _staminaTxt:FilterFrameText;
      
      private var _armorTxt:FilterFrameText;
      
      private var _strengthAddArrow:MovieClip;
      
      private var _intellectAddArrow:MovieClip;
      
      private var _staminaAddArrow:MovieClip;
      
      private var _armorAddArrow:MovieClip;
      
      private var _strengthAddTxt:String;
      
      private var _intellectAddTxt:String;
      
      private var _staminaAddTxt:String;
      
      private var _armorAddTxt:String;
      
      private var _hasCoeStone:Bitmap;
      
      private var _hasAdvCoeStone:Bitmap;
      
      private var _tipBtn:BaseButton;
      
      private var _fightCapacityImg:Bitmap;
      
      private var _fightMc:MovieClip;
      
      private var _playFightMc:Boolean = false;
      
      private var _petFight:int;
      
      private var _trainCountImage:Image;
      
      private var _trainCountBottom:Image;
      
      private var _trainCountText:FilterFrameText;
      
      private var _lastCickTime1:int = 0;
      
      private var tempObj:Object;
      
      private var _data:PetData;
      
      private var _strengthOld:int = 0;
      
      private var _intellectOld:int = 0;
      
      private var _staminaOld:int = 0;
      
      private var _armorOld:int = 0;
      
      private var _delay1:uint;
      
      private var _delay2:uint;
      
      private var _delay3:uint;
      
      private var _delay4:uint;
      
      public function PetStrengthenView()
      {
         super();
         initView();
         addEvent();
         mouseEnabled = false;
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creat("asset.pet.ResBack");
         _showView = new PetShowView();
         _showView.state = 1;
         _showView.x = 5;
         _showView.y = -10;
         addChild(_back);
         addChild(_showView);
         _strengthMc = ComponentFactory.Instance.creatComponentByStylename("zizhi.StrengthMc");
         _intellectMc = ComponentFactory.Instance.creatComponentByStylename("zizhi.IntellectMc");
         _staminaMc = ComponentFactory.Instance.creatComponentByStylename("zizhi.StaminaMc");
         _armorMc = ComponentFactory.Instance.creatComponentByStylename("zizhi.ArmorMc");
         _strengthTxt = ComponentFactory.Instance.creatComponentByStylename("coe.StrengthTxt");
         _intellectTxt = ComponentFactory.Instance.creatComponentByStylename("coe.IntellectTxt");
         _staminaTxt = ComponentFactory.Instance.creatComponentByStylename("coe.StaminaTxt");
         _armorTxt = ComponentFactory.Instance.creatComponentByStylename("coe.ArmorTxt");
         addChild(_strengthMc);
         addChild(_intellectMc);
         addChild(_staminaMc);
         addChild(_armorMc);
         addChild(_strengthTxt);
         addChild(_intellectTxt);
         addChild(_staminaTxt);
         addChild(_armorTxt);
         _strengthMc.setFrame(1);
         _intellectMc.setFrame(1);
         _staminaMc.setFrame(1);
         _armorMc.setFrame(1);
         _strengthAddArrow = ComponentFactory.Instance.creat("asset.pet.AddArrowMc");
         _intellectAddArrow = ComponentFactory.Instance.creat("asset.pet.AddArrowMc");
         _staminaAddArrow = ComponentFactory.Instance.creat("asset.pet.AddArrowMc");
         _armorAddArrow = ComponentFactory.Instance.creat("asset.pet.AddArrowMc");
         _strengthAddArrow.x = _intellectAddArrow.x = _staminaAddArrow.x = _armorAddArrow.x = 570;
         _strengthAddArrow.y = 0;
         _intellectAddArrow.y = 130;
         _staminaAddArrow.y = 195;
         _armorAddArrow.y = 65;
         _strengthAddTxt = ComponentFactory.Instance.creatComponentByStylename("coe.StrengthAddTxt");
         _intellectAddTxt = ComponentFactory.Instance.creatComponentByStylename("coe.IntellectAddTxt");
         _staminaAddTxt = ComponentFactory.Instance.creatComponentByStylename("coe.StaminaAddTxt");
         _armorAddTxt = ComponentFactory.Instance.creatComponentByStylename("coe.ArmorAddTxt");
         addChild(_strengthAddArrow);
         addChild(_intellectAddArrow);
         addChild(_staminaAddArrow);
         addChild(_armorAddArrow);
         _strengthAddArrow.gotoAndStop(1);
         _intellectAddArrow.gotoAndStop(1);
         _staminaAddArrow.gotoAndStop(1);
         _armorAddArrow.gotoAndStop(1);
         _strengthAddArrow.visible = false;
         _intellectAddArrow.visible = false;
         _staminaAddArrow.visible = false;
         _armorAddArrow.visible = false;
         _goodsNumTxt = new Sprite();
         _goodsNumTxt.x = 370;
         _goodsNumTxt.y = 306;
         _normalTrain = ComponentFactory.Instance.creatComponentByStylename("coe.NormalTrainBtn");
         _numBitmapData = ComponentFactory.Instance.creatBitmapData("asset.core.number_img_04");
         _tipBtn = ComponentFactory.Instance.creatComponentByStylename("petskill.tipBtn");
         _hasCoeStone = ComponentFactory.Instance.creatBitmap("asset.pet.coeStone");
         _hasAdvCoeStone = ComponentFactory.Instance.creatBitmap("asset.pet.advCoeStone");
         _trainCountImage = ComponentFactory.Instance.creatComponentByStylename("PetStrengthenView.trainCountImage");
         _trainCountBottom = ComponentFactory.Instance.creatComponentByStylename("PetStrengthenView.trainCountBottom");
         _trainCountText = ComponentFactory.Instance.creatComponentByStylename("PetStrengthenView.trainCountText");
         addChild(_goodsNumTxt);
         addChild(_trainCountImage);
         addChild(_trainCountBottom);
         addChild(_trainCountText);
         _trainCountText.text = "1";
         addChild(_normalTrain);
         var _loc1_:int = int(GoodsManager.instance.getGoodsNumByTempId(3040001));
         NumberViewUtils.refreshValue(_loc1_,_goodsNumTxt,_numBitmapData,19,25,15,19,"0123456789");
         _normalTrain.tipData = LanguageMgr.GetTranslation("PetStrengthenView.NormalTrainTip");
         addChild(_hasCoeStone);
         addChild(_hasAdvCoeStone);
         addChild(_tipBtn);
         _fightCapacityImg = ComponentFactory.Instance.creatBitmap("asset.pet.FightCapacityTxt");
         _fightCapacityImg.x = 80;
         _fightCapacityImg.y = 215;
         _fightMc = ComponentFactory.Instance.creat("asset.core.powerMc");
         _fightMc.x = 136;
         _fightMc.y = 212;
         addChild(_fightCapacityImg);
         addChild(_fightMc);
      }
      
      private function uintView() : void
      {
         clearTimeout(_delay1);
         clearTimeout(_delay2);
         clearTimeout(_delay3);
         clearTimeout(_delay4);
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_showView);
         _showView = null;
         ObjectUtils.disposeObject(_goodsNumTxt);
         _goodsNumTxt = null;
         ObjectUtils.disposeObject(_normalTrain);
         _normalTrain = null;
         ObjectUtils.disposeObject(_numBitmapData);
         _numBitmapData = null;
         ObjectUtils.disposeObject(_strengthMc);
         _strengthMc = null;
         ObjectUtils.disposeObject(_intellectMc);
         _intellectMc = null;
         ObjectUtils.disposeObject(_staminaMc);
         _staminaMc = null;
         ObjectUtils.disposeObject(_armorMc);
         _armorMc = null;
         ObjectUtils.disposeObject(_strengthTxt);
         _strengthTxt = null;
         ObjectUtils.disposeObject(_intellectTxt);
         _intellectTxt = null;
         ObjectUtils.disposeObject(_staminaTxt);
         _staminaTxt = null;
         ObjectUtils.disposeObject(_armorTxt);
         _armorTxt = null;
         ObjectUtils.disposeObject(_strengthAddArrow);
         _strengthAddArrow = null;
         ObjectUtils.disposeObject(_intellectAddArrow);
         _intellectAddArrow = null;
         ObjectUtils.disposeObject(_staminaAddArrow);
         _staminaAddArrow = null;
         ObjectUtils.disposeObject(_armorAddArrow);
         _armorAddArrow = null;
         ObjectUtils.disposeObject(_strengthAddTxt);
         _strengthAddTxt = null;
         ObjectUtils.disposeObject(_intellectAddTxt);
         _intellectAddTxt = null;
         ObjectUtils.disposeObject(_staminaAddTxt);
         _staminaAddTxt = null;
         ObjectUtils.disposeObject(_armorAddTxt);
         _armorAddTxt = null;
         ObjectUtils.disposeObject(_tipBtn);
         _tipBtn = null;
         ObjectUtils.disposeObject(_fightCapacityImg);
         _fightCapacityImg = null;
         ObjectUtils.disposeViolentMc(_fightMc);
         _fightMc = null;
         ObjectUtils.disposeObject(_hasAdvCoeStone);
         _hasAdvCoeStone = null;
         ObjectUtils.disposeObject(_hasCoeStone);
         _hasCoeStone = null;
         ObjectUtils.disposeObject(_trainCountBottom);
         _trainCountBottom = null;
         ObjectUtils.disposeObject(_trainCountImage);
         _trainCountImage = null;
         ObjectUtils.disposeObject(_trainCountText);
         _trainCountText = null;
      }
      
      private function addEvent() : void
      {
         _normalTrain.addEventListener("click",__trainHandler);
         GoodsManager.instance.addEventListener("UPDATE_BAG",__onUpdateNumberHandler);
         _trainCountText.addEventListener("change",__textChangHandler);
         _trainCountText.addEventListener("focusIn",__inHandler);
      }
      
      private function removeEvent() : void
      {
         if(_normalTrain)
         {
            _normalTrain.removeEventListener("click",__trainHandler);
         }
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__onUpdateNumberHandler);
         _trainCountText.removeEventListener("change",__textChangHandler);
         _trainCountText.removeEventListener("focusIn",__inHandler);
      }
      
      private function __textChangHandler(param1:Event) : void
      {
         var _loc2_:int = parseInt(_trainCountText.text);
         if(_loc2_ <= 0)
         {
            _trainCountText.text = "1";
         }
         if(_loc2_ >= 10000)
         {
            _trainCountText.text = "9999";
         }
      }
      
      private function __inHandler(param1:FocusEvent) : void
      {
         _trainCountText.setSelection(0,_trainCountText.text.length);
      }
      
      private function __trainHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         SoundManager.instance.play("022");
         var _loc3_:int = getTimer();
         if(_loc3_ - _lastCickTime1 < 500)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.view.ActivityItem.command01"));
            return;
         }
         _lastCickTime1 = _loc3_;
         if(!data)
         {
            return;
         }
         if(data.isFullRes())
         {
            _loc2_ = LanguageMgr.GetTranslation("PetStrengthenView.isFullRes");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         advancedTrain();
      }
      
      private function advancedTrain() : void
      {
         var _loc6_:String = null;
         var _loc3_:int = getOnceAdvancedCost();
         var _loc4_:int = parseInt(_trainCountText.text);
         _loc6_ = LanguageMgr.GetTranslation("PetAdvancedView.strength.tipCommand01",_loc4_,needItemName,_loc3_,needItemName);
         var _loc1_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc5_:String = LanguageMgr.GetTranslation("public.prompt");
         SimpleAlertHelper.instance.data = [checkPointForNormalBack];
         SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc1_,_loc2_,true,false,false,2,"USEBINDPOINT_ALERT",0,"",null,"SimpleAlert");
      }
      
      private function getOnceAdvancedCost() : int
      {
         var _loc1_:int = int(ConfigInfoManager.instance.getPetUpApt());
         return _loc1_ * parseInt(_trainCountText.text);
      }
      
      private function checkPointForNormalBack(param1:Boolean, param2:Boolean) : void
      {
         if(!param1)
         {
            return;
         }
         checkWillBeBindForNormal(param2);
      }
      
      private function checkWillBeBindForNormal(param1:Boolean) : void
      {
         tempObj = {
            "useBindPoint":param1,
            "useGoodsType":0,
            "useFlag":0
         };
         doNormal(tempObj.useBindPoint,tempObj.useGoodsType);
      }
      
      private function willUsedBindForNormal(param1:Boolean) : int
      {
         var _loc4_:Array = null;
         var _loc2_:int = 0;
         if(data && data.template && data.template.NeedGrade == 3)
         {
            _loc4_ = GoodsManager.instance.getBagGoodsByTemplateId(3040002);
         }
         else
         {
            _loc4_ = GoodsManager.instance.getBagGoodsByTemplateId(3040001);
         }
         var _loc3_:Boolean = false;
         for each(var _loc5_:GoodsInfo in _loc4_)
         {
            if(_loc5_.isBinds)
            {
               _loc3_ = true;
               break;
            }
         }
         if(_loc3_)
         {
            _loc2_ = 1;
         }
         if(param1 && PlayerManager.instance.currentPlayerModel.playerInfo.giftToken > 0)
         {
            _loc2_ = 2;
         }
         return _loc2_;
      }
      
      private function checkUseBindForNoraml(param1:int) : void
      {
         var _loc4_:TodayNotAlertFrame = null;
         var _loc3_:String = null;
         var _loc2_:String = null;
         tempObj.useFlag = param1;
         if(checkIsExpired(SharedManager.instance.petAdvanceAlertDate))
         {
            _loc4_ = ComponentFactory.Instance.creatComponentByStylename("worldboss.RiverNotAlert");
            if(param1 == 1)
            {
               _loc3_ = LanguageMgr.GetTranslation("GrowthInfoView.useBindGoodsTip");
               _loc4_.usebindPointTxt = LanguageMgr.GetTranslation("mainBar.view.VipCoolDownFrame.useGood");
            }
            else
            {
               _loc3_ = LanguageMgr.GetTranslation("PetAdvancedView.useBindPointTip");
            }
            _loc2_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc4_.show(_loc3_,_loc2_,checkUseBindForNoramlBack,null,"center",2,true);
         }
         else
         {
            doNormal(tempObj.useBindPoint,SharedManager.instance.petadvanceWillbeBindCheck4);
         }
      }
      
      private function checkUseBindForNoramlBack(param1:Boolean, param2:Boolean) : void
      {
         if(!tempObj)
         {
            return;
         }
         if(tempObj.useFlag == 1 && !param2)
         {
            tempObj.useGoodsType = 2;
         }
         doNormal(tempObj.useBindPoint,tempObj.useGoodsType);
         if(param1)
         {
            SharedManager.instance.petAdvanceAlertDate = new Date();
            SharedManager.instance.savePetAdvanceAlert();
            SharedManager.instance.petadvanceWillbeBindCheck4 = tempObj.useGoodsType;
            SharedManager.instance.savePetadvanceWillbeBindCheck4();
         }
      }
      
      private function checkIsExpired(param1:Date) : Boolean
      {
         var _loc2_:Date = null;
         var _loc3_:Boolean = true;
         if(param1)
         {
            _loc2_ = new Date();
            if(_loc2_.fullYear == param1.fullYear && _loc2_.month == param1.month && _loc2_.date == param1.date)
            {
               _loc3_ = false;
            }
         }
         return _loc3_;
      }
      
      private function doNormal(param1:Boolean, param2:int = 0) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(!data)
         {
            return;
         }
         if(param2 == 2)
         {
            param1 = false;
         }
         var _loc3_:int = getGoodsCount(param2);
         if(_loc3_ < 1)
         {
            _loc4_ = getOnceAdvancedCost();
            _loc5_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.point);
            if(param1)
            {
               _loc5_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.allPoint);
            }
            if(_loc5_ < _loc4_)
            {
               RechargeAlertMannager.show();
               return;
            }
         }
         PetSocketOut.trainCoe(data.petId,parseInt(_trainCountText.text),param1,param2);
      }
      
      private function __onUpdateNumberHandler(param1:BagEvent = null) : void
      {
         NumberViewUtils.refreshValue(ownTrainNeed,_goodsNumTxt,_numBitmapData,19,25,15,19,"0123456789");
         _trainCountText.text = "1";
      }
      
      private function get ownTrainNeed() : int
      {
         var _loc1_:int = 0;
         if(_data.template.NeedGrade >= 3)
         {
            _loc1_ = int(GoodsManager.instance.getGoodsNumByTempId(3040002));
         }
         else
         {
            _loc1_ = int(GoodsManager.instance.getGoodsNumByTempId(3040001));
         }
         return _loc1_;
      }
      
      private function get needItemName() : String
      {
         if(_data.template.NeedGrade >= 3)
         {
            return LanguageMgr.GetTranslation("PetStrengthenView.firstNingshenZhu02");
         }
         return LanguageMgr.GetTranslation("PetStrengthenView.firstNingshenZhu01");
      }
      
      private function getGoodsCount(param1:int = 0) : int
      {
         var _loc2_:Array = null;
         if(data && data.template && data.template.NeedGrade == 3)
         {
            _loc2_ = GoodsManager.instance.getBagGoodsByTemplateId(3040002);
         }
         else
         {
            _loc2_ = GoodsManager.instance.getBagGoodsByTemplateId(3040001);
         }
         var _loc3_:int = 0;
         for each(var _loc4_:GoodsInfo in _loc2_)
         {
            if(param1 == 0)
            {
               _loc3_ += _loc4_.count;
            }
            else if(param1 == 1 && Boolean(_loc4_.isBinds))
            {
               _loc3_ += _loc4_.count;
            }
            else if(param1 == 2 && !_loc4_.isBinds)
            {
               _loc3_ += _loc4_.count;
            }
         }
         return _loc3_;
      }
      
      public function get data() : PetData
      {
         return _data;
      }
      
      public function set data(param1:PetData) : void
      {
         if(param1 && param1 != _data)
         {
            _strengthOld = param1.coeStrength;
            _intellectOld = param1.coeIntellect;
            _staminaOld = param1.coeStamina;
            _armorOld = param1.coeArmor;
            _strengthAddTxt = "";
            _intellectAddTxt = "";
            _staminaAddTxt = "";
            _armorAddTxt = "";
         }
         _data = param1;
         _strengthAddArrow.visible = false;
         _intellectAddArrow.visible = false;
         _staminaAddArrow.visible = false;
         _armorAddArrow.visible = false;
         clearTimeout(_delay1);
         clearTimeout(_delay2);
         clearTimeout(_delay3);
         clearTimeout(_delay4);
         if(_data)
         {
            refresh();
         }
         else
         {
            restore();
         }
         __onUpdateNumberHandler();
      }
      
      private function refresh() : void
      {
         var _loc1_:int = 0;
         var _loc3_:Boolean = false;
         _showView.data = _data;
         _strengthTxt.text = _data.coeStrength + " / " + _data.coeStrengthLimit;
         _intellectTxt.text = _data.coeIntellect + " / " + _data.coeIntellectLimit;
         _staminaTxt.text = _data.coeStamina + " / " + _data.coeStaminaLimit;
         _armorTxt.text = _data.coeArmor + " / " + _data.coeArmorLimit;
         var _loc5_:int = 1;
         _loc5_ = Math.floor(_data.coeStrength * 100 / _data.coeStrengthLimit);
         _strengthMc.setFrame(_loc5_);
         _loc5_ = Math.floor(_data.coeIntellect * 100 / _data.coeIntellectLimit);
         _intellectMc.setFrame(_loc5_);
         _loc5_ = Math.floor(_data.coeStamina * 100 / _data.coeStaminaLimit);
         _staminaMc.setFrame(_loc5_);
         _loc5_ = Math.floor(_data.coeArmor * 100 / _data.coeArmorLimit);
         _armorMc.setFrame(_loc5_);
         if(_data.template.NeedGrade >= 3)
         {
            _tipBtn.tipData = LanguageMgr.GetTranslation("PetStrengthenView.tipData02");
            _hasAdvCoeStone.visible = true;
            _hasCoeStone.visible = false;
            _tipBtn.x = 174;
            _tipBtn.width = 235;
         }
         else
         {
            _tipBtn.tipData = LanguageMgr.GetTranslation("PetStrengthenView.tipData");
            _hasAdvCoeStone.visible = false;
            _hasCoeStone.visible = true;
            _tipBtn.x = 204;
            _tipBtn.width = 205;
         }
         _loc1_ = _data.coeStrength - _strengthOld;
         _loc3_ = _data.coeStrength >= _data.coeStrengthLimit;
         if(_loc1_ > 0)
         {
            playMovie(_strengthAddArrow,_loc1_.toString(),_strengthAddTxt,_loc3_);
            _strengthAddTxt = _loc1_.toString();
            _delay1 = setTimeout(stopMovie,5000,_strengthAddArrow);
         }
         _loc1_ = _data.coeIntellect - _intellectOld;
         _loc3_ = _data.coeIntellect >= _data.coeIntellectLimit;
         if(_loc1_ > 0)
         {
            playMovie(_intellectAddArrow,_loc1_.toString(),_intellectAddTxt,_loc3_);
            _intellectAddTxt = _loc1_.toString();
            _delay2 = setTimeout(stopMovie,5000,_intellectAddArrow);
         }
         _loc1_ = _data.coeStamina - _staminaOld;
         _loc3_ = _data.coeStamina >= _data.coeStaminaLimit;
         if(_loc1_ > 0)
         {
            playMovie(_staminaAddArrow,_loc1_.toString(),_staminaAddTxt,_loc3_);
            _staminaAddTxt = _loc1_.toString();
            _delay3 = setTimeout(stopMovie,5000,_staminaAddArrow);
         }
         _loc1_ = _data.coeArmor - _armorOld;
         _loc3_ = _data.coeArmor >= _data.coeArmorLimit;
         if(_loc1_ > 0)
         {
            playMovie(_armorAddArrow,_loc1_.toString(),_armorAddTxt,_loc3_);
            _armorAddTxt = _loc1_.toString();
            _delay4 = setTimeout(stopMovie,5000,_armorAddArrow);
         }
         _strengthOld = _data.coeStrength;
         _intellectOld = _data.coeIntellect;
         _staminaOld = _data.coeStamina;
         _armorOld = _data.coeArmor;
         _fightCapacityImg.visible = true;
         _fightMc.visible = true;
         var _loc4_:int = 240;
         var _loc2_:int = _fightCapacityImg.width + _data.fightPower.toString().length * 16;
         _fightMc.x = _fightCapacityImg.x + _fightCapacityImg.width;
         fightChange(_data.fightPower);
         if(_data.template.NeedGrade >= 3)
         {
            _normalTrain.tipData = LanguageMgr.GetTranslation("PetStrengthenView.NormalTrainTip2");
         }
         else
         {
            _normalTrain.tipData = LanguageMgr.GetTranslation("PetStrengthenView.NormalTrainTip");
         }
      }
      
      private function playMovie(param1:MovieClip, param2:String, param3:String, param4:Boolean) : void
      {
         param1.gotoAndPlay(1);
         param1.visible = true;
         var _loc6_:MovieClip = param1["newMc"] as MovieClip;
         var _loc5_:MovieClip = param1["oldMc"] as MovieClip;
         _loc5_.visible = false;
         _loc5_["valueTxt"]["text"] = "";
         if(_loc6_["valueTxt"])
         {
            _loc5_["valueTxt"]["text"] = param3;
         }
         if(!_loc5_["valueTxt"]["text"])
         {
            _loc5_.visible = false;
         }
         if(param4)
         {
            _loc6_.gotoAndStop(2);
         }
         else
         {
            _loc6_.gotoAndStop(1);
            _loc6_["valueTxt"]["text"] = param2;
         }
      }
      
      private function stopMovie(param1:MovieClip) : void
      {
         switch(param1)
         {
            case _strengthAddArrow:
               clearTimeout(_delay1);
               break;
            case _intellectAddArrow:
               clearTimeout(_delay2);
               break;
            case _staminaAddArrow:
               clearTimeout(_delay3);
               break;
            case _armorAddArrow:
               clearTimeout(_delay4);
         }
         param1.gotoAndStop(1);
         param1.visible = false;
      }
      
      public function fightChange(param1:int) : void
      {
         if(_petFight == param1)
         {
            return;
         }
         if(!_playFightMc)
         {
            _fightMc.gotoAndStop(24);
            NumberViewUtils.refreshValue(param1,_fightMc["new_power"],_numBitmapData,19,25,15,19,"0123456789");
            _petFight = param1;
            _playFightMc = true;
            return;
         }
         if(_petFight > 0)
         {
            NumberViewUtils.refreshValue(_petFight,_fightMc["old_power"],_numBitmapData,19,25,15,19,"0123456789");
         }
         NumberViewUtils.refreshValue(param1,_fightMc["new_power"],_numBitmapData,19,25,15,19,"0123456789");
         _fightMc["shine1"].x = _fightMc["shine2"].x = _fightMc["new_power"].width / 2;
         _fightMc.gotoAndPlay(1);
         _petFight = param1;
      }
      
      private function restore() : void
      {
         _showView.data = null;
         _strengthTxt.text = "";
         _intellectTxt.text = "";
         _staminaTxt.text = "";
         _armorTxt.text = "";
         _strengthMc.setFrame(1);
         _intellectMc.setFrame(1);
         _staminaMc.setFrame(1);
         _armorMc.setFrame(1);
         _strengthAddTxt = "";
         _intellectAddTxt = "";
         _staminaAddTxt = "";
         _armorAddTxt = "";
         _strengthAddArrow.visible = false;
         _intellectAddArrow.visible = false;
         _staminaAddArrow.visible = false;
         _armorAddArrow.visible = false;
         _strengthOld = 0;
         _intellectOld = 0;
         _staminaOld = 0;
         _armorOld = 0;
         _fightCapacityImg.visible = false;
         _fightMc.visible = false;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uintView();
         super.dispose();
         _data = null;
      }
   }
}

