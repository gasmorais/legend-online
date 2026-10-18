package view.subshop
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.ComboBox;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.list.VectorListModel;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import events.ShopEvent;
   import farm.FarmManager;
   import flash.display.Bitmap;
   import flash.geom.Rectangle;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import managers.ShopManager;
   import mvc.module.shop.ShopGoodsInfo;
   import mvc.module.shop.ShopModel;
   import yishi.datas.ComponentGroupType;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.utils.SimpleDictionary;
   
   public class FarmShopFrame extends Frame implements IManualSize
   {
      
      private var _data:ShopModel;
      
      private var _back:Scale9CornerImage;
      
      private var _backBorder:ScaleBitmapImage;
      
      private var _itemList:Vector.<FarmShopItem>;
      
      private var _bigContainer:Component;
      
      private var _shopItemContainer:Component;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _splitLineList:Vector.<Bitmap>;
      
      private var _combox1:ComboBox;
      
      private var _combox2:ComboBox;
      
      private var _orderType:int;
      
      public function FarmShopFrame()
      {
         super();
         initView();
         initCombox();
         addEvent();
         setTimeout(initData,100);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,783,535);
      }
      
      private function initView() : void
      {
         _data = FrameControllerManager.instance.shopController.model;
         titleText = LanguageMgr.GetTranslation("farm.FarmShopFrame.title");
         _back = ComponentFactory.Instance.creatComponentByStylename("farm.shopFrameTableBg");
         _backBorder = ComponentFactory.Instance.creatComponentByStylename("farm.shopBg");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("farm.scrollPanel");
         _combox1 = ComponentFactory.Instance.creatComponentByStylename("FarmShopFrame.Combox1");
         _combox2 = ComponentFactory.Instance.creatComponentByStylename("FarmShopFrame.Combox2");
         addToContent(_back);
         addToContent(_backBorder);
         addToContent(_scrollPanel);
         addToContent(_combox1);
         addToContent(_combox2);
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _itemList = new Vector.<FarmShopItem>();
         _splitLineList = new Vector.<Bitmap>();
         _bigContainer = new Component();
         _shopItemContainer = new Component();
         addToContent(_bigContainer);
         _bigContainer.addChild(_scrollPanel);
         _bigContainer.addChild(_shopItemContainer);
         _scrollPanel.setView(_shopItemContainer);
         _scrollPanel.invalidateViewport();
         _bigContainer.height = 300;
      }
      
      private function initCombox() : void
      {
         _combox1.beginChanges();
         _combox1.textField.text = LanguageMgr.GetTranslation("FarmShopFrame.profitType");
         _combox1.selctedPropName = "formatText";
         var _loc1_:VectorListModel = _combox1.listPanel.vectorListModel;
         _loc1_.clear();
         if(check(1))
         {
            _loc1_.append({
               "Type":1,
               "TypeText":LanguageMgr.GetTranslation("FarmShopFrame.all")
            });
         }
         if(check(2))
         {
            _loc1_.append({
               "Type":2,
               "TypeText":LanguageMgr.GetTranslation("FarmShopFrame.gold")
            });
         }
         if(check(3))
         {
            _loc1_.append({
               "Type":3,
               "TypeText":LanguageMgr.GetTranslation("FarmShopFrame.soul")
            });
         }
         if(check(4))
         {
            _loc1_.append({
               "Type":4,
               "TypeText":LanguageMgr.GetTranslation("FarmShopFrame.crystal")
            });
         }
         if(check(5))
         {
            _loc1_.append({
               "Type":5,
               "TypeText":LanguageMgr.GetTranslation("FarmShopFrame.exp")
            });
         }
         if(check(7))
         {
            _loc1_.append({
               "Type":7,
               "TypeText":LanguageMgr.GetTranslation("FarmShopFrame.medal")
            });
         }
         if(check(6))
         {
            _loc1_.append({
               "Type":6,
               "TypeText":LanguageMgr.GetTranslation("FarmShopFrame.other")
            });
         }
         _combox1.listPanel.list.updateListView();
         _combox1.commitChanges();
         _combox2.beginChanges();
         _combox2.textField.text = LanguageMgr.GetTranslation("FarmShopFrame.maturityTime");
         _combox2.selctedPropName = "formatText";
         var _loc2_:VectorListModel = _combox2.listPanel.vectorListModel;
         _loc2_.clear();
         _loc2_.append({
            "OrderType":1,
            "TypeText":LanguageMgr.GetTranslation("FarmShopFrame.desc")
         });
         _loc2_.append({
            "OrderType":2,
            "TypeText":LanguageMgr.GetTranslation("FarmShopFrame.asc")
         });
         _combox2.listPanel.list.updateListView();
         _combox2.commitChanges();
      }
      
      private function check(param1:int) : Boolean
      {
         return true;
      }
      
      private function __selected1Change(param1:ListItemEvent) : void
      {
         if(!_data)
         {
            return;
         }
         var _loc2_:int = int(param1.cellValue.Type);
         switch(_loc2_ - 1)
         {
            case 0:
               _data.currentTab = 1;
               break;
            case 1:
               _data.currentTab = 2;
               break;
            case 2:
               _data.currentTab = 3;
               break;
            case 3:
               _data.currentTab = 4;
               break;
            case 4:
               _data.currentTab = 5;
               break;
            case 5:
               _data.currentTab = 6;
               break;
            case 6:
               _data.currentTab = 7;
         }
         _data.sortFarmGoods(_orderType == 1);
      }
      
      private function __selected2Change(param1:ListItemEvent) : void
      {
         _orderType = param1.cellValue.OrderType;
         var _loc2_:int = int(param1.cellValue.OrderType);
         _data.sortFarmGoods(_loc2_ == 1);
      }
      
      private function initData() : void
      {
         FrameControllerManager.instance.shopController.initFarmShopFrame();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _data.addEventListener("GOODS_LIST_UPDATE",__refreshGoods);
         _combox1.listPanel.list.addEventListener("listItemClick",__selected1Change);
         _combox2.listPanel.list.addEventListener("listItemClick",__selected2Change);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _data.removeEventListener("GOODS_LIST_UPDATE",__refreshGoods);
         _combox1.listPanel.list.removeEventListener("listItemClick",__selected1Change);
         _combox2.listPanel.list.removeEventListener("listItemClick",__selected2Change);
      }
      
      private function clear() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _splitLineList.length)
         {
            ObjectUtils.disposeObject(_splitLineList[_loc1_]);
            _splitLineList[_loc1_] = null;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _itemList.length)
         {
            ObjectUtils.disposeObject(_itemList[_loc1_]);
            _itemList[_loc1_] = null;
            _loc1_++;
         }
         _shopItemContainer.height = 0;
      }
      
      private function __refreshGoods(param1:ShopEvent) : void
      {
         var _loc6_:int = 0;
         var _loc3_:ShopGoodsInfo = null;
         var _loc5_:Bitmap = null;
         var _loc2_:FarmShopItem = null;
         clear();
         var _loc4_:int = int(FarmManager.instance.model.myFarm.grade);
         _itemList = new Vector.<FarmShopItem>();
         _loc6_ = 0;
         while(_loc6_ < _data.showGoodsList.length)
         {
            _loc3_ = ShopGoodsInfo(_data.showGoodsList[_loc6_]);
            if(_loc3_)
            {
               if(_loc6_ != 0)
               {
                  _loc5_ = ComponentFactory.Instance.creatBitmap("asset.farm.shopSplitLine");
                  _loc5_.y = _loc6_ * 41;
                  _shopItemContainer.addChild(_loc5_);
                  _splitLineList.push(_loc5_);
               }
               _loc2_ = new FarmShopItem();
               _loc2_.data = _loc3_;
               _loc2_.x = 10;
               _loc2_.y = _loc6_ * 41 + 1;
               _shopItemContainer.addChild(_loc2_);
               _shopItemContainer.height += 41;
               _itemList.push(_loc2_);
            }
            _loc6_++;
         }
         _scrollPanel.invalidateViewport();
         _bigContainer.height = 300;
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
               break;
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         for each(var _loc1_:FarmShopItem in _itemList)
         {
            _loc1_.dispose();
         }
         _itemList = null;
         _data = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

