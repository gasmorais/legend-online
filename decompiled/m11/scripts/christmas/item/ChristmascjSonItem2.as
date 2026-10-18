package christmas.item
{
   import avatar.view.ShowAvatar;
   import bag.helper.GoodsCheck;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.fashion.FashionInfoMsg;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import funny.mountact.MountsAvatarView;
   import managers.FashionManager;
   import mvc.module.christmas.ChristmasModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.ChristmasActivitiesTempInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.MountTemplate;
   import yishi.datas.templates.PetTemplate;
   import yishi.filter.UIFilter;
   import yishi.manager.ArmyManager;
   import yishi.manager.ChristmasManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.ThaneEquipShowHelper;
   import yishi.view.community.BaseItemView;
   
   public class ChristmascjSonItem2 extends Sprite
   {
      
      protected var _flg2:Bitmap;
      
      protected var _flg:Bitmap;
      
      protected var _cjsonNum2:FilterFrameText;
      
      private var _tempInfo:ChristmasActivitiesTempInfo;
      
      private var _goodsTemp:GoodsTemplateInfo;
      
      private var _noramlItem:BaseItemView;
      
      private var _receivedBg:Bitmap;
      
      private var _eff:MovieImage;
      
      private var _figure:ShowAvatar;
      
      private var _fContainer:Component;
      
      private var _showThane:ThaneInfo;
      
      private var currentThane:ThaneInfo;
      
      private var _mountsAvatar:MountsAvatarView;
      
      private var _mountsContainer:Component;
      
      private var _petContainer:Component;
      
      private var _isDis:Boolean;
      
      public function ChristmascjSonItem2()
      {
         super();
         initView();
      }
      
      protected function initView() : void
      {
         _flg2 = ComponentFactory.Instance.creatBitmap("asset.Christmas.chengjiu.flg2");
         _flg = ComponentFactory.Instance.creatBitmap("asset.Christmas.chengjiu.flg");
         _cjsonNum2 = ComponentFactory.Instance.creatComponentByStylename("ui.christmas.cjsonNum2");
         _noramlItem = ComponentFactory.Instance.creatCustomObject("feedBackFrame.BaseItemView");
         _receivedBg = ComponentFactory.Instance.creatBitmap("asset.ChristmasAnswerPreviewItem.bmp");
         _eff = ComponentFactory.Instance.creatComponentByStylename("core.EquipActiveBack");
         addChild(_flg2);
         addChild(_flg);
         addChild(_cjsonNum2);
         addChild(_noramlItem);
         addChild(_eff);
         _eff.x = 32;
         _eff.y = 55;
         _eff.width = 63;
         _eff.height = 62;
         _eff.movie.gotoAndStop(1);
         _eff.visible = false;
         _receivedBg.x = 25;
         _receivedBg.y = 85;
         _receivedBg.visible = false;
         _noramlItem.x = 38;
         _noramlItem.y = 60;
      }
      
      public function set tempInfo(param1:ChristmasActivitiesTempInfo) : void
      {
         _tempInfo = param1;
         if(_tempInfo)
         {
            _goodsTemp = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_tempInfo.Reward1);
            preShowAvater();
         }
         addChild(_receivedBg);
         _cjsonNum2.text = _tempInfo.Para1.toString();
         refreshView();
      }
      
      public function refreshView() : void
      {
         if(model.scoreRewardInfoList && model.scoreRewardInfoList.indexOf("" + _tempInfo.Id) != -1)
         {
            _receivedBg.visible = true;
            _noramlItem.filters = [UIFilter.getGrayFilter()];
            if(_fContainer)
            {
               _fContainer.filters = [UIFilter.getGrayFilter()];
            }
            if(_mountsContainer)
            {
               _mountsContainer.filters = [UIFilter.getGrayFilter()];
            }
            if(_petContainer)
            {
               _petContainer.filters = [UIFilter.getGrayFilter()];
            }
            _flg.visible = false;
            _eff.movie.gotoAndStop(1);
            _eff.visible = false;
            removeEvent();
         }
         else
         {
            _flg.visible = model.score >= _tempInfo.Para1;
            _noramlItem.filters = [];
            if(_fContainer)
            {
               _fContainer.filters = [];
            }
            if(_mountsContainer)
            {
               _mountsContainer.filters = [];
            }
            if(_petContainer)
            {
               _petContainer.filters = [];
            }
            if(model.score >= _tempInfo.Para1)
            {
               _eff.movie.gotoAndPlay(1);
               _eff.visible = true;
               _flg.visible = true;
               removeEvent();
               addEvent();
            }
            else
            {
               _flg.visible = false;
               _eff.visible = false;
               _eff.movie.gotoAndStop(1);
               removeEvent();
            }
            if(_noramlItem.data == null)
            {
               _eff.visible = false;
            }
         }
      }
      
      private function addEvent() : void
      {
         this.buttonMode = true;
         this.addEventListener("click",clickHandler);
      }
      
      private function removeEvent() : void
      {
         this.buttonMode = false;
         this.removeEventListener("click",clickHandler);
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         ChristmasManager.instance.opRequest(14,_tempInfo.Id);
      }
      
      private function get model() : ChristmasModel
      {
         return ChristmasManager.instance.model;
      }
      
      public function preShowAvater() : void
      {
         if(GoodsCheck.isFashion(_goodsTemp))
         {
            setFashionItem();
         }
         else if(GoodsCheck.isMount(_goodsTemp))
         {
            setMountItem();
         }
         else if(GoodsCheck.isPet(_goodsTemp))
         {
            setPetItem();
         }
         else
         {
            setNormalItem();
         }
      }
      
      private function setNormalItem() : void
      {
         var _loc1_:GoodsInfo = new GoodsInfo();
         _loc1_.templateId = _tempInfo.Reward1;
         _loc1_.count = _tempInfo.Num1;
         _noramlItem.data = _loc1_;
      }
      
      private function setFashionItem() : void
      {
         var _loc1_:Array = [_goodsTemp];
         _fContainer = ComponentFactory.Instance.creatCustomObject("SevenYearRewardItem.fashionContainer");
         _figure = new ShowAvatar(true);
         _fContainer.addChild(_figure);
         _figure.scaleX = _figure.scaleY = 0.4;
         _fContainer.x = 16;
         _fContainer.y = 38;
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
      
      private function get thaneInfo() : ThaneInfo
      {
         return ArmyManager.instance.thane;
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
         _mountsContainer.x = 65;
         _mountsContainer.y = 143;
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
         ObjectUtils.disposeObject(_flg2);
         _flg2 = null;
         ObjectUtils.disposeObject(_flg);
         _flg = null;
         ObjectUtils.disposeObject(_cjsonNum2);
         _cjsonNum2 = null;
         ObjectUtils.disposeObject(_mountsAvatar);
         _mountsAvatar = null;
         ObjectUtils.disposeObject(_mountsContainer);
         _mountsContainer = null;
         ObjectUtils.disposeObject(_petContainer);
         _petContainer = null;
         ObjectUtils.disposeObject(_figure);
         _figure = null;
         ObjectUtils.disposeObject(_fContainer);
         _fContainer = null;
         ObjectUtils.disposeObject(_noramlItem);
         _noramlItem = null;
         ObjectUtils.disposeObject(_eff);
         _eff = null;
         ObjectUtils.disposeObject(_receivedBg);
         _receivedBg = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _goodsTemp = null;
         _tempInfo = null;
      }
   }
}

