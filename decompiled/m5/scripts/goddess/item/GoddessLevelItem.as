package goddess.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import goddess.vo.EquipAddVo;
   import managers.GodDessManager;
   import yishi.datas.templates.GoddessUpLevelTempInfo;
   import yishi.utils.NumberViewUtils;
   
   public class GoddessLevelItem extends Sprite
   {
      
      private var _bg:MutipleImage;
      
      private var _title:ScaleFrameImage;
      
      private var _lvSp:Sprite;
      
      private var _lvData:BitmapData;
      
      private var _attackTxt:FilterFrameText;
      
      private var _defanceTxt:FilterFrameText;
      
      private var _magicFanceTxt:FilterFrameText;
      
      private var _liveTxt:FilterFrameText;
      
      private var _fullFlg:Bitmap;
      
      private var _idx:int;
      
      private var _data:GoddessUpLevelTempInfo;
      
      public function GoddessLevelItem(param1:int)
      {
         super();
         _idx = param1;
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.lvItemBack");
         _title = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.lvItemTitle");
         _attackTxt = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.itemAttackTxt");
         _defanceTxt = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.itemDefanceTxt");
         _magicFanceTxt = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.itemMagicDefanceTxt");
         _liveTxt = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.itemLifeTxt");
         _lvData = ComponentFactory.Instance.creatBitmap("asset.goddess.lvNumData").bitmapData;
         _lvSp = ComponentFactory.Instance.creatCustomObject("ui.goddess.itemLvSp");
         _fullFlg = ComponentFactory.Instance.creatBitmap("asset.goddess.fullLv");
         addChild(_bg);
         addChild(_title);
         addChild(_attackTxt);
         addChild(_defanceTxt);
         addChild(_magicFanceTxt);
         addChild(_liveTxt);
         addChild(_lvSp);
         addChild(_fullFlg);
         _title.setFrame(_idx);
         if(_idx == 1)
         {
            _lvSp.x = 92;
            _attackTxt.setFrame(1);
            _defanceTxt.setFrame(1);
            _magicFanceTxt.setFrame(1);
            _liveTxt.setFrame(1);
         }
         else
         {
            _lvSp.x = 114;
            _attackTxt.setFrame(2);
            _defanceTxt.setFrame(2);
            _magicFanceTxt.setFrame(2);
            _liveTxt.setFrame(2);
         }
      }
      
      private function refreshLv(param1:int) : void
      {
         ObjectUtils.disposeAllChildren(_lvSp);
         NumberViewUtils.refreshValue(param1,_lvSp,_lvData,15,19,10,15);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_lvSp);
         _lvSp = null;
         ObjectUtils.disposeObject(_lvData);
         _lvData = null;
         ObjectUtils.disposeObject(_attackTxt);
         _attackTxt = null;
         ObjectUtils.disposeObject(_defanceTxt);
         _defanceTxt = null;
         ObjectUtils.disposeObject(_magicFanceTxt);
         _magicFanceTxt = null;
         ObjectUtils.disposeObject(_liveTxt);
         _liveTxt = null;
         ObjectUtils.disposeObject(_fullFlg);
         _fullFlg = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         _data = null;
      }
      
      public function get data() : GoddessUpLevelTempInfo
      {
         return _data;
      }
      
      public function refreshView(param1:GoddessUpLevelTempInfo, param2:int, param3:EquipAddVo) : void
      {
         _data = param1;
         if(_data == null)
         {
            ObjectUtils.disposeAllChildren(_lvSp);
            _attackTxt.visible = false;
            _defanceTxt.visible = false;
            _magicFanceTxt.visible = false;
            _liveTxt.visible = false;
            _fullFlg.visible = true;
            _title.visible = false;
            _bg.visible = false;
         }
         else
         {
            _bg.visible = true;
            _attackTxt.visible = true;
            _defanceTxt.visible = true;
            _magicFanceTxt.visible = true;
            _liveTxt.visible = true;
            _fullFlg.visible = false;
            _title.visible = true;
            _attackTxt.text = GodDessManager.calculationAddValue(_data.Attack,param2) + param3.Attack + "";
            _defanceTxt.text = GodDessManager.calculationAddValue(_data.Defance,param2) + param3.Defance + "";
            _magicFanceTxt.text = GodDessManager.calculationAddValue(_data.MagicDefance,param2) + param3.MagicDefance + "";
            _liveTxt.text = GodDessManager.calculationAddValue(_data.Live,param2) + param3.Live + "";
            refreshLv(_data.Level);
         }
      }
   }
}

