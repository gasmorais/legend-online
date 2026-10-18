package carnvial.item
{
   import avatar.view.ShowAvatar;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.fashion.FashionInfoMsg;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import funny.mountact.MountsAvatarView;
   import managers.FashionManager;
   import mvc.module.carnival.CarnivalModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.CarnivalPointExchangeTemplateInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.MountTemplate;
   import yishi.datas.templates.PetTemplate;
   import yishi.manager.ArmyManager;
   import yishi.manager.CarnivalManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.ThaneEquipShowHelper;
   import yishi.view.base.NumberBitmap;
   import yishi.view.community.BaseItemView;
   
   public class CarnivalYearBigBox extends Sprite implements IManualSize
   {
      
      private var _bg:Bitmap;
      
      private var _pointBit:NumberBitmap;
      
      private var _btn:BaseButton;
      
      private var _btnIcon:ScaleFrameImage;
      
      private var _simpleTitle:SimpleTileList;
      
      private var _getFlg:Image;
      
      private var _itemList:Array;
      
      private var _goodsTemp:GoodsTemplateInfo;
      
      private var _isDis:Boolean;
      
      private var _temp:CarnivalPointExchangeTemplateInfo;
      
      private var _standBit:Bitmap;
      
      private var _figure:ShowAvatar;
      
      private var _fContainer:Component;
      
      private var _showThane:ThaneInfo;
      
      private var currentThane:ThaneInfo;
      
      private var _mountsAvatar:MountsAvatarView;
      
      private var _mountsContainer:Component;
      
      private var _petContainer:Component;
      
      public function CarnivalYearBigBox()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,172,416);
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.carniver.yearBigBg");
         _simpleTitle = ComponentFactory.Instance.creatCustomObject("ui.carnival.yearBList",[2]);
         _btn = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.yearBbtn");
         _btnIcon = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.onLineBtnTxt");
         _getFlg = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.yearBget");
         _pointBit = ComponentFactory.Instance.creatCustomObject("ui.carnival.yearTargetScoreBit");
         _pointBit.initParams("asset.carniver.score","asset.carniver.pointNum",18,22,15,18,"0123456789",-80,-2,0,80);
         _standBit = ComponentFactory.Instance.creatBitmap("asset.carniver.stand");
         addChild(_bg);
         addChild(_pointBit);
         addChild(_simpleTitle);
         addChild(_btn);
         addChild(_getFlg);
         addChild(_standBit);
         _btn.addChild(_btnIcon);
         _btn.enable = false;
      }
      
      public function refreshView() : void
      {
         var _loc3_:String = null;
         var _loc2_:String = model.scoreRewardInfo;
         var _loc1_:Array = _loc2_.split(",");
         if(_temp)
         {
            _loc3_ = "" + _temp.Id;
            if(_loc1_.indexOf(_loc3_) != -1)
            {
               _getFlg.visible = true;
               _btn.visible = false;
            }
            else
            {
               _getFlg.visible = false;
               _btn.visible = true;
               if(_temp.Target <= model.score)
               {
                  _btn.enable = true;
                  _btnIcon.setFrame(1);
               }
               else
               {
                  _btn.enable = false;
                  _btnIcon.setFrame(2);
               }
            }
         }
      }
      
      private function get model() : CarnivalModel
      {
         return CarnivalManager.Instance.model;
      }
      
      private function initEvent() : void
      {
         _btn.addEventListener("click",clickHandler);
      }
      
      private function removeEvent() : void
      {
         _btn.removeEventListener("click",clickHandler);
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         if(_temp)
         {
            CarnivalManager.Instance.opRequest(2,_temp.Id);
         }
      }
      
      public function preShowAvater() : void
      {
         var _loc1_:int = int(_temp.specialType);
         switch(_loc1_ - 2)
         {
            case 0:
               setFashionItem();
               break;
            case 1:
               setMountItem();
               break;
            case 2:
               setPetItem();
         }
      }
      
      private function setFashionItem() : void
      {
         var _loc1_:Array = [_goodsTemp];
         _fContainer = ComponentFactory.Instance.creatCustomObject("SevenYearRewardItem.fashionContainer");
         _figure = new ShowAvatar(true);
         _fContainer.addChild(_figure);
         _figure.scaleX = _figure.scaleY = 0.4;
         _fContainer.x = 26;
         _fContainer.y = 98;
         addChild(_fContainer);
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
      
      private function get thaneInfo() : ThaneInfo
      {
         return ArmyManager.instance.thane;
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
         var _loc1_:int = int(_goodsTemp.Property1);
         if(_loc1_ == 0)
         {
            return;
         }
         _mountsAvatar = new MountsAvatarView();
         _mountsContainer = new Component();
         _mountsContainer.addChild(_mountsAvatar);
         _mountsAvatar.scaleX = _mountsAvatar.scaleY = 0.4;
         _mountsAvatar.mouseChildren = false;
         _mountsContainer.x = 86;
         _mountsContainer.y = 188;
         addChild(_mountsContainer);
         var _loc2_:MountTemplate = TempleteManager.instance.mountTemplateDic[_loc1_];
         _mountsAvatar.data = _loc2_;
         _mountsContainer.tipStyle = "yishi.view.tips.goods.MountCardTip";
         _mountsContainer.isFollowMouse = false;
         _mountsContainer.tipDirctions = "4,1,6,5,2,7,0,3";
         _mountsContainer.tipGapH = 77;
         _mountsContainer.tipGapV = 64;
         var _loc3_:GoodsInfo = new GoodsInfo();
         _loc3_.templateId = _goodsTemp.TemplateId;
         _mountsContainer.tipData = _loc3_;
      }
      
      private function setPetItem() : void
      {
         var _loc2_:PetTemplate = TempleteManager.instance.petTemplateCate.getTemplateById(_goodsTemp.Property1);
         if(!_loc2_)
         {
            return;
         }
         _petContainer = new Component();
         _petContainer.x = 125;
         _petContainer.y = 216;
         addChild(_petContainer);
         _petContainer.tipStyle = "yishi.view.tips.goods.PropTips";
         _petContainer.isFollowMouse = false;
         _petContainer.tipDirctions = "4,1,6,5,2,7,0,3";
         _petContainer.tipGapH = 93;
         _petContainer.tipGapV = 272;
         var _loc3_:GoodsInfo = new GoodsInfo();
         _loc3_.templateId = _goodsTemp.TemplateId;
         _petContainer.tipData = _loc3_;
         var _loc1_:String = PathManager.getPetMorphShowPath(_loc2_.PetAvatar);
         LoaderManagerII.instance.load(_loc1_,2,8,__loadAvatarCompleteHandler);
      }
      
      private function __loadAvatarCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         if(_isDis)
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
      
      public function dispose() : void
      {
         if(_isDis)
         {
            return;
         }
         _isDis = true;
         removeEvent();
         for each(var _loc1_:BaseItemView in _itemList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _itemList = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         ObjectUtils.disposeObject(_btnIcon);
         _btnIcon = null;
         ObjectUtils.disposeObject(_getFlg);
         _getFlg = null;
         ObjectUtils.disposeObject(_pointBit);
         _pointBit = null;
         ObjectUtils.disposeObject(_mountsAvatar);
         _mountsAvatar = null;
         ObjectUtils.disposeObject(_mountsContainer);
         _mountsContainer = null;
         ObjectUtils.disposeObject(_simpleTitle);
         _simpleTitle = null;
         ObjectUtils.disposeObject(_petContainer);
         _petContainer = null;
         ObjectUtils.disposeObject(_figure);
         _figure = null;
         ObjectUtils.disposeObject(_fContainer);
         _fContainer = null;
         ObjectUtils.disposeObject(_standBit);
         _standBit = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _temp = null;
         _goodsTemp = null;
         _showThane = null;
         currentThane = null;
      }
      
      public function set temp(param1:CarnivalPointExchangeTemplateInfo) : void
      {
         _temp = param1;
         if(_temp)
         {
            _pointBit.num = _temp.Target;
            _goodsTemp = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_temp.Item1);
            refreshView();
            _itemList = [];
            _simpleTitle.beginChanges();
            createGoodItem(_temp.Item2,_temp.ItemNum2);
            createGoodItem(_temp.Item3,_temp.ItemNum3);
            createGoodItem(_temp.Item4,_temp.ItemNum4);
            _simpleTitle.commitChanges();
            preShowAvater();
         }
      }
      
      private function createGoodItem(param1:int, param2:int) : void
      {
         if(param1 == 0)
         {
            return;
         }
         var _loc3_:BaseItemView = ComponentFactory.Instance.creatCustomObject("feedBackFrame.BaseItemView");
         var _loc4_:GoodsInfo = new GoodsInfo();
         _loc4_.templateId = param1;
         _loc4_.count = param2;
         _loc3_.data = _loc4_;
         _itemList.push(_loc3_);
         _simpleTitle.addChild(_loc3_);
      }
   }
}

