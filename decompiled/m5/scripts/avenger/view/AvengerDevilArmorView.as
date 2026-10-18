package avenger.view
{
   import avenger.item.AvengerDevilArmorEquipItem;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.avenger.AvengerDevilArmorInfo;
   import mvc.module.avenger.AvengerModel;
   import utils.LogicUtils;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.AvengerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.utils.NumberViewUtils;
   import yishi.view.base.ProgressCommon;
   import yishi.view.base.TokenAmountItem;
   import yishi.view.tips.MessageTipManager;
   
   public class AvengerDevilArmorView extends Component
   {
      
      private var _bg:MutipleImage;
      
      private var _itemTitleText:FilterFrameText;
      
      private var _numBit:BitmapData;
      
      private var _gradeCon:Component;
      
      private var _nextCon:Component;
      
      private var _nextBit:Bitmap;
      
      private var _nextDescText:FilterFrameText;
      
      private var _expBar:ProgressCommon;
      
      private var _costItem:TokenAmountItem;
      
      private var _polishBtn:IconButton;
      
      private var _lookImage:Image;
      
      private var _itemCon:Component;
      
      private var itemList:Vector.<AvengerDevilArmorEquipItem>;
      
      private var _bagView:AvengerDevilArmorBagView;
      
      private var itemPosAry:Array = [[10,150],[13,50],[100,10],[200,10],[290,50],[292,150]];
      
      private var data:AvengerDevilArmorInfo;
      
      private var hasMaterialCount:int;
      
      public function AvengerDevilArmorView()
      {
         super();
         initView();
         initItemView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("Avenger.AvengerDevilArmorView.bg");
         _itemTitleText = ComponentFactory.Instance.creatComponentByStylename("AvengerDevilArmorView.itemTitleText");
         _numBit = ComponentFactory.Instance.creatBitmapData("asset.Avenger.numBmd");
         _gradeCon = ComponentFactory.Instance.creatComponentByStylename("AvengerDevilArmorView.gradeCon");
         _nextCon = ComponentFactory.Instance.creatComponentByStylename("AvengerDevilArmorView.nextCon");
         _nextBit = ComponentFactory.Instance.creatBitmap("asset.AvengerDevilArmorView.nextBit");
         _nextDescText = ComponentFactory.Instance.creatComponentByStylename("AvengerDevilArmorView.nextDescText");
         _expBar = ComponentFactory.Instance.creatComponentByStylename("AvengerDevilArmorView.expBar");
         _lookImage = ComponentFactory.Instance.creatComponentByStylename("AvengerDevilArmorView.lookImage");
         _costItem = ComponentFactory.Instance.creatComponentByStylename("AvengerDevilArmorView.costItem");
         _polishBtn = ComponentFactory.Instance.creatComponentByStylename("AvengerDevilArmorView.polishBtn");
         _itemCon = ComponentFactory.Instance.creatComponentByStylename("AvengerDevilArmorView.itemCon");
         _bagView = ComponentFactory.Instance.creatCustomObject("AvengerDevilArmorView.bagView");
         addChild(_bg);
         addChild(_itemTitleText);
         addChild(_gradeCon);
         addChild(_lookImage);
         addChild(_nextCon);
         addChild(_expBar);
         addChild(_costItem);
         addChild(_polishBtn);
         addChild(_itemCon);
         addChild(_bagView);
         _nextCon.addChild(_nextBit);
         _nextCon.addChild(_nextDescText);
         _itemTitleText.text = LanguageMgr.GetTranslation("AvengerDevilArmorView.itemTitleText.text");
      }
      
      private function initItemView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:AvengerDevilArmorEquipItem = null;
         itemList = new Vector.<AvengerDevilArmorEquipItem>();
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _loc1_ = new AvengerDevilArmorEquipItem(_loc2_,true);
            _loc1_.x = itemPosAry[_loc2_][0];
            _loc1_.y = itemPosAry[_loc2_][1];
            _itemCon.addChild(_loc1_);
            itemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         MsgMan.addObserver("DEVIL_ARMOR_INFO_UPDATE",this,__devilArmorChangeHandler);
         MsgMan.addObserver("DEVIL_ARMOR_BAG_UPDATE",this,__updateEquipViewHandler);
         _polishBtn.addEventListener("click",__polishClickHandler);
      }
      
      private function removeEvent() : void
      {
         MsgMan.removeObserver("DEVIL_ARMOR_INFO_UPDATE",this,__devilArmorChangeHandler);
         MsgMan.removeObserver("DEVIL_ARMOR_BAG_UPDATE",this,__updateEquipViewHandler);
         if(_polishBtn)
         {
            _polishBtn.removeEventListener("click",__polishClickHandler);
         }
      }
      
      private function __polishClickHandler(param1:MouseEvent) : void
      {
         if(hasMaterialCount <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("PetHallowsRightSkillView.train.noGoodsAlert"));
            return;
         }
         AvengerManager.instance.sendDevilArmorRequest();
      }
      
      private function __devilArmorChangeHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function __updateEquipViewHandler(param1:String, param2:Object) : void
      {
         var _loc4_:int = 0;
         var _loc3_:AvengerDevilArmorEquipItem = null;
         _loc4_ = 0;
         while(_loc4_ < itemList.length)
         {
            _loc3_ = itemList[_loc4_];
            _loc3_.data = data.holeDic[_loc4_];
            _loc4_++;
         }
         _bagView.refreshView();
         hasMaterialCount = model.armorBagDic[6910001] ? model.armorBagDic[6910001].count : 0;
         _costItem.firstText = hasMaterialCount + "";
      }
      
      private function refreshView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:AvengerDevilArmorEquipItem = null;
         data = model.devilArmorInfo;
         if(!data.upgradeTempInfo)
         {
            return;
         }
         refreshImageTips();
         NumberViewUtils.refreshValue(data.grade,_gradeCon,_numBit,14,18,11,14,"0123456789");
         hasMaterialCount = model.armorBagDic[6910001] ? model.armorBagDic[6910001].count : 0;
         var _loc2_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(6910001);
         _costItem.firstText = hasMaterialCount + "";
         if(_loc2_)
         {
            _costItem.iconTipData = _loc2_.TemplateName + "\n" + _loc2_.Description;
         }
         if(data.nextUpgradeTempInfo)
         {
            _polishBtn.enable = true;
            _expBar.value = data.exp / data.nextUpgradeTempInfo.Data;
            _expBar.text = data.exp + "/" + data.nextUpgradeTempInfo.Data;
            _nextDescText.text = data.nextUpgradeTempInfo.TemplateName;
            _nextBit.visible = true;
            _nextDescText.x = 115;
         }
         else
         {
            _nextBit.visible = false;
            _polishBtn.enable = false;
            _expBar.value = 1;
            _expBar.text = LanguageMgr.GetTranslation("armyII.viewII.rune.RuneUpgradeView.RuneMaxTxt");
            _nextDescText.text = LanguageMgr.GetTranslation("AvengerDevilArmorView.nextDescText.text");
            _nextDescText.x = 50;
         }
         _loc3_ = 0;
         while(_loc3_ < itemList.length)
         {
            _loc1_ = itemList[_loc3_];
            _loc1_.data = data.holeDic[_loc3_];
            _loc3_++;
         }
      }
      
      private function refreshImageTips() : void
      {
         var _loc2_:UpgradeTemplateInfo = null;
         var _loc3_:int = 0;
         var _loc4_:String = "";
         var _loc1_:Array = TempleteManager.instance.getTemplatesByType(155);
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc2_ = _loc1_[_loc3_];
            if(data.grade >= _loc2_.Grades)
            {
               _loc4_ += "<font color=\'#48d72a\'>" + _loc2_.TemplateName + "</font>" + "\n";
            }
            else
            {
               _loc4_ += "<font color=\'#808080\'>" + _loc2_.TemplateName + "</font>" + "\n";
            }
            _loc3_++;
         }
         _lookImage.tipData = _loc4_;
      }
      
      private function get model() : AvengerModel
      {
         return AvengerManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_nextDescText);
         _nextDescText = null;
         ObjectUtils.disposeObject(_itemTitleText);
         _itemTitleText = null;
         ObjectUtils.disposeObject(_gradeCon);
         _gradeCon = null;
         ObjectUtils.disposeObject(_numBit);
         _numBit = null;
         ObjectUtils.disposeObject(_expBar);
         _expBar = null;
         ObjectUtils.disposeObject(_nextCon);
         _nextCon = null;
         ObjectUtils.disposeObject(_nextBit);
         _nextBit = null;
         ObjectUtils.disposeObject(_bagView);
         _bagView = null;
         ObjectUtils.disposeObject(_polishBtn);
         _polishBtn = null;
         ObjectUtils.disposeObject(_costItem);
         _costItem = null;
         ObjectUtils.disposeObject(_lookImage);
         _lookImage = null;
         LogicUtils.disposeDisplayCollection(itemList);
         itemList = null;
         super.dispose();
      }
   }
}

