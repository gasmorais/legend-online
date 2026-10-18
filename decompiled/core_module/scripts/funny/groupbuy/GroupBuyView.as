package funny.groupbuy
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.shop.BuyInfo;
   import com.road.yishi.proto.shop.GrouponShopMsg;
   import com.road.yishi.proto.shop.ShopMsg;
   import com.road.yishi.proto.vip.VipRouletteMsg;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.getTimer;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import managers.ShopManager;
   import mvc.controler.FunnyControler;
   import mvc.module.shop.MainShopInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   import yishi.timer.TimerTicker;
   import yishi.utils.DateFormatter;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseItemView;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class GroupBuyView extends Component
   {
      
      private var _bg:MovieClip;
      
      private var _oldPriceTxt:FilterFrameText;
      
      private var _rengouOverTxt:FilterFrameText;
      
      private var _jingbaojiaC:Sprite;
      
      private var _quanfuBuyC:Sprite;
      
      private var _jianzuanC:Sprite;
      
      private var _dazheC:Sprite;
      
      private var _yirengouMy:GradientText;
      
      private var _gonghuafeiMy:GradientText;
      
      private var _btnRengou:IconButton;
      
      private var _btnJiesuan:IconButton;
      
      private var _btnZhuanpan:IconButton;
      
      private var _smallZuanshi:Bitmap;
      
      private var _xiantiao:Bitmap;
      
      private var _zizuanshi:Bitmap;
      
      private var _zijian:Bitmap;
      
      private var _zijianBig:Bitmap;
      
      private var _progressBar:GroupBuyProgressBar;
      
      private var _data:GroupBuyInfo;
      
      private var _timer:TimerTicker;
      
      private var _checkTips:StripView;
      
      private var _tempItem:BaseItemView;
      
      private var _helpBtn:BaseButton;
      
      private var _loadCount:int = 0;
      
      private var _clickTime:int = 0;
      
      private var _oldPrice:int;
      
      public function GroupBuyView()
      {
         super();
         initUI();
         addEvents();
      }
      
      private function addEvents() : void
      {
         _btnRengou.addEventListener("click",rengouHandler);
         _helpBtn.addEventListener("click",__clickHelpHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4559,updateDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4560,checkResultHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 338,zhuanpanResultHandler);
      }
      
      protected function __clickHelpHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("core.groupbuy.HelpFrame");
         _loc2_["show"]();
      }
      
      protected function checkResultHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:GrouponShopMsg = new GrouponShopMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as GrouponShopMsg;
         var _loc4_:CheckView = new CheckView(_loc2_.buyCount,_loc2_.totalPoint,_loc2_.param1);
         _loc4_.show();
         if(_data)
         {
            _data.isCheck = true;
            _btnJiesuan.enable = false;
            _gonghuafeiMy.text = String(_loc2_.totalPoint);
         }
      }
      
      protected function updateDataHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:GrouponShopMsg = new GrouponShopMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as GrouponShopMsg;
         var _loc4_:MainShopInfo = ShopManager.Instance.getMainShopInfoById(_loc2_.goodId);
         if(_data == null)
         {
            _data = new GroupBuyInfo();
         }
         _data.allServerBuyNum = _loc4_.currentCount;
         _data.buyEndTime = _loc4_.endDate;
         _data.checkEndTime = _loc4_.sendDate;
         _data.oldPrice = _loc4_.price;
         _data.url = _loc4_.url;
         _data.content = _loc4_.content;
         _data.templateId = _loc4_.templateId;
         _data.isGift = _loc4_.isGift;
         _data.names = _loc4_.names;
         _data.oneDayNum = _loc4_.oneDayCount;
         _data.maxCount = _loc4_.maxCount;
         _data.goodsNum = _loc4_.counts;
         _data.goodsId = _loc2_.goodId;
         _data.totalPay = _loc2_.totalPoint;
         _data.allServerBuyNum = _loc2_.curCount;
         _data.alreadyBuyNum = _loc2_.buyCount;
         _data.currentJingbaojia = _loc2_.curPrice;
         _data.currentBuyNumMy = _loc2_.count;
         _data.isCheck = _loc2_.isReward;
         _data.frontMoney = _loc2_.frontMoney;
         updateNum(_data);
         timeTick();
      }
      
      private function timeTick() : void
      {
         if(_timer == null)
         {
            _timer = new TimerTicker(1000);
            _timer.addEventListener("timer",timeHandler);
            _timer.start();
         }
         timeHandler(null);
      }
      
      protected function timeHandler(param1:TimerEvent) : void
      {
         var _loc4_:String = null;
         var _loc3_:Number = _data.buyEndTime - PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond;
         var _loc2_:Object = {};
         if(_loc3_ >= 60)
         {
            _loc2_.checkTime = DateFormatter.getFullTimeString(_loc3_);
         }
         else
         {
            _loc2_.checkTime = LanguageMgr.GetTranslation("funny.groupbuy.buyRestTimeSecond",_loc3_);
         }
         _checkTips.tipData = _loc2_;
         if(_loc3_ > 0)
         {
            _btnRengou.visible = true;
            _yirengouMy.visible = true;
            _gonghuafeiMy.visible = true;
            _bg.yirengouimg.visible = true;
            _bg.gonghuafeiimg.visible = true;
            _zijian.visible = true;
            _zizuanshi.visible = true;
            _checkTips.visible = true;
            if(_loc3_ >= 60)
            {
               _rengouOverTxt.text = LanguageMgr.GetTranslation("funny.groupbuy.buyRestTime",DateFormatter.getFullTimeString(_loc3_));
            }
            else
            {
               _loc4_ = LanguageMgr.GetTranslation("funny.groupbuy.buyRestTimeSecond",_loc3_);
               _rengouOverTxt.text = LanguageMgr.GetTranslation("funny.groupbuy.buyRestTime",_loc4_);
            }
            if(_btnJiesuan != null)
            {
               _btnJiesuan.visible = false;
            }
         }
         else if(_loc3_ <= 0)
         {
            _loc3_ = _data.checkEndTime - PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond;
            if(_loc3_ > 0)
            {
               initBtnJiesuan();
               _btnRengou.visible = false;
               _yirengouMy.visible = true;
               _gonghuafeiMy.visible = true;
               _bg.yirengouimg.visible = true;
               _bg.gonghuafeiimg.visible = true;
               _zijian.visible = true;
               _zizuanshi.visible = true;
               _checkTips.visible = false;
               if(_loc3_ >= 60)
               {
                  _rengouOverTxt.text = LanguageMgr.GetTranslation("funny.groupbuy.checkRestTime",DateFormatter.getFullTimeString(_loc3_));
               }
               else
               {
                  _loc4_ = LanguageMgr.GetTranslation("funny.groupbuy.buyRestTimeSecond",_loc3_);
                  _rengouOverTxt.text = LanguageMgr.GetTranslation("funny.groupbuy.checkRestTime",_loc4_);
               }
            }
            else
            {
               _rengouOverTxt.text = LanguageMgr.GetTranslation("funny.groupbuy.checkOver");
               _timer.stop();
               _timer.removeEventListener("timer",timeHandler);
               _timer = null;
            }
         }
      }
      
      protected function rengouHandler(param1:MouseEvent) : void
      {
         if(_data)
         {
            if(_data.allServerBuyNum >= _data.maxCount)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("funny.groupbuy.error2"));
               return;
            }
            if(_data.currentBuyNumMy >= _data.oneDayNum)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("funny.groupbuy.error1",_data.oneDayNum));
               return;
            }
         }
         if(_data.frontMoney > PlayerManager.instance.currentPlayerModel.playerInfo.point)
         {
            RechargeAlertMannager.show();
            return;
         }
         var _loc2_:ZuanshiView = new ZuanshiView(_data.frontMoney,confirmBuy);
         _loc2_.show();
      }
      
      private function confirmBuy() : void
      {
         var _loc2_:PackageOut = null;
         _loc2_ = new PackageOut(8645);
         var _loc1_:ShopMsg = new ShopMsg();
         _loc1_.payType = 1;
         _loc1_.buyInfo = new BuyInfo();
         _loc1_.buyInfo.goodId = _data.goodsId;
         _loc1_.buyInfo.count = 1;
         SocketManager.instance.socket.sendProtobuffer(_loc2_,_loc1_);
      }
      
      private function removeEvents() : void
      {
         _btnRengou.removeEventListener("click",rengouHandler);
         _helpBtn.removeEventListener("click",__clickHelpHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4559,updateDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4560,checkResultHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 338,zhuanpanResultHandler);
      }
      
      private function initUI() : void
      {
         _bg = ComponentFactory.Instance.creatCustomObject("groupbuy.bgMC");
         this.addChild(_bg);
         _progressBar = new GroupBuyProgressBar();
         _progressBar.x = 40;
         _progressBar.y = 227;
         this.addChild(_progressBar);
         _tempItem = ComponentFactory.Instance.creatCustomObject("groupbuy.BaseItemView");
         this.addChild(_tempItem);
         _oldPriceTxt = ComponentFactory.Instance.creatComponentByStylename("groupbuy.oldpricetxt");
         _smallZuanshi = ComponentFactory.Instance.creatBitmap("asset.core.SmallPointImg");
         _xiantiao = ComponentFactory.Instance.creatBitmap("asset.groupbuy.xiantiao");
         _jingbaojiaC = ComponentFactory.Instance.creatCustomObject("groupbuy.jingbaojiaC");
         this.addChild(_jingbaojiaC);
         _quanfuBuyC = ComponentFactory.Instance.creatCustomObject("groupbuy.quanfubuyC");
         this.addChild(_quanfuBuyC);
         _dazheC = ComponentFactory.Instance.creatCustomObject("groupbuy.dazheC");
         this.addChild(_dazheC);
         _yirengouMy = ComponentFactory.Instance.creatComponentByStylename("groupbuy.mineYirengouNum");
         this.addChild(_yirengouMy);
         _zizuanshi = ComponentFactory.Instance.creatBitmap("asset.groupbuy.zizuanshismall");
         this.addChild(_zizuanshi);
         _gonghuafeiMy = ComponentFactory.Instance.creatComponentByStylename("groupbuy.mineGonghuafeiNum");
         this.addChild(_gonghuafeiMy);
         _zijian = ComponentFactory.Instance.creatBitmap("asset.groupbuy.zijiansmall");
         this.addChild(_zijian);
         _zijianBig = ComponentFactory.Instance.creatBitmap("asset.groupbuy.zijianbig");
         this.addChild(_zijianBig);
         _zijianBig.y = 161;
         _btnRengou = ComponentFactory.Instance.creatComponentByStylename("groupbuy.btnRengou");
         this.addChild(_btnRengou);
         _rengouOverTxt = ComponentFactory.Instance.creatComponentByStylename("groupbuy.rengouovertxt");
         this.addChild(_rengouOverTxt);
         _checkTips = ComponentFactory.Instance.creatCustomObject("groupbuy.checktips");
         _checkTips.setHitArea(0,0,91,21);
         addChild(_checkTips);
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("groupbuy.helpbtn");
         addChild(_helpBtn);
         _helpBtn.tipData = LanguageMgr.GetTranslation("funny.groupbuy.helptips");
         _btnZhuanpan = ComponentFactory.Instance.creatComponentByStylename("groupbuy.btnZhuanpan");
         _btnZhuanpan.tipData = LanguageMgr.GetTranslation("funny.groupbuy.zhuanpanTips");
         _btnZhuanpan.addEventListener("click",zhuanpanHandler);
         this.addChild(_btnZhuanpan);
      }
      
      private function initBtnJiesuan() : void
      {
         if(_btnJiesuan != null)
         {
            _btnJiesuan.visible = true;
            if(_data)
            {
               if(_data.isCheck)
               {
                  _btnJiesuan.enable = false;
               }
               else
               {
                  _btnJiesuan.enable = true;
               }
            }
            return;
         }
         _btnJiesuan = ComponentFactory.Instance.creatComponentByStylename("groupbuy.btnJiesuan");
         this.addChild(_btnJiesuan);
         _btnJiesuan.addEventListener("click",jiesuanHandler);
         _btnJiesuan.visible = true;
         if(_data)
         {
            if(_data.isCheck)
            {
               _btnJiesuan.enable = false;
            }
            else
            {
               _btnJiesuan.enable = true;
            }
         }
      }
      
      protected function jiesuanHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         if(!_data)
         {
            return;
         }
         SoundManager.instance.play("022");
         var _loc5_:int = int(_data.isCheck ? _data.alreadyBuyNum * _data.currentJingbaojia : _data.totalPay);
         var _loc4_:int = _data.alreadyBuyNum * _data.currentJingbaojia - _loc5_;
         if(_data.alreadyBuyNum <= 0)
         {
            SimpleAlertHelper.instance.data = [];
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc6_ = LanguageMgr.GetTranslation("public.prompt");
            _loc7_ = LanguageMgr.GetTranslation("funny.groupbuy.error3");
            SimpleAlertHelper.instance.popAlerFrame(_loc6_,_loc7_,_loc2_,"",true,false,false,2);
         }
         else if(_data.isCheck)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("funny.groupbuy.error4"));
         }
         else if(_loc4_ >= 0)
         {
            if(_loc4_ > PlayerManager.instance.currentPlayerModel.playerInfo.point)
            {
               RechargeAlertMannager.show();
               return;
            }
            SimpleAlertHelper.instance.data = [requestBuyHandler];
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc6_ = LanguageMgr.GetTranslation("public.prompt");
            _loc7_ = LanguageMgr.GetTranslation("funny.groupbuy.buyAlert1",_loc5_,_loc4_);
            SimpleAlertHelper.instance.popAlerFrame(_loc6_,_loc7_,_loc2_,_loc3_,true,false,false,2);
         }
         else if(_loc4_ < 0)
         {
            SimpleAlertHelper.instance.data = [requestBuyHandler];
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc6_ = LanguageMgr.GetTranslation("public.prompt");
            _loc7_ = LanguageMgr.GetTranslation("funny.groupbuy.buyAlert2",_loc5_,Math.abs(_loc4_));
            SimpleAlertHelper.instance.popAlerFrame(_loc6_,_loc7_,_loc2_,_loc3_,true,false,false,2);
         }
      }
      
      private function requestBuyHandler(param1:Boolean = true, param2:Boolean = true) : void
      {
         var _loc4_:PackageOut = null;
         var _loc3_:ShopMsg = null;
         if(param1)
         {
            _btnJiesuan.enable = false;
            _loc4_ = new PackageOut(8645);
            _loc3_ = new ShopMsg();
            _loc3_.payType = 2;
            _loc3_.buyInfo = new BuyInfo();
            _loc3_.buyInfo.goodId = _data.goodsId;
            SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
         }
      }
      
      protected function zhuanpanHandler(param1:MouseEvent) : void
      {
         if(getTimer() - _clickTime < 1000)
         {
            return;
         }
         _clickTime = getTimer();
         SoundManager.instance.play("022");
         _loadCount = 0;
         var _loc2_:String = ComponentSetting.getProjectSourcePath("11.png");
         LoaderManagerII.instance.load(_loc2_,3,8,__onComplete);
         _loc2_ = ComponentSetting.getUISourcePath("dayguide");
         LoaderManagerII.instance.load(_loc2_,3,8,__onComplete);
      }
      
      protected function __onComplete(param1:LoaderInfo, param2:Object) : void
      {
         _loadCount = _loadCount + 1;
         if(_loadCount == 2)
         {
            FrameControllerManager.instance.funnyControler.sendLuckDraw(3);
         }
      }
      
      protected function zhuanpanResultHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:VipRouletteMsg = new VipRouletteMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as VipRouletteMsg;
         FrameControllerManager.instance.funnyControler.luckDrawCount = _loc2_.leftCount;
         FrameControllerManager.instance.openControllerByInfo("funny",FunnyControler.LUCKVIEW,_loc2_.leftItem);
      }
      
      private function setOldPrice(param1:GroupBuyInfo) : void
      {
         _oldPrice = param1.oldPrice;
         _oldPriceTxt.text = LanguageMgr.GetTranslation("funny.view.FunnyHotBuyItem.price1",_oldPrice);
         _smallZuanshi.x = _oldPriceTxt.textWidth + _oldPriceTxt.x + 5;
         _smallZuanshi.y = _oldPriceTxt.y;
         _xiantiao.x = _oldPriceTxt.x;
         _xiantiao.y = _oldPriceTxt.y + 8;
         _xiantiao.width = _oldPriceTxt.textWidth + 25;
      }
      
      private function updateNum(param1:GroupBuyInfo) : void
      {
         var _loc2_:String = null;
         var _loc5_:GoodsTemplateInfo = null;
         var _loc6_:Object = null;
         setOldPrice(param1);
         jingbaojiaSet(param1.currentJingbaojia);
         quanfubuySet(param1.allServerBuyNum);
         var _loc3_:Number = param1.currentJingbaojia / _oldPrice * 10;
         _loc3_ = Number(_loc3_.toFixed(1));
         dazheSet(_loc3_);
         _yirengouMy.text = param1.alreadyBuyNum + "";
         _zijian.x = _yirengouMy.x + _yirengouMy.textWidth + 3;
         _zijian.y = 315;
         _gonghuafeiMy.text = param1.isCheck ? _data.alreadyBuyNum * _data.currentJingbaojia + "" : param1.totalPay + "";
         _zizuanshi.x = _gonghuafeiMy.x + _gonghuafeiMy.textWidth + 3;
         _zizuanshi.y = 339;
         _progressBar.initData(param1.goodsId);
         _progressBar.updateNum(param1.allServerBuyNum);
         var _loc4_:GoodsInfo = new GoodsInfo();
         _loc4_.count = param1.goodsNum;
         if(param1.isGift)
         {
            _tempItem.icon.icon = PathManager.info.REQUEST_PATH + param1.url;
            _loc2_ = param1.content;
            _loc5_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1.templateId);
            if(_loc5_ && _loc5_.SonType == 206)
            {
               _loc2_ += "<br/><font color=\'#00ff00\'>" + _loc5_.Description + "</font>";
            }
            _loc6_ = {
               "name":param1.names,
               "content":_loc2_
            };
            _tempItem.icon.tipData = _loc6_;
            _tempItem.icon.tipStyle = "yishi.view.tips.ShopMainTips";
            _tempItem.setItemText(0);
         }
         else
         {
            _loc4_.templateId = param1.templateId;
            _tempItem.data = _loc4_;
         }
      }
      
      private function dazheSet(param1:Number) : void
      {
         var _loc3_:Bitmap = null;
         ObjectUtils.removeChildAllChildren(_dazheC);
         _loc3_ = ComponentFactory.Instance.creatBitmap("asset.groupbuy.num4");
         var _loc4_:int = 100 - param1 * 10;
         NumberViewUtils.getNumberView(_loc4_,_dazheC,_loc3_.bitmapData,14,18,10,14,".0123456789",1);
         ObjectUtils.disposeObject(_loc3_);
         _loc3_ = null;
         _dazheC.rotation = 10;
         var _loc2_:String = param1 + "";
         if(_loc2_.indexOf(".") == -1)
         {
            if(param1 == 10)
            {
               _dazheC.x = _bg.zhekoubg.x + 13;
               _dazheC.visible = false;
               _bg.zhekoubg.visible = false;
            }
            else
            {
               _dazheC.x = _bg.zhekoubg.x + 20;
               _dazheC.visible = true;
               _bg.zhekoubg.visible = true;
            }
         }
         else
         {
            _dazheC.x = _bg.zhekoubg.x + 20;
            _dazheC.visible = true;
            _bg.zhekoubg.visible = true;
         }
      }
      
      private function quanfubuySet(param1:int) : void
      {
         var _loc2_:Bitmap = null;
         ObjectUtils.removeChildAllChildren(_quanfuBuyC);
         _loc2_ = ComponentFactory.Instance.creatBitmap("asset.groupbuy.num2");
         NumberViewUtils.getNumberView(param1,_quanfuBuyC,_loc2_.bitmapData,18,22,18,18,"0123456789.",1);
         ObjectUtils.disposeObject(_loc2_);
         _loc2_ = null;
         _zijianBig.x = _quanfuBuyC.x + _quanfuBuyC.width;
      }
      
      private function jingbaojiaSet(param1:int) : void
      {
         var _loc2_:Bitmap = null;
         ObjectUtils.removeChildAllChildren(_jingbaojiaC);
         _loc2_ = ComponentFactory.Instance.creatBitmap("asset.groupbuy.num1");
         NumberViewUtils.getNumberView(param1,_jingbaojiaC,_loc2_.bitmapData,22,28,22,22,"0123456789.",1);
         ObjectUtils.disposeObject(_loc2_);
         _loc2_ = null;
         _bg.zuanshibg.x = _jingbaojiaC.x + _jingbaojiaC.width;
         _bg.zhekoubg.x = _jingbaojiaC.x + _jingbaojiaC.width + 42;
      }
      
      override public function dispose() : void
      {
         removeEvents();
         if(_btnJiesuan)
         {
            _btnJiesuan.removeEventListener("click",jiesuanHandler);
            ObjectUtils.disposeObject(_btnJiesuan);
            _btnJiesuan = null;
         }
         if(_btnZhuanpan)
         {
            _btnZhuanpan.removeEventListener("click",zhuanpanHandler);
            ObjectUtils.disposeObject(_btnZhuanpan);
            _btnZhuanpan = null;
         }
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_progressBar);
         _progressBar = null;
         ObjectUtils.disposeObject(_oldPriceTxt);
         _oldPriceTxt = null;
         ObjectUtils.disposeObject(_rengouOverTxt);
         _rengouOverTxt = null;
         ObjectUtils.disposeObject(_jingbaojiaC);
         _jingbaojiaC = null;
         ObjectUtils.disposeObject(_quanfuBuyC);
         _quanfuBuyC = null;
         ObjectUtils.disposeObject(_jianzuanC);
         _jianzuanC = null;
         ObjectUtils.disposeObject(_yirengouMy);
         _yirengouMy = null;
         ObjectUtils.disposeObject(_gonghuafeiMy);
         _gonghuafeiMy = null;
         ObjectUtils.disposeObject(_btnRengou);
         _btnRengou = null;
         ObjectUtils.disposeObject(_zizuanshi);
         _zizuanshi = null;
         ObjectUtils.disposeObject(_zijian);
         _zijian = null;
         ObjectUtils.disposeObject(_dazheC);
         _dazheC = null;
         ObjectUtils.disposeObject(_smallZuanshi);
         _smallZuanshi = null;
         ObjectUtils.disposeObject(_xiantiao);
         _xiantiao = null;
         ObjectUtils.disposeObject(_zijianBig);
         _zijianBig = null;
         ObjectUtils.disposeObject(_checkTips);
         _checkTips = null;
         ObjectUtils.disposeObject(_tempItem);
         _tempItem = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         _data = null;
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",timeHandler);
            _timer = null;
         }
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

