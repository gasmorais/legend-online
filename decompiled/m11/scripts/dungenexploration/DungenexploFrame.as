package dungenexploration
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import dungenexploration.item.DungenexploItem;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.DungeonExploManager;
   import managers.PlayerCurrencyManager;
   import mvc.module.currency.PlayerCurrencyInfo;
   import mvc.module.shop.ShopGoodsInfo;
   import mvc.module.theseus.dungeon.TheseusDungeonModel;
   import yishi.datas.ConfigInfoManager;
   import yishi.events.NotificationEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.frame.BuyFrameI;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class DungenexploFrame extends Frame implements IManualSize
   {
      
      protected var _bg:Bitmap;
      
      protected var _BindDiamondBG:Bitmap;
      
      protected var _BindDiamondBG1:Bitmap;
      
      protected var _BindDiamondBG2:Bitmap;
      
      protected var _Title:FilterFrameText;
      
      protected var _openflow:FilterFrameText;
      
      protected var _gaotouTxt:Bitmap;
      
      protected var _gaotouxiao:Bitmap;
      
      protected var _shuijingxiao:Bitmap;
      
      protected var _shuijingTxt:Bitmap;
      
      protected var _yaoshiTxt:Bitmap;
      
      protected var _yaoshixiao:Bitmap;
      
      protected var _nowopenflow:FilterFrameText;
      
      protected var _numshuijian:FilterFrameText;
      
      protected var _numgaozi:FilterFrameText;
      
      protected var _yaoshi:FilterFrameText;
      
      protected var _topBtn1:BaseButton;
      
      protected var _topBtn2:BaseButton;
      
      protected var _topBtn3:BaseButton;
      
      protected var _shuijing:FilterFrameText;
      
      protected var _topBtn4:BaseButton;
      
      protected var _topBtn5:BaseButton;
      
      private var _buyBtn:BaseButton;
      
      private var _mapItemList:Array = [];
      
      private var _helpBtn:BaseButton;
      
      protected var _shuaxintishi:FilterFrameText;
      
      protected var _qianwangxiayiceng:FilterFrameText;
      
      private var _effectContainer:Sprite;
      
      private var _currencyInfo:PlayerCurrencyInfo;
      
      public function DungenexploFrame()
      {
         super();
         DungeonExploManager.instance.sendDungeonOperate(1);
         initView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,1139,746);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initMapItem() : void
      {
         var _loc2_:int = 0;
         var _loc1_:DungenexploItem = null;
         _loc2_ = 0;
         while(_loc2_ < 45)
         {
            _loc1_ = new DungenexploItem(_loc2_);
            _loc1_.parentFrame = this;
            _loc1_.x = 160 + int(_loc2_ % 9) * 90;
            _loc1_.y = 155 + int(_loc2_ / 9) * 91;
            _mapItemList.push(_loc1_);
            addToContent(_loc1_);
            _loc2_++;
         }
      }
      
      private function refreshMap() : void
      {
         var _loc2_:int = 0;
         var _loc1_:DungenexploItem = null;
         _loc2_ = 0;
         while(_loc2_ < _mapItemList.length)
         {
            _loc1_ = _mapItemList[_loc2_];
            _loc1_.refreshView();
            _loc2_++;
         }
      }
      
      private function get model() : TheseusDungeonModel
      {
         return DungeonExploManager.instance.model;
      }
      
      protected function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.dungenexplo.bg");
         _BindDiamondBG = ComponentFactory.Instance.creatBitmap("asset.dungenexplo.BindDiamondBG");
         _BindDiamondBG1 = ComponentFactory.Instance.creatBitmap("asset.dungenexplo.BindDiamondBG");
         _BindDiamondBG2 = ComponentFactory.Instance.creatBitmap("asset.dungenexplo.BindDiamondBG");
         _BindDiamondBG1.x = 355;
         _BindDiamondBG2.y = 675;
         _Title = ComponentFactory.Instance.creatComponentByStylename("ui.dungenexplo.Title");
         _openflow = ComponentFactory.Instance.creatComponentByStylename("ui.dungenexplo.openflow");
         _gaotouTxt = ComponentFactory.Instance.creatBitmap("asset.dungenexplo.gaotouTxt");
         _gaotouxiao = ComponentFactory.Instance.creatBitmap("asset.dungenexplo.gaotouxiao");
         _shuijingxiao = ComponentFactory.Instance.creatBitmap("asset.dungenexplo.shuijingxiao");
         _shuijingTxt = ComponentFactory.Instance.creatBitmap("asset.dungenexplo.shuijingTxt");
         _yaoshiTxt = ComponentFactory.Instance.creatBitmap("asset.dungenexplo.yaoshiTxt");
         _yaoshixiao = ComponentFactory.Instance.creatBitmap("asset.dungenexplo.yaoshixiao");
         _nowopenflow = ComponentFactory.Instance.creatComponentByStylename("ui.dungenexplo.nowopenflow");
         _numshuijian = ComponentFactory.Instance.creatComponentByStylename("ui.dungenexplo.numshuijian");
         _numgaozi = ComponentFactory.Instance.creatComponentByStylename("ui.dungenexplo.numgaozi");
         _yaoshi = ComponentFactory.Instance.creatComponentByStylename("ui.dungenexplo.yaoshi");
         _topBtn1 = ComponentFactory.Instance.creatComponentByStylename("ui.dungenexplo.topBtn1");
         _topBtn2 = ComponentFactory.Instance.creatComponentByStylename("ui.dungenexplo.topBtn2");
         _topBtn3 = ComponentFactory.Instance.creatComponentByStylename("ui.dungenexplo.topBtn3");
         _shuijing = ComponentFactory.Instance.creatComponentByStylename("ui.dungenexplo.shuijing");
         _topBtn4 = ComponentFactory.Instance.creatComponentByStylename("ui.dungenexplo.topBtn4");
         _topBtn5 = ComponentFactory.Instance.creatComponentByStylename("ui.dungenexplo.topBtn5");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("uidungenexplo.buyBtn");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("stokesOreFrame.helpBtn");
         _shuaxintishi = ComponentFactory.Instance.creatComponentByStylename("ui.dungenexplo.shuaxintishi");
         _qianwangxiayiceng = ComponentFactory.Instance.creatComponentByStylename("ui.dungenexplo.qianwangxiayiceng");
         _shuijingxiao.x = 148;
         _shuijingxiao.y = 639;
         _effectContainer = new Sprite();
         addToContent(_bg);
         addToContent(_BindDiamondBG);
         addToContent(_BindDiamondBG1);
         addToContent(_BindDiamondBG2);
         addToContent(_Title);
         addToContent(_openflow);
         addToContent(_gaotouTxt);
         addToContent(_gaotouxiao);
         addToContent(_shuijingxiao);
         addToContent(_shuijingTxt);
         addToContent(_yaoshiTxt);
         addToContent(_yaoshixiao);
         addToContent(_nowopenflow);
         addToContent(_numshuijian);
         addToContent(_numgaozi);
         addToContent(_yaoshi);
         addToContent(_topBtn1);
         addToContent(_topBtn2);
         addToContent(_topBtn3);
         addToContent(_shuijing);
         addToContent(_topBtn4);
         addToContent(_topBtn5);
         addToContent(_helpBtn);
         _helpBtn.x = 1045;
         addToContent(_buyBtn);
         addToContent(_shuaxintishi);
         addToContent(_qianwangxiayiceng);
         _Title.text = LanguageMgr.GetTranslation("TheseusDungeonEventInfo.message5");
         _shuaxintishi.text = LanguageMgr.GetTranslation("TheseusDungeonEventInfo.message8");
         _qianwangxiayiceng.text = LanguageMgr.GetTranslation("TheseusDungeonEventInfo.message9");
         initMapItem();
         addToContent(_effectContainer);
      }
      
      private function addEvent() : void
      {
         _topBtn1.addEventListener("click",_openrewardFrame);
         _topBtn2.addEventListener("click",_openshopFrame);
         _topBtn3.addEventListener("click",_openskillbagFrame);
         _topBtn4.addEventListener("click",_gonextstage);
         _topBtn5.addEventListener("click",_gonextstage1);
         NotificationManager.instance.addEventListener("THESEUS_DUNGEON_DATA",__onDungeonDataUpdate);
         addEventListener("response",__frameResponse);
         if(_helpBtn)
         {
            _helpBtn.addEventListener("click",__helpBtnHandler);
         }
         _buyBtn.addEventListener("click",buyClickHandler);
         NotificationManager.instance.addEventListener("CURRENCYREFRESH",__updateGodwinerPoint);
      }
      
      private function __onDungeonDataUpdate(param1:NotificationEvent) : void
      {
         refreshMap();
         _nowopenflow.text = LanguageMgr.GetTranslation("TheseusDungeonEventInfo.message7",model.getCurrentUnlockedLevel());
         _openflow.text = LanguageMgr.GetTranslation("TheseusDungeonEventInfo.message6",model.level);
         _numgaozi.text = model.freeActionNum + model.buyActionNum + "";
         _currencyInfo = PlayerCurrencyManager.instance.currencyInfo;
         _shuijing.text = _currencyInfo.theseusshuijing.amount.toString();
         _yaoshi.text = GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(30000015) + "";
         if(model.level < model.getCurrentUnlockedLevel())
         {
            _topBtn4.visible = true;
            _topBtn5.visible = false;
         }
         else
         {
            _topBtn4.visible = false;
            _topBtn5.visible = true;
         }
      }
      
      private function _openrewardFrame(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("dungenexplo",2);
      }
      
      private function _openshopFrame(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("shop",1034);
      }
      
      private function _openskillbagFrame(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("dungenexplo",3);
      }
      
      private function _gonextstage(param1:MouseEvent) : void
      {
         var _loc5_:String = null;
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         _loc5_ = LanguageMgr.GetTranslation("TheseusDungeonEventInfo.message2");
         SimpleAlertHelper.instance.data = [buyCallBack1];
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_);
      }
      
      private function buyCallBack1(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            DungeonExploManager.instance.sendDungeonOperate(2);
         }
      }
      
      private function _gonextstage1(param1:MouseEvent) : void
      {
         MessageTipManager.instance().show(LanguageMgr.GetTranslation("TheseusDungeonEventInfo.message1"));
      }
      
      private function __updateGodwinerPoint(param1:NotificationEvent) : void
      {
         _shuijing.text = _currencyInfo.theseusshuijing.amount.toString();
      }
      
      public function showEffect(param1:int, param2:String) : void
      {
         var gridIndex:int = param1;
         var effectName:String = param2;
         var onFrameEnd:* = function():void
         {
            if(effect.parent)
            {
               effect.parent.removeChild(effect);
            }
         };
         var item:DungenexploItem = _mapItemList[gridIndex];
         var effect:MovieClip = ComponentFactory.Instance.creatCustomObject(effectName);
         effect.x = item.x + item.width / 2 - effect.width / 2;
         effect.y = item.y + item.height / 2 - effect.height / 2;
         _effectContainer.addChild(effect);
         effect.addFrameScript(effect.totalFrames - 1,onFrameEnd);
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function __helpBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("dungenexploration.DungenexploFrame.helpFrame");
         _loc2_.show();
      }
      
      private function quickUIcallback(param1:int = 1) : void
      {
         var _loc3_:Array = ConfigInfoManager.instance.gettheseusdungeon();
         var _loc4_:ShopGoodsInfo = new ShopGoodsInfo();
         _loc4_.ItemId = 30000013;
         _loc4_.OneCurrentCount = _loc3_[0] - model.dayPurchasableActionNum;
         _loc4_.Point = _loc3_[1];
         _loc4_.VIP0Count = _loc3_[0];
         _loc4_.ShopType = 1;
         _loc4_.init();
         var _loc2_:BuyFrameI = ComponentFactory.Instance.creatComponentByStylename("quickbuy.buyFrame");
         _loc2_.data(_loc4_,param1);
         _loc2_.show();
      }
      
      private function buyClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:PlayerCurrencyInfo = null;
         var _loc3_:Array = ConfigInfoManager.instance.gettheseusdungeon();
         if(model.dayPurchasableActionNum > 0)
         {
            _loc2_ = PlayerCurrencyManager.instance.currencyInfo;
            CheckUIModuleUtil.instance.tryCall("quickbuy",quickUIcallback);
         }
         else
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("theseuspvp.buyMax"));
         }
      }
      
      private function confirmChoose(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            DungeonExploManager.instance.sendDungeonOperate(5);
         }
      }
      
      private function remEvent() : void
      {
         NotificationManager.instance.removeEventListener("CURRENCYREFRESH",__updateGodwinerPoint);
         _topBtn1.removeEventListener("click",_openrewardFrame);
         _topBtn2.removeEventListener("click",_openshopFrame);
         _topBtn3.removeEventListener("click",_openskillbagFrame);
         _topBtn4.removeEventListener("click",_gonextstage);
         NotificationManager.instance.removeEventListener("THESEUS_DUNGEON_DATA",__onDungeonDataUpdate);
         if(_helpBtn)
         {
            _helpBtn.removeEventListener("click",__helpBtnHandler);
         }
         removeEventListener("response",__frameResponse);
         _topBtn5.removeEventListener("click",_gonextstage1);
         _buyBtn.removeEventListener("click",buyClickHandler);
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2,0,true);
      }
      
      override public function dispose() : void
      {
         remEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_BindDiamondBG);
         _BindDiamondBG = null;
         ObjectUtils.disposeObject(_Title);
         _Title = null;
         ObjectUtils.disposeObject(_openflow);
         _openflow = null;
         ObjectUtils.disposeObject(_gaotouTxt);
         _gaotouTxt = null;
         ObjectUtils.disposeObject(_gaotouxiao);
         _gaotouxiao = null;
         ObjectUtils.disposeObject(_shuijingxiao);
         _shuijingxiao = null;
         ObjectUtils.disposeObject(_shuijingTxt);
         _shuijingTxt = null;
         ObjectUtils.disposeObject(_yaoshiTxt);
         _yaoshiTxt = null;
         ObjectUtils.disposeObject(_yaoshixiao);
         _yaoshixiao = null;
         ObjectUtils.disposeObject(_nowopenflow);
         _nowopenflow = null;
         ObjectUtils.disposeObject(_numshuijian);
         _numshuijian = null;
         ObjectUtils.disposeObject(_numgaozi);
         _numgaozi = null;
         ObjectUtils.disposeObject(_yaoshi);
         _yaoshi = null;
         ObjectUtils.disposeObject(_topBtn1);
         _topBtn1 = null;
         ObjectUtils.disposeObject(_topBtn2);
         _topBtn2 = null;
         ObjectUtils.disposeObject(_topBtn3);
         _topBtn3 = null;
         ObjectUtils.disposeObject(_shuijing);
         _shuijing = null;
         ObjectUtils.disposeObject(_topBtn4);
         _topBtn4 = null;
         ObjectUtils.disposeObject(_topBtn5);
         _topBtn5 = null;
         ObjectUtils.disposeObject(_shuaxintishi);
         _shuaxintishi = null;
         ObjectUtils.disposeObject(_qianwangxiayiceng);
         _qianwangxiayiceng = null;
         ObjectUtils.disposeAllChildren(_effectContainer);
         _effectContainer = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

