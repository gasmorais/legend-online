package exchargerank.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
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
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.TempleteManager;
   import yishi.utils.MoneyUtils;
   import yishi.view.community.BaseItemView;
   
   public class ExchargeRewardItem extends Sprite implements Disposeable
   {
      
      private var _title:FilterFrameText;
      
      private var _vipText:FilterFrameText;
      
      private var _chargeNumderText:FilterFrameText;
      
      private var _textHBox:HBox;
      
      private var _hBox:HBox;
      
      private var _vBox:VBox;
      
      private var _hasGet:Bitmap;
      
      private var _getBtn:BaseButton;
      
      private var _container:Component;
      
      private var _data:FunnyBagData;
      
      private var _filters:UIFilter;
      
      private var _itemList:ScrollPanel;
      
      private var _itemBg:ScaleBitmapImage;
      
      private var _itemListBg:ScaleBitmapImage;
      
      public function ExchargeRewardItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _itemBg = ComponentFactory.Instance.creatComponentByStylename("exchargeRankRewardItem.itemBg");
         _itemListBg = ComponentFactory.Instance.creatComponentByStylename("exchargeRankRewardItem.itemListBg");
         _title = ComponentFactory.Instance.creatComponentByStylename("exchargeRankRewardItem.title");
         _hBox = ComponentFactory.Instance.creatComponentByStylename("exchargeRankRewardItem.hBox");
         _hasGet = ComponentFactory.Instance.creatBitmap("asset.exchargerank.ReceivedImg");
         _getBtn = ComponentFactory.Instance.creatComponentByStylename("exchargeRankRewardItem.getBtn");
         _vipText = ComponentFactory.Instance.creatComponentByStylename("exchargeRankRewardItem.vipText");
         _itemList = ComponentFactory.Instance.creatComponentByStylename("exchargeRankRewardItem.itemList");
         _chargeNumderText = ComponentFactory.Instance.creatComponentByStylename("exchargeRankRewardItem.chargeNumberText");
         _textHBox = ComponentFactory.Instance.creatComponentByStylename("exchargeRankRewardItem.textBHox");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("exchargeRankRewardItem.vBox");
         addChild(_title);
         _container = new Component();
         _container.addChild(_hBox);
         _hBox.y = 30;
         _itemList.setView(_container,true);
         addChild(_itemBg);
         addChild(_itemListBg);
         addChild(_itemList);
         addChild(_hasGet);
         addChild(_getBtn);
         _filters = new UIFilter();
         _hasGet.visible = false;
         _getBtn.enable = false;
      }
      
      private function initEvent() : void
      {
         if(_getBtn)
         {
            _getBtn.addEventListener("click",__clickHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_getBtn)
         {
            _getBtn.removeEventListener("click",__clickHandler);
         }
      }
      
      public function set data(param1:FunnyBagData) : void
      {
         var _loc2_:String = null;
         var _loc4_:int = 0;
         var _loc3_:BaseItemView = null;
         var _loc5_:GoodsInfo = null;
         var _loc7_:GoodsTemplateInfo = null;
         var _loc6_:MovieImage = null;
         if(param1 == null)
         {
            return;
         }
         _data = param1;
         if(_data.conditionList[0].id == 67)
         {
            _textHBox.addChild(_title);
            _textHBox.addChild(_chargeNumderText);
            _vBox.addChild(_textHBox);
            _vBox.addChild(_vipText);
            _vBox.addChild(_hBox);
            _vBox.addChild(_itemList);
            addChild(_vBox);
            _vBox.x = 10;
            _vBox.y = 8;
            _chargeNumderText.x = _title.x + _title.width;
            _chargeNumderText.y = _title.y;
            _vipText.x = _title.x;
            _vipText.y = _title.y + _title.height;
            _getBtn.y = _vipText.y + 10;
            _hasGet.y = _getBtn.y - 16;
            if(_data.conditionList[0].bak == 1)
            {
               _vBox.removeChild(_vipText);
               _title.text = _data.title;
            }
            if(_data.conditionList[0].bak == 2)
            {
               _chargeNumderText.text = LanguageMgr.GetTranslation("exchargerank.view.ExchargeRankBagView.RewardItem.chargeNumber",ExchargeRankManager.instance._chargeNumber);
               _vipText.text = LanguageMgr.GetTranslation("exchargerank.view.ExchargeRankBagView.RewardItem.vipText1");
               _title.text = _data.title;
               _getBtn.y = _vipText.y + 38;
               _hasGet.y = _getBtn.y - 16;
            }
            if(_data.conditionList[0].bak == 3)
            {
               _vipText.text = LanguageMgr.GetTranslation("exchargerank.view.ExchargeRankBagView.RewardItem.vipText2");
               _vBox.addChild(_vipText);
               _vBox.removeChild(_textHBox);
            }
         }
         else
         {
            _itemList.x = _title.x = 10;
            _title.y = 6;
            _itemList.y = 45;
            if(_data.conditionList[0].value == 2)
            {
               _loc2_ = MoneyUtils.toCNUpper(_data.conditionList[0].bak2,true);
               if(_data.conditionList[0].bak2 == 1)
               {
                  _title.text = LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title74",_data.conditionList[0].bak,_loc2_,_data.conditionList[0].bak3);
               }
               else
               {
                  _title.text = LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title74_1",_data.conditionList[0].bak,_loc2_,_data.conditionList[0].bak3);
               }
            }
            else if(_data.conditionList[0].value == 1)
            {
               _title.text = _data.title;
               _title.width = 570;
            }
            else if(_data.conditionList[0].value == 3)
            {
               _title.text = LanguageMgr.GetTranslation("funny.datas.FunnyBagData.title84",_data.conditionList[0].bak);
            }
            _getBtn.y = _title.y + 30;
         }
         if(_hBox)
         {
            _hBox.disposeAllChildren();
         }
         _itemList.beginChanges();
         _loc4_ = 0;
         while(_loc4_ < _data.rewardList.length)
         {
            if(_data.rewardList[_loc4_].temType == 1)
            {
               _loc3_ = ComponentFactory.Instance.creatCustomObject("exchargerankFrame.BaseItemView");
               _loc5_ = new GoodsInfo();
               _loc5_.templateId = _data.rewardList[_loc4_].temId;
               _loc5_.count = _data.rewardList[_loc4_].count;
               _loc5_.showCount = true;
               _loc5_.isBinds = _data.rewardList[_loc4_].isBind;
               _loc5_.strengthenGrade = _data.rewardList[_loc4_].strengthenGrade;
               _loc3_.data = _loc5_;
               _hBox.addChild(_loc3_);
               _loc7_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_data.rewardList[_loc4_].temId);
               if(_loc7_ && _loc7_.Profile >= 5)
               {
                  _loc6_ = ComponentFactory.Instance.creatComponentByStylename("exchargerank.LightEffect");
                  _loc6_.mouseEnabled = false;
                  _loc6_.mouseChildren = false;
                  _loc6_.x = _loc3_.x + 26;
                  _loc6_.y = _loc3_.y + 2;
                  _container.addChild(_loc6_);
               }
            }
            _loc4_++;
         }
         _container.width = _hBox.width;
         _itemList.invalidateViewport(true);
         _itemList.commitChanges();
         setState();
      }
      
      public function setState() : void
      {
         if(_data == null)
         {
            return;
         }
         switch(int(_data.status) - 1)
         {
            case 0:
               _filters.setNormalFilter(this);
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
               _filters.setGrayFilter(this);
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
               _filters.setNormalFilter(this);
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
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         ExchargeRankManager.instance.sendGetBag(2,_data.activeId,_data.id);
         ExchargeRankManager.instance.sendInitBagData(1);
      }
      
      public function dispose() : void
      {
         removeEvent();
         _filters = null;
         ObjectUtils.disposeObject(_itemBg);
         _itemBg = null;
         ObjectUtils.disposeObject(_itemListBg);
         _itemListBg = null;
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_hBox);
         _hBox = null;
         ObjectUtils.disposeObject(_itemList);
         _itemList = null;
         if(_hasGet)
         {
            _hasGet.filters = null;
         }
         ObjectUtils.disposeObject(_hasGet);
         _hasGet = null;
         ObjectUtils.disposeObject(_getBtn);
         _getBtn = null;
         _data = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

