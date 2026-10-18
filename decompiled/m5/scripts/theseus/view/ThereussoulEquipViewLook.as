package theseus.view
{
   import avatar.view.ShowAvatar;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import mvc.module.theseus.TheseussoulModel;
   import mvc.module.theseus.WarFrameItemInfo;
   import theseus.item.TheseusTaoItem;
   import theseus.item.TheseussoulEquipCell;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.RoyaltyTempInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   
   public class ThereussoulEquipViewLook extends Sprite
   {
      
      public var _jiaBg:Bitmap;
      
      public var _eqFightBg:MutipleImage;
      
      public var _equipTName:FilterFrameText;
      
      public var _fightValue:FilterFrameText;
      
      private var _figure:ShowAvatar;
      
      private var _bagBack:Scale9CornerImage;
      
      private var _equipCellList:Vector.<TheseussoulEquipCell>;
      
      private var _suitItemList:Vector.<TheseusTaoItem>;
      
      private const SUIT_MAX:int = 9;
      
      private const EQUIP_MAX:int = 12;
      
      private var _thane:ThaneInfo;
      
      public function ThereussoulEquipViewLook()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bagBack = ComponentFactory.Instance.creatComponentByStylename("ThereussoulEquipView.BagBack");
         _jiaBg = ComponentFactory.Instance.creatBitmap("asset.theseus.jiaBg");
         _eqFightBg = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.eqFightBg");
         _equipTName = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.equipTName");
         _fightValue = ComponentFactory.Instance.creatComponentByStylename("theseus.lookSuitTxt");
         _figure = new ShowAvatar(true);
         _figure.x = 44;
         _figure.y = 22;
         _figure.mouseChildren = _figure.mouseEnabled = false;
         addChild(_bagBack);
         addChild(_jiaBg);
         addChild(_figure);
         addChild(_eqFightBg);
         addChild(_equipTName);
         addChild(_fightValue);
      }
      
      private function initEquipItems() : void
      {
         var _loc2_:int = 0;
         var _loc1_:TheseussoulEquipCell = null;
         _equipCellList = new Vector.<TheseussoulEquipCell>();
         var _loc3_:Array = TheseussoulModel.SONTYPES;
         _loc2_ = 0;
         while(_loc2_ < 12)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.equipCell" + (_loc2_ + 1));
            _loc1_.needMediator = false;
            _loc1_.model = model;
            _loc1_.pos = _loc2_;
            _loc1_.sonType = _loc3_[_loc2_];
            addChild(_loc1_);
            _equipCellList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function initTaoItems() : void
      {
         var _loc2_:TheseusTaoItem = null;
         var _loc3_:int = 0;
         _suitItemList = new Vector.<TheseusTaoItem>();
         var _loc5_:Array = [8,6,7,9,4,2,1,3,5];
         var _loc4_:int = int(model.getRoyaltyLevel(_thane.userId));
         if(_loc4_ <= 0)
         {
            _loc4_ = 1;
         }
         var _loc1_:RoyaltyTempInfo = TempleteManager.instance.royaltyTempCate.getTempInfoByLevel(_loc4_);
         _loc3_ = 0;
         while(_loc3_ < 9)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.suit" + (_loc3_ + 1),[_loc5_[_loc3_]]);
            _loc2_.model = model;
            if(_loc1_.OpenTheseus >= _loc5_[_loc3_])
            {
               _loc2_.lock = false;
            }
            else
            {
               _loc2_.lock = true;
            }
            addChild(_loc2_);
            if(_loc3_ > 3)
            {
               _loc2_.y = 337;
            }
            _suitItemList.push(_loc2_);
            _loc3_++;
         }
      }
      
      public function initData(param1:ThaneInfo) : void
      {
         _thane = param1;
         initEquipItems();
         initTaoItems();
         refreshHeroFigure();
         initEvent();
         chooseHandler();
      }
      
      private function initEvent() : void
      {
         model.addEventListener("EVENT_CHOOSE_SUIT",chooseHandler);
      }
      
      private function removeEvent() : void
      {
         model.removeEventListener("EVENT_CHOOSE_SUIT",chooseHandler);
      }
      
      private function chooseHandler(param1:Event = null) : void
      {
         var _loc2_:TheseusTaoItem = null;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < 9)
         {
            _loc2_ = _suitItemList[_loc3_];
            _loc2_.isSelect = _loc2_.suitIdx == model.currSuitIdx;
            _loc3_++;
         }
         refreshEquipView();
      }
      
      public function refreshEquipView() : void
      {
         var _loc5_:WarFrameItemInfo = null;
         var _loc1_:TheseussoulEquipCell = null;
         var _loc6_:int = 0;
         var _loc3_:WarFrameItemInfo = null;
         var _loc4_:int = 0;
         _fightValue.text = "" + model.propertys.armour;
         var _loc2_:int = int(model.currSuitIdx);
         _equipTName.text = LanguageMgr.GetTranslation("theseus.equip.suitName" + _loc2_);
         var _loc7_:Array = model.suitInfo.getSuitArray(_loc2_);
         _loc4_ = 0;
         while(_loc4_ < _equipCellList.length)
         {
            _loc1_ = _equipCellList[_loc4_];
            _loc1_.suitIdx = _loc2_;
            _loc6_ = int(_loc7_[_loc4_]);
            if(PlayerManager.instance.currentPlayerModel.playerInfo.userId == _thane.userId)
            {
               _loc3_ = TheseussoulManager.Instance.model.armorBagDic[_loc6_] as WarFrameItemInfo;
            }
            else
            {
               _loc3_ = _thane.theseusInfo.armorBagDic[_loc6_] as WarFrameItemInfo;
            }
            if(_loc6_ > 0)
            {
               _loc5_ = _loc3_;
               _loc5_.id = _loc6_;
               _loc5_.model = model;
               _loc1_.data = _loc5_;
            }
            else
            {
               _loc1_.data = null;
            }
            _loc4_++;
         }
      }
      
      private function get model() : TheseussoulModel
      {
         return _thane.theseusInfo;
      }
      
      private function refreshHeroFigure() : void
      {
         _figure.data = _thane;
      }
      
      public function dispose() : void
      {
         removeEvent();
         for each(var _loc1_:TheseussoulEquipCell in _equipCellList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _equipCellList = null;
         for each(var _loc2_:TheseusTaoItem in _suitItemList)
         {
            ObjectUtils.disposeObject(_loc2_);
         }
         _suitItemList = null;
         ObjectUtils.disposeObject(_bagBack);
         _bagBack = null;
         ObjectUtils.disposeObject(_fightValue);
         _fightValue = null;
         ObjectUtils.disposeObject(_jiaBg);
         _jiaBg = null;
         ObjectUtils.disposeObject(_eqFightBg);
         _eqFightBg = null;
         ObjectUtils.disposeObject(_equipTName);
         _equipTName = null;
         ObjectUtils.disposeObject(_figure);
         _figure = null;
      }
   }
}

