package theseus.war.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import mvc.module.theseus.TheseusWarsoulItemInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   
   public class TheseusWarEquipHItemLook extends Sprite
   {
      
      public var _warEquipHbox:HBox;
      
      public var _warEquipType:ScaleFrameImage;
      
      private var _checkBtn:SelectedCheckButton;
      
      private var _itemList:Vector.<TheseusWarEquipCellLook> = new Vector.<TheseusWarEquipCellLook>();
      
      private var _maintype:int;
      
      private var _thane:ThaneInfo;
      
      public function TheseusWarEquipHItemLook(param1:int)
      {
         super();
         _maintype = param1;
         initView();
      }
      
      private function initView() : void
      {
         var _loc1_:TheseusWarEquipCellLook = null;
         var _loc3_:int = 0;
         _warEquipHbox = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.warEquipHbox");
         _warEquipType = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.warEquipType");
         _checkBtn = ComponentFactory.Instance.creatComponentByStylename("theseus.war.equipCheckBtn");
         addChild(_warEquipHbox);
         addChild(_warEquipType);
         addChild(_checkBtn);
         _warEquipType.setFrame(_maintype);
         _warEquipHbox.beginChanges();
         var _loc2_:Array = [[1,4,7],[2,5,8],[3,6,9]];
         _loc3_ = 0;
         while(_loc3_ < 3)
         {
            _loc1_ = new TheseusWarEquipCellLook(_loc2_[_maintype - 1][_loc3_]);
            _itemList[_loc3_] = _loc1_;
            _warEquipHbox.addChild(_loc1_);
            _loc3_++;
         }
         _warEquipHbox.commitChanges();
         _checkBtn.mouseChildren = _checkBtn.mouseEnabled = false;
      }
      
      public function refreshView(param1:Array) : void
      {
         var _loc3_:int = 0;
         if(_thane.warSoulInfo)
         {
            _checkBtn.selected = _thane.warSoulInfo.fightIdx == _maintype;
         }
         for each(var _loc2_:TheseusWarEquipCellLook in _itemList)
         {
            _loc2_.data = getInfoBySontype(param1,_loc2_.sonType);
            _loc3_ = int(_thane.theseusInfo.getRoyaltyLevel(_thane.userId));
            if(_loc3_ <= 0)
            {
               _loc3_ = 1;
            }
            _loc2_.setLock(_loc3_);
         }
      }
      
      public function initData(param1:ThaneInfo) : void
      {
         _thane = param1;
      }
      
      private function getInfoBySontype(param1:Array, param2:int) : TheseusWarsoulItemInfo
      {
         for each(var _loc3_:TheseusWarsoulItemInfo in param1)
         {
            if(_loc3_.warTempInfo.SonType == param2)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function dispose() : void
      {
         for each(var _loc1_:TheseusWarEquipCellLook in _itemList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _itemList = null;
         ObjectUtils.disposeObject(_warEquipHbox);
         _warEquipHbox = null;
         ObjectUtils.disposeObject(_warEquipType);
         _warEquipType = null;
         ObjectUtils.disposeObject(_checkBtn);
         _checkBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

