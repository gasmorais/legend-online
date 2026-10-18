package view.inside
{
   import avatar.view.ShowAvatar;
   import cell.view.fashionbag.FashionBag;
   import cell.view.fashionbag.FashionBagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.fashion.FashionModel;
   import mvc.module.shop.ShopGoodsInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.PlayerEvent;
   import yishi.filter.UIFilter;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.view.tips.MessageTipManager;
   
   public class FashionShowView extends Sprite implements Disposeable
   {
      
      private var _heroBack:ScaleFrameImage;
      
      private var _figure:ShowAvatar;
      
      private var _mask:Shape;
      
      private var _fashionGirdBack:MovieClip;
      
      private var _goBackBtn:BaseButton;
      
      private var _hideBtn:SelectedButton;
      
      private var _hideTxt:FilterFrameText;
      
      private var _buyBtn:IconButton;
      
      private var _fashionBagTitle:MutipleImage;
      
      private var _hairFashionCell:FashionBagCell;
      
      private var _clothFashionCell:FashionBagCell;
      
      private var _weaponFashionCell:FashionBagCell;
      
      private var _wingFashionCell:FashionBagCell;
      
      private var _fashionBag:FashionBag;
      
      private var _filter:UIFilter;
      
      public function FashionShowView()
      {
         super();
         initView();
         initShowView();
         initEvent();
      }
      
      private function initView() : void
      {
         _heroBack = ComponentFactory.Instance.creatComponentByStylename("shop.fashionHeroBack");
         _fashionGirdBack = ComponentFactory.Instance.creatCustomObject("shop.FashionGird");
         _goBackBtn = ComponentFactory.Instance.creatComponentByStylename("shop.goBackImage");
         _hideBtn = ComponentFactory.Instance.creatComponentByStylename("shop.hideFashionBtn");
         _hideTxt = ComponentFactory.Instance.creatComponentByStylename("shop.hideFashionTxt");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("shop.fashion.buyBtn");
         _fashionBagTitle = ComponentFactory.Instance.creatComponentByStylename("shop.fashion.fashionBagTitle");
         _fashionBag = new FashionBag(2,7);
         _mask = new Shape();
         _mask.x = 18;
         addChild(_mask);
         this.mask = _mask;
         _figure = new ShowAvatar(true);
         _figure.x = 60;
         _figure.y = 25;
         _figure.mouseChildren = _figure.mouseEnabled = false;
         addChild(_heroBack);
         addChild(_figure);
         addChild(_fashionGirdBack);
         addChild(_goBackBtn);
         _goBackBtn.tipData = LanguageMgr.GetTranslation("view.inside.FashionShowView.goBackBtn");
         addChild(_hideBtn);
         addChild(_hideTxt);
         _hideTxt.text = LanguageMgr.GetTranslation("armyII.viewII.equip.EquipView.hideTxt");
         addChild(_buyBtn);
         addChild(_fashionBagTitle);
         addChild(_fashionBag);
         _fashionBag.x = 28;
         _fashionBag.y = 345;
         _mask.graphics.beginFill(16777215,0);
         _mask.graphics.drawRect(0,0,width - 26,height);
         _mask.graphics.endFill();
         _filter = new UIFilter();
      }
      
      private function initShowView() : void
      {
         fashionModel.showThane.templateId = thane.templateId;
         fashionModel.showThane.wingAvata = thane.wingEquipAvata;
         fashionModel.showThane.hairFashionAvata = thane.hairFashionAvata;
         fashionModel.showThane.bodyFashionAvata = thane.bodyFashionAvata;
         fashionModel.showThane.armsFashionAvata = thane.armsFashionAvata;
         fashionModel.showThane.hideFashion = thane.hideFashion;
         if(playerInfo.vocationGrades > 0)
         {
            _heroBack.setFrame(thane.templateInfo.Job + 4);
         }
         else
         {
            _heroBack.setFrame(thane.templateInfo.Job);
         }
         _figure.data = fashionModel.showThane;
         _hideBtn.selected = fashionModel.showThane.hideFashion;
         while(fashionModel.stepList.length > 0)
         {
            fashionModel.stepList.pop();
         }
         _goBackBtn.enable = fashionModel.canGotoPreStep;
         fashionModel.showDic.clear();
         fashionModel.initShowDic();
         creatFashionView();
      }
      
      private function creatFashionView() : void
      {
         _hairFashionCell = ComponentFactory.Instance.creatCustomObject("shop.hairCell");
         _hairFashionCell.sonType = 110;
         _hairFashionCell.moveType = "GET_OFF";
         _clothFashionCell = ComponentFactory.Instance.creatCustomObject("shop.clothCell");
         _clothFashionCell.sonType = 112;
         _clothFashionCell.moveType = "GET_OFF";
         _weaponFashionCell = ComponentFactory.Instance.creatCustomObject("shop.weaponCell");
         _weaponFashionCell.sonType = 111;
         _weaponFashionCell.moveType = "GET_OFF";
         _wingFashionCell = ComponentFactory.Instance.creatCustomObject("shop.wingCell");
         _wingFashionCell.sonType = 109;
         _wingFashionCell.moveType = "GET_OFF";
         addChild(_hairFashionCell);
         addChild(_clothFashionCell);
         addChild(_weaponFashionCell);
         addChild(_wingFashionCell);
         refreshCell();
      }
      
      private function initEvent() : void
      {
         fashionModel.showThane.addEventListener("PLAYER_AVATA_CHANGE",__refreshView);
         if(_hideBtn)
         {
            _hideBtn.addEventListener("select",__hideHandler);
         }
         if(_goBackBtn)
         {
            _goBackBtn.addEventListener("click",__goBackHandler);
         }
         if(_buyBtn)
         {
            _buyBtn.addEventListener("click",__allBuyHandler);
         }
      }
      
      private function removeEvent() : void
      {
         fashionModel.showThane.removeEventListener("PLAYER_AVATA_CHANGE",__refreshView);
         if(_hideBtn)
         {
            _hideBtn.removeEventListener("select",__hideHandler);
         }
         if(_goBackBtn)
         {
            _goBackBtn.removeEventListener("click",__goBackHandler);
         }
         if(_buyBtn)
         {
            _buyBtn.removeEventListener("click",__allBuyHandler);
         }
      }
      
      protected function __allBuyHandler(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < fashionModel.showDic.getList().length)
         {
            if(fashionModel.showDic.getList()[_loc3_] is ShopGoodsInfo)
            {
               _loc2_.push(fashionModel.showDic.getList()[_loc3_]);
            }
            _loc3_++;
         }
         if(_loc2_.length <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("view.inside.FashionShowView.oneFashionLess"));
            return;
         }
         var _loc4_:FashionAllBuyFrame = ComponentFactory.Instance.creatComponentByStylename("shop.FashionAllBuyFrame");
         _loc4_.show(_loc2_);
      }
      
      private function __goBackHandler(param1:MouseEvent) : void
      {
         fashionModel.gotoPreStep();
      }
      
      private function __hideHandler(param1:Event) : void
      {
         fashionModel.showThane.hideFashion = _hideBtn.selected;
         fashionModel.showThane.commit();
      }
      
      private function __refreshView(param1:PlayerEvent) : void
      {
         if(!param1.info)
         {
            return;
         }
         _figure.data = param1.info as ThaneInfo;
         refreshCell();
         _goBackBtn.enable = fashionModel.canGotoPreStep;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get fashionModel() : FashionModel
      {
         return FrameControllerManager.instance.fashionCodeController.model;
      }
      
      public function refreshCell() : void
      {
         var _loc4_:GoodsInfo = null;
         var _loc3_:GoodsInfo = null;
         var _loc2_:GoodsInfo = null;
         var _loc1_:GoodsInfo = null;
         if(fashionModel.showDic[_hairFashionCell.sonType] is GoodsInfo)
         {
            _hairFashionCell.data = fashionModel.showDic[_hairFashionCell.sonType] as GoodsInfo;
            _filter.setGrayFilter(_hairFashionCell);
         }
         else if(fashionModel.showDic[_hairFashionCell.sonType] is ShopGoodsInfo)
         {
            _loc4_ = new GoodsInfo();
            _loc4_.templateId = (fashionModel.showDic[_hairFashionCell.sonType] as ShopGoodsInfo).ItemId;
            _hairFashionCell.data = _loc4_;
            _filter.setNormalFilter(_hairFashionCell);
         }
         else
         {
            _hairFashionCell.data = null;
            _filter.setNormalFilter(_hairFashionCell);
         }
         if(fashionModel.showDic[_clothFashionCell.sonType] is GoodsInfo)
         {
            _clothFashionCell.data = fashionModel.showDic[_clothFashionCell.sonType] as GoodsInfo;
            _filter.setGrayFilter(_clothFashionCell);
         }
         else if(fashionModel.showDic[_clothFashionCell.sonType] is ShopGoodsInfo)
         {
            _loc3_ = new GoodsInfo();
            _loc3_.templateId = (fashionModel.showDic[_clothFashionCell.sonType] as ShopGoodsInfo).ItemId;
            _clothFashionCell.data = _loc3_;
            _filter.setNormalFilter(_clothFashionCell);
         }
         else
         {
            _clothFashionCell.data = null;
            _filter.setNormalFilter(_clothFashionCell);
         }
         if(fashionModel.showDic[_weaponFashionCell.sonType] is GoodsInfo)
         {
            _weaponFashionCell.data = fashionModel.showDic[_weaponFashionCell.sonType] as GoodsInfo;
            _filter.setGrayFilter(_weaponFashionCell);
         }
         else if(fashionModel.showDic[_weaponFashionCell.sonType] is ShopGoodsInfo)
         {
            _loc2_ = new GoodsInfo();
            _loc2_.templateId = (fashionModel.showDic[_weaponFashionCell.sonType] as ShopGoodsInfo).ItemId;
            _weaponFashionCell.data = _loc2_;
            _filter.setNormalFilter(_weaponFashionCell);
         }
         else
         {
            _weaponFashionCell.data = null;
            _filter.setNormalFilter(_weaponFashionCell);
         }
         if(fashionModel.showDic[_wingFashionCell.sonType] is GoodsInfo)
         {
            _wingFashionCell.data = fashionModel.showDic[_wingFashionCell.sonType] as GoodsInfo;
            _filter.setGrayFilter(_wingFashionCell);
         }
         else if(fashionModel.showDic[_wingFashionCell.sonType] is ShopGoodsInfo)
         {
            _loc1_ = new GoodsInfo();
            _loc1_.templateId = (fashionModel.showDic[_wingFashionCell.sonType] as ShopGoodsInfo).ItemId;
            _wingFashionCell.data = _loc1_;
            _filter.setNormalFilter(_wingFashionCell);
         }
         else
         {
            _wingFashionCell.data = null;
            _filter.setNormalFilter(_wingFashionCell);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         _hairFashionCell.filters = null;
         _clothFashionCell.filters = null;
         _weaponFashionCell.filters = null;
         _wingFashionCell.filters = null;
         _filter = null;
         ObjectUtils.disposeObject(_heroBack);
         _heroBack = null;
         ObjectUtils.disposeObject(_figure);
         _figure = null;
         ObjectUtils.disposeObject(_mask);
         _mask = null;
         ObjectUtils.disposeObject(_fashionGirdBack);
         _fashionGirdBack = null;
         ObjectUtils.disposeObject(_goBackBtn);
         _goBackBtn = null;
         ObjectUtils.disposeObject(_hideBtn);
         _hideBtn = null;
         ObjectUtils.disposeObject(_hideTxt);
         _hideTxt = null;
         ObjectUtils.disposeObject(_buyBtn);
         _buyBtn = null;
         ObjectUtils.disposeObject(_fashionBagTitle);
         _fashionBagTitle = null;
         ObjectUtils.disposeObject(_fashionBag);
         _fashionBag = null;
         ObjectUtils.disposeObject(_hairFashionCell);
         _hairFashionCell = null;
         ObjectUtils.disposeObject(_clothFashionCell);
         _clothFashionCell = null;
         ObjectUtils.disposeObject(_weaponFashionCell);
         _weaponFashionCell = null;
         ObjectUtils.disposeObject(_wingFashionCell);
         _wingFashionCell = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

