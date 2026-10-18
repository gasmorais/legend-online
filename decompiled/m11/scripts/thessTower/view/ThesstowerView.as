package thessTower.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import mvc.module.theseus.ThessTowerInfo;
   import thessTower.UI.ThesstowerViewUI;
   import utils.LogicUtils;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.datas.templates.ThessTowerTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class ThesstowerView extends ThesstowerViewUI
   {
      
      private var _items:Vector.<ThesstowerCardItem>;
      
      private var _itemGroup:SelectedButtonGroup;
      
      private var MAX_LV:int;
      
      private const PAGE_COUT:int = 4;
      
      private var _normalRewardList:Vector.<BaseItemView>;
      
      private var _popRewardList:Vector.<BaseItemView>;
      
      private var MAX_BUY:int;
      
      private var WEEK_NUM:int;
      
      private var buyPriceArr:Array;
      
      public function ThesstowerView()
      {
         var _loc1_:Array = null;
         super();
         _pupBtn.enableMouseAble = true;
         initItem();
         initEvent();
         var _loc2_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("theseustower_income_addprice");
         if(_loc2_)
         {
            _loc1_ = _loc2_.ConfigValue.split(",");
            MAX_BUY = _loc1_.length;
            buyPriceArr = _loc1_;
         }
         WEEK_NUM = TempleteManager.instance.getConfigValue("theseustower_income_week");
         MAX_LV = TempleteManager.instance.thessTowerCate.maxLevel;
         TheseussoulManager.Instance.doTowerParam(0);
      }
      
      private function initItem() : void
      {
         var _loc1_:ThesstowerCardItem = null;
         var _loc3_:int = 0;
         var _loc2_:BaseItemView = null;
         _itemGroup = new SelectedButtonGroup();
         _items = new Vector.<ThesstowerCardItem>();
         _cardItemBox.beginChanges();
         _loc3_ = 0;
         while(_loc3_ < 4)
         {
            _loc1_ = new ThesstowerCardItem();
            _loc1_.state = 0;
            _items.push(_loc1_);
            _cardItemBox.addChild(_loc1_);
            _itemGroup.addSelectItem(_loc1_);
            _loc3_++;
         }
         _cardItemBox.commitChanges();
         _normalRewardList = new Vector.<BaseItemView>();
         _popRewardList = new Vector.<BaseItemView>();
         _loc3_ = 0;
         while(_loc3_ < 10)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("thesstower.nor.BaseItemView");
            _normalRewardList.push(_loc2_);
            _loc2_ = ComponentFactory.Instance.creatCustomObject("thesstower.glv.BaseItemView");
            _popRewardList.push(_loc2_);
            _loc3_++;
         }
      }
      
      private function initEvent() : void
      {
         _pupBtn.addEventListener("click",pupBtnClickHandler,false,10);
         _fightBtn.addEventListener("click",fightHandler);
         _buyBtn.addEventListener("click",buyHandler);
         TheseussoulManager.Instance.addEventListener("EVENT_TOWER",updateHandler);
         _itemGroup.addEventListener("change",selectHandler);
      }
      
      private function removeEvent() : void
      {
         _pupBtn.removeEventListener("click",pupBtnClickHandler);
         _fightBtn.removeEventListener("click",fightHandler);
         _buyBtn.removeEventListener("click",buyHandler);
         TheseussoulManager.Instance.removeEventListener("EVENT_TOWER",updateHandler);
         _itemGroup.removeEventListener("change",selectHandler);
      }
      
      private function selectHandler(param1:Event) : void
      {
         var _loc4_:BaseItemView = null;
         var _loc10_:GoodsInfo = null;
         var _loc11_:Array = null;
         var _loc7_:int = 0;
         var _loc2_:Array = null;
         var _loc9_:Array = null;
         var _loc8_:ThessTowerInfo = TheseussoulManager.Instance.thessTowerInfo;
         var _loc3_:ThesstowerCardItem = _itemGroup.getSelectedItem() as ThesstowerCardItem;
         if(_loc3_.idxNum == _loc8_.passLevel)
         {
            _pupBtn.enable = true;
            _fightBtn.enable = false;
         }
         else if(_loc3_.idxNum == _loc8_.passLevel + 1)
         {
            _pupBtn.enable = false;
            _fightBtn.enable = true;
         }
         else
         {
            _pupBtn.enable = false;
            _fightBtn.enable = false;
         }
         var _loc5_:Boolean = _loc3_.idxNum <= _loc8_.passLevel;
         _normalHbox.removeAllChild();
         _advanceBox.removeAllChild();
         var _loc6_:ThessTowerTempInfo = TempleteManager.instance.thessTowerCate.getTemplateById(_loc3_.idxNum);
         if(_loc6_)
         {
            _loc11_ = GoodsManager.getGoodListByPramStr(_loc6_.FirstRewards);
            _normalHbox.beginChanges();
            _loc7_ = 0;
            while(_loc7_ < _loc11_.length)
            {
               _loc4_ = _normalRewardList[_loc7_];
               _loc10_ = _loc11_[_loc7_];
               _loc10_.showHasGet = _loc5_;
               _loc4_.data = _loc10_;
               _normalHbox.addChild(_loc4_);
               _loc7_++;
            }
            _normalHbox.commitChanges();
            _loc2_ = GoodsManager.getGoodListByPramStr(_loc6_.SweepRewards);
            _loc9_ = GoodsManager.getGoodListByPramStr(_loc6_.SweepRandom);
            _loc7_ = 0;
            while(_loc7_ < _loc9_.length)
            {
               _loc10_ = _loc9_[_loc7_];
               _loc10_.showHasGet = true;
               _loc7_++;
            }
            _loc2_ = _loc2_.concat(_loc9_);
            _advanceBox.beginChanges();
            _loc7_ = 0;
            while(_loc7_ < _loc2_.length)
            {
               _loc10_ = _loc2_[_loc7_];
               _loc4_ = _popRewardList[_loc7_];
               _loc4_.data = _loc10_;
               _advanceBox.addChild(_loc4_);
               _loc7_++;
            }
            _advanceBox.commitChanges();
         }
      }
      
      private function updateHandler(param1:NotificationEvent) : void
      {
         var _loc3_:ThesstowerCardItem = null;
         var _loc5_:int = 0;
         var _loc2_:int = int(param1.data);
         var _loc6_:ThessTowerInfo = TheseussoulManager.Instance.thessTowerInfo;
         var _loc7_:int = (_loc6_.passLevel - 1) / (4 - 1);
         var _loc8_:int = (4 - 1) * _loc7_ + 1;
         _loc5_ = 0;
         while(_loc5_ < 4)
         {
            _loc3_ = _items[_loc5_];
            _loc3_.idxNum = _loc8_ + _loc5_;
            if(_loc8_ + _loc5_ <= _loc6_.passLevel)
            {
               _loc3_.state = 2;
               if(_loc6_.passLevel == MAX_LV)
               {
                  if(!(_loc2_ == 2 || _loc2_ == 3))
                  {
                     _itemGroup.selectIndex = _loc5_;
                  }
               }
            }
            else if(_loc8_ + _loc5_ == _loc6_.passLevel + 1)
            {
               _loc3_.state = 1;
               if(!(_loc2_ == 2 || _loc2_ == 3))
               {
                  if(_loc8_ + _loc5_ <= MAX_LV)
                  {
                     _itemGroup.selectIndex = _loc5_;
                  }
               }
            }
            else
            {
               _loc3_.state = 0;
            }
            if(_loc8_ + _loc5_ > MAX_LV)
            {
               _loc3_.visible = false;
            }
            else
            {
               _loc3_.visible = true;
            }
            _loc5_++;
         }
         var _loc4_:int = int(_loc6_.normalTime);
         if(_loc4_ <= 0)
         {
            _buyTxt.htmlText = "<font color=\'#ff0000\'>" + _loc4_ + "</font>/" + WEEK_NUM;
         }
         else
         {
            _buyTxt.text = _loc4_ + "/" + WEEK_NUM;
         }
         _buyTxt1.text = LanguageMgr.GetTranslation("TheseusCollenedBuyTimes",_loc6_.buyTime);
      }
      
      private function pupBtnClickHandler(param1:MouseEvent) : void
      {
         if(!_pupBtn.enable)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("thesstower.pupNeed"));
            return;
         }
         var _loc2_:ThessTowerInfo = TheseussoulManager.Instance.thessTowerInfo;
         if(_loc2_.normalTime + _loc2_.buyTime > 0)
         {
            TheseussoulManager.Instance.doTowerParam(2);
         }
         else
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("thesstower.reward.noTime"));
         }
      }
      
      private function fightHandler(param1:MouseEvent) : void
      {
         var _loc2_:ThessTowerInfo = TheseussoulManager.Instance.thessTowerInfo;
         if(_loc2_.normalTime + _loc2_.buyTime > 0)
         {
            TheseussoulManager.Instance.doTowerParam(1);
         }
         else
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("thesstower.reward.noTime"));
         }
      }
      
      private function buyHandler(param1:MouseEvent) : void
      {
         var _loc8_:ThessTowerInfo = TheseussoulManager.Instance.thessTowerInfo;
         if(_loc8_.hasBuyTime >= MAX_BUY)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("thesstower.buyMax"));
            return;
         }
         var _loc2_:int = int(buyPriceArr[_loc8_.hasBuyTime]);
         if(PlayerManager.instance.currentPlayerModel.playerInfo.point < _loc2_)
         {
            RechargeAlertMannager.show();
            return;
         }
         SimpleAlertHelper.instance.data = [checkForUsePetExpBookBack,_loc8_];
         var _loc7_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc4_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc9_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc3_:String = LanguageMgr.GetTranslation("thesstower.buy.type1");
         var _loc5_:int = Math.max(MAX_BUY - _loc8_.hasBuyTime,0);
         var _loc6_:String = LanguageMgr.GetTranslation("thesstower.buy.tip",_loc2_,_loc3_,_loc5_ <= 0 ? "ff0000" : "FFEFBD",_loc5_,MAX_BUY);
         SimpleAlertHelper.instance.popAlerFrame(_loc9_,_loc6_,_loc7_,_loc4_,true,true,true);
      }
      
      private function checkForUsePetExpBookBack(param1:Boolean, param2:Boolean, param3:ThessTowerInfo) : void
      {
         if(param1)
         {
            TheseussoulManager.Instance.doTowerParam(3);
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_itemGroup);
         _itemGroup = null;
         LogicUtils.disposeDisplayCollection(_items);
         _items = null;
         LogicUtils.disposeDisplayCollection(_normalRewardList);
         _normalRewardList = null;
         LogicUtils.disposeDisplayCollection(_popRewardList);
         _popRewardList = null;
         super.dispose();
      }
   }
}

