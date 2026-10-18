package vip
{
   import chat.datas.ChatData;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectPool;
   import com.pickgliss.utils.ObjectUtils;
   import events.VIPEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.VIPManager;
   import mvc.module.vip.VIPModel;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseItemView;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class VipBoxFrame extends Frame
   {
      
      private var _bgUpLeft:Bitmap;
      
      private var _bgUpRight:Bitmap;
      
      private var _bgLeft:Bitmap;
      
      private var _bgRight:Bitmap;
      
      private var _bgDownLeft:Bitmap;
      
      private var _bgDownRight:Bitmap;
      
      private var _joyBg:Bitmap;
      
      private var _titleBg:Bitmap;
      
      private var _totalTxtBg:Bitmap;
      
      private var _needTxtBg:Bitmap;
      
      private var _currTxtBg:Bitmap;
      
      private var _needGoldBg:Bitmap;
      
      private var _currGoldBg:Bitmap;
      
      private var _vipBarBg01:Bitmap;
      
      private var _vipBarBg02:Bitmap;
      
      private var _startBtn:IconButton;
      
      private var _refreshBtn:IconButton;
      
      private var _quickBtn:SimpleBitmapButton;
      
      private var _totalTxt:FilterFrameText;
      
      private var _needTxt:FilterFrameText;
      
      private var _currTxt:FilterFrameText;
      
      private var _vipReceiveList:Array;
      
      private var _boxList:Array;
      
      private var _boxListSp:Sprite;
      
      private var _turnControl:VipTurnControl;
      
      private var _boxTempIdList:Array;
      
      private var _smallEffctMC:MovieClip;
      
      private var _residueList:Array = [];
      
      public var _selectCurr:int = -1;
      
      public function VipBoxFrame()
      {
         super();
         initView();
         initViewList();
         initEvent();
         initData();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:BaseItemView = null;
         _titleText = LanguageMgr.GetTranslation("vip.view.VipBoxFrame.title");
         _bgUpLeft = ComponentFactory.Instance.creatBitmap("asset.vip.VipBoxFrameUpBg");
         _bgUpRight = ComponentFactory.Instance.creatBitmap("asset.vip.VipBoxFrameUpBg");
         _bgLeft = ComponentFactory.Instance.creatBitmap("asset.vip.VipBoxFrameBg");
         _bgRight = ComponentFactory.Instance.creatBitmap("asset.vip.VipBoxFrameBg");
         _bgDownLeft = ComponentFactory.Instance.creatBitmap("asset.vip.VipBoxFrameDownBg");
         _bgDownRight = ComponentFactory.Instance.creatBitmap("asset.vip.VipBoxFrameDownBg");
         _titleBg = ComponentFactory.Instance.creatBitmap("asset.vip.VipBoxTitleTxt");
         _joyBg = ComponentFactory.Instance.creatBitmap("asset.vip.VipBoxJoyTxt");
         _totalTxt = ComponentFactory.Instance.creatComponentByStylename("vip.totalTxt");
         _needTxt = ComponentFactory.Instance.creatComponentByStylename("vip.neddTxt");
         _currTxt = ComponentFactory.Instance.creatComponentByStylename("vip.currTxt");
         _startBtn = ComponentFactory.Instance.creatComponentByStylename("vip.startBtn");
         _quickBtn = ComponentFactory.Instance.creatComponentByStylename("vip.quickBtn");
         _refreshBtn = ComponentFactory.Instance.creatComponentByStylename("vip.refreshBtn");
         _smallEffctMC = ComponentFactory.Instance.creatCustomObject("vip.VIPsmallEffctMC");
         _totalTxtBg = ComponentFactory.Instance.creatBitmap("asset.vip.VipNeedGoldTxtBg");
         _needTxtBg = ComponentFactory.Instance.creatBitmap("asset.vip.VipNeedGoldTxtBg");
         _currTxtBg = ComponentFactory.Instance.creatBitmap("asset.vip.VipNeedGoldTxtBg02");
         _needGoldBg = ComponentFactory.Instance.creatBitmap("asset.vip.VipGoldBg");
         _currGoldBg = ComponentFactory.Instance.creatBitmap("asset.vip.VipGoldBg");
         _vipBarBg01 = ComponentFactory.Instance.creatBitmap("asset.vip.VipTitlerBar");
         _vipBarBg02 = ComponentFactory.Instance.creatBitmap("asset.vip.VipTitlerBar");
         addToContent(_bgLeft);
         addToContent(_bgRight);
         _bgRight.x = _bgRight.width * 2;
         _bgRight.scaleX = -1;
         addToContent(_bgUpLeft);
         addToContent(_bgUpRight);
         _bgUpRight.x = _bgUpRight.width * 2;
         _bgUpRight.scaleX = -1;
         addToContent(_bgDownLeft);
         addToContent(_bgDownRight);
         _bgDownRight.x = _bgDownRight.width * 2;
         _bgDownRight.scaleX = -1;
         addToContent(_titleBg);
         addToContent(_joyBg);
         addToContent(_quickBtn);
         addToContent(_startBtn);
         addToContent(_refreshBtn);
         addToContent(_totalTxtBg);
         addToContent(_needTxtBg);
         _needTxtBg.x = 210;
         addToContent(_currTxtBg);
         addToContent(_needGoldBg);
         addToContent(_currGoldBg);
         _currGoldBg.x = 364;
         addToContent(_vipBarBg01);
         addToContent(_vipBarBg02);
         _vipBarBg02.x = 260;
         addToContent(_totalTxt);
         _totalTxt.text = vipModel.rouletteInfo.LeftCount + "";
         addToContent(_needTxt);
         _needTxt.setFrame(1);
         _needTxt.text = vipModel.rouletteInfo.NeedVipItem + "";
         addToContent(_currTxt);
         if(int(_currTxt.text) > 999)
         {
            _currTxt.setFrame(3);
         }
         else
         {
            _currTxt.setFrame(1);
         }
         _currTxt.text = GoodsManager.instance.getCountBySontypeAndBagType(292,1) + "";
         _vipReceiveList = [];
         _loc1_ = 0;
         while(_loc1_ < 8)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("vip.VIPReceiveItem");
            _loc2_.x = 47 * _loc1_ + 9;
            addToContent(_loc2_);
            _vipReceiveList.push(_loc2_);
            _loc1_++;
         }
         addToContent(_smallEffctMC);
         _smallEffctMC.gotoAndStop(1);
         _smallEffctMC.visible = false;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         _startBtn.addEventListener("click",__StartHandler);
         _quickBtn.addEventListener("click",__StartHandler);
         _refreshBtn.addEventListener("click",__StartHandler);
         vipModel.addEventListener("vip_open_box",__refreshHandler);
         vipModel.addEventListener("vipeffctcomplete",__effctComplete);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4415,_openVipRouletteHandler);
      }
      
      private function _openVipRouletteHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc7_:GoodsInfo = null;
         var _loc2_:VipBoxItem = null;
         var _loc4_:int = 0;
         _totalTxt.text = vipModel.rouletteInfo.LeftCount.toString();
         _needTxt.text = vipModel.rouletteInfo.NeedVipItem.toString();
         _currTxt.text = GoodsManager.instance.getCountBySontypeAndBagType(292,1) + "";
         if(vipModel.rouletteInfo.NeedVipItem > GoodsManager.instance.getCountBySontypeAndBagType(292,1))
         {
            _needTxt.setFrame(2);
            _currTxt.setFrame(2);
         }
         else if(int(_currTxt.text) > 999)
         {
            _needTxt.setFrame(1);
            _currTxt.setFrame(3);
         }
         else
         {
            _needTxt.setFrame(1);
            _currTxt.setFrame(1);
         }
         if(vipModel.rouletteInfo.startType == 1)
         {
            _loc3_ = int(vipModel.rouletteInfo.TakedTempList.length);
            if(_loc3_ >= 8)
            {
               _startBtn.enable = _quickBtn.enable = false;
            }
            else
            {
               _startBtn.enable = _quickBtn.enable = true;
            }
            _refreshBtn.enable = true;
            closeButton.enable = true;
            if(_loc3_ > 0)
            {
               _loc5_ = 1;
               while(_loc5_ <= _loc3_)
               {
                  _loc7_ = new GoodsInfo();
                  _loc7_.templateId = vipModel.rouletteInfo.TakedTempList[_loc5_ - 1].tempId;
                  if(vipModel.rouletteInfo.TakedTempList[_loc5_ - 1].count > 1)
                  {
                     _loc7_.count = vipModel.rouletteInfo.TakedTempList[_loc5_ - 1].count;
                  }
                  _vipReceiveList[_loc5_ - 1].data = _loc7_;
                  _loc5_++;
               }
               for each(var _loc6_:int in vipModel.rouletteInfo.OpenIndex)
               {
                  _loc2_ = _boxList[_loc6_] as VipBoxItem;
                  if(_loc2_)
                  {
                     _loc2_.data = -1;
                     _residueList.splice(_residueList.indexOf(_loc2_),1);
                  }
               }
               _selectCurr = -1;
               _turnControl.defaultTurn(_residueList);
            }
            return;
         }
         if(vipModel.rouletteInfo.IsStart)
         {
            _loc4_ = 0;
            while(_loc4_ < _residueList.length)
            {
               if(vipModel.rouletteInfo.OpenIndex[0] == _residueList[_loc4_].Index)
               {
                  _turnControl.turnPlate(_loc4_ + 1);
                  _selectCurr = _loc4_;
                  return;
               }
               _loc4_++;
            }
         }
         else
         {
            _startBtn.enable = _refreshBtn.enable = _quickBtn.enable = true;
            closeButton.enable = true;
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         _startBtn.removeEventListener("click",__StartHandler);
         _quickBtn.removeEventListener("click",__StartHandler);
         _refreshBtn.removeEventListener("click",__StartHandler);
         vipModel.removeEventListener("vip_open_box",__refreshHandler);
         vipModel.removeEventListener("vipeffctcomplete",__effctComplete);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4415,_openVipRouletteHandler);
      }
      
      private function __StartHandler(param1:MouseEvent) : void
      {
         var _loc5_:String = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         if(!vipModel.vipInfo.IsVipAndNoExpirt)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("vip.view.VipBoxFrame.command01"));
            return;
         }
         if(param1.currentTarget == _refreshBtn)
         {
            if(vipModel.rouletteInfo.TakedTempList.length >= 8 || !showRefreshAlert())
            {
               SocketSendManager.instance.sendUseVipMoney();
            }
         }
         else if(param1.currentTarget == _startBtn)
         {
            if(int(_needTxt.text) > int(_currTxt.text))
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("vip.view.VipBoxFrame.command02"));
               return;
            }
            closeButton.enable = false;
            _startBtn.enable = _quickBtn.enable = _refreshBtn.enable = false;
            VIPManager.Instance.senVIPRolette();
         }
         else if(param1.currentTarget == _quickBtn)
         {
            _loc5_ = LanguageMgr.GetTranslation("vip.view.VipBoxFrame.content03");
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc4_ = LanguageMgr.GetTranslation("public.prompt");
            SimpleAlertHelper.instance.data = [_quickStartRolette];
            SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_);
         }
      }
      
      private function _quickStartRolette(param1:Boolean, param2:Boolean) : void
      {
         if(int(_needTxt.text) > int(_currTxt.text))
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("vip.view.VipBoxFrame.command02"));
            return;
         }
         if(param1)
         {
            closeButton.enable = false;
            _startBtn.enable = _quickBtn.enable = _refreshBtn.enable = false;
            VIPManager.Instance.senVIPRolette(1);
         }
      }
      
      private function showRefreshAlert() : Boolean
      {
         var _loc7_:TodayNotAlertFrame = null;
         var _loc6_:String = null;
         var _loc2_:String = null;
         var _loc3_:Date = SharedManager.instance.vipBoxRefreshTipCheckDate;
         var _loc4_:Date = new Date();
         var _loc1_:Boolean = false;
         var _loc5_:Boolean = Boolean(SharedManager.instance.vipBoxRefreshTip);
         if(!_loc5_ || _loc3_.month <= _loc4_.month && _loc3_.date < _loc4_.date)
         {
            _loc1_ = true;
         }
         if(_loc1_)
         {
            _loc7_ = ComponentFactory.Instance.creatComponentByStylename("vip.vipFrameRefreshAlert");
            _loc6_ = LanguageMgr.GetTranslation("vip.VipBoxFrame.RefreshTips");
            _loc2_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc7_.show(_loc6_,_loc2_,showRefreshAlertBack,null,"center");
         }
         return _loc1_;
      }
      
      private function showRefreshAlertBack(param1:Boolean) : void
      {
         SharedManager.instance.vipBoxRefreshTip = param1;
         SharedManager.instance.vipBoxRefreshTipCheckDate = new Date();
         SharedManager.instance.saveVipBoxRefreshTipCheck();
         SocketSendManager.instance.sendUseVipMoney();
      }
      
      private function __effctComplete(param1:VIPEvent) : void
      {
         var _loc3_:GoodsInfo = null;
         var _loc2_:int = int(vipModel.rouletteInfo.TakedTempList.length);
         if(_loc2_ == 8)
         {
            _startBtn.enable = _quickBtn.enable = false;
         }
         else
         {
            _startBtn.enable = _quickBtn.enable = true;
         }
         _refreshBtn.enable = true;
         closeButton.enable = true;
         if(_selectCurr >= 0 && _loc2_ > 0)
         {
            _loc3_ = new GoodsInfo();
            _loc3_.templateId = vipModel.rouletteInfo.TakedTempList[_loc2_ - 1].tempId;
            if(vipModel.rouletteInfo.TakedTempList[_loc2_ - 1].count > 1)
            {
               _loc3_.count = vipModel.rouletteInfo.TakedTempList[_loc2_ - 1].count;
            }
            _vipReceiveList[_loc2_ - 1].data = _loc3_;
            _smallEffctMC.gotoAndPlay(1);
            _smallEffctMC.visible = true;
            _smallEffctMC.x = _vipReceiveList[_loc2_ - 1].x - 2;
            _smallEffctMC.y = _vipReceiveList[_loc2_ - 1].y - 2;
            _residueList.splice(_selectCurr,1);
            _selectCurr = -1;
            _turnControl.defaultTurn(_residueList);
         }
      }
      
      private function __refreshHandler(param1:VIPEvent) : void
      {
         senChatData();
         cleanReceiveList();
         _totalTxt.text = vipModel.rouletteInfo.LeftCount.toString();
         _needTxt.text = vipModel.rouletteInfo.NeedVipItem.toString();
         initData();
         _residueList = _boxList.concat();
         _turnControl.defaultTurn(_residueList);
      }
      
      private function initViewList() : void
      {
         var _loc2_:int = 0;
         var _loc1_:VipBoxItem = null;
         _boxListSp = new Sprite();
         _boxListSp.x = 12;
         _boxListSp.y = 43;
         addToContent(_boxListSp);
         _boxList = [];
         _loc2_ = 0;
         while(_loc2_ < 18)
         {
            _loc1_ = new VipBoxItem();
            _boxListSp.addChild(_loc1_);
            _boxList.push(_loc1_);
            _loc1_.Index = _loc2_;
            if(_loc2_ == 0 || _loc2_ == 1 || _loc2_ == 2 || _loc2_ == 3 || _loc2_ == 4 || _loc2_ == 5)
            {
               _loc1_.x = _loc2_ * 62;
            }
            if(_loc2_ == 6 || _loc2_ == 7 || _loc2_ == 8 || _loc2_ == 9)
            {
               _loc1_.x = 310;
               _loc1_.y = (_loc2_ - 5) * 62;
            }
            if(_loc2_ == 10 || _loc2_ == 11 || _loc2_ == 12 || _loc2_ == 13 || _loc2_ == 14)
            {
               _loc1_.y = 248;
            }
            if(_loc2_ == 10)
            {
               _loc1_.x = 248;
            }
            if(_loc2_ == 11)
            {
               _loc1_.x = 186;
            }
            if(_loc2_ == 12)
            {
               _loc1_.x = 124;
            }
            if(_loc2_ == 13)
            {
               _loc1_.x = 62;
            }
            if(_loc2_ == 14 || _loc2_ == 15 || _loc2_ == 16 || _loc2_ == 17)
            {
               _loc1_.x = 0;
            }
            if(_loc2_ == 15)
            {
               _loc1_.y = 186;
            }
            if(_loc2_ == 16)
            {
               _loc1_.y = 124;
            }
            if(_loc2_ == 17)
            {
               _loc1_.y = 62;
            }
            _loc2_++;
         }
         _residueList = _residueList.concat(_boxList);
         _turnControl = new VipTurnControl();
         _turnControl.defaultTurn(_boxList);
      }
      
      private function initData() : void
      {
         var _loc1_:int = 0;
         _boxTempIdList = vipModel.rouletteInfo.BoxTempIdList;
         _loc1_ = 0;
         while(_loc1_ < _boxList.length)
         {
            _boxList[_loc1_].data = _boxTempIdList[_loc1_].tempId;
            _boxList[_loc1_].count = _boxTempIdList[_loc1_].count;
            _loc1_++;
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               __AlertVipHandler();
         }
      }
      
      private function __AlertVipHandler() : void
      {
         var _loc4_:String = LanguageMgr.GetTranslation("vip.view.VipBoxFrame.content02");
         SimpleAlertHelper.instance.data = [_confirmFun];
         var _loc1_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc3_:String = LanguageMgr.GetTranslation("public.prompt");
         SimpleAlertHelper.instance.popAlerFrame(_loc3_,_loc4_,_loc1_,_loc2_);
      }
      
      private function _confirmFun(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            FrameControllerManager.instance.vipController.hideBoxFrame();
         }
      }
      
      private function senChatData() : void
      {
         var _loc3_:String = null;
         var _loc2_:int = 0;
         var _loc1_:ChatData = null;
         if(vipModel.rouletteInfo.TakedTempList.length > 0)
         {
            _loc3_ = LanguageMgr.GetTranslation("vip.view.VipBoxFrame.content");
            _loc2_ = 0;
            while(_loc2_ < vipModel.rouletteInfo.TakedTempList.length)
            {
               if(_loc2_ > 0)
               {
                  _loc3_ += ",";
               }
               _loc3_ += TempleteManager.instance.goodsTemplateCate.getTemplateByID(vipModel.rouletteInfo.TakedTempList[_loc2_].tempId).TemplateName;
               _loc3_ += " x" + vipModel.rouletteInfo.TakedTempList[_loc2_].count;
               _loc2_++;
            }
            _loc1_ = ObjectPool.getObject(ChatData) as ChatData;
            _loc1_.channel = 3;
            _loc1_.msg = _loc3_;
            _loc1_.commit();
            NotificationManager.instance.sendNotification("ADD_CHAT",_loc1_);
            if(GoodsManager.instance.getEmputyPosCount() < vipModel.rouletteInfo.TakedTempList.length)
            {
            }
         }
      }
      
      private function cleanReceiveList() : void
      {
         for each(var _loc1_:BaseItemView in _vipReceiveList)
         {
            _loc1_.data = null;
         }
      }
      
      private function get vipModel() : VIPModel
      {
         return VIPManager.Instance.model;
      }
      
      override public function dispose() : void
      {
         senChatData();
         KeyBoardRegister.instance.keyEnable = true;
         cleanReceiveList();
         if(_turnControl)
         {
            _turnControl.dispose();
         }
         _turnControl = null;
         removeEvent();
         super.dispose();
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

