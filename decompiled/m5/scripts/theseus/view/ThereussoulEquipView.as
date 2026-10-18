package theseus.view
{
   import avatar.view.ShowAvatar;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.fashion.FashionInfoMsg;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import mvc.module.fashion.FashionModel;
   import mvc.module.theseus.TheseusCollenTionModel;
   import mvc.module.theseus.TheseussoulModel;
   import mvc.module.theseus.WarFrameItemInfo;
   import theseus.item.TheseusTaoItem;
   import theseus.item.TheseussoulEquipCell;
   import yishi.datas.VersionSwitch;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.RoyaltyTempInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RoyaltyBossManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.SimpleDictionary;
   import yishi.utils.ThaneEquipShowHelper;
   
   public class ThereussoulEquipView extends Sprite
   {
      
      public var _jiaBg:Bitmap;
      
      public var _zhangjValue:Bitmap;
      
      public var _nowZhangjValue:Bitmap;
      
      public var _collentionBtn:BaseButton;
      
      public var _collentionBtntxt:FilterFrameText;
      
      public var _godheadBtn:BaseButton;
      
      public var _godheadBtntxt:FilterFrameText;
      
      public var _eqFightBg:MutipleImage;
      
      public var _look:FilterFrameText;
      
      public var _equipTName:FilterFrameText;
      
      public var _fightValue:FilterFrameText;
      
      private var _figure:ShowAvatar;
      
      private var _bagBack:Scale9CornerImage;
      
      private var _equipCellList:Vector.<TheseussoulEquipCell>;
      
      private var _suitItemList:Vector.<TheseusTaoItem>;
      
      private const SUIT_MAX:int = 9;
      
      private const EQUIP_MAX:int = 12;
      
      public var _warIntensifyBtn:IconButton;
      
      private var _refresh:BaseButton;
      
      protected var _redcollention:Bitmap;
      
      private var _isNowZhangjValue:Boolean = false;
      
      public function ThereussoulEquipView()
      {
         super();
         initView();
         refreshHeroFigure();
         initEvent();
         chooseHandler();
         TheseussoulManager.Instance.doCollectionthing(1);
      }
      
      private function initView() : void
      {
         var _loc5_:int = 0;
         var _loc1_:TheseussoulEquipCell = null;
         var _loc3_:TheseusTaoItem = null;
         _bagBack = ComponentFactory.Instance.creatComponentByStylename("ThereussoulEquipView.BagBack");
         _jiaBg = ComponentFactory.Instance.creatBitmap("asset.theseus.jiaBg");
         _eqFightBg = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.eqFightBg1");
         _zhangjValue = ComponentFactory.Instance.creatBitmap("asset.theseus.zhangjValue");
         _nowZhangjValue = ComponentFactory.Instance.creatBitmap("asset.theseus.nowzhangjValue");
         _look = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.look");
         _equipTName = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.equipTName");
         _fightValue = ComponentFactory.Instance.creatComponentByStylename("theseus.lookSuitTxt");
         _refresh = ComponentFactory.Instance.creatComponentByStylename("theseus.warframe.refresh");
         _redcollention = ComponentFactory.Instance.creatBitmap("asset.theseusCollection.red1");
         _figure = new ShowAvatar(true);
         _figure.x = 74;
         _figure.y = 32;
         _figure.mouseChildren = _figure.mouseEnabled = false;
         _figure.scaleX = _figure.scaleY = 0.8;
         _collentionBtn = ComponentFactory.Instance.creatComponentByStylename("theseuscollention.collentionBtn");
         _collentionBtntxt = ComponentFactory.Instance.creatComponentByStylename("theseuscollention.collentionBtnTxt");
         _collentionBtntxt.text = LanguageMgr.GetTranslation("TheseusCollentionFrame.title");
         _godheadBtn = ComponentFactory.Instance.creatComponentByStylename("theseuscollention.GodheadBtn");
         _godheadBtntxt = ComponentFactory.Instance.creatComponentByStylename("theseuscollention.GodheadTxt");
         _godheadBtntxt.text = LanguageMgr.GetTranslation("TheseusGodheadFrame.title1");
         addChild(_bagBack);
         addChild(_jiaBg);
         addChild(_figure);
         addChild(_eqFightBg);
         addChild(_look);
         addChild(_equipTName);
         addChild(_fightValue);
         _eqFightBg.addChild(_zhangjValue);
         _eqFightBg.addChild(_nowZhangjValue);
         _nowZhangjValue.visible = false;
         _equipCellList = new Vector.<TheseussoulEquipCell>();
         var _loc9_:Array = TheseussoulModel.SONTYPES;
         _loc5_ = 0;
         while(_loc5_ < 12)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.equipCell" + (_loc5_ + 1));
            _loc1_.model = model;
            _loc1_.pos = _loc5_;
            _loc1_.sonType = _loc9_[_loc5_];
            addChild(_loc1_);
            _equipCellList.push(_loc1_);
            _loc5_++;
         }
         _suitItemList = new Vector.<TheseusTaoItem>();
         var _loc7_:Array = [8,6,7,9,4,2,1,3,5];
         var _loc6_:int = int(RoyaltyBossManager.instance.model.royaltyLevel);
         if(_loc6_ <= 0)
         {
            _loc6_ = 1;
         }
         var _loc2_:RoyaltyTempInfo = TempleteManager.instance.royaltyTempCate.getTempInfoByLevel(_loc6_);
         _loc5_ = 0;
         while(_loc5_ < 9)
         {
            _loc3_ = ComponentFactory.Instance.creatCustomObject("ui.theseussoul.suit" + (_loc5_ + 1),[_loc7_[_loc5_]]);
            _loc3_.scaleX = _loc3_.scaleY = 0.8;
            _loc3_.model = model;
            if(_loc2_.OpenTheseus >= _loc7_[_loc5_])
            {
               _loc3_.lock = false;
            }
            else
            {
               _loc3_.lock = true;
            }
            addChild(_loc3_);
            _suitItemList.push(_loc3_);
            _loc5_++;
         }
         _look.htmlText = LanguageMgr.GetTranslation("theseus.equip.LookTxt");
         _warIntensifyBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseussoul.warFrameBtn");
         addChild(_warIntensifyBtn);
         addChild(_refresh);
         if(VersionSwitch.TREASURECANGPING)
         {
            addChild(_collentionBtn);
            addChild(_collentionBtntxt);
            _redcollention.x = 40;
            _redcollention.y = 0;
            _collentionBtn.addChild(_redcollention);
            updateRed();
         }
         addChild(_godheadBtn);
         addChild(_godheadBtntxt);
         var _loc8_:RoyaltyTempInfo = TempleteManager.instance.royaltyTempCate.getTempInfoByLevel(RoyaltyBossManager.instance.model.royaltyLevel);
         var _loc4_:Boolean = _loc8_.OpenSlate == 1;
         if(!_loc4_)
         {
            _godheadBtntxt.visible = _godheadBtn.visible = false;
         }
         else
         {
            _godheadBtntxt.visible = _godheadBtn.visible = true;
         }
      }
      
      private function updateRed1(param1:Event) : void
      {
         updateRed();
      }
      
      private function updateRed(param1:Object = null) : void
      {
         _redcollention.visible = modelCollenTion.checkAllcollectionRed() || Boolean(modelCollenTion.checkAllboxRed()) || Boolean(modelCollenTion.allred);
      }
      
      private function get modelCollenTion() : TheseusCollenTionModel
      {
         return TheseussoulManager.Instance.modelCollenTion;
      }
      
      public function refreshEquipView() : void
      {
         var _loc6_:WarFrameItemInfo = null;
         var _loc1_:TheseussoulEquipCell = null;
         var _loc7_:int = 0;
         var _loc4_:WarFrameItemInfo = null;
         var _loc5_:int = 0;
         model.checkEquipRed();
         if(!_isNowZhangjValue)
         {
            _fightValue.text = "" + model.propertys.armour;
         }
         else
         {
            _fightValue.text = "" + model.getSuitEquipZhangjValue(model.currSuitIdx);
         }
         var _loc3_:int = int(model.currSuitIdx);
         _equipTName.text = LanguageMgr.GetTranslation("theseus.equip.suitName" + _loc3_);
         var _loc8_:Array = model.suitInfo.getSuitArray(_loc3_);
         _loc5_ = 0;
         while(_loc5_ < _equipCellList.length)
         {
            _loc1_ = _equipCellList[_loc5_];
            _loc1_.suitIdx = _loc3_;
            _loc7_ = int(_loc8_[_loc5_]);
            _loc4_ = TheseussoulManager.Instance.model.armorBagDic[_loc7_] as WarFrameItemInfo;
            if(_loc7_ > 0 && _loc4_)
            {
               _loc6_ = _loc4_;
               _loc6_.id = _loc7_;
               _loc6_.model = model;
               _loc1_.data = _loc6_;
            }
            else
            {
               _loc1_.data = null;
            }
            _loc5_++;
         }
         for each(var _loc2_:TheseusTaoItem in _suitItemList)
         {
            _loc2_.refreshRed();
         }
      }
      
      private function initEvent() : void
      {
         _warIntensifyBtn.addEventListener("click",doIntensifyHandler);
         _refresh.addEventListener("click",__checkRefreshWarNum);
         _collentionBtn.addEventListener("click",__openCollention);
         _look.addEventListener("click",__checkTxtClickHandler);
         TheseussoulManager.Instance.addEventListener("EVENT_SUIT_UPDATE",suitUpdateHandler);
         model.addEventListener("EVENT_CHOOSE_SUIT",chooseHandler);
         TheseussoulManager.Instance.addEventListener("EVENT_PROPERTY_UPDATE",propertyUpdateHandler);
         TheseussoulManager.Instance.addEventListener("EVENT_COLLECTION_UPDATE",updateRed1);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 212,updateRed);
         _godheadBtn.addEventListener("click",__openGodtion);
         TheseussoulManager.Instance.addEventListener("OP_COLLECTION_UPGRADETASK",updateRed1);
      }
      
      private function removeEvent() : void
      {
         TheseussoulManager.Instance.removeEventListener("OP_COLLECTION_UPGRADETASK",updateRed1);
         _warIntensifyBtn.removeEventListener("click",doIntensifyHandler);
         _refresh.removeEventListener("click",__checkRefreshWarNum);
         _collentionBtn.removeEventListener("click",__openCollention);
         _godheadBtn.removeEventListener("click",__openGodtion);
         _look.removeEventListener("click",__checkTxtClickHandler);
         TheseussoulManager.Instance.removeEventListener("EVENT_SUIT_UPDATE",suitUpdateHandler);
         model.removeEventListener("EVENT_CHOOSE_SUIT",chooseHandler);
         TheseussoulManager.Instance.removeEventListener("EVENT_PROPERTY_UPDATE",propertyUpdateHandler);
         TheseussoulManager.Instance.addEventListener("EVENT_COLLECTION_UPDATE",updateRed1);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 212,updateRed);
      }
      
      private function __openCollention(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.theseussoulController.backTheseFrame = "theseussoul";
         FrameControllerManager.instance.openControllerByInfo("theseussoul",9);
      }
      
      private function __openGodtion(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.theseussoulController.backTheseFrame = "theseussoul";
         FrameControllerManager.instance.openControllerByInfo("theseussoul",10);
      }
      
      private function doIntensifyHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.theseussoulController.backTheseFrame = "theseussoul";
         FrameControllerManager.instance.openControllerByInfo("theseussoul",8);
      }
      
      private function propertyUpdateHandler(param1:Event) : void
      {
         if(!_isNowZhangjValue)
         {
            _fightValue.text = "" + model.propertys.armour;
         }
         else
         {
            _fightValue.text = "" + model.getSuitEquipZhangjValue(model.currSuitIdx);
         }
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
         __checkRefreshWarNum();
      }
      
      private function get model() : TheseussoulModel
      {
         return TheseussoulManager.Instance.model;
      }
      
      private function suitUpdateHandler(param1:Event) : void
      {
         refreshEquipView();
      }
      
      private function __checkRefreshWarNum(param1:MouseEvent = null) : void
      {
         if(param1 == null)
         {
            _fightValue.text = "" + model.propertys.armour;
            _zhangjValue.visible = true;
            _nowZhangjValue.visible = false;
            _isNowZhangjValue = false;
            return;
         }
         if(_isNowZhangjValue)
         {
            _fightValue.text = "" + model.propertys.armour;
         }
         else
         {
            _fightValue.text = "" + model.getSuitEquipZhangjValue(model.currSuitIdx);
         }
         _zhangjValue.visible = _isNowZhangjValue;
         _nowZhangjValue.visible = !_isNowZhangjValue;
         _isNowZhangjValue = !_isNowZhangjValue;
      }
      
      private function __checkTxtClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("theseussoul",1);
      }
      
      private function get fashionModel() : FashionModel
      {
         return FrameControllerManager.instance.fashionCodeController.model;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function getDataFromPos(param1:SimpleDictionary, param2:int) : GoodsInfo
      {
         for each(var _loc3_:GoodsInfo in param1)
         {
            if(_loc3_.pos == param2)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      private function refreshHeroFigure() : void
      {
         var _loc2_:Dictionary = null;
         if(fashionModel.lookDragonTalkerFashion)
         {
            return;
         }
         var _loc1_:FashionInfoMsg = ArmyManager.instance.fashionInfoMsg;
         var _loc6_:ThaneInfo = new ThaneInfo();
         _loc6_.templateId = thane.templateId;
         _loc6_.hideFashion = thane.hideFashion;
         _loc2_ = ArmyManager.instance.fashionList;
         var _loc5_:GoodsInfo = _loc2_[8];
         var _loc3_:GoodsInfo = _loc2_[9];
         var _loc7_:GoodsInfo = _loc2_[10];
         var _loc4_:GoodsInfo = _loc2_[11];
         var _loc8_:SimpleDictionary = GoodsManager.instance.getHeroGoodsListByTypeAndId(1,thane.id);
         _loc6_.armsEquipAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(getDataFromPos(_loc8_,0));
         _loc6_.hairEquipAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(getDataFromPos(_loc8_,1));
         _loc6_.bodyEquipAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(getDataFromPos(_loc8_,2));
         if(_loc1_ && !_loc1_.isHidenWingAvata)
         {
            _loc6_.wingAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc5_);
         }
         if(_loc1_ && !_loc1_.isHidenArmAvata)
         {
            _loc6_.armsFashionAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc4_);
         }
         if(_loc1_ && !_loc1_.isHidenClothAvata)
         {
            _loc6_.bodyFashionAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc7_);
         }
         if(_loc1_ && !_loc1_.isHidenHatAvat)
         {
            _loc6_.hairFashionAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc3_);
         }
         _figure.data = _loc6_;
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
         ObjectUtils.disposeObject(_refresh);
         _refresh = null;
         ObjectUtils.disposeObject(_collentionBtn);
         _collentionBtn = null;
         ObjectUtils.disposeObject(_bagBack);
         _bagBack = null;
         ObjectUtils.disposeObject(_fightValue);
         _fightValue = null;
         ObjectUtils.disposeObject(_jiaBg);
         _jiaBg = null;
         ObjectUtils.disposeObject(_eqFightBg);
         _eqFightBg = null;
         ObjectUtils.disposeObject(_look);
         _look = null;
         ObjectUtils.disposeObject(_equipTName);
         _equipTName = null;
         ObjectUtils.disposeObject(_figure);
         _figure = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _isNowZhangjValue = false;
      }
   }
}

