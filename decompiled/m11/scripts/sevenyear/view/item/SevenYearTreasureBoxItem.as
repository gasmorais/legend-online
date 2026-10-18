package sevenyear.view.item
{
   import avatar.view.ShowAvatar;
   import bag.helper.GoodsCheck;
   import com.greensock.TweenLite;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.fashion.FashionInfoMsg;
   import events.SevenYearEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import funny.mountact.MountsAvatarView;
   import managers.FashionManager;
   import managers.SevenYearManager;
   import mvc.module.sevenyear.SevenYearModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.MountTemplate;
   import yishi.datas.templates.SevenYearTreasureBoxDropTemplate;
   import yishi.filter.UIFilter;
   import yishi.manager.ArmyManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.ThaneEquipShowHelper;
   
   public class SevenYearTreasureBoxItem extends Component implements IManualSize
   {
      
      private var _bg:Bitmap;
      
      private var _figure:ShowAvatar;
      
      private var _fContainer:Component;
      
      private var _showThane:ThaneInfo;
      
      private var _mountsAvatar:MountsAvatarView;
      
      private var _mountsContainer:Component;
      
      private var currentThane:ThaneInfo;
      
      private var _rareImg:ScaleFrameImage;
      
      private var _selectedBmp:Bitmap;
      
      private var _goodsTemp:GoodsTemplateInfo;
      
      private var _data:SevenYearTreasureBoxDropTemplate;
      
      private var _selected:Boolean;
      
      private var _delayTime:Number;
      
      private var _flickerEffct:MovieClip;
      
      public function SevenYearTreasureBoxItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _rareImg = ComponentFactory.Instance.creatComponentByStylename("SevenYearTreasureBoxItem.rareImg");
         _selectedBmp = ComponentFactory.Instance.creatBitmap("asset.SevenYearTreasureBoxFrame.itemSelected");
         _flickerEffct = ComponentFactory.Instance.creatCustomObject("SevenYearTreasureBoxFrame.goodsFlickerEffctMC");
         _flickerEffct.visible = false;
         _flickerEffct.gotoAndStop(1);
      }
      
      public function set data(param1:SevenYearTreasureBoxDropTemplate) : void
      {
         if(!param1)
         {
            return;
         }
         _data = param1;
         _goodsTemp = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1.itemId);
         if(_goodsTemp)
         {
            if(GoodsCheck.isFashion(_goodsTemp))
            {
               _bg = ComponentFactory.Instance.creatBitmap("asset.SevenYearTreasureBoxFrame.itemBack");
               refreshFashionItem();
            }
            else if(_goodsTemp.SonType == 218)
            {
               refreshMountItem();
               if(param1.isShow == 0)
               {
                  _bg = ComponentFactory.Instance.creatBitmap("asset.SevenYearTreasureBoxFashion");
                  _flickerEffct.width = _selectedBmp.width = 232;
                  _flickerEffct.height = _selectedBmp.height = 223;
               }
               else if(param1.isShow == 1)
               {
                  _bg = ComponentFactory.Instance.creatBitmap("asset.SevenYearTreasureBoxMount");
                  _flickerEffct.width = _selectedBmp.width = 232;
                  _flickerEffct.height = _selectedBmp.height = 263;
                  _mountsContainer.y = 217;
               }
               else
               {
                  _bg = ComponentFactory.Instance.creatBitmap("asset.SevenYearTreasureBoxFrame.itemBack");
               }
            }
         }
         refreshAdd();
         _rareImg.visible = param1.appearType == 3;
         var _loc2_:int = param1.isShow + 1;
         _rareImg.setFrame(_loc2_);
      }
      
      public function setGrayFilter() : void
      {
         this.filters = [UIFilter.getGrayFilter()];
      }
      
      public function setNormalFilter() : void
      {
         this.filters = [];
      }
      
      private function refreshFashionItem() : void
      {
         _fContainer = ComponentFactory.Instance.creatCustomObject("SevenYearTreasureBoxItem.fashionContainer");
         _figure = new ShowAvatar(true);
         _fContainer.addChild(_figure);
         _figure.scaleX = _figure.scaleY = 0.4;
         _fContainer.x = 10;
         _fContainer.y = 35;
         _showThane = new ThaneInfo();
         if(_goodsTemp.isViceEquip)
         {
            currentThane = ArmyManager.instance.vice;
            _showThane = createDragonTalkerInfo(_goodsTemp);
         }
         else
         {
            currentThane = ArmyManager.instance.thane;
            _showThane = createThaneInfo(_goodsTemp);
         }
         var _loc1_:Array = [];
         var _loc2_:GoodsInfo = new GoodsInfo();
         _loc2_.templateId = _goodsTemp.TemplateId;
         _loc2_.identityed = FashionManager.instance.fashionModel.hasIdentityedBook(_goodsTemp.TemplateId);
         _loc1_.push(_loc2_);
         _fContainer.tipData = _loc1_;
         _figure.data = _showThane;
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
      
      private function refreshMountItem() : void
      {
         var _loc1_:int = int(_goodsTemp.Property1);
         _mountsAvatar = new MountsAvatarView();
         _mountsContainer = new Component();
         _mountsContainer.addChild(_mountsAvatar);
         _mountsAvatar.scaleX = _mountsAvatar.scaleY = 0.5;
         _mountsAvatar.mouseChildren = false;
         _mountsContainer.x = 119;
         _mountsContainer.y = 172;
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
      
      private function refreshAdd() : void
      {
         addChild(_bg);
         if(_fContainer)
         {
            addChild(_fContainer);
         }
         if(_mountsContainer)
         {
            addChild(_mountsContainer);
         }
         addChild(_rareImg);
         addChild(_selectedBmp);
         _selectedBmp.visible = false;
         addChild(_flickerEffct);
         _flickerEffct.visible = false;
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,146,165);
      }
      
      public function get data() : SevenYearTreasureBoxDropTemplate
      {
         return _data;
      }
      
      public function hideMoveBg(param1:Number) : void
      {
         TweenLite.to(_selectedBmp,param1,{"alpha":0});
      }
      
      public function flicker() : void
      {
         _selectedBmp.visible = false;
         _flickerEffct.visible = true;
         _flickerEffct.gotoAndPlay(1);
         StageReferance.stage.addEventListener("enterFrame",_stageFrame);
      }
      
      private function _stageFrame(param1:Event) : void
      {
         if(_flickerEffct.currentFrame == _flickerEffct.totalFrames)
         {
            _flickerEffct.visible = false;
            _flickerEffct.gotoAndStop(1);
            StageReferance.stage.removeEventListener("enterFrame",_stageFrame);
            model.dispatchEvent(new SevenYearEvent("UPDATE_TREASUREBOX_LIST",null));
         }
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         _delayTime = model.delayTime * 0.002;
         if(_selectedBmp == null)
         {
            return;
         }
         if(_selected)
         {
            _selectedBmp.alpha = 1;
            _selectedBmp.visible = true;
            _delayTime = model.delayTime > 400 ? 0.8 : model.delayTime * 0.002;
            if(_delayTime)
            {
               setTween();
            }
         }
         else if(!_delayTime)
         {
            _selectedBmp.visible = false;
         }
      }
      
      private function setTween() : void
      {
         if(_selectedBmp == null)
         {
            return;
         }
         TweenLite.killTweensOf(_selectedBmp);
         _selectedBmp.alpha = 0;
         var _loc1_:Number = _delayTime;
         if(_delayTime >= 0.6)
         {
            _loc1_ = 0.3;
         }
         if(_delayTime >= 0.8)
         {
            _loc1_ = 0.05;
         }
         TweenLite.to(_selectedBmp,_loc1_ + 0.2,{
            "alpha":1,
            "onComplete":hideBg
         });
      }
      
      private function hideBg() : void
      {
         hideMoveBg(_delayTime);
      }
      
      public function get model() : SevenYearModel
      {
         return SevenYearManager.instance.model;
      }
      
      public function get goodsTemp() : GoodsTemplateInfo
      {
         return _goodsTemp;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_figure);
         _figure = null;
         ObjectUtils.disposeObject(_fContainer);
         _fContainer = null;
         ObjectUtils.disposeObject(_mountsAvatar);
         _mountsAvatar = null;
         ObjectUtils.disposeObject(_mountsContainer);
         _mountsContainer = null;
         ObjectUtils.disposeObject(_rareImg);
         _rareImg = null;
         ObjectUtils.disposeObject(_selectedBmp);
         _selectedBmp = null;
         ObjectUtils.disposeViolentMc(_flickerEffct);
         _flickerEffct = null;
         super.dispose();
      }
   }
}

