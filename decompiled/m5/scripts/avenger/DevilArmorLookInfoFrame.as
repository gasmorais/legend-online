package avenger
{
   import avenger.item.AvengerDevilArmorEquipItem;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BitmapData;
   import manager.LanguageMgr;
   import mvc.module.avenger.AvengerDevilArmorInfo;
   import mvc.module.avenger.AvengerModel;
   import yishi.manager.AvengerManager;
   import yishi.utils.NumberViewUtils;
   import yishi.view.base.ProgressCommon;
   
   public class DevilArmorLookInfoFrame extends Frame
   {
      
      private var _bg:MutipleImage;
      
      private var _gradeCon:Component;
      
      private var _numBit:BitmapData;
      
      private var _expBar:ProgressCommon;
      
      private var _itemCon:Component;
      
      private var itemList:Vector.<AvengerDevilArmorEquipItem>;
      
      private var itemPosAry:Array = [[10,150],[13,50],[100,10],[200,10],[290,50],[292,150]];
      
      private var _data:AvengerDevilArmorInfo;
      
      public function DevilArmorLookInfoFrame()
      {
         super();
         initView();
         initItemView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("Avenger.AvengerDevilArmorView.bg2");
         _gradeCon = ComponentFactory.Instance.creatComponentByStylename("AvengerDevilArmorView.gradeCon");
         _numBit = ComponentFactory.Instance.creatBitmapData("asset.Avenger.numBmd");
         _expBar = ComponentFactory.Instance.creatComponentByStylename("AvengerDevilArmorView.expBar");
         _itemCon = ComponentFactory.Instance.creatComponentByStylename("AvengerDevilArmorView.itemCon");
         _expBar.y = 273;
         addToContent(_bg);
         addToContent(_gradeCon);
         addToContent(_expBar);
         addToContent(_itemCon);
      }
      
      private function initItemView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:AvengerDevilArmorEquipItem = null;
         itemList = new Vector.<AvengerDevilArmorEquipItem>();
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _loc1_ = new AvengerDevilArmorEquipItem(_loc2_,false);
            _loc1_.x = itemPosAry[_loc2_][0];
            _loc1_.y = itemPosAry[_loc2_][1];
            _itemCon.addChild(_loc1_);
            itemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      public function set data(param1:AvengerDevilArmorInfo) : void
      {
         var _loc3_:int = 0;
         var _loc2_:AvengerDevilArmorEquipItem = null;
         _data = param1;
         if(!_data.upgradeTempInfo)
         {
            return;
         }
         NumberViewUtils.refreshValue(_data.grade,_gradeCon,_numBit,14,18,11,14,"0123456789");
         if(_data.nextUpgradeTempInfo)
         {
            _expBar.value = _data.exp / _data.nextUpgradeTempInfo.Data;
            _expBar.text = _data.exp + "/" + _data.nextUpgradeTempInfo.Data;
         }
         else
         {
            _expBar.value = 1;
            _expBar.text = LanguageMgr.GetTranslation("armyII.viewII.rune.RuneUpgradeView.RuneMaxTxt");
         }
         _loc3_ = 0;
         while(_loc3_ < itemList.length)
         {
            _loc2_ = itemList[_loc3_];
            _loc2_.data = _data.holeDic[_loc3_];
            _loc3_++;
         }
      }
      
      private function get model() : AvengerModel
      {
         return AvengerManager.instance.model;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_gradeCon);
         _gradeCon = null;
         ObjectUtils.disposeObject(_numBit);
         _numBit = null;
         ObjectUtils.disposeObject(_expBar);
         _expBar = null;
         ObjectUtils.disposeObject(_itemCon);
         _itemCon = null;
         super.dispose();
      }
   }
}

