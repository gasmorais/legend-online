package view.inside
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import managers.ShopManager;
   import mvc.module.shop.ShopModel;
   import view.ShopFrame;
   import view.timebuy.ShopTimeBuyView;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   
   public class ShopTypeTabView extends Sprite implements Disposeable
   {
      
      private var _elsepageBtn:SelectedButton;
      
      private var _homepageBtn:SelectedButton;
      
      private var _propBtn:SelectedButton;
      
      private var _btGroup:SelectedButtonGroup;
      
      private var _shopInsideView:ShopInsideView;
      
      private var _shopFrame:ShopFrame;
      
      private var _hBox:HBox;
      
      private var _heroBtn:SelectedButton;
      
      private var _petBtn:SelectedButton;
      
      private var _childBtn:SelectedButton;
      
      private var _fashionBoxBtn:SelectedButton;
      
      private var _mountBoxBtn:SelectedButton;
      
      private var _shopBoxView:ShopBoxView;
      
      private var _shopTimeBuyView:ShopTimeBuyView;
      
      public function ShopTypeTabView(param1:ShopFrame)
      {
         super();
         _shopFrame = param1;
         init();
         addEvent();
         _btGroup.selectIndex = 0;
      }
      
      private function init() : void
      {
         _elsepageBtn = ComponentFactory.Instance.creatComponentByStylename("shop.ElsepageBtn");
         _homepageBtn = ComponentFactory.Instance.creatComponentByStylename("shop.TimeBuyBtn");
         _propBtn = ComponentFactory.Instance.creatComponentByStylename("shop.PropBtn");
         _hBox = ComponentFactory.Instance.creatComponentByStylename("shop.TopButtonHbox");
         _heroBtn = ComponentFactory.Instance.creatComponentByStylename("shop.heroBtn");
         _petBtn = ComponentFactory.Instance.creatComponentByStylename("shop.petBtn");
         _childBtn = ComponentFactory.Instance.creatComponentByStylename("shop.childBtn");
         _fashionBoxBtn = ComponentFactory.Instance.creatComponentByStylename("shop.fashionBoxBtn");
         _mountBoxBtn = ComponentFactory.Instance.creatComponentByStylename("shop.mountBoxBtn");
         _btGroup = new SelectedButtonGroup();
         addChild(_hBox);
         if(isShowHomePageBtn)
         {
            _hBox.addChild(_homepageBtn);
            _btGroup.addSelectItem(_homepageBtn);
         }
         _hBox.addChild(_propBtn);
         _hBox.addChild(_heroBtn);
         _hBox.addChild(_petBtn);
         _hBox.addChild(_childBtn);
         _hBox.addChild(_elsepageBtn);
         _hBox.addChild(_fashionBoxBtn);
         _hBox.addChild(_mountBoxBtn);
         _btGroup.addSelectItem(_propBtn);
         _btGroup.addSelectItem(_heroBtn);
         _btGroup.addSelectItem(_petBtn);
         _btGroup.addSelectItem(_childBtn);
         _btGroup.addSelectItem(_elsepageBtn);
         _btGroup.addSelectItem(_fashionBoxBtn);
         _btGroup.addSelectItem(_mountBoxBtn);
      }
      
      private function get isShowHomePageBtn() : Boolean
      {
         var _loc1_:Array = ShopManager.Instance.model.getPromotionalGoodsList();
         if(shopModel.getTimeBuyList(0).length > 0 || _loc1_.length > 0)
         {
            return true;
         }
         return false;
      }
      
      private function addEvent() : void
      {
         if(_btGroup)
         {
            _btGroup.addEventListener("change",__onTabBtnHandler);
         }
         NotificationManager.instance.addEventListener("SHOP_LIMITE_TIMEDISCOUNT_UPDATA",__updateDataHandler);
      }
      
      private function removeEvent() : void
      {
         if(_btGroup)
         {
            _btGroup.removeEventListener("change",__onTabBtnHandler);
         }
         NotificationManager.instance.removeEventListener("SHOP_LIMITE_TIMEDISCOUNT_UPDATA",__updateDataHandler);
      }
      
      private function __updateDataHandler(param1:NotificationEvent) : void
      {
         __onTabBtnHandler(null);
      }
      
      private function __onTabBtnHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SelectedButton = _btGroup.getSelectedItem() as SelectedButton;
         if(_shopFrame)
         {
            _shopFrame.searchView(false);
         }
         updateState(_loc2_);
         switch(_loc2_)
         {
            case _homepageBtn:
               break;
            case _propBtn:
               FrameControllerManager.instance.shopController.setCurrentGoodsList(shopModel.propGoodsList);
               break;
            case _heroBtn:
               FrameControllerManager.instance.shopController.setCurrentGoodsList(shopModel.heroGoodsList);
               break;
            case _petBtn:
               FrameControllerManager.instance.shopController.setCurrentGoodsList(shopModel.petGoodsList);
               break;
            case _childBtn:
               FrameControllerManager.instance.shopController.setCurrentGoodsList(shopModel.childGoodsList);
               break;
            case _elsepageBtn:
               FrameControllerManager.instance.shopController.setCurrentGoodsList(shopModel.elseGoodsList);
               break;
            case _fashionBoxBtn:
            case _mountBoxBtn:
               if(_shopFrame)
               {
                  _shopFrame.searchView(true);
               }
         }
      }
      
      public function searchState() : void
      {
         _btGroup.selectIndex = 1;
         var _loc1_:SelectedButton = _btGroup.getSelectedItem() as SelectedButton;
         updateState(_loc1_);
         _btGroup.selectIndex = -1;
         updateState(null);
      }
      
      private function updateState(param1:SelectedButton) : void
      {
         var _loc2_:String = null;
         _homepageBtn.selected = false;
         _propBtn.selected = false;
         _heroBtn.selected = false;
         _petBtn.selected = false;
         _childBtn.selected = false;
         _fashionBoxBtn.selected = false;
         _mountBoxBtn.selected = false;
         _elsepageBtn.selected = false;
         _homepageBtn.mouseEnabled = true;
         _propBtn.mouseEnabled = true;
         _heroBtn.mouseEnabled = true;
         _petBtn.mouseEnabled = true;
         _childBtn.mouseEnabled = true;
         _fashionBoxBtn.mouseEnabled = true;
         _mountBoxBtn.mouseEnabled = true;
         _elsepageBtn.mouseEnabled = true;
         switch(param1)
         {
            case _homepageBtn:
               updateTimeBuyView();
               break;
            case _propBtn:
            case _heroBtn:
            case _petBtn:
            case _childBtn:
            case _elsepageBtn:
               _loc2_ = "SHOP_INSIDE";
               updateInsideView(_loc2_);
               break;
            case _fashionBoxBtn:
               updateBoxView(1);
               break;
            case _mountBoxBtn:
               updateBoxView(2);
         }
         if(param1)
         {
            param1.selected = true;
            param1.mouseEnabled = false;
         }
      }
      
      private function updateTimeBuyView() : void
      {
         if(_shopInsideView)
         {
            _shopInsideView.dispose();
            _shopInsideView = null;
         }
         if(_shopBoxView)
         {
            _shopBoxView.dispose();
            _shopBoxView = null;
         }
         if(_shopTimeBuyView)
         {
            _shopTimeBuyView.dispose();
            _shopTimeBuyView = null;
         }
         if(_shopTimeBuyView == null)
         {
            _shopTimeBuyView = new ShopTimeBuyView();
            addChildAt(_shopTimeBuyView,0);
         }
         _shopTimeBuyView.isVIPShop = false;
         _shopTimeBuyView.currentPage = 1;
         _shopTimeBuyView.updateView();
      }
      
      private function updateInsideView(param1:String) : void
      {
         if(_shopBoxView)
         {
            _shopBoxView.dispose();
            _shopBoxView = null;
         }
         if(_shopTimeBuyView)
         {
            _shopTimeBuyView.dispose();
            _shopTimeBuyView = null;
         }
         if(_shopInsideView)
         {
            _shopInsideView.dispose();
            _shopInsideView = null;
         }
         if(_shopInsideView == null)
         {
            _shopInsideView = new ShopInsideView(param1);
            addChildAt(_shopInsideView,0);
         }
      }
      
      private function updateBoxView(param1:int) : void
      {
         if(_shopInsideView)
         {
            _shopInsideView.dispose();
            _shopInsideView = null;
         }
         if(_shopTimeBuyView)
         {
            _shopTimeBuyView.dispose();
            _shopTimeBuyView = null;
         }
         if(_shopBoxView)
         {
            _shopBoxView.dispose();
            _shopBoxView = null;
         }
         if(!_shopBoxView)
         {
            _shopBoxView = new ShopBoxView(param1);
            addChildAt(_shopBoxView,0);
         }
      }
      
      private function get shopModel() : ShopModel
      {
         return ShopManager.Instance.model;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_elsepageBtn);
         _elsepageBtn = null;
         ObjectUtils.disposeObject(_homepageBtn);
         _homepageBtn = null;
         ObjectUtils.disposeObject(_propBtn);
         _propBtn = null;
         ObjectUtils.disposeObject(_heroBtn);
         _heroBtn = null;
         ObjectUtils.disposeObject(_petBtn);
         _petBtn = null;
         ObjectUtils.disposeObject(_childBtn);
         _childBtn = null;
         ObjectUtils.disposeObject(_fashionBoxBtn);
         _fashionBoxBtn = null;
         ObjectUtils.disposeObject(_mountBoxBtn);
         _mountBoxBtn = null;
         ObjectUtils.disposeObject(_btGroup);
         _btGroup = null;
         ObjectUtils.disposeObject(_shopInsideView);
         _shopInsideView = null;
         ObjectUtils.disposeObject(_hBox);
         _hBox = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

