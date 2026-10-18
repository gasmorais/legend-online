package christmas
{
   import bag.events.BagEvent;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import mvc.module.christmas.ChristmasModel;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.templates.ChristmasLotteryTempInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.ChristmasManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.SharedManagerHelper;
   import yishi.manager.TempleteManager;
   import yishi.view.base.TextAddBitmap;
   import yishi.view.tips.MessageTipManager;
   
   public class ChristmasRewardFrame extends Frame implements IManualSize
   {
      
      private var _bg:Image;
      
      private var _timeTxt:FilterFrameText;
      
      private var _btn:IconButton;
      
      private var _pointBit:TextAddBitmap;
      
      private var _mc:MovieClip;
      
      private var _item:ChristmasPrayItem;
      
      private var _timeId:int;
      
      private var _isPlaying:Boolean = false;
      
      private var _mask:Sprite;
      
      private var _numBg:Bitmap;
      
      private var _numIcon:Bitmap;
      
      private var _numTxt:FilterFrameText;
      
      public function ChristmasRewardFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,1043,651);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("christmasRewardFrame.bg");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("christmasRewardFrame.timeTxt");
         _btn = ComponentFactory.Instance.creatComponentByStylename("christmasRewardFrame.btn");
         _pointBit = ComponentFactory.Instance.creatCustomObject("christmasRewardFrame.pointBit");
         _pointBit.initView("christmasRewardFrame.pointNumTx","asset.ChristmasRewardFrame.icon");
         _numBg = ComponentFactory.Instance.creatBitmap("asset.ChristmasFrame.iconBg");
         _numIcon = ComponentFactory.Instance.creatBitmap("asset.ChristmasRewardFrame.icon");
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("christmasRewardFrame.numTxt");
         _mc = ComponentFactory.Instance.creat("asset.ChristmasFrame.mc");
         _item = new ChristmasPrayItem();
         addToContent(_bg);
         addToContent(_timeTxt);
         addToContent(_btn);
         addToContent(_pointBit);
         addToContent(_numBg);
         addToContent(_numIcon);
         addToContent(_numTxt);
         _timeTxt.htmlText = LanguageMgr.GetTranslation("ChristmasFrame.timeTxt.text",model.openTimeStr,model.stopTimeStr);
         _pointBit.setText(point.toString());
         _pointBit.mouseChildren = _pointBit.mouseEnabled = false;
         initItem();
         addToContent(_mc);
         addToContent(_item);
         _mc.x = 500;
         _mc.y = 400;
         _mc.gotoAndStop(1);
         _mc.visible = false;
         _item.visible = false;
         _item.x = 460;
         _item.y = 265;
         _mask = new Sprite();
         _mask.graphics.beginFill(16777215,0);
         _mask.graphics.drawRect(0,0,1043,651);
         _mask.graphics.endFill();
         _mask.x = -17;
         _mask.y = -68;
         addToContent(_mask);
         _mask.visible = false;
         _numIcon.x = 800;
         _numIcon.y = 44;
         __onUpdateNumberHandler();
      }
      
      private function initItem() : void
      {
         var _loc3_:int = 0;
         var _loc1_:Array = null;
         var _loc2_:ChristmasRewardItem = null;
         _loc3_ = 1;
         while(_loc3_ <= 8)
         {
            _loc1_ = TempleteManager.instance.christmasLotteryTempCate.getTempByTypeSonType(3,_loc3_);
            _loc2_ = new ChristmasRewardItem(_loc3_);
            _loc2_.x = 35;
            _loc2_.y = 81 + (_loc3_ - 1) * 55;
            _loc2_.refreshData(_loc1_);
            addToContent(_loc2_);
            _loc3_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _btn.addEventListener("click",__btnClickHandler);
         ChristmasManager.instance.addEventListener("EVENT_UPDATE",updateInfoHandler);
         NotificationManager.instance.addEventListener("REFRESH_TOPTOOLS",__refreshTopToolsHandler);
         GoodsManager.instance.addEventListener("UPDATE_BAG",__onUpdateNumberHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__onUpdateNumberHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _btn.removeEventListener("click",__btnClickHandler);
         ChristmasManager.instance.removeEventListener("EVENT_UPDATE",updateInfoHandler);
         NotificationManager.instance.removeEventListener("REFRESH_TOPTOOLS",__refreshTopToolsHandler);
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__onUpdateNumberHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__onUpdateNumberHandler);
      }
      
      private function __onUpdateNumberHandler(param1:BagEvent = null) : void
      {
         _numTxt.text = hasCount.toString();
      }
      
      private function __refreshTopToolsHandler(param1:NotificationEvent) : void
      {
         if(!model.isOpen)
         {
            dispose();
         }
      }
      
      private function updateInfoHandler(param1:NotificationEvent) : void
      {
         if(model.type == 6 && _isPlaying)
         {
            showGoods();
         }
      }
      
      private function __btnClickHandler(param1:MouseEvent) : void
      {
         if(_isPlaying)
         {
            return;
         }
         var _loc2_:String = LanguageMgr.GetTranslation("active.expback.frame.selectbtntxt");
         var _loc3_:String = LanguageMgr.GetTranslation("ChristmasRewardFrame.btn.content.text",point,goodsName);
         SharedManagerHelper.ins.needAlert("ChristmasRewardFrame_btn_clickHandler",sendJackPot,_loc2_,_loc3_);
      }
      
      private function sendJackPot() : void
      {
         if(hasCount < point)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChristmasPrayFrame.noEnough.text",goodsName));
            return;
         }
         _isPlaying = true;
         _mask.visible = true;
         _mc.visible = true;
         _mc.gotoAndPlay(1);
         _mc.addFrameScript(6,callBack);
      }
      
      private function callBack() : void
      {
         _mc.addFrameScript(6,null);
         ChristmasManager.instance.opRequest(6);
      }
      
      private function showGoods() : void
      {
         var _loc1_:int = int(model.result);
         var _loc2_:ChristmasLotteryTempInfo = TempleteManager.instance.christmasLotteryTempCate.getTemplateByID(_loc1_);
         if(_loc2_)
         {
            _item.visible = true;
            _item.data = _loc2_;
         }
         _timeId = setTimeout(close,2000);
      }
      
      private function close() : void
      {
         clearTimeout(_timeId);
         _mc.gotoAndStop(1);
         _mc.visible = false;
         _item.visible = false;
         _isPlaying = false;
         _mask.visible = false;
      }
      
      private function get hasCount() : int
      {
         var _loc1_:Array = ConfigInfoManager.instance.christmasJackpot;
         return int(GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(int(_loc1_[0])));
      }
      
      private function get goodsName() : String
      {
         var _loc1_:int = int(ConfigInfoManager.instance.christmasJackpot[0]);
         var _loc2_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc1_);
         if(_loc2_)
         {
            return _loc2_.TemplateName;
         }
         return "";
      }
      
      private function get point() : int
      {
         return ConfigInfoManager.instance.christmasJackpot[1];
      }
      
      public function refreshView() : void
      {
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
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2,0,true);
      }
      
      private function get model() : ChristmasModel
      {
         return ChristmasManager.instance.model;
      }
      
      override public function dispose() : void
      {
         _isPlaying = false;
         removeEvent();
         clearTimeout(_timeId);
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_timeTxt);
         _timeTxt = null;
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         ObjectUtils.disposeObject(_pointBit);
         _pointBit = null;
         ObjectUtils.disposeViolentMc(_mc);
         _mc = null;
         ObjectUtils.disposeObject(_item);
         _item = null;
         super.dispose();
      }
   }
}

