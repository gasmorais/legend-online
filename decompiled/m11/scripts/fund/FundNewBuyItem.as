package fund
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import managers.FundManager;
   import mvc.module.fund.ActiveParmaInfo;
   import mvc.module.fund.FundInfo;
   import mvc.module.fund.GItemInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.RechargeAlertMannager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseItemView;
   import yishi.view.component.MovieButton;
   
   public class FundNewBuyItem extends Component
   {
      
      private var _iconBg:ScaleFrameImage;
      
      private var _getBag1Txt:FilterFrameText;
      
      private var _getBag2Txt:FilterFrameText;
      
      private var _preBtnA:IconButton;
      
      private var _nextBtnA:IconButton;
      
      private var _preBtnB:IconButton;
      
      private var _nextBtnB:IconButton;
      
      private var _hboxA:HBox;
      
      private var _hboxB:HBox;
      
      private var _chargeBg:Bitmap;
      
      private var _costdiamondTxt:FilterFrameText;
      
      private var _diamondBg:Bitmap;
      
      private var _costContractTxt:FilterFrameText;
      
      private var _contractBg:Bitmap;
      
      private var _data:ActiveParmaInfo;
      
      private var _model:FundInfo;
      
      private var _currentPageA:int;
      
      private var _currentPageB:int;
      
      private var _totoalPageA:int;
      
      private var _totoalPageB:int;
      
      private var _arrayA:Array = [];
      
      private var _arrayB:Array = [];
      
      private var _containerA:Component;
      
      private var _containerB:Component;
      
      private var _mBtn:MovieButton;
      
      private var _iconPoint:Point;
      
      public function FundNewBuyItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _iconBg = ComponentFactory.Instance.creatComponentByStylename("fundnewbuy.iconBg");
         _getBag1Txt = ComponentFactory.Instance.creatComponentByStylename("fundnewbuy.getBag1Txt");
         _getBag2Txt = ComponentFactory.Instance.creatComponentByStylename("fundnewbuy.getBag2Txt");
         _preBtnA = ComponentFactory.Instance.creatComponentByStylename("fundnewbuy.preBtn");
         _nextBtnA = ComponentFactory.Instance.creatComponentByStylename("fundnewbuy.nextBtn");
         _preBtnB = ComponentFactory.Instance.creatComponentByStylename("fundnewbuy.preBtn");
         _nextBtnB = ComponentFactory.Instance.creatComponentByStylename("fundnewbuy.nextBtn");
         _hboxA = ComponentFactory.Instance.creatComponentByStylename("fundnewbuy.hbox1");
         _hboxB = ComponentFactory.Instance.creatComponentByStylename("fundnewbuy.hbox2");
         _chargeBg = ComponentFactory.Instance.creatBitmap("asset.fundnew.chargeBg");
         _costdiamondTxt = ComponentFactory.Instance.creatComponentByStylename("fundnewbuy.costdiamondTxt");
         _diamondBg = ComponentFactory.Instance.creatBitmap("asset.core.SmallPointImg");
         _costContractTxt = ComponentFactory.Instance.creatComponentByStylename("fundnewbuy.costContractTxt");
         _contractBg = ComponentFactory.Instance.creatBitmap("asset.fund.deed");
         _containerA = new Component();
         _containerB = new Component();
         _containerA.x = 140;
         _containerA.y = 12;
         _containerB.x = 375;
         _containerB.y = 12;
         addChild(_iconBg);
         addChild(_getBag1Txt);
         addChild(_getBag2Txt);
         addChild(_preBtnA);
         addChild(_nextBtnA);
         _preBtnA.x = 120;
         _nextBtnA.x = 287;
         addChild(_preBtnB);
         addChild(_nextBtnB);
         addChild(_containerA);
         addChild(_containerB);
         _containerA.addChild(_hboxA);
         _containerB.addChild(_hboxB);
         addChild(_chargeBg);
         addChild(_costdiamondTxt);
         addChild(_diamondBg);
         addChild(_costContractTxt);
         addChild(_contractBg);
         _diamondBg.x = 688;
         _diamondBg.y = 28;
         _contractBg.x = 695;
         _contractBg.y = 8;
         _getBag1Txt.text = LanguageMgr.GetTranslation("funny.view.FunnyDoubleBagItem.giftLable01");
         _getBag2Txt.text = LanguageMgr.GetTranslation("funny.view.FunnyDoubleBagItem.giftLable02");
         _costContractTxt.visible = _contractBg.visible = _preBtnB.visible = _nextBtnB.visible = false;
         _preBtnA.visible = _nextBtnA.visible = false;
         _hboxB.width = 195;
      }
      
      private function uninitView() : void
      {
         if(_iconBg)
         {
            ObjectUtils.disposeObject(_iconBg);
         }
         _iconBg = null;
         if(_getBag1Txt)
         {
            ObjectUtils.disposeObject(_getBag1Txt);
         }
         _getBag1Txt = null;
         if(_getBag2Txt)
         {
            ObjectUtils.disposeObject(_getBag2Txt);
         }
         _getBag2Txt = null;
         if(_preBtnA)
         {
            ObjectUtils.disposeObject(_preBtnA);
         }
         _preBtnA = null;
         if(_nextBtnA)
         {
            ObjectUtils.disposeObject(_nextBtnA);
         }
         _nextBtnA = null;
         if(_preBtnB)
         {
            ObjectUtils.disposeObject(_preBtnB);
         }
         _preBtnB = null;
         if(_nextBtnB)
         {
            ObjectUtils.disposeObject(_nextBtnB);
         }
         _nextBtnB = null;
         if(_containerA)
         {
            ObjectUtils.disposeObject(_containerA);
         }
         _containerA = null;
         if(_containerB)
         {
            ObjectUtils.disposeObject(_containerB);
         }
         _containerB = null;
         if(_chargeBg)
         {
            ObjectUtils.disposeObject(_chargeBg);
         }
         _chargeBg = null;
         if(_costdiamondTxt)
         {
            ObjectUtils.disposeObject(_costdiamondTxt);
         }
         _costdiamondTxt = null;
         if(_diamondBg)
         {
            ObjectUtils.disposeObject(_diamondBg);
         }
         _diamondBg = null;
         if(_costContractTxt)
         {
            ObjectUtils.disposeObject(_costContractTxt);
         }
         _costContractTxt = null;
         if(_contractBg)
         {
            ObjectUtils.disposeObject(_contractBg);
         }
         _contractBg = null;
      }
      
      private function initEvent() : void
      {
         if(_preBtnA)
         {
            _preBtnA.addEventListener("click",_preBtnHandler);
         }
         if(_nextBtnA)
         {
            _nextBtnA.addEventListener("click",_nextBtnHandler);
         }
         if(_preBtnB)
         {
            _preBtnB.addEventListener("click",_preBtnHandler);
         }
         if(_nextBtnB)
         {
            _nextBtnB.addEventListener("click",_nextBtnHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_preBtnA)
         {
            _preBtnA.removeEventListener("click",_preBtnHandler);
         }
         if(_nextBtnA)
         {
            _nextBtnA.removeEventListener("click",_nextBtnHandler);
         }
         if(_preBtnB)
         {
            _preBtnB.removeEventListener("click",_preBtnHandler);
         }
         if(_nextBtnB)
         {
            _nextBtnB.removeEventListener("click",_nextBtnHandler);
         }
      }
      
      private function _preBtnHandler(param1:MouseEvent) : void
      {
         if(param1.target == _preBtnB)
         {
            _currentPageB = _currentPageB - 1;
            refreshBox(true);
         }
         else if(param1.target == _preBtnA)
         {
            _currentPageA = _currentPageA - 1;
            refreshBox(false);
         }
      }
      
      private function _nextBtnHandler(param1:MouseEvent) : void
      {
         if(param1.target == _nextBtnB)
         {
            _currentPageB = _currentPageB + 1;
            refreshBox(true);
         }
         else if(param1.target == _nextBtnA)
         {
            _currentPageA = _currentPageA + 1;
            refreshBox(false);
         }
      }
      
      private function refreshBox(param1:Boolean) : void
      {
         updateBtnState(param1);
         refreshHboxData(param1);
      }
      
      private function updateBtnState(param1:Boolean) : void
      {
         if(param1)
         {
            _preBtnB.enable = _currentPageB > 1;
            _nextBtnB.enable = _currentPageB < _totoalPageB;
         }
         else
         {
            _preBtnA.enable = _currentPageA > 1;
            _nextBtnA.enable = _currentPageA < _totoalPageA;
         }
      }
      
      private function refreshHboxData(param1:Boolean) : void
      {
         var _loc6_:int = 0;
         var _loc2_:BaseItemView = null;
         var _loc4_:GoodsInfo = null;
         var _loc7_:int = 0;
         var _loc5_:BaseItemView = null;
         var _loc3_:GoodsInfo = null;
         if(param1)
         {
            if(_hboxB)
            {
               _hboxB.disposeAllChildren();
            }
            _loc6_ = (_currentPageB - 1) * 4;
            while(_loc6_ < _currentPageB * 4)
            {
               if(_arrayB.length > _loc6_)
               {
                  _loc2_ = ComponentFactory.Instance.creatCustomObject("fundnew.BaseItemView");
                  _loc4_ = new GoodsInfo();
                  _loc4_.templateId = _arrayB[_loc6_].templateId;
                  _loc4_.count = _arrayB[_loc6_].count;
                  _loc4_.showCount = true;
                  _loc2_.data = _loc4_;
                  if(_hboxB)
                  {
                     _hboxB.addChild(_loc2_);
                  }
               }
               _loc6_++;
            }
         }
         else
         {
            if(_hboxA)
            {
               _hboxA.disposeAllChildren();
            }
            _loc7_ = (_currentPageA - 1) * 3;
            while(_loc7_ < _currentPageA * 3)
            {
               if(_arrayA.length > _loc7_)
               {
                  _loc5_ = ComponentFactory.Instance.creatCustomObject("fundnew.BaseItemView");
                  _loc3_ = new GoodsInfo();
                  _loc3_.templateId = _arrayA[_loc7_].templateId;
                  _loc3_.count = _arrayA[_loc7_].count;
                  _loc3_.showCount = true;
                  _loc5_.data = _loc3_;
                  if(_hboxA)
                  {
                     _hboxA.addChild(_loc5_);
                  }
               }
               _loc7_++;
            }
         }
      }
      
      public function get data() : ActiveParmaInfo
      {
         return _data;
      }
      
      public function set data(param1:ActiveParmaInfo) : void
      {
         if(!param1)
         {
            return;
         }
         _data = param1;
         refreshView();
      }
      
      private function sortByProfile(param1:GItemInfo, param2:GItemInfo) : int
      {
         var _loc3_:GoodsInfo = null;
         var _loc4_:GoodsInfo = null;
         if(!param1 || !param2)
         {
            return 0;
         }
         if(param1.templateId == -400 && param2.templateId != -400)
         {
            return -1;
         }
         if(param1.templateId != -400 && param2.templateId == -400)
         {
            return 1;
         }
         _loc3_ = new GoodsInfo();
         _loc3_.templateId = param1.templateId;
         _loc4_ = new GoodsInfo();
         _loc4_.templateId = param2.templateId;
         if(_loc3_.templateInfo.Profile > _loc4_.templateInfo.Profile)
         {
            return -1;
         }
         if(_loc3_.templateInfo.Profile < _loc4_.templateInfo.Profile)
         {
            return 1;
         }
         return 0;
      }
      
      private function refreshView() : void
      {
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc5_:int = 0;
         var _loc1_:BaseItemView = null;
         var _loc6_:GoodsInfo = null;
         var _loc7_:int = 0;
         var _loc2_:BaseItemView = null;
         var _loc3_:GoodsInfo = null;
         if(_hboxA)
         {
            _hboxA.disposeAllChildren();
         }
         if(_hboxB)
         {
            _hboxB.disposeAllChildren();
         }
         _currentPageA = 1;
         _currentPageB = 1;
         if(_iconBg)
         {
            _iconBg.setFrame(_data.level);
         }
         if(_data.costContract > 0)
         {
            _costContractTxt.visible = _contractBg.visible = true;
            _costContractTxt.text = _data.costContract.toString();
         }
         else
         {
            _costdiamondTxt.x = 646;
            _diamondBg.x = 688;
            _chargeBg.x = 590;
         }
         _costdiamondTxt.text = _data.costDiamond.toString();
         _arrayA = _data.allGetA;
         _arrayB = _data.allGetB;
         _arrayA.sort(sortByProfile);
         _arrayB.sort(sortByProfile);
         _loc8_ = int(_arrayA.length);
         _totoalPageA = Math.ceil(_loc8_ / 3);
         _loc9_ = int(_arrayB.length);
         _totoalPageB = Math.ceil(_loc9_ / 4);
         var _loc4_:int = 0;
         if(_loc8_ > 3)
         {
            _preBtnA.visible = _nextBtnA.visible = true;
            updateBtnState(false);
         }
         if(_loc9_ > 4)
         {
            _preBtnB.visible = _nextBtnB.visible = true;
            updateBtnState(true);
         }
         _loc5_ = 0;
         while(_loc5_ < _loc8_)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("fundnew.BaseItemView");
            _loc6_ = new GoodsInfo();
            _loc6_.templateId = _arrayA[_loc5_].templateId;
            _loc6_.count = _arrayA[_loc5_].count;
            _loc6_.showCount = true;
            _loc1_.data = _loc6_;
            if(_loc4_ < 3)
            {
               _hboxA.addChild(_loc1_);
               _loc4_++;
            }
            _loc5_++;
         }
         _loc4_ = 0;
         _loc7_ = 0;
         while(_loc7_ < _loc9_)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("fundnew.BaseItemView");
            _loc3_ = new GoodsInfo();
            _loc3_.templateId = _arrayB[_loc7_].templateId;
            _loc3_.count = _arrayB[_loc7_].count;
            _loc3_.showCount = true;
            _loc2_.data = _loc3_;
            if(_loc4_ < 4)
            {
               _hboxB.addChild(_loc2_);
               _loc4_++;
            }
            _loc7_++;
         }
         setEffect();
      }
      
      private function setEffect() : void
      {
         var _loc1_:FundInfo = FundManager.instance.model;
         if(_loc1_.isCurrentAchiveInfo(_data))
         {
            if(!_mBtn)
            {
               _mBtn = ComponentFactory.Instance.creatComponentByStylename("toptoolbar.topBtn");
               _mBtn.mouseChildren = _mBtn.mouseEnabled = false;
               _mBtn.x = _iconBg.x - 10;
               _mBtn.y = _iconBg.y - 10;
               _iconPoint = new Point(_iconBg.x,_iconBg.y);
               _iconBg.x = 0;
               _iconBg.y = 0;
               _mBtn.movie.movie["icon"].addChild(_iconBg);
               _mBtn.movie.movie["effect"]["effect_01"].gotoAndPlay(1);
               addChild(_mBtn);
            }
         }
         else if(_mBtn)
         {
            _iconBg.parent.removeChild(_iconBg);
            if(_iconPoint)
            {
               _iconBg.x = _iconPoint.x;
               _iconBg.y = _iconPoint.y;
            }
            else
            {
               _iconBg.x = 6;
               _iconBg.y = 4;
            }
            addChild(_iconBg);
            _mBtn.parent.removeChild(_mBtn);
            _mBtn.movie.movie["effect"]["effect_01"].stop();
            _mBtn.dispose();
            ObjectUtils.disposeAllChildren(_mBtn);
            _mBtn = null;
         }
      }
      
      private function numchange(param1:int) : String
      {
         var _loc2_:String = null;
         var _loc3_:Number = param1 / 10000;
         if(param1 % 10000 == 0)
         {
            if(_loc3_ >= 1)
            {
               _loc2_ = LanguageMgr.GetTranslation("fund.fundItem.payTxt",int(_loc3_));
            }
            else
            {
               _loc2_ = "0";
            }
         }
         else if(_loc3_ >= 1 && _loc3_ < 10)
         {
            _loc2_ = LanguageMgr.GetTranslation("fund.fundItem.payTxt",_loc3_.toFixed(1));
         }
         else if(_loc3_ > 10)
         {
            _loc2_ = LanguageMgr.GetTranslation("fund.fundItem.payTxt",int(_loc3_));
         }
         else
         {
            _loc2_ = param1.toString();
         }
         return _loc2_;
      }
      
      private function _partInBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         SoundManager.instance.play("022");
         var _loc3_:String = "";
         _loc2_ = LanguageMgr.GetTranslation("fund.FundBuyItem.buyPrompt",_data.costDiamond,fundInfo.chargePoint);
         SimpleAlertHelper.instance.data = [payMoneyHandler];
         SimpleAlertHelper.instance.popAlerFrame(LanguageMgr.GetTranslation("public.prompt"),_loc2_,LanguageMgr.GetTranslation("public.confirm"),LanguageMgr.GetTranslation("public.cancel"),true);
      }
      
      private function payMoneyHandler(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:String = null;
         if(param1)
         {
            if(fundInfo.chargePoint < _data.costDiamond)
            {
               _loc3_ = LanguageMgr.GetTranslation("fund.FundBuyItem.charge.alert");
               SimpleAlertHelper.instance.data = [chargeAlertHandler];
               SimpleAlertHelper.instance.popAlerFrame(LanguageMgr.GetTranslation("public.prompt"),_loc3_,LanguageMgr.GetTranslation("public.confirm"),LanguageMgr.GetTranslation("public.cancel"),true);
               return;
            }
            FundManager.instance.fundNewOperate(1,data.level);
         }
      }
      
      private function chargeAlertHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            RechargeAlertMannager.navigateToRechargePage();
         }
      }
      
      private function get fundInfo() : FundInfo
      {
         return FundManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninitView();
         super.dispose();
         ObjectUtils.removeChildAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

