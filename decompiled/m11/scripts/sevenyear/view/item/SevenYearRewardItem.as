package sevenyear.view.item
{
   import avatar.view.ShowAvatar;
   import bag.helper.GoodsCheck;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.fashion.FashionInfoMsg;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import funny.mountact.MountsAvatarView;
   import mainBar.StripView;
   import mainBar.effects.MainToolBtnGlowEffect;
   import managers.FashionManager;
   import managers.SevenYearManager;
   import mvc.module.sevenyear.SevenYearModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.MountTemplate;
   import yishi.datas.templates.PetTemplate;
   import yishi.datas.templates.SevenYearRewardDropTemplate;
   import yishi.manager.ArmyManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.ThaneEquipShowHelper;
   import yishi.view.community.BaseItemView;
   
   public class SevenYearRewardItem extends Component implements IManualSize
   {
      
      public static const EMPTY:int = 0;
      
      public static const GOODS:int = 1;
      
      public static const FASHION:int = 2;
      
      public static const MOUNTS:int = 3;
      
      public static const PET:int = 4;
      
      private var _bg:ScaleBitmapImage;
      
      private var _downBg:ScaleBitmapImage;
      
      private var _numBitmap:Bitmap;
      
      private var _numContainer:StripView;
      
      private var _receiveBmp:Bitmap;
      
      private var _list:SimpleTileList;
      
      private var _type:int;
      
      private var _arr:Array = [];
      
      public var grade:int;
      
      private var _figure:ShowAvatar;
      
      private var _fContainer:Component;
      
      private var _showThane:ThaneInfo;
      
      private var _mountsAvatar:MountsAvatarView;
      
      private var _mountsContainer:Component;
      
      private var currentThane:ThaneInfo;
      
      private var _effect:MainToolBtnGlowEffect;
      
      private var _petContainer:Component;
      
      private var _lock:Bitmap;
      
      private var _freeBg:ScaleBitmapImage;
      
      private var _freeList:SimpleTileList;
      
      private var _freeEffect:MainToolBtnGlowEffect;
      
      private var _freeReceiveBmp:Bitmap;
      
      private var _freeArr:Array = [];
      
      private var _freeType:int;
      
      public function SevenYearRewardItem(param1:int, param2:int)
      {
         super();
         _type = param1;
         _freeType = param2;
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("core.commonTipBg");
         _downBg = ComponentFactory.Instance.creatComponentByStylename("SevenYearRewardItem.downBg");
         _numBitmap = ComponentFactory.Instance.creatBitmap("asset.SevenYearBattleFlagView.numberbmp");
         _numContainer = ComponentFactory.Instance.creatCustomObject("SevenYearRewardItem.numContainer");
         _receiveBmp = ComponentFactory.Instance.creatBitmap("asset.SevenYearBattleFlagView.receiveBmp");
         _freeBg = ComponentFactory.Instance.creatComponentByStylename("core.commonTipBg");
         _freeReceiveBmp = ComponentFactory.Instance.creatBitmap("asset.SevenYearBattleFlagView.receiveBmp");
         _lock = ComponentFactory.Instance.creatBitmap("asset.SevenYearRewardView.lock");
         _effect = new MainToolBtnGlowEffect(_bg);
         _effect.stop();
         _freeEffect = new MainToolBtnGlowEffect(_freeBg);
         _freeEffect.stop();
      }
      
      public function refreshReceive() : void
      {
         if(_type == 0 && _freeType == 0)
         {
            return;
         }
         if(_freeType > 0)
         {
            _freeReceiveBmp.visible = false;
            _freeEffect.stop();
            if(model.rewardFreeGrade < grade)
            {
               if(model.flagGrade >= grade)
               {
                  _freeEffect.play();
               }
            }
            else
            {
               _freeReceiveBmp.visible = true;
            }
         }
         if(_type > 0)
         {
            _receiveBmp.visible = false;
            _effect.stop();
            if(model.hasBuy)
            {
               if(model.rewardGrade < grade)
               {
                  if(model.flagGrade >= grade)
                  {
                     _effect.play();
                  }
               }
               else
               {
                  _receiveBmp.visible = true;
               }
            }
         }
      }
      
      public function data(param1:Array, param2:Array, param3:int) : void
      {
         _arr = param1;
         _freeArr = param2;
         grade = param3;
         if(_freeType == 0 && _type == 0)
         {
            setEmptyItem();
         }
         else
         {
            switch(_type - 1)
            {
               case 0:
                  setGoodsItem();
                  break;
               case 1:
                  setFashionItem();
                  break;
               case 2:
                  setMountItem();
                  break;
               case 3:
                  setPetItem();
            }
            if(_freeType > 0)
            {
               setFreeGoodsItem();
            }
            refreshAdd();
         }
      }
      
      private function setEmptyItem() : void
      {
         _downBg.width = 15;
         addChild(_downBg);
      }
      
      private function refreshAdd() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = _type >= _freeType ? _type : _freeType;
         _bg.x = 0;
         _bg.y = 71;
         _freeBg.x = _freeBg.y = 0;
         _downBg.width = 134;
         if(_loc2_ == 1)
         {
            if(_list)
            {
               _list.y = _arr.length > 2 ? 86 : 145;
            }
            _loc1_ = int(_arr.length >= _freeArr.length ? _arr.length : _freeArr.length);
            if(_loc1_ == 1)
            {
               _bg.width = 72;
               _bg.height = 134;
               _freeBg.width = 72;
               _freeBg.height = 68;
               _downBg.width = 72;
            }
            else if(_loc1_ >= 2)
            {
               _bg.width = 134;
               _bg.height = 134;
               _freeBg.width = 134;
               _freeBg.height = 68;
            }
         }
         else
         {
            _bg.width = 134;
            _bg.height = 134;
            _freeBg.width = 134;
            _freeBg.height = 68;
         }
         if(model.hasBuy)
         {
            _lock.visible = false;
         }
         else
         {
            _lock.visible = true;
            _lock.x = _bg.x + _bg.width - 19;
            _lock.y = _bg.y - 1;
         }
         NumberViewUtils.refreshValue(grade,_numContainer,_numBitmap.bitmapData,20,21,15,20,"0123456789");
         _numContainer.x = (_downBg.width - _numContainer.width) / 2;
         _receiveBmp.x = (_downBg.width - _receiveBmp.width) / 2;
         _freeReceiveBmp.x = (_downBg.width - _freeReceiveBmp.width) / 2;
         _receiveBmp.y = 180;
         _freeReceiveBmp.y = 33;
         addChild(_freeBg);
         addChild(_bg);
         addChild(_downBg);
         addChild(_numContainer);
         if(_freeList)
         {
            addChild(_freeList);
         }
         if(_list)
         {
            addChild(_list);
         }
         addChild(_lock);
         if(_fContainer)
         {
            addChild(_fContainer);
         }
         if(_mountsContainer)
         {
            addChild(_mountsContainer);
         }
         if(_petContainer)
         {
            addChild(_petContainer);
         }
         addChild(_receiveBmp);
         _receiveBmp.visible = false;
         addChild(_freeReceiveBmp);
         _freeReceiveBmp.visible = false;
      }
      
      private function setGoodsItem() : void
      {
         var _loc1_:BaseItemView = null;
         var _loc3_:GoodsInfo = null;
         _list = ComponentFactory.Instance.creatCustomObject("SevenYearRewardItem.list",[2]);
         for each(var _loc2_:SevenYearRewardDropTemplate in _arr)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("SevenYearRewardItem.goodsItem");
            _loc3_ = new GoodsInfo();
            _loc3_.templateId = _loc2_.itemId;
            _loc3_.count = _loc2_.count;
            _loc1_.data = _loc3_;
            _list.addChild(_loc1_);
         }
      }
      
      private function setFreeGoodsItem() : void
      {
         var _loc1_:BaseItemView = null;
         var _loc3_:GoodsInfo = null;
         _freeList = ComponentFactory.Instance.creatCustomObject("SevenYearRewardItem.list",[2]);
         _freeList.y = 11;
         for each(var _loc2_:SevenYearRewardDropTemplate in _freeArr)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("SevenYearRewardItem.goodsItem");
            _loc3_ = new GoodsInfo();
            _loc3_.templateId = _loc2_.itemId;
            _loc3_.count = _loc2_.count;
            _loc1_.data = _loc3_;
            _freeList.addChild(_loc1_);
            if(_freeList.numChildren >= 2)
            {
               break;
            }
         }
      }
      
      private function setFashionItem() : void
      {
         var _loc3_:GoodsTemplateInfo = null;
         var _loc1_:Array = [];
         for each(var _loc2_:SevenYearRewardDropTemplate in _arr)
         {
            _loc3_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc2_.itemId);
            if(GoodsCheck.isFashion(_loc3_))
            {
               _loc1_.push(_loc3_);
            }
         }
         _fContainer = ComponentFactory.Instance.creatCustomObject("SevenYearRewardItem.fashionContainer");
         _figure = new ShowAvatar(true);
         _fContainer.addChild(_figure);
         _figure.scaleX = _figure.scaleY = 0.4;
         _fContainer.x = 10;
         _fContainer.y = 106;
         _showThane = new ThaneInfo();
         handleFashion(_loc1_,_fContainer);
      }
      
      private function handleFashion(param1:Array, param2:Component) : void
      {
         var _loc5_:GoodsInfo = null;
         var _loc3_:ShowAvatar = param2.getChildAt(0) as ShowAvatar;
         var _loc6_:GoodsTemplateInfo = param1[0];
         if(_loc6_.isViceEquip)
         {
            currentThane = ArmyManager.instance.vice;
            _showThane = createDragonTalkerInfo(_loc6_);
         }
         else
         {
            currentThane = ArmyManager.instance.thane;
            _showThane = createThaneInfo(_loc6_);
         }
         var _loc4_:Array = [];
         for each(_loc6_ in param1)
         {
            _loc5_ = new GoodsInfo();
            _loc5_.templateId = _loc6_.TemplateId;
            _loc5_.identityed = FashionManager.instance.fashionModel.hasIdentityedBook(_loc6_.TemplateId);
            _loc4_.push(_loc5_);
         }
         param2.tipData = _loc4_;
         _loc3_.data = _showThane;
      }
      
      private function createDragonTalkerInfo(param1:GoodsTemplateInfo) : ThaneInfo
      {
         var _loc2_:ThaneInfo = new ThaneInfo();
         ObjectUtils.copyProperties(_loc2_,thaneInfo);
         _loc2_.templateId = thaneInfo.templateId;
         var _loc4_:Dictionary = ArmyManager.instance.dragonFashionList;
         var _loc3_:FashionInfoMsg = ArmyManager.instance.fashionInfoMsg;
         var _loc7_:GoodsInfo = _loc4_[8];
         var _loc5_:GoodsInfo = _loc4_[9];
         var _loc8_:GoodsInfo = _loc4_[10];
         var _loc6_:GoodsInfo = _loc4_[11];
         if(_loc3_ && !_loc3_.isHidendDragonWingAvata)
         {
            _loc2_.wingAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc7_);
         }
         if(_loc3_ && !_loc3_.isHidenDragonArmAvata)
         {
            _loc2_.armsFashionAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc6_);
         }
         if(_loc3_ && !_loc3_.isHidenDragonClothAvata)
         {
            _loc2_.bodyFashionAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc8_);
         }
         if(_loc3_ && !_loc3_.isHidenDragonHatAvat)
         {
            _loc2_.hairFashionAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc5_);
         }
         switch(int(param1.SonType) - 109)
         {
            case 0:
               _loc2_.wingAvata = param1.Avata;
               break;
            case 1:
               _loc2_.hairFashionAvata = param1.Avata;
               break;
            case 2:
               _loc2_.armsFashionAvata = param1.Avata;
               break;
            case 3:
               _loc2_.bodyFashionAvata = param1.Avata;
         }
         return _loc2_;
      }
      
      private function get thaneInfo() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function createThaneInfo(param1:GoodsTemplateInfo) : ThaneInfo
      {
         var _loc3_:GoodsInfo = null;
         var _loc10_:GoodsInfo = null;
         var _loc2_:ThaneInfo = new ThaneInfo();
         ObjectUtils.copyProperties(_loc2_,thaneInfo);
         _loc2_.templateId = thaneInfo.templateId;
         var _loc9_:int = int(ArmyManager.instance.thane.id);
         _loc3_ = GoodsManager.instance.getItemByPOB(0,_loc9_,4);
         _loc10_ = GoodsManager.instance.getItemByPOB(2,_loc9_,4);
         if(_loc10_)
         {
            _loc2_.bodyEquipAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc10_);
         }
         if(_loc3_)
         {
            _loc2_.armsEquipAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc3_);
         }
         var _loc6_:Dictionary = ArmyManager.instance.fashionList;
         var _loc4_:FashionInfoMsg = ArmyManager.instance.fashionInfoMsg;
         var _loc8_:GoodsInfo = _loc6_[8];
         var _loc5_:GoodsInfo = _loc6_[9];
         var _loc11_:GoodsInfo = _loc6_[10];
         var _loc7_:GoodsInfo = _loc6_[11];
         if(_loc4_ && !_loc4_.isHidenWingAvata)
         {
            _loc2_.wingAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc8_);
         }
         if(_loc4_ && !_loc4_.isHidenArmAvata)
         {
            _loc2_.armsFashionAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc7_);
         }
         if(_loc4_ && !_loc4_.isHidenClothAvata)
         {
            _loc2_.bodyFashionAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc11_);
         }
         if(_loc4_ && !_loc4_.isHidenHatAvat)
         {
            _loc2_.hairFashionAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc5_);
         }
         switch(int(param1.SonType) - 109)
         {
            case 0:
               _loc2_.wingAvata = param1.Avata;
               break;
            case 1:
               _loc2_.hairFashionAvata = param1.Avata;
               break;
            case 2:
               _loc2_.armsFashionAvata = param1.Avata;
               break;
            case 3:
               _loc2_.bodyFashionAvata = param1.Avata;
         }
         return _loc2_;
      }
      
      private function setMountItem() : void
      {
         var _loc1_:int = 0;
         var _loc3_:GoodsTemplateInfo = null;
         for each(var _loc2_:SevenYearRewardDropTemplate in _arr)
         {
            _loc3_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc2_.itemId);
            if(_loc3_ && _loc3_.SonType == 218)
            {
               _loc1_ = int(_loc3_.Property1);
            }
         }
         _mountsAvatar = new MountsAvatarView();
         _mountsContainer = new Component();
         _mountsContainer.addChild(_mountsAvatar);
         _mountsAvatar.scaleX = _mountsAvatar.scaleY = 0.4;
         _mountsAvatar.mouseChildren = false;
         _mountsContainer.x = 70;
         _mountsContainer.y = 196;
         if(_loc1_ == 0)
         {
            return;
         }
         var _loc4_:MountTemplate = TempleteManager.instance.mountTemplateDic[_loc1_];
         _mountsAvatar.data = _loc4_;
         _mountsContainer.tipStyle = "yishi.view.tips.goods.MountCardTip";
         _mountsContainer.isFollowMouse = false;
         _mountsContainer.tipDirctions = "4,1,6,5,2,7,0,3";
         _mountsContainer.tipGapH = 77;
         _mountsContainer.tipGapV = 64;
         var _loc5_:GoodsInfo = new GoodsInfo();
         _loc5_.templateId = _loc3_.TemplateId;
         _mountsContainer.tipData = _loc5_;
      }
      
      private function setPetItem() : void
      {
         var _loc3_:GoodsTemplateInfo = null;
         var _loc4_:PetTemplate = null;
         for each(var _loc2_:SevenYearRewardDropTemplate in _arr)
         {
            _loc3_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc2_.itemId);
            if(_loc3_.SonType == 306)
            {
               _loc4_ = TempleteManager.instance.petTemplateCate.getTemplateById(_loc3_.Property1);
               break;
            }
         }
         if(!_loc4_)
         {
            return;
         }
         _petContainer = new Component();
         _petContainer.x = 110;
         _petContainer.y = 296;
         _petContainer.tipStyle = "yishi.view.tips.goods.PropTips";
         _petContainer.isFollowMouse = false;
         _petContainer.tipDirctions = "4,1,6,5,2,7,0,3";
         _petContainer.tipGapH = 77;
         _petContainer.tipGapV = 200;
         var _loc5_:GoodsInfo = new GoodsInfo();
         _loc5_.templateId = _loc3_.TemplateId;
         _petContainer.tipData = _loc5_;
         var _loc1_:String = PathManager.getPetMorphShowPath(_loc4_.PetAvatar);
         LoaderManagerII.instance.load(_loc1_,2,8,__loadAvatarCompleteHandler);
      }
      
      private function __loadAvatarCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         if(isDie)
         {
            return;
         }
         var _loc3_:MovieClip = param2 as MovieClip;
         if(_loc3_)
         {
            if(_loc3_["pos_down"])
            {
               _loc3_.x = -_loc3_["pos_down"]["x"];
               _loc3_.y = -_loc3_["pos_down"]["y"];
            }
            _petContainer.addChild(_loc3_);
            _loc3_.mouseChildren = _loc3_.mouseEnabled = false;
            _loc3_.scaleX = _loc3_.scaleY = 0.7;
         }
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,_downBg.width,_downBg.height);
      }
      
      private function get model() : SevenYearModel
      {
         return SevenYearManager.instance.model;
      }
      
      public function get lock() : Bitmap
      {
         return _lock;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_downBg);
         _downBg = null;
         ObjectUtils.disposeObject(_numBitmap);
         _numBitmap = null;
         ObjectUtils.disposeObject(_numContainer);
         _numContainer = null;
         ObjectUtils.disposeObject(_receiveBmp);
         _receiveBmp = null;
         ObjectUtils.disposeObject(_list);
         _list = null;
         ObjectUtils.disposeObject(_petContainer);
         _petContainer = null;
         ObjectUtils.disposeObject(_figure);
         _figure = null;
         ObjectUtils.disposeObject(_fContainer);
         _fContainer = null;
         ObjectUtils.disposeObject(_mountsAvatar);
         _mountsAvatar = null;
         ObjectUtils.disposeObject(_mountsContainer);
         _mountsContainer = null;
         ObjectUtils.disposeObject(_petContainer);
         _petContainer = null;
         _effect = null;
         _showThane = null;
         super.dispose();
      }
   }
}

