package view.inside
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.ShopEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mvc.module.shop.ShopGoodsInfo;
   import mvc.module.shop.ShopModel;
   import view.GoodsItem3;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   
   public class FashionGoodsListView extends Sprite implements Disposeable
   {
      
      private var _back:MutipleImage;
      
      private var _pointBack:MutipleImage;
      
      private var _selectedimage:Bitmap;
      
      private var _pointTxt:FilterFrameText;
      
      private var _weaponBtn:SelectedButton;
      
      private var _clothesBtn:SelectedButton;
      
      private var _hatBtn:SelectedButton;
      
      private var _wingBtn:SelectedButton;
      
      private var _btGroup:SelectedButtonGroup;
      
      private var _itemList:Vector.<GoodsItem3>;
      
      private var _row:int = 0;
      
      private var _col:int = 0;
      
      private var _preBtn:BaseButton;
      
      private var _nextBtn:BaseButton;
      
      private var _pageNumTxt:FilterFrameText;
      
      private var _bindPoint:FilterFrameText;
      
      private var _bindPoingBg:MutipleImage;
      
      public function FashionGoodsListView()
      {
         super();
         initView();
         initEvent();
         _btGroup.selectIndex = 0;
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:GoodsItem3 = null;
         _back = ComponentFactory.Instance.creatComponentByStylename("shop.FashionGoodsList.back");
         _pointBack = ComponentFactory.Instance.creatComponentByStylename("shop.pointImage");
         _bindPoingBg = ComponentFactory.Instance.creatComponentByStylename("shop.bindDiamond");
         _selectedimage = ComponentFactory.Instance.creatBitmap("asset.shop.selectedImage");
         _weaponBtn = ComponentFactory.Instance.creatComponentByStylename("shop.FashionGoodsList.weaponBtn");
         _clothesBtn = ComponentFactory.Instance.creatComponentByStylename("shop.FashionGoodsList.clothesBtn");
         _hatBtn = ComponentFactory.Instance.creatComponentByStylename("shop.FashionGoodsList.hatBtn");
         _wingBtn = ComponentFactory.Instance.creatComponentByStylename("shop.FashionGoodsList.wingBtn");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("fashionStoreFrame.nextBtn");
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("fashionStoreFrame.preBtn");
         _pageNumTxt = ComponentFactory.Instance.creatComponentByStylename("shop.PageTextStyle1");
         _pointTxt = ComponentFactory.Instance.creatComponentByStylename("shop.PointTextStyle1");
         _bindPoint = ComponentFactory.Instance.creatComponentByStylename("shop.GiftTextStyle1");
         addChild(_back);
         addChild(_pointBack);
         _pointBack.x = 7;
         _pointBack.y = 429;
         addChild(_bindPoingBg);
         _bindPoingBg.x = 190;
         _bindPoingBg.y = 429;
         addChild(_selectedimage);
         _selectedimage.x = _weaponBtn.x - 9;
         _selectedimage.y = 3;
         addChild(_weaponBtn);
         addChild(_clothesBtn);
         addChild(_hatBtn);
         addChild(_wingBtn);
         addChild(_preBtn);
         _preBtn.x = 219;
         _preBtn.y = 385;
         addChild(_nextBtn);
         _nextBtn.x = 315;
         _nextBtn.y = 385;
         addChild(_pageNumTxt);
         _pageNumTxt.x = 249;
         _pageNumTxt.y = 388;
         addChild(_pointTxt);
         _pointTxt.text = playerInfo.point + "";
         _pointTxt.x = 83;
         _pointTxt.y = 435;
         addChild(_bindPoint);
         _bindPoint.text = playerInfo.giftToken + "";
         _bindPoint.x = 278;
         _bindPoint.y = 435;
         _btGroup = new SelectedButtonGroup();
         _btGroup.addSelectItem(_weaponBtn);
         _btGroup.addSelectItem(_clothesBtn);
         _btGroup.addSelectItem(_hatBtn);
         _btGroup.addSelectItem(_wingBtn);
         _itemList = new Vector.<GoodsItem3>();
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _loc1_ = new GoodsItem3();
            _row = _loc2_ / 2;
            _col = _loc2_ % 2;
            _loc1_.x = _col * (_loc1_.width + 2) + 9;
            _loc1_.y = _row * (_loc1_.height - 8) + 51;
            addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      public function showList(param1:Array) : void
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < 6)
         {
            _itemList[_loc3_].data = null;
            _loc3_++;
         }
         var _loc2_:int = int(6 > param1.length ? 6 : param1.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _itemList[_loc3_].data = param1[_loc3_] as ShopGoodsInfo;
            _loc3_++;
         }
      }
      
      private function initEvent() : void
      {
         if(_btGroup)
         {
            _btGroup.addEventListener("change",__selectedHandler);
         }
         if(_preBtn)
         {
            _preBtn.addEventListener("click",__onPageBtnHandler);
         }
         if(_nextBtn)
         {
            _nextBtn.addEventListener("click",__onPageBtnHandler);
         }
         if(shopModel)
         {
            shopModel.addEventListener("GOODS_LIST_UPDATE",__onListUpdateHandler);
         }
         if(shopModel)
         {
            shopModel.addEventListener("PAGE_UPDATE",__onPageUpdateHandler);
         }
         playerInfo.addEventListener("PLAYER_INFO_UPDATE",__refreshPlayerInfoHandler);
      }
      
      private function removeEvent() : void
      {
         if(_btGroup)
         {
            _btGroup.removeEventListener("change",__selectedHandler);
         }
         if(_preBtn)
         {
            _preBtn.removeEventListener("click",__onPageBtnHandler);
         }
         if(_nextBtn)
         {
            _nextBtn.removeEventListener("click",__onPageBtnHandler);
         }
         if(shopModel)
         {
            shopModel.removeEventListener("GOODS_LIST_UPDATE",__onListUpdateHandler);
         }
         if(shopModel)
         {
            shopModel.removeEventListener("PAGE_UPDATE",__onPageUpdateHandler);
         }
         playerInfo.removeEventListener("PLAYER_INFO_UPDATE",__refreshPlayerInfoHandler);
      }
      
      private function __onPageBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.shopController.shopPageBtnHandler(param1.currentTarget == _preBtn);
      }
      
      private function __onPageUpdateHandler(param1:ShopEvent) : void
      {
         _pageNumTxt.text = shopModel.currentPage + "/" + shopModel.totalPage;
         _preBtn.enable = shopModel.currentPage > 1;
         _nextBtn.enable = shopModel.currentPage < shopModel.totalPage;
      }
      
      private function __onListUpdateHandler(param1:ShopEvent) : void
      {
         var _loc2_:Array = FrameControllerManager.instance.shopController.sortList(shopModel.showGoodsList);
         showList(_loc2_);
      }
      
      private function __selectedHandler(param1:Event) : void
      {
         if(!_btGroup.getSelectedItem())
         {
            return;
         }
         _selectedimage.x = _btGroup.getSelectedItem().x - 9;
         switch(_btGroup.getSelectedItem())
         {
            case _weaponBtn:
               FrameControllerManager.instance.shopController.setCurrentGoodsList(shopModel.fashionWeaponList,6);
               break;
            case _clothesBtn:
               FrameControllerManager.instance.shopController.setCurrentGoodsList(shopModel.fashionClothList,6);
               break;
            case _hatBtn:
               FrameControllerManager.instance.shopController.setCurrentGoodsList(shopModel.fashionHairList,6);
               break;
            case _wingBtn:
               FrameControllerManager.instance.shopController.setCurrentGoodsList(shopModel.fashionWingList,6);
         }
         var _loc2_:Array = FrameControllerManager.instance.shopController.sortList(shopModel.showGoodsList);
         showList(_loc2_);
      }
      
      private function __refreshPlayerInfoHandler(param1:Event) : void
      {
         _pointTxt.text = playerInfo.point + "";
         _bindPoint.text = playerInfo.giftToken + "";
      }
      
      private function get shopModel() : ShopModel
      {
         return FrameControllerManager.instance.shopController.model;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function dispose() : void
      {
         removeEvent();
         for each(var _loc1_:GoodsItem3 in _itemList)
         {
            _loc1_.dispose();
            _loc1_ = null;
         }
         _itemList = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_pointTxt);
         _pointTxt = null;
         ObjectUtils.disposeObject(_pointBack);
         _pointBack = null;
         ObjectUtils.disposeObject(_selectedimage);
         _selectedimage = null;
         ObjectUtils.disposeObject(_hatBtn);
         _hatBtn = null;
         ObjectUtils.disposeObject(_clothesBtn);
         _clothesBtn = null;
         ObjectUtils.disposeObject(_weaponBtn);
         _weaponBtn = null;
         ObjectUtils.disposeObject(_wingBtn);
         _wingBtn = null;
         ObjectUtils.disposeObject(_btGroup);
         _btGroup = null;
         ObjectUtils.disposeObject(_nextBtn);
         _nextBtn = null;
         ObjectUtils.disposeObject(_preBtn);
         _preBtn = null;
         ObjectUtils.disposeObject(_pageNumTxt);
         _pageNumTxt = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

