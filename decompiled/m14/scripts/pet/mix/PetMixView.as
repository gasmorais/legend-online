package pet.mix
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.MonopolySocketOutManager;
   import managers.PetSocketOut;
   import mvc.controler.PetController;
   import mvc.module.pet.PetData;
   import mvc.module.shop.ShopGoodsInfo;
   import pet.common.PetAvatarView;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.PetComposeGoodsTemplete;
   import yishi.datas.templates.PetTemplate;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.MaskUtils;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseIconView;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   import yishi.view.tools.SimpleMovie;
   
   public class PetMixView extends Component
   {
      
      private var _back:DisplayObject;
      
      private var _pet1:BaseIconView;
      
      private var _pet2:BaseIconView;
      
      private var _newPet:PetAvatarView;
      
      private var _nameBack:MutipleImage;
      
      private var _level1:FilterFrameText;
      
      private var _level2:FilterFrameText;
      
      private var _num1:FilterFrameText;
      
      private var _num2:FilterFrameText;
      
      private var _name1:FilterFrameText;
      
      private var _name2:FilterFrameText;
      
      private var _newName:FilterFrameText;
      
      private var _pointTxt:FilterFrameText;
      
      private var _materialList:Vector.<GoodsInfo>;
      
      private var _hBox1:HBox;
      
      private var _hBox2:HBox;
      
      private var _mixBtn:IconButton;
      
      private var _immediatelyMixBtn:IconButton;
      
      private var _data1:PetData;
      
      private var _data2:PetData;
      
      private var _newData:PetData;
      
      private var _controller:PetController;
      
      private var _otherData:PetData;
      
      private var _dragCallBack:Function;
      
      private var _point:int;
      
      private var _isEnough:Boolean;
      
      private var _needPoint:int;
      
      private var _petMixMc:MovieClip;
      
      private var _itemMcList:Array;
      
      private var _iconMcList:Array;
      
      private var _newPetMc:PetAvatarView;
      
      private var _newPetBg:Image;
      
      private var _mixType:int = -1;
      
      private var payType:int = 2;
      
      private var temp:PetComposeGoodsTemplete;
      
      private var level:Array = [50,70,80];
      
      public function PetMixView(param1:Function)
      {
         _dragCallBack = param1;
         super();
         _controller = FrameControllerManager.instance.petController;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creat("asset.pet.mixBg");
         _pet1 = ComponentFactory.Instance.creatCustomObject("PetMixView.pet1");
         _pet2 = ComponentFactory.Instance.creatCustomObject("PetMixView.pet2");
         _nameBack = ComponentFactory.Instance.creatComponentByStylename("PetMixView.nameBack");
         _level1 = ComponentFactory.Instance.creatComponentByStylename("PetMixView.level1");
         _level2 = ComponentFactory.Instance.creatComponentByStylename("PetMixView.level2");
         _num1 = ComponentFactory.Instance.creatComponentByStylename("PetMixView.num1");
         _num2 = ComponentFactory.Instance.creatComponentByStylename("PetMixView.num2");
         _name1 = ComponentFactory.Instance.creatComponentByStylename("PetMixView.name1");
         _name2 = ComponentFactory.Instance.creatComponentByStylename("PetMixView.name2");
         _newName = ComponentFactory.Instance.creatComponentByStylename("PetMixView.newName");
         _pointTxt = ComponentFactory.Instance.creatComponentByStylename("PetMixView.point");
         _mixBtn = ComponentFactory.Instance.creatComponentByStylename("PetMixView.mixBtn");
         _immediatelyMixBtn = ComponentFactory.Instance.creatComponentByStylename("pet.composeView.immediatelyMixBtn");
         _hBox1 = ComponentFactory.Instance.creatComponentByStylename("PetMixView.hBox1");
         _hBox2 = ComponentFactory.Instance.creatComponentByStylename("PetMixView.hBox2");
         _newPetBg = ComponentFactory.Instance.creatComponentByStylename("PetMixView.newPetBg");
         _newPet = new PetAvatarView();
         _newPet.mouseEnabled = _newPet.mouseChildren = false;
         _newPet.x = 449;
         _newPet.y = 214;
         addChild(_back);
         addChild(_newPetBg);
         addChild(_pet1);
         addChild(_pet2);
         addChild(_newPet);
         addChild(_nameBack);
         addChild(_level1);
         addChild(_num1);
         addChild(_num2);
         addChild(_name1);
         addChild(_name2);
         addChild(_newName);
         addChild(_pointTxt);
         addChild(_hBox1);
         addChild(_hBox2);
         addChild(_mixBtn);
         _mixBtn.enable = false;
         addChild(_immediatelyMixBtn);
         _pet1.mouseChildren = false;
         _pet2.mouseChildren = false;
         _pet1.graphics.beginFill(0,0);
         _pet1.graphics.drawRect(0,0,_pet1.iconWidth,_pet1.iconHeight);
         _pet1.graphics.endFill();
         _pet2.graphics.beginFill(0,0);
         _pet2.graphics.drawRect(0,0,_pet2.iconWidth,_pet2.iconHeight);
         _pet2.graphics.endFill();
         _point = 60000;
         temp = getMixTemplate();
         if(temp)
         {
            _point = temp.NeedPoint;
         }
      }
      
      private function unitView() : void
      {
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_newPetBg);
         _newPetBg = null;
         ObjectUtils.disposeObject(_pet1);
         _pet1 = null;
         ObjectUtils.disposeObject(_pet2);
         _pet2 = null;
         ObjectUtils.disposeObject(_newPet);
         _newPet = null;
         ObjectUtils.disposeObject(_nameBack);
         _nameBack = null;
         ObjectUtils.disposeObject(_level1);
         _level1 = null;
         ObjectUtils.disposeObject(_level2);
         _level2 = null;
         ObjectUtils.disposeObject(_num1);
         _num1 = null;
         ObjectUtils.disposeObject(_num2);
         _num2 = null;
         ObjectUtils.disposeObject(_name1);
         _name1 = null;
         ObjectUtils.disposeObject(_name2);
         _name2 = null;
         ObjectUtils.disposeObject(_newName);
         _newName = null;
         ObjectUtils.disposeObject(_pointTxt);
         _pointTxt = null;
         ObjectUtils.disposeObject(_hBox1);
         _hBox1 = null;
         ObjectUtils.disposeObject(_hBox2);
         _hBox2 = null;
         ObjectUtils.disposeObject(_mixBtn);
         _mixBtn = null;
         ObjectUtils.disposeObject(_immediatelyMixBtn);
         _immediatelyMixBtn = null;
         _data1 = null;
         _data2 = null;
         _newData = null;
         _controller = null;
         _otherData = null;
         _materialList = null;
         _dragCallBack = null;
         ObjectUtils.disposeViolentMc(_petMixMc);
         _petMixMc = null;
         if(_itemMcList)
         {
            while(_itemMcList.length > 0)
            {
               ObjectUtils.disposeObject(_itemMcList.pop());
            }
            _itemMcList = null;
         }
         if(_iconMcList)
         {
            while(_iconMcList.length > 0)
            {
               ObjectUtils.disposeObject(_iconMcList.pop());
            }
            _iconMcList = null;
         }
         if(_newPetMc)
         {
            _newPetMc.dispose();
         }
         _newPetMc = null;
      }
      
      public function get data() : PetData
      {
         return _data1;
      }
      
      public function set data(param1:PetData) : void
      {
         _data1 = param1;
         refreshView();
      }
      
      private function clean() : void
      {
         _data2 = null;
         _materialList = new Vector.<GoodsInfo>();
         _mixBtn.enable = false;
         _pet1.tipData = null;
         _pet2.tipData = null;
         _pet1.icon = null;
         _pet2.icon = null;
         _level1.text = "";
         _level2.text = "";
         _num1.text = "";
         _num2.text = "";
         _name1.text = "";
         _name2.text = "";
         _newName.text = "";
         _pointTxt.text = "--";
         _hBox1.disposeAllChildren();
         _hBox2.disposeAllChildren();
      }
      
      private function refreshView() : void
      {
         var _loc5_:BaseItemView = null;
         var _loc4_:FilterFrameText = null;
         var _loc1_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:ShopGoodsInfo = null;
         clean();
         if(_data1 == null || _data1.template.NeedGrade < 2 || _data1.template.PetType != 105 && _data1.template.PetType != 106 && _data1.template.PetType != 102 && _data1.template.PetType != 104 && _data1.template.PetType != 101 && _data1.template.PetType != 103)
         {
            if(_dragCallBack != null)
            {
               _dragCallBack(null);
            }
            return;
         }
         _newData = null;
         _newPet.data = null;
         _mixBtn.enable = true;
         var _loc7_:String = IconFactory.getPetHeadSmallIcon(_data1.templateId);
         if(_pet1.icon != _loc7_)
         {
            _pet1.icon = _loc7_;
         }
         _pet1.tipData = _data1;
         _level1.text = LanguageMgr.GetTranslation("public.level2",_data1.grade);
         if(cheakPet())
         {
            _num1.text = "1/1";
            _num1.setFrame(1);
         }
         else
         {
            _num1.text = "0/1";
            _num1.setFrame(2);
         }
         _name1.htmlText = LanguageMgr.GetTranslation("pet.mix.PetMixView.petName",getNameColor(),_data1.name);
         temp = getMixTemplate();
         if(!temp || !_data2)
         {
            return;
         }
         _point = temp.NeedPoint;
         _pointTxt.text = _point + "";
         var _loc3_:int = int(GoodsManager.instance.getBagCountByTempId(1,211002));
         if(_loc3_ > 0)
         {
            _point = 0;
         }
         _newData = new PetData();
         _newData.quality = _data1.quality;
         _newData.temQuality = _data1.quality * (_data1.quality - 1) + 1;
         var _loc8_:PetTemplate = TempleteManager.instance.petTemplateCate.getTemplateByTNQ(temp.ResultPetTypes,temp.ResultPetGrade,temp.ResultQuality);
         _newData.templateId = _loc8_.TemplateId;
         _newData.isBind = true;
         _newData.grade = _data1.grade;
         _newData.name = _newData.template.TemplateName;
         _newData.remainPoint = (_newData.grade - 1) * 5;
         _newData.coeArmor = Math.max(_data1.coeArmorLimit,_data2.coeArmorLimit);
         _newData.coeIntellect = Math.max(_data1.coeIntellectLimit,_data2.coeIntellectLimit);
         _newData.coeStamina = Math.max(_data1.coeStaminaLimit,_data2.coeStaminaLimit);
         _newData.coeStrength = Math.max(_data1.coeStrengthLimit,_data2.coeStrengthLimit);
         _newData.intellect = _newData.intellectBase;
         _newData.strength = _newData.strengthBase;
         _newData.stamina = _newData.staminaBase;
         _newData.armor = _newData.armorBase;
         _newData.fightPower = PetData.calculatefightPower(_newData);
         _newPet.data = _newData.template;
         _newPetBg.tipData = _newData;
         _loc7_ = IconFactory.getPetHeadSmallIcon(_data2.templateId);
         if(_pet2.icon != _loc7_)
         {
            _pet2.icon = _loc7_;
         }
         _level2.text = LanguageMgr.GetTranslation("public.level2",_data2.grade);
         if(_otherData)
         {
            _num2.text = "1/1";
            _num2.setFrame(1);
            _pet2.tipData = _otherData;
            _name2.htmlText = LanguageMgr.GetTranslation("pet.mix.PetMixView.petName",getNameColor(),_otherData.name);
         }
         else
         {
            _num2.text = "0/1";
            _num2.setFrame(2);
            _pet2.tipData = _data2;
            _name2.htmlText = LanguageMgr.GetTranslation("pet.mix.PetMixView.petName",getNameColor(),_data2.template.TemplateName);
         }
         _newName.htmlText = LanguageMgr.GetTranslation("pet.mix.PetMixView.newName",getNameColor(),_newData.template.TemplateName);
         _isEnough = true;
         _needPoint = 0;
         _loc6_ = 0;
         while(_loc6_ < 3)
         {
            if(_materialList.length > _loc6_)
            {
               _loc5_ = ComponentFactory.Instance.creatCustomObject("pet.ComposeMaterialCell");
               _loc4_ = ComponentFactory.Instance.creatComponentByStylename("PetMixView.materialTxt");
               _loc5_.data = _materialList[_loc6_];
               _hBox1.addChild(_loc5_);
               _loc1_ = int(GoodsManager.instance.getBagCountByTempId(1,_materialList[_loc6_].templateId));
               _loc4_.text = _loc1_ + "/" + _materialList[_loc6_].count;
               _hBox2.addChild(_loc4_);
               if(_loc1_ < _materialList[_loc6_].count)
               {
                  _isEnough = false;
                  _loc2_ = TempleteManager.instance.getShopTempInfoByItemId(_materialList[_loc6_].templateId);
                  _needPoint += (_materialList[_loc6_].count - _loc1_) * _loc2_.GiftToken;
               }
            }
            _loc6_++;
         }
      }
      
      private function cheakPet() : Boolean
      {
         if(_data1 == null)
         {
            return false;
         }
         if(_data1.template.PetType != 105 && _data1.template.PetType != 106 && _data1.template.PetType != 102 && _data1.template.PetType != 104 && _data1.template.PetType != 101 && _data1.template.PetType != 103)
         {
            return false;
         }
         if(_data1.grade < _data1.template.NeedGrade)
         {
            return false;
         }
         if(_data1.isFullRes() == false)
         {
            return false;
         }
         if(_data1.template.NeedGrade == 3)
         {
            return _data1.quality == 6;
         }
         if(_data1.template.NeedGrade == 2)
         {
            return _data1.quality == 5;
         }
         return false;
      }
      
      private function initEvent() : void
      {
         if(_mixBtn)
         {
            _mixBtn.addEventListener("click",__mixBtnHandler);
         }
         if(_immediatelyMixBtn)
         {
            _immediatelyMixBtn.addEventListener("click",__immediatelyMixBtnHandler);
         }
         NotificationManager.instance.addEventListener("END_DRAG",__endDragHandler);
      }
      
      private function removeEvent() : void
      {
         if(_mixBtn)
         {
            _mixBtn.removeEventListener("click",__mixBtnHandler);
         }
         if(_immediatelyMixBtn)
         {
            _immediatelyMixBtn.removeEventListener("click",__immediatelyMixBtnHandler);
         }
         NotificationManager.instance.removeEventListener("END_DRAG",__endDragHandler);
      }
      
      private function __mixBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc10_:String = null;
         var _loc8_:String = null;
         if(_data1 == null)
         {
            _loc2_ = LanguageMgr.GetTranslation("pet.PetMixView.MixTips8");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(_otherData == null || cheakPet() == false)
         {
            _loc2_ = LanguageMgr.GetTranslation("pet.PetMixView.MixTips9");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         var _loc9_:Array = GoodsManager.instance.getPetEquipListById(_data1.petId);
         var _loc6_:Array = GoodsManager.instance.getPetEquipListById(_otherData.petId);
         if(_data1.isLock || Boolean(_otherData.isLock))
         {
            _loc2_ = LanguageMgr.GetTranslation("pet.PetMixView.MixTips10");
         }
         else if(_data1.isFullRes() == false || _otherData.isFullRes() == false)
         {
            _loc2_ = LanguageMgr.GetTranslation("pet.PetMixView.MixTips7");
         }
         else if(_isEnough == false)
         {
            _loc2_ = LanguageMgr.GetTranslation("pet.PetMixView.MixTips6");
         }
         else if(thaneInfo.grades < _data1.template.NeedGrade)
         {
            _loc2_ = LanguageMgr.GetTranslation("pet.PetMixView.MixTips3");
         }
         if(_loc2_)
         {
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(playerInfo.point + playerInfo.giftToken < _point)
         {
            RechargeAlertMannager.show();
            return;
         }
         var _loc3_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc4_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc7_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:uint = uint(_newData.template.PetType);
         if(_loc5_ > 106)
         {
            switch(int(_loc5_) - 117)
            {
               case 0:
               case 1:
               case 2:
                  _loc8_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip06") + LanguageMgr.GetTranslation("pet.PetMixView.and") + LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip08");
                  break;
               default:
                  _loc8_ = "";
            }
            if(_loc8_ != "")
            {
               _loc8_ = "(" + _loc8_ + ")";
            }
            _loc10_ = LanguageMgr.GetTranslation("pet.PetMixView.ConfiramMixMixedPet",_point,_data1.name,_otherData.name,_newData.template.TemplateName,getNameColor(),_loc8_);
         }
         else
         {
            _loc10_ = LanguageMgr.GetTranslation("pet.PetMixView.ConfiramMix",_point,_data1.name,_otherData.name,_newData.template.TemplateName,getNameColor());
         }
         _mixType = 0;
         SimpleAlertHelper.instance.data = [mixConfirmBack];
         SimpleAlertHelper.instance.popAlerFrame(_loc7_,_loc10_,_loc3_,_loc4_,true,true,false,2,"USEBINDPOINT_ALERT",193);
      }
      
      private function __immediatelyMixBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc10_:String = null;
         var _loc8_:String = null;
         if(_data1 == null)
         {
            _loc2_ = LanguageMgr.GetTranslation("pet.PetMixView.MixTips8");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(_otherData == null || cheakPet() == false)
         {
            _loc2_ = LanguageMgr.GetTranslation("pet.PetMixView.MixTips9");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         var _loc9_:Array = GoodsManager.instance.getPetEquipListById(_data1.petId);
         var _loc6_:Array = GoodsManager.instance.getPetEquipListById(_otherData.petId);
         if(_data1.isLock || Boolean(_otherData.isLock))
         {
            _loc2_ = LanguageMgr.GetTranslation("pet.PetMixView.MixTips10");
         }
         else if(_data1.isFullRes() == false || _otherData.isFullRes() == false)
         {
            _loc2_ = LanguageMgr.GetTranslation("pet.PetMixView.MixTips7");
         }
         else if(thaneInfo.grades < _data1.template.NeedGrade)
         {
            _loc2_ = LanguageMgr.GetTranslation("pet.PetMixView.MixTips3");
         }
         if(_loc2_)
         {
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(playerInfo.point + playerInfo.giftToken < _point)
         {
            RechargeAlertMannager.show();
            return;
         }
         var _loc3_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc4_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc7_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:uint = uint(_newData.template.PetType);
         if(_loc5_ > 106)
         {
            switch(int(_loc5_) - 117)
            {
               case 0:
               case 1:
               case 2:
                  _loc8_ = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip06") + LanguageMgr.GetTranslation("pet.PetMixView.and") + LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip08");
                  break;
               default:
                  _loc8_ = "";
            }
            if(_loc8_ != "")
            {
               _loc8_ = "(" + _loc8_ + ")";
            }
            _loc10_ = LanguageMgr.GetTranslation("pet.PetMixView.ConfiramMixMixedPet",_point + _needPoint,_data1.name,_otherData.name,_newData.template.TemplateName,getNameColor(),_loc8_);
         }
         else
         {
            _loc10_ = LanguageMgr.GetTranslation("pet.PetMixView.ConfiramMix",_point + _needPoint,_data1.name,_otherData.name,_newData.template.TemplateName,getNameColor());
         }
         _mixType = 2;
         SimpleAlertHelper.instance.data = [mixConfirmBack];
         SimpleAlertHelper.instance.popAlerFrame(_loc7_,_loc10_,_loc3_,_loc4_,true,true,false,2,"USEBINDPOINT_ALERT",193);
      }
      
      private function mixConfirmBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            payType = param2 ? 2 : 1;
            if(_mixBtn)
            {
               _mixBtn.enable = false;
            }
            playComposeMovie();
         }
      }
      
      private function __endDragHandler(param1:NotificationEvent) : void
      {
         var _loc3_:DisplayObject = param1.data.target;
         var _loc2_:PetData = param1.data.data;
         if(_loc3_ == _pet1 || _loc3_ == _pet2)
         {
            data = _loc2_;
         }
      }
      
      private function playComposeMovie() : void
      {
         var _loc2_:BaseItemView = null;
         var _loc4_:int = 0;
         if(!_data1 || !_otherData || !_newData)
         {
            return;
         }
         MaskUtils.instance.maskShow(0);
         KeyBoardRegister.instance.keyEnable = false;
         _petMixMc = ComponentFactory.Instance.creat("asset.pet.PetMixMovie");
         _petMixMc.mouseChildren = false;
         _petMixMc.x = 228;
         _petMixMc.y = 186;
         _petMixMc.gotoAndStop(1);
         _newPetMc = new PetAvatarView();
         _newPetMc.data = _newData.template;
         _newPetMc.x = -18;
         _newPetMc.y = 80;
         _itemMcList = [];
         _iconMcList = [];
         _loc4_ = 0;
         while(_loc4_ < 3)
         {
            if(_materialList.length > _loc4_)
            {
               _loc2_ = ComponentFactory.Instance.creatCustomObject("pet.ComposeMaterialCell2");
               _loc2_.data = _materialList[_loc4_];
               _itemMcList.push(_loc2_);
            }
            _loc4_++;
         }
         var _loc3_:BaseIconView = ComponentFactory.Instance.creatCustomObject("pet.CellIcon");
         _loc3_.icon = IconFactory.getPetHeadSmallIcon(_data1.templateId);
         _iconMcList.push(_loc3_);
         _loc3_ = ComponentFactory.Instance.creatCustomObject("pet.CellIcon");
         _loc3_.icon = IconFactory.getPetHeadSmallIcon(_data2.templateId);
         _iconMcList.push(_loc3_);
         var _loc1_:SimpleMovie = new SimpleMovie(_petMixMc,onMovieEnd,1,1,onMovieEnterFrame);
         _loc1_.mouseChildren = false;
         addChild(_loc1_);
      }
      
      private function onMovieEnd() : void
      {
         MaskUtils.instance.maskHide();
         KeyBoardRegister.instance.keyEnable = true;
         if(_data1 && _otherData)
         {
            updateToPlayerInfo(_data1.petId);
            updateToPlayerInfo(_otherData.petId);
            PetSocketOut.mixDoublePet(_data1.petId,_otherData.petId,_mixType,payType);
         }
         ObjectUtils.disposeViolentMc(_petMixMc);
         _petMixMc = null;
         if(_itemMcList)
         {
            while(_itemMcList.length > 0)
            {
               ObjectUtils.disposeObject(_itemMcList.pop());
            }
            _itemMcList = null;
         }
         if(_iconMcList)
         {
            while(_iconMcList.length > 0)
            {
               ObjectUtils.disposeObject(_iconMcList.pop());
            }
            _iconMcList = null;
         }
         if(_newPetMc)
         {
            _newPetMc.dispose();
         }
         _newPetMc = null;
         clean();
      }
      
      private function onMovieEnterFrame() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(_petMixMc.currentFrame == 127)
         {
            _petMixMc["newPet"].addChild(_newPetMc);
         }
         else if(_petMixMc.currentFrame == 26)
         {
            _loc1_ = 0;
            while(_loc1_ < 3)
            {
               if(_itemMcList.length > _loc1_)
               {
                  _petMixMc["center"]["material"]["material" + (_loc1_ + 1)].addChild(_itemMcList[_loc1_]);
               }
               _loc1_++;
            }
            _loc2_ = 0;
            while(_loc2_ < 2)
            {
               if(_iconMcList.length > _loc2_)
               {
                  _petMixMc["center"]["pet"]["pet" + (_loc2_ + 1)].addChild(_iconMcList[_loc2_]);
               }
               _loc2_++;
            }
         }
         else if(_petMixMc.currentFrame == 76)
         {
            _petMixMc["center"]["newPet"].addChild(_newPetMc);
         }
      }
      
      private function updateToPlayerInfo(param1:int) : void
      {
         var _loc3_:String = null;
         var _loc2_:int = 0;
         playerInfo.beginChanges();
         _loc2_ = int(playerInfo.petMonopolyFormationOfArray.indexOf(param1.toString()));
         if(_loc2_ != -1)
         {
            playerInfo.petMonopolyFormationOfArray[_loc2_] = -1;
            _loc3_ = playerInfo.petMonopolyFormationOfArray.join(",");
            playerInfo.petMonopolyFormation = _loc3_;
            MonopolySocketOutManager.sendPetFormation(_loc3_);
         }
         playerInfo.commit();
      }
      
      private function getMixTemplate() : PetComposeGoodsTemplete
      {
         var _loc1_:PetTemplate = null;
         if(!_data1 || !_controller)
         {
            return null;
         }
         var _loc2_:Vector.<PetComposeGoodsTemplete> = _controller.getMixPetTemplateList();
         for each(var _loc3_:PetComposeGoodsTemplete in _loc2_)
         {
            if(_loc3_.Pet1Types == _data1.template.PetType && _loc3_.Pet1Grade == _data1.template.NeedGrade && _loc3_.Pet1Quality >= 5)
            {
               _loc1_ = TempleteManager.instance.petTemplateCate.getTemplateByTNQ(_loc3_.Pet2Types,_loc3_.Pet2Grade,_loc3_.Pet2Quality);
               if(_loc1_)
               {
                  _data2 = new PetData();
                  _data2.templateId = _loc1_.TemplateId;
                  _data2.grade = level[_loc3_.Pet2Grade - 1];
                  _data2.quality = _loc3_.Pet2Quality;
                  _data2.name = _loc1_.TemplateName;
                  _data2.temQuality = _loc3_.Pet2Quality * (_loc3_.Pet2Quality - 1) + 1;
                  _data2.coeArmor = _data2.coeArmorLimit;
                  _data2.coeIntellect = _data2.coeIntellectLimit;
                  _data2.coeStamina = _data2.coeStaminaLimit;
                  _data2.coeStrength = _data2.coeStrengthLimit;
                  _otherData = playerInfo.getMixPetData(_loc3_.Pet2Types,_loc3_.Pet2Grade,_loc3_.Pet2Quality);
               }
               setMaterial(_loc3_);
               return _loc3_;
            }
            if(_loc3_.Pet2Types == _data1.template.PetType && _loc3_.Pet2Grade == _data1.template.NeedGrade && _loc3_.Pet2Quality >= 5)
            {
               _loc1_ = TempleteManager.instance.petTemplateCate.getTemplateByTNQ(_loc3_.Pet1Types,_loc3_.Pet1Grade,_loc3_.Pet1Quality);
               if(_loc1_)
               {
                  _data2 = new PetData();
                  _data2.templateId = _loc1_.TemplateId;
                  _data2.grade = level[_loc3_.Pet1Grade - 1];
                  _data2.quality = _loc3_.Pet1Quality;
                  _data2.name = _loc1_.TemplateName;
                  _data2.temQuality = _loc3_.Pet1Quality * (_loc3_.Pet1Quality - 1) + 1;
                  _data2.coeArmor = _data2.coeArmorLimit;
                  _data2.coeIntellect = _data2.coeIntellectLimit;
                  _data2.coeStamina = _data2.coeStaminaLimit;
                  _data2.coeStrength = _data2.coeStrengthLimit;
                  _otherData = playerInfo.getMixPetData(_loc3_.Pet1Types,_loc3_.Pet1Grade,_loc3_.Pet1Quality);
               }
               setMaterial(_loc3_);
               return _loc3_;
            }
         }
         return null;
      }
      
      private function setMaterial(param1:PetComposeGoodsTemplete) : void
      {
         var _loc2_:GoodsInfo = null;
         if(param1.NeedItemTempId1 > 0)
         {
            _loc2_ = new GoodsInfo();
            _loc2_.templateId = param1.NeedItemTempId1;
            _loc2_.count = param1.NeedItemTempIdCount1;
            _materialList.push(_loc2_);
         }
         if(param1.NeedItemTempId2 > 0)
         {
            _loc2_ = new GoodsInfo();
            _loc2_.templateId = param1.NeedItemTempId2;
            _loc2_.count = param1.NeedItemTempIdCount2;
            _materialList.push(_loc2_);
         }
         if(param1.NeedItemTempId3 > 0)
         {
            _loc2_ = new GoodsInfo();
            _loc2_.templateId = param1.NeedItemTempId3;
            _loc2_.count = param1.NeedItemTempIdCount3;
            _materialList.push(_loc2_);
         }
      }
      
      private function getNameColor() : String
      {
         var _loc2_:int = 5;
         if(_data1.template.NeedGrade == 3)
         {
            _loc2_ = 6;
         }
         var _loc1_:String = "ffffff";
         switch(_loc2_ - 1)
         {
            case 0:
               _loc1_ = "ffffff";
               break;
            case 1:
               _loc1_ = "59cd41";
               break;
            case 2:
               _loc1_ = "32a2f8";
               break;
            case 3:
               _loc1_ = "c300ff";
               break;
            case 4:
               _loc1_ = "ff9600";
               break;
            case 5:
               _loc1_ = "ce0f0f";
         }
         return _loc1_;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get thaneInfo() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         unitView();
         super.dispose();
      }
   }
}

