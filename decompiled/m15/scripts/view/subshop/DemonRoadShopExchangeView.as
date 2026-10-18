package view.subshop
{
   import bag.events.BagEvent;
   import com.pickgliss.geom.IntPoint;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.demonroad.DemonRoadRewardMsg;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import managers.IncreasinglyRoadManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.ResolveTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.SimpleDictionary;
   import yishi.view.community.BaseItemView;
   
   public class DemonRoadShopExchangeView extends Sprite
   {
      
      private var _gb1:ScaleBitmapImage;
      
      public var _back:MutipleImage;
      
      public var _cancel:IconButton;
      
      public var _exchangeBtn:IconButton;
      
      private var _playerBagScroll:ScrollPanel;
      
      private var _playerBagTiltList:SimpleTileList;
      
      private var _PlayerBagItemList:Vector.<BaseItemView>;
      
      private var _playerDic:SimpleDictionary = new SimpleDictionary(true);
      
      private var _playerDefaultCount:int = 56;
      
      private var _playerData:Array = [];
      
      private var _exhangeBagScroll:ScrollPanel;
      
      private var _exchangeBagTitleList:SimpleTileList;
      
      private var _exchangeBagItemList:Vector.<BaseItemView>;
      
      private var _exchangeDefaultCount:int = 35;
      
      private var _exchangeData:Array = [];
      
      private var _exchangeDic:SimpleDictionary = new SimpleDictionary(true);
      
      private var _stripView:StripView;
      
      private var _contributeTxt:FilterFrameText;
      
      private var _iconBit:Bitmap;
      
      private const P_BAGTYPE:int = 101;
      
      private const EXCHANGE_BAGTYPE:int = 102;
      
      private var _hasCount:int = 0;
      
      public function DemonRoadShopExchangeView()
      {
         super();
         initView();
         initEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _gb1 = ComponentFactory.Instance.creatComponentByStylename("demonroadshop.back1");
         _back = ComponentFactory.Instance.creatComponentByStylename("ui.demonroadshop.back");
         _cancel = ComponentFactory.Instance.creatComponentByStylename("ui.demonroadshop.cancel");
         _exchangeBtn = ComponentFactory.Instance.creatComponentByStylename("ui.demonroadshop.exchangeBtn");
         _playerBagScroll = ComponentFactory.Instance.creatComponentByStylename("demonroadexchange.playerBagScroll");
         _playerBagTiltList = ComponentFactory.Instance.creatCustomObject("demonroadecchange.playerBagViewList",[7]);
         _exhangeBagScroll = ComponentFactory.Instance.creatComponentByStylename("demonroadexchange.exchangeBagScroll");
         _exchangeBagTitleList = ComponentFactory.Instance.creatCustomObject("demonroadecchange.exchageBagViewList",[7]);
         _stripView = ComponentFactory.Instance.creatCustomObject("demonroadshop.exchangeStripView");
         _contributeTxt = ComponentFactory.Instance.creatComponentByStylename("demonroadexchange.countTxt");
         _iconBit = ComponentFactory.Instance.creatBitmap("asset.demoinroadshop.icon");
         addChild(_gb1);
         addChild(_back);
         addChild(_cancel);
         addChild(_exchangeBtn);
         addChild(_playerBagScroll);
         addChild(_exhangeBagScroll);
         addChild(_iconBit);
         addChild(_stripView);
         addChild(_contributeTxt);
         var _loc1_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(-16000);
         _stripView.setHitArea(0,0,30,27);
         _stripView.tipData = _loc1_.Description;
         _contributeTxt.text = "0";
         _playerBagScroll.setView(_playerBagTiltList);
         _exhangeBagScroll.setView(_exchangeBagTitleList);
         initPlayerBagList();
         initExchangeBagList();
      }
      
      private function initPlayerBagList() : void
      {
         var _loc2_:* = 0;
         var _loc1_:BaseItemView = null;
         _PlayerBagItemList = new Vector.<BaseItemView>();
         _playerBagTiltList.beginChanges();
         _loc2_ = 0;
         while(_loc2_ < _playerDefaultCount)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("store.StoreBagCell");
            _loc1_.pos = -1;
            _playerBagTiltList.addChild(_loc1_);
            _PlayerBagItemList.push(_loc1_);
            _loc2_++;
         }
         _playerBagTiltList.commitChanges();
         _playerBagScroll.invalidateViewport();
      }
      
      private function initExchangeBagList() : void
      {
         var _loc2_:* = 0;
         var _loc1_:BaseItemView = null;
         _exchangeBagItemList = new Vector.<BaseItemView>();
         _exchangeBagTitleList.beginChanges();
         _loc2_ = 0;
         while(_loc2_ < _exchangeDefaultCount)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("store.StoreBagCell");
            _loc1_.pos = -1;
            _exchangeBagTitleList.addChild(_loc1_);
            _exchangeBagItemList.push(_loc1_);
            _loc2_++;
         }
         _exchangeBagTitleList.commitChanges();
         _exhangeBagScroll.invalidateViewport();
      }
      
      private function initEvent() : void
      {
         _exchangeBtn.addEventListener("click",exchangeHandler);
         _cancel.addEventListener("click",cancelHandler);
         GoodsManager.instance.addEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__bagItemDeleteHandler);
         NotificationManager.instance.addEventListener("DOUBLE_CLICK",dataOpHandler);
      }
      
      private function removeEvent() : void
      {
         _exchangeBtn.removeEventListener("click",exchangeHandler);
         _cancel.removeEventListener("click",cancelHandler);
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__bagItemDeleteHandler);
         NotificationManager.instance.removeEventListener("DOUBLE_CLICK",dataOpHandler);
      }
      
      private function dataOpHandler(param1:NotificationEvent) : void
      {
         var _loc2_:BaseItemView = param1.data as BaseItemView;
         var _loc3_:GoodsInfo = _loc2_.data;
         if(_loc2_.bagType == 101)
         {
            addExchange(_loc3_);
         }
         else if(_loc2_.bagType == 102)
         {
            removeExchange(_loc3_);
         }
      }
      
      private function __bagItemUpdateHandler(param1:BagEvent) : void
      {
         var _loc2_:GoodsInfo = param1.info;
      }
      
      private function __bagItemDeleteHandler(param1:BagEvent) : void
      {
         var _loc2_:BaseItemView = null;
         var _loc3_:GoodsInfo = param1.info;
         _loc2_ = _playerDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         if(_loc2_)
         {
            _loc2_.data = null;
         }
      }
      
      private function refreshView() : void
      {
         refreshBag();
         refreshItemView();
      }
      
      private function refreshItemView() : void
      {
         var _loc2_:int = 0;
         var _loc3_:GoodsInfo = null;
         var _loc1_:IntPoint = new IntPoint(0,0);
         _loc2_ = 0;
         while(_loc2_ < _playerData.length)
         {
            _loc3_ = _playerData[_loc2_] as GoodsInfo;
            _PlayerBagItemList[_loc2_].bagType = 101;
            _PlayerBagItemList[_loc2_].pos = _loc3_.pos;
            _PlayerBagItemList[_loc2_].data = _loc3_;
            _playerDic.add(_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType,_PlayerBagItemList[_loc2_]);
            _loc2_++;
         }
         _playerBagScroll.invalidateViewport();
         _playerBagScroll.viewPort.viewPosition = _loc1_;
      }
      
      private function refreshBag() : void
      {
         _playerData = [];
         _playerData = GoodsManager.instance.getDemonRoadShopResloves();
         var _loc2_:int = 7 * Math.ceil(_playerData.length / 7);
         var _loc1_:int = _loc2_ < _playerDefaultCount ? _playerDefaultCount : _loc2_;
         if(_PlayerBagItemList.length < _loc1_)
         {
            addItems(_loc1_ - _PlayerBagItemList.length,1);
         }
      }
      
      private function refreshResolveBag() : void
      {
         var _loc2_:int = 7 * Math.ceil(_exchangeData.length / 7);
         var _loc1_:int = _loc2_ < _exchangeDefaultCount ? _exchangeDefaultCount : _loc2_;
         if(_exchangeBagItemList.length < _loc1_)
         {
            addItems(_loc1_ - _exchangeBagItemList.length,2);
         }
         else if(_exchangeBagItemList.length > _loc1_ && _exchangeBagItemList.length > _exchangeDefaultCount)
         {
            removeItems(_exchangeBagItemList.length - _loc1_,2);
         }
      }
      
      private function addExchangeItemView(param1:GoodsInfo) : void
      {
         var _loc2_:BaseItemView = null;
         var _loc4_:int = 0;
         var _loc3_:int = int(_exchangeBagItemList.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = _exchangeBagItemList[_loc4_];
            if(_loc2_ != null && _loc2_.data == null)
            {
               _loc2_.bagType = 102;
               _loc2_.pos = param1.pos;
               _loc2_.data = param1;
               _exchangeDic.add(param1.pos + "_" + param1.objectId + "_" + param1.bagType,_loc2_);
               _loc2_ = _playerDic[param1.pos + "_" + param1.objectId + "_" + param1.bagType];
               if(_loc2_)
               {
                  _loc2_.data = null;
               }
               break;
            }
            _loc4_++;
         }
         _exhangeBagScroll.invalidateViewport();
      }
      
      private function addItems(param1:int, param2:int) : void
      {
         var _loc3_:BaseItemView = null;
         var _loc4_:int = 0;
         if(param2 == 1)
         {
            _playerBagTiltList.beginChanges();
            _loc4_ = 0;
            while(_loc4_ < param1)
            {
               _loc3_ = ComponentFactory.Instance.creatCustomObject("store.StoreBagCell");
               _loc3_.pos = -1;
               _playerBagTiltList.addChild(_loc3_);
               _PlayerBagItemList.push(_loc3_);
               _loc4_++;
            }
            _playerBagTiltList.commitChanges();
            _playerBagScroll.invalidateViewport();
         }
         else if(param2 == 2)
         {
            _exchangeBagTitleList.beginChanges();
            _loc4_ = 0;
            while(_loc4_ < param1)
            {
               _loc3_ = ComponentFactory.Instance.creatCustomObject("store.StoreBagCell");
               _loc3_.pos = -1;
               _exchangeBagTitleList.addChild(_loc3_);
               _exchangeBagItemList.push(_loc3_);
               _loc4_++;
            }
            _exchangeBagTitleList.commitChanges();
            _exhangeBagScroll.invalidateViewport();
         }
      }
      
      private function removeItems(param1:int, param2:int) : void
      {
         var _loc3_:BaseItemView = null;
         var _loc4_:int = 0;
         if(param2 == 1)
         {
            _playerBagTiltList.beginChanges();
            _loc4_ = 0;
            while(_loc4_ < param1)
            {
               _loc3_ = _PlayerBagItemList.pop();
               _playerBagTiltList.removeChild(_loc3_);
               _loc3_.dispose();
               _loc4_++;
            }
            _playerBagTiltList.commitChanges();
            _playerBagScroll.invalidateViewport();
         }
         else if(param2 == 2)
         {
            _exchangeBagTitleList.beginChanges();
            _loc4_ = 0;
            while(_loc4_ < param1)
            {
               _loc3_ = _exchangeBagItemList.pop();
               _exchangeBagTitleList.removeChild(_loc3_);
               _loc3_.dispose();
               _loc4_++;
            }
            _exchangeBagTitleList.commitChanges();
            _exhangeBagScroll.invalidateViewport();
         }
      }
      
      private function addExchange(param1:GoodsInfo) : void
      {
         if(_exchangeData.indexOf(param1) == -1)
         {
            _exchangeData.push(param1);
            refreshResolveBag();
            addExchangeItemView(param1);
            updateCount(param1,"add");
         }
      }
      
      private function removeExchange(param1:GoodsInfo, param2:Boolean = true) : void
      {
         var _loc3_:BaseItemView = null;
         var _loc4_:int = _exchangeData.indexOf(param1);
         if(_loc4_ != -1)
         {
            _exchangeData.splice(_loc4_,1);
            refreshResolveBag();
            if(param2)
            {
               _loc3_ = _playerDic[param1.pos + "_" + param1.objectId + "_" + param1.bagType];
               if(_loc3_ != null)
               {
                  _loc3_.data = param1;
               }
            }
            _loc3_ = _exchangeDic[param1.pos + "_" + param1.objectId + "_" + param1.bagType];
            if(_loc3_ != null)
            {
               _loc3_.data = null;
            }
            updateCount(param1,"remove");
         }
      }
      
      private function updateCount(param1:GoodsInfo, param2:String) : void
      {
         var _loc3_:ResolveTemplateInfo = null;
         _loc3_ = TempleteManager.instance.resolveTemplateCate.getTemplateByTypeAndTempId(2,param1.templateId);
         if(_loc3_)
         {
            if(param2 == "add")
            {
               _hasCount += param1.count * _loc3_.Count1;
            }
            else if(param2 == "remove")
            {
               _hasCount -= param1.count * _loc3_.Count1;
            }
         }
         _contributeTxt.text = "" + _hasCount;
      }
      
      private function exchangeHandler(param1:MouseEvent) : void
      {
         var _loc4_:GoodsInfo = null;
         var _loc5_:DemonRoadRewardMsg = null;
         var _loc2_:Array = [];
         for each(var _loc3_:BaseItemView in _exchangeBagItemList)
         {
            _loc4_ = _loc3_.data;
            if(_loc4_ != null)
            {
               _loc5_ = new DemonRoadRewardMsg();
               _loc5_.itemTempId = _loc4_.templateId;
               _loc5_.count = _loc4_.count;
               _loc2_.push(_loc5_);
            }
         }
         if(_loc2_.length > 0)
         {
            confirm(_loc2_);
         }
      }
      
      private function confirm(param1:Array) : void
      {
         var _loc2_:String = LanguageMgr.GetTranslation("demonroad.shop.exchangeConfirm",_hasCount);
         SimpleAlertHelper.instance.data = [confirmChoose,param1];
         var _loc3_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc4_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc5_:String = LanguageMgr.GetTranslation("public.prompt");
         SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc2_,_loc3_,_loc4_,true,true);
      }
      
      private function confirmChoose(param1:Boolean, param2:Boolean, param3:Array) : void
      {
         if(param1)
         {
            cancelHandler(null,false);
            IncreasinglyRoadManager.instance.resolveGoods(param3);
         }
      }
      
      private function cancelHandler(param1:MouseEvent = null, param2:Boolean = true) : void
      {
         for each(var _loc3_:BaseItemView in _exchangeBagItemList)
         {
            if(_loc3_.data != null)
            {
               removeExchange(_loc3_.data,param2);
            }
            _loc3_.data = null;
         }
         _hasCount = 0;
         _contributeTxt.text = "" + _hasCount;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_cancel);
         _cancel = null;
         ObjectUtils.disposeObject(_exchangeBtn);
         _exchangeBtn = null;
         for each(var _loc1_:BaseItemView in _PlayerBagItemList)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
         _PlayerBagItemList = null;
         for each(var _loc2_:BaseItemView in _exchangeBagItemList)
         {
            ObjectUtils.disposeObject(_loc2_);
            _loc2_ = null;
         }
         _exchangeBagItemList = null;
         ObjectUtils.disposeObject(_playerBagTiltList);
         _playerBagTiltList = null;
         ObjectUtils.disposeObject(_playerBagScroll);
         _playerBagScroll = null;
         ObjectUtils.disposeObject(_exchangeBagTitleList);
         _exchangeBagTitleList = null;
         ObjectUtils.disposeObject(_exhangeBagScroll);
         _exhangeBagScroll = null;
         ObjectUtils.disposeObject(_gb1);
         _gb1 = null;
         ObjectUtils.disposeObject(_contributeTxt);
         _contributeTxt = null;
         ObjectUtils.disposeObject(_stripView);
         _stripView = null;
         ObjectUtils.disposeObject(_iconBit);
         _iconBit = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

