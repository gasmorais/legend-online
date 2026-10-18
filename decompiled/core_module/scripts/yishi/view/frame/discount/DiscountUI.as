package yishi.view.frame.discount
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.ShopManager;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.view.tips.MessageTipManager;
   
   public class DiscountUI extends Component
   {
      
      private var _vbox:VBox;
      
      private var _scroll:ScrollPanel;
      
      private var _dic:Dictionary;
      
      public var selectedItem:DiscountItem;
      
      private var _goodsSonType:int;
      
      private var _totalPrice:int;
      
      public function DiscountUI(param1:int, param2:int)
      {
         _goodsSonType = param1;
         _totalPrice = param2;
         super();
         loadRes();
      }
      
      private function loadRes() : void
      {
         var _loc1_:String = ComponentSetting.getUISourcePath("quickbuy");
         LoaderManagerII.instance.load(_loc1_,3,0,completeHandler);
      }
      
      private function completeHandler(param1:LoaderInfo, param2:Object) : void
      {
         initUI();
      }
      
      private function initUI() : void
      {
         var _loc1_:DiscountItem = null;
         var _loc2_:DisplayObject = ComponentFactory.Instance.creat("asset.quickbuy.quanBg");
         this.addChild(_loc2_);
         _vbox = new VBox();
         _vbox.spacing = -5;
         _scroll = ComponentFactory.Instance.creatComponentByStylename("quickbuy.discountScrollPanel");
         _scroll.beginChanges();
         _scroll.setView(_vbox);
         _scroll.commitChanges();
         addChild(_scroll);
         _dic = new Dictionary();
         for each(var _loc3_:int in DiscountCons.DISCOUNT_ID_ARR)
         {
            if(_loc3_ >= 3171001)
            {
               if(_goodsSonType == 1 && _loc3_ != 3171001)
               {
                  continue;
               }
               if(_goodsSonType == 2 && _loc3_ != 3172001)
               {
                  continue;
               }
               if(_goodsSonType == 3 && _loc3_ != 3173001)
               {
                  continue;
               }
               if(_goodsSonType == 0)
               {
                  continue;
               }
            }
            if(!(GoodsManager.instance.getBagGoodsByTemplateId(_loc3_).length <= 0 && GoodsManager.instance.getMailGoodsByTemplateId(_loc3_).length <= 0 && GoodsManager.instance.getBottleGoodsByTemplateId(_loc3_).length <= 0))
            {
               _loc1_ = new DiscountItem(_loc3_);
               _vbox.addChild(_loc1_);
               _dic[_loc3_] = _loc1_;
               _loc1_.enable = false;
            }
         }
         _vbox.refreshChildPos();
         _scroll.invalidateViewport();
         checkEnable();
         _vbox.addEventListener("click",vboxClickHandler);
         MsgMan.addObserver("yishi.view.frame.discount.DiscountCons.MSG_EVENT_NUM_CHANGED",this,numChanged);
      }
      
      private function numChanged(param1:String, param2:Object) : void
      {
         _totalPrice = int(param2);
         checkEnable();
      }
      
      private function checkEnable() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         for each(var _loc1_:DiscountItem in _dic)
         {
            _loc2_ = DiscountUtil.getDiscountNumByIdAndPrice(_loc1_.itemId,_totalPrice);
            if(ShopManager.Instance.totalFashionCount <= 1 && _loc2_ > 0 && PlayerManager.instance.currentPlayerModel.playerInfo.point >= _totalPrice - _loc2_)
            {
               if(!_loc1_.enable)
               {
                  _loc1_.enable = true;
                  _vbox.removeChild(_loc1_);
                  if(_loc1_.itemId >= 3171001)
                  {
                     _vbox.addChildAt(_loc1_,0);
                  }
                  else if(_vbox.numChildren > 0 && Boolean(DiscountItem(_vbox.getChildAt(0)).enable))
                  {
                     if(_vbox.numChildren >= 2 && Boolean(DiscountItem(_vbox.getChildAt(1)).enable))
                     {
                        if(_vbox.numChildren >= 3 && Boolean(DiscountItem(_vbox.getChildAt(2)).enable))
                        {
                           _vbox.addChildAt(_loc1_,3);
                        }
                        else
                        {
                           _vbox.addChildAt(_loc1_,2);
                        }
                     }
                     else
                     {
                        _vbox.addChildAt(_loc1_,1);
                     }
                  }
                  else
                  {
                     _vbox.addChildAt(_loc1_,0);
                  }
               }
            }
            else if(_loc1_.enable)
            {
               _loc1_.enable = false;
               if(_loc1_.selectBtn.selected && selectedItem && selectedItem.itemId == _loc1_.itemId)
               {
                  selectedItem = null;
               }
               _loc1_.selectBtn.selected = false;
               _vbox.removeChild(_loc1_);
               if(_loc1_.itemId >= 3171001)
               {
                  _vbox.addChildAt(_loc1_,_vbox.numChildren);
               }
               else if(_vbox.numChildren == 0)
               {
                  _vbox.addChildAt(_loc1_,0);
               }
               else
               {
                  _loc3_ = 0;
                  while(_loc3_ < _vbox.numChildren)
                  {
                     if(!DiscountItem(_vbox.getChildAt(_loc3_)).enable)
                     {
                        if(_loc1_.itemId < DiscountItem(_vbox.getChildAt(_loc3_)).itemId)
                        {
                           _vbox.addChildAt(_loc1_,_loc3_);
                           break;
                        }
                        if(_loc3_ == _vbox.numChildren - 1)
                        {
                           _vbox.addChildAt(_loc1_,_loc3_ + 1);
                           break;
                        }
                     }
                     else if(_loc3_ == _vbox.numChildren - 1)
                     {
                        _vbox.addChildAt(_loc1_,_loc3_ + 1);
                        break;
                     }
                     _loc3_++;
                  }
               }
            }
         }
         _vbox.refreshChildPos();
         _scroll.invalidateViewport();
      }
      
      protected function vboxClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc4_:int = 0;
         if(!(param1.target.parent as DiscountItem))
         {
            return;
         }
         var _loc3_:DiscountItem = param1.target.parent as DiscountItem;
         if(_loc3_.selectBtn.selected)
         {
            if(GoodsManager.instance.getBagGoodsByTemplateId(_loc3_.itemId).length <= 0)
            {
               _loc3_.selectBtn.selected = false;
               _loc2_ = LanguageMgr.GetTranslation("yishi.view.frame.BuyFrameI.hasNoDiscountQuan");
               MessageTipManager.instance().show(_loc2_);
               selectedItem = null;
            }
            else
            {
               _loc4_ = DiscountUtil.getDiscountNumByIdAndPrice(_loc3_.itemId,_totalPrice);
               if(_loc4_ > 0)
               {
                  if(selectedItem)
                  {
                     selectedItem.selectBtn.selected = false;
                  }
                  selectedItem = _loc3_;
               }
               else
               {
                  _loc3_.selectBtn.selected = false;
                  selectedItem = null;
                  _loc2_ = LanguageMgr.GetTranslation("yishi.view.frame.BuyFrameI.notUsableDiscount");
                  MessageTipManager.instance().show(_loc2_);
               }
            }
            MsgMan.notifyObserver("yishi.view.frame.discount.DiscountCons.MSG_EVENT_SELECTED_QUAN",selectedItem);
         }
         else
         {
            selectedItem = null;
            MsgMan.notifyObserver("yishi.view.frame.discount.DiscountCons.MSG_EVENT_SELECTED_QUAN",selectedItem);
         }
      }
      
      public function getDiscountNum(param1:int) : int
      {
         var _loc3_:int = 0;
         var _loc7_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:ConfigInfosTempInfo = null;
         var _loc2_:Array = null;
         var _loc6_:int = 0;
         for(var _loc8_:String in _dic)
         {
            _loc7_ = parseInt(_loc8_);
            _loc4_ = DiscountCons.DISCOUNT_ID_ARR.indexOf(_loc7_);
            if(_loc4_ == -1)
            {
               return 0;
            }
            _loc5_ = TempleteManager.instance.getConfigInfoByConfigName(DiscountCons.TEMPLATE_CONFIG_NAMES[_loc4_]);
            _loc2_ = _loc5_.ConfigValue.split("|");
            if(_loc2_.length == 1)
            {
               if(param1 >= _loc2_[0].split(",")[0])
               {
                  if(_loc2_[0].split(",")[1] > _loc3_)
                  {
                     _loc3_ = int(_loc2_[0].split(",")[1]);
                  }
               }
            }
            else if(_loc2_.length > 1)
            {
               _loc6_ = _loc2_.length - 1;
               while(_loc6_ >= 0)
               {
                  if(param1 >= _loc2_[_loc6_].split(",")[0])
                  {
                     if(_loc2_[_loc6_].split(",")[1] > _loc3_)
                     {
                        _loc3_ = int(_loc2_[_loc6_].split(",")[1]);
                     }
                  }
                  _loc6_--;
               }
            }
         }
         return _loc3_;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _vbox.removeEventListener("click",vboxClickHandler);
         MsgMan.removeObserver("yishi.view.frame.discount.DiscountCons.MSG_EVENT_NUM_CHANGED",this,numChanged);
      }
   }
}

