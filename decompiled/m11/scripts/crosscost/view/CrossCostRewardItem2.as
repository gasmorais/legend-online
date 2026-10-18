package crosscost.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import funny.datas.FunnyBagData;
   import manager.LanguageMgr;
   import managers.ExchargeRankManager;
   import managers.FunnyManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   
   public class CrossCostRewardItem2 extends Sprite implements Disposeable
   {
      
      public const LE_PROFILE_LIMIT:int = 5;
      
      private var _title:FilterFrameText;
      
      private var _vipText:FilterFrameText;
      
      private var _allPeopleText:FilterFrameText;
      
      private var _chargeNumderText:FilterFrameText;
      
      private var _textHBox:HBox;
      
      private var _itemList1:ScrollPanel;
      
      private var _container1:Component;
      
      private var _hBox1:HBox;
      
      private var _itemList2:ScrollPanel;
      
      private var _container2:Component;
      
      private var _hBox2:HBox;
      
      private var _vBox:VBox;
      
      private var _hasGet:Bitmap;
      
      private var _getBtn:IconButton;
      
      private var _hasGet2:Bitmap;
      
      private var _getBtn2:IconButton;
      
      private var _data1:FunnyBagData;
      
      private var _data2:FunnyBagData;
      
      private var _filters:UIFilter;
      
      private var _itemBg:ScaleBitmapImage;
      
      private var _itemListBg1:ScaleBitmapImage;
      
      private var _itemListBg2:ScaleBitmapImage;
      
      public function CrossCostRewardItem2()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _itemBg = ComponentFactory.Instance.creatComponentByStylename("exchargeRankRewardItem2.itemBg");
         _itemListBg1 = ComponentFactory.Instance.creatComponentByStylename("exchargeRankRewardItem2.itemListBg1");
         _itemListBg2 = ComponentFactory.Instance.creatComponentByStylename("exchargeRankRewardItem2.itemListBg2");
         _title = ComponentFactory.Instance.creatComponentByStylename("exchargeRankRewardItem.title");
         _chargeNumderText = ComponentFactory.Instance.creatComponentByStylename("exchargeRankRewardItem.chargeNumberText");
         _textHBox = ComponentFactory.Instance.creatComponentByStylename("exchargeRankRewardItem.textBHox");
         _vipText = ComponentFactory.Instance.creatComponentByStylename("exchargeRankRewardItem.vipText");
         _itemList1 = ComponentFactory.Instance.creatComponentByStylename("exchargeRankRewardItem.itemList");
         _hBox1 = ComponentFactory.Instance.creatComponentByStylename("exchargeRankRewardItem.hBox");
         _hasGet = ComponentFactory.Instance.creatBitmap("asset.rewarditem.ReceivedImg");
         _getBtn = ComponentFactory.Instance.creatComponentByStylename("crosscost.rewarditem.getBtn");
         _allPeopleText = ComponentFactory.Instance.creatComponentByStylename("exchargeRankRewardItem.vipText");
         _itemList2 = ComponentFactory.Instance.creatComponentByStylename("exchargeRankRewardItem.itemList");
         _hBox2 = ComponentFactory.Instance.creatComponentByStylename("exchargeRankRewardItem.hBox2");
         _hasGet2 = ComponentFactory.Instance.creatBitmap("asset.rewarditem.ReceivedImg");
         _getBtn2 = ComponentFactory.Instance.creatComponentByStylename("crosscost.rewarditem.getBtn");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("exchargeRankRewardItem.vBox");
         _itemList1.y = 51;
         _container1 = new Component();
         _container1.addChild(_hBox1);
         _itemList1.setView(_container1,true);
         _itemList2.y = 131;
         _container2 = new Component();
         _container2.addChild(_hBox2);
         _itemList2.setView(_container2,true);
         addChild(_itemBg);
         addChild(_itemListBg1);
         addChild(_itemListBg2);
         addChild(_hasGet);
         addChild(_getBtn);
         addChild(_hasGet2);
         addChild(_getBtn2);
         addChild(_vBox);
         _filters = new UIFilter();
         _vBox.x = 10;
         _vBox.y = 8;
         _hasGet.visible = false;
         _getBtn.enable = false;
         _hasGet2.visible = false;
         _getBtn2.enable = false;
         _getBtn.x = 465;
         _getBtn.y = 68;
         _hasGet.x = _getBtn.x - 10;
         _hasGet.y = _getBtn.y - 20;
         _getBtn2.x = 465;
         _getBtn2.y = 155;
         _hasGet2.x = _getBtn2.x - 10;
         _hasGet2.y = _getBtn2.y - 20;
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeAllChildren(_textHBox);
         ObjectUtils.disposeAllChildren(_hBox1);
         ObjectUtils.disposeAllChildren(_hBox2);
         ObjectUtils.disposeAllChildren(_container1);
         ObjectUtils.disposeAllChildren(_container2);
         ObjectUtils.disposeAllChildren(_itemList1);
         ObjectUtils.disposeAllChildren(_itemList2);
         ObjectUtils.disposeObject(_itemBg);
         _itemBg = null;
         ObjectUtils.disposeObject(_itemListBg1);
         _itemListBg1 = null;
         ObjectUtils.disposeObject(_itemListBg2);
         _itemListBg2 = null;
         ObjectUtils.disposeObject(_textHBox);
         _textHBox = null;
         ObjectUtils.disposeObject(_hBox1);
         _hBox1 = null;
         ObjectUtils.disposeObject(_hBox2);
         _hBox2 = null;
         ObjectUtils.disposeObject(_container1);
         _container1 = null;
         ObjectUtils.disposeObject(_container2);
         _container2 = null;
         ObjectUtils.disposeObject(_itemList1);
         _itemList1 = null;
         ObjectUtils.disposeObject(_itemList2);
         _itemList2 = null;
         ObjectUtils.disposeObject(_hasGet);
         _hasGet = null;
         ObjectUtils.disposeObject(_getBtn);
         _getBtn = null;
         ObjectUtils.disposeObject(_hasGet2);
         _hasGet2 = null;
         ObjectUtils.disposeObject(_getBtn2);
         _getBtn2 = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         if(_hasGet)
         {
            _hasGet.filters = null;
         }
         if(_hasGet2)
         {
            _hasGet2.filters = null;
         }
         _filters = null;
         _data1 = null;
         _data2 = null;
      }
      
      private function initEvent() : void
      {
         if(_getBtn)
         {
            _getBtn.addEventListener("click",__clickHandler);
         }
         if(_getBtn2)
         {
            _getBtn2.addEventListener("click",__clickHandler2);
         }
      }
      
      private function removeEvent() : void
      {
         if(_getBtn)
         {
            _getBtn.removeEventListener("click",__clickHandler);
         }
         if(_getBtn2)
         {
            _getBtn2.removeEventListener("click",__clickHandler2);
         }
      }
      
      private function clear() : void
      {
         _vipText.text = "";
         _title.text = "";
         _hBox1.disposeAllChildren();
         _hBox2.disposeAllChildren();
      }
      
      private function get currentChargeValue() : int
      {
         var _loc2_:int = 0;
         var _loc1_:Object = FunnyManager.instance.model.currentCost;
         if(_loc1_)
         {
            _loc2_ = int(_loc1_.currentValue);
         }
         return _loc2_;
      }
      
      public function setData(param1:FunnyBagData, param2:FunnyBagData) : void
      {
         var _loc7_:int = 0;
         var _loc4_:BaseItemView = null;
         var _loc8_:GoodsInfo = null;
         var _loc12_:GoodsTemplateInfo = null;
         var _loc11_:MovieImage = null;
         var _loc10_:int = 0;
         var _loc6_:BaseItemView = null;
         var _loc5_:GoodsInfo = null;
         var _loc9_:GoodsTemplateInfo = null;
         var _loc3_:MovieImage = null;
         if(!param1 || !param2)
         {
            return;
         }
         if(_data1 == param1 && _data2 == param2)
         {
            return;
         }
         clear();
         _itemList1.beginChanges();
         _itemList2.beginChanges();
         _data1 = param1;
         _data2 = param2;
         _title.text = _data1.title;
         _chargeNumderText.text = LanguageMgr.GetTranslation("exchargerank.view.ExchargeRankBagView.RewardItem.chargeNumber",currentChargeValue);
         _vipText.text = LanguageMgr.GetTranslation("exchargerank.view.ExchargeRankBagView.RewardItem.vipText1");
         _vipText.y = _title.y + _title.height;
         _loc7_ = 0;
         while(_loc7_ < _data1.rewardList.length)
         {
            if(_data1.rewardList[_loc7_].temType == 1)
            {
               _loc4_ = ComponentFactory.Instance.creatCustomObject("exchargerankFrame.BaseItemView");
               _loc8_ = new GoodsInfo();
               _loc8_.templateId = _data1.rewardList[_loc7_].temId;
               _loc8_.count = _data1.rewardList[_loc7_].count;
               _loc8_.showCount = true;
               _loc8_.isBinds = _data1.rewardList[_loc7_].isBind;
               _loc8_.strengthenGrade = _data1.rewardList[_loc7_].strengthenGrade;
               _loc4_.data = _loc8_;
               _hBox1.addChild(_loc4_);
               _loc12_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_data1.rewardList[_loc7_].temId);
               if(_loc12_ && _loc12_.Profile >= 5)
               {
                  _loc11_ = ComponentFactory.Instance.creatComponentByStylename("exchargerank.LightEffect1");
                  _loc11_.mouseEnabled = false;
                  _loc11_.mouseChildren = false;
                  _loc11_.x = _loc4_.x + 26;
                  _loc11_.y = _hBox1.y - 29;
                  _container1.addChild(_loc11_);
               }
            }
            _loc7_++;
         }
         _allPeopleText.text = LanguageMgr.GetTranslation("exchargerank.view.ExchargeRankBagView.RewardItem.vipText2");
         _loc10_ = 0;
         while(_loc10_ < _data2.rewardList.length)
         {
            if(_data2.rewardList[_loc10_].temType == 1)
            {
               _loc6_ = ComponentFactory.Instance.creatCustomObject("exchargerankFrame.BaseItemView");
               _loc5_ = new GoodsInfo();
               _loc5_.templateId = _data2.rewardList[_loc10_].temId;
               _loc5_.count = _data2.rewardList[_loc10_].count;
               _loc5_.showCount = true;
               _loc5_.isBinds = _data2.rewardList[_loc10_].isBind;
               _loc5_.strengthenGrade = _data2.rewardList[_loc10_].strengthenGrade;
               _loc6_.data = _loc5_;
               _hBox2.addChild(_loc6_);
               _loc9_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_data2.rewardList[_loc10_].temId);
               if(_loc9_ && _loc9_.Profile >= 5)
               {
                  _loc3_ = ComponentFactory.Instance.creatComponentByStylename("exchargerank.LightEffect1");
                  _loc3_.mouseEnabled = false;
                  _loc3_.mouseChildren = false;
                  _loc3_.x = _loc6_.x + 26;
                  _loc3_.y = _hBox2.y - 29;
                  _container2.addChild(_loc3_);
               }
            }
            _loc10_++;
         }
         _container1.width = _hBox1.width;
         _itemList1.invalidateViewport(true);
         _itemList1.commitChanges();
         _container2.width = _hBox2.width;
         _itemList2.invalidateViewport(true);
         _itemList2.commitChanges();
         _textHBox.spacing = 5;
         _textHBox.addChild(_title);
         _textHBox.addChild(_chargeNumderText);
         _vBox.addChild(_textHBox);
         _vBox.addChild(_vipText);
         _vBox.addChild(_itemList1);
         _vBox.addChild(_allPeopleText);
         _vBox.addChild(_itemList2);
         _allPeopleText.y = 144;
         _itemList2.y = 173;
         setState();
         setState2();
      }
      
      private function setState() : void
      {
         if(_data1 == null)
         {
            return;
         }
         switch(int(_data1.status) - 1)
         {
            case 0:
               if(_hasGet)
               {
                  _hasGet.visible = false;
               }
               if(_getBtn)
               {
                  _getBtn.visible = true;
                  _getBtn.enable = true;
               }
               if(_title)
               {
                  _title.setFrame(2);
               }
               break;
            case 1:
               if(_hasGet)
               {
                  _hasGet.visible = true;
               }
               if(_getBtn)
               {
                  _getBtn.visible = false;
               }
               if(_title)
               {
                  _title.setFrame(1);
               }
               break;
            case 2:
               if(_hasGet)
               {
                  _hasGet.visible = false;
               }
               if(_getBtn)
               {
                  _getBtn.visible = true;
                  _getBtn.enable = false;
               }
               if(_title)
               {
                  _title.setFrame(2);
               }
         }
      }
      
      private function setState2() : void
      {
         if(_data2 == null)
         {
            return;
         }
         switch(int(_data2.status) - 1)
         {
            case 0:
               if(_hasGet2)
               {
                  _hasGet2.visible = false;
               }
               if(_getBtn2)
               {
                  _getBtn2.visible = true;
                  _getBtn2.enable = true;
               }
               break;
            case 1:
               if(_hasGet2)
               {
                  _hasGet2.visible = true;
               }
               if(_getBtn2)
               {
                  _getBtn2.visible = false;
               }
               break;
            case 2:
               if(_hasGet2)
               {
                  _hasGet2.visible = false;
               }
               if(_getBtn2)
               {
                  _getBtn2.visible = true;
                  _getBtn2.enable = false;
               }
         }
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         ExchargeRankManager.instance.sendGetBag(2,_data1.activeId,_data1.id);
         ExchargeRankManager.instance.sendInitBagData(1);
      }
      
      private function __clickHandler2(param1:MouseEvent) : void
      {
         ExchargeRankManager.instance.sendGetBag(2,_data2.activeId,_data2.id);
         ExchargeRankManager.instance.sendInitBagData(1);
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

