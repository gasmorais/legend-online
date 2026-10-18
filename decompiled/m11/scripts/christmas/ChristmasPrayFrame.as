package christmas
{
   import bag.events.BagEvent;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import mvc.module.christmas.ChristmasModel;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.templates.ChristmasActivitiesTempInfo;
   import yishi.datas.templates.ChristmasLotteryTempInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.ChristmasManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.SharedManagerHelper;
   import yishi.manager.TempleteManager;
   import yishi.utils.NumberViewUtils;
   import yishi.view.tips.MessageTipManager;
   
   public class ChristmasPrayFrame extends Frame implements IManualSize
   {
      
      private static const POINT_ARR:Array = [[675,55],[600,165],[750,165],[535,275],[675,275],[815,275],[470,385],[575,385],[680,385],[785,385],[890,385]];
      
      private var _back:ScaleFrameImage;
      
      private var _titleBg:Bitmap;
      
      private var _tree:Bitmap;
      
      private var _lightBtn:SelectedIconButton;
      
      private var _prayBtn:SelectedIconButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _timeTxtBg:ScaleFrameImage;
      
      private var _timeTxt:FilterFrameText;
      
      private var _txt:FilterFrameText;
      
      private var _lightUpBtn:IconButton;
      
      private var _pointTxt:FilterFrameText;
      
      private var _previewBtn:IconButton;
      
      private var _lightIcon:Bitmap;
      
      private var _prayIcon:Bitmap;
      
      private var _prayIconBtn:IconButton;
      
      private var _numContiner:Component;
      
      private var _numBitmap:BitmapData;
      
      private var _sprite:Sprite;
      
      private var _mc:MovieClip;
      
      private var _item:ChristmasPrayItem;
      
      private var _timeId:int;
      
      private var _isPlaying:Boolean = false;
      
      private var _mask:Sprite;
      
      private var _numBg:Bitmap;
      
      private var _numIcon:Bitmap;
      
      private var _numTxt:FilterFrameText;
      
      private var _treeMc:MovieClip;
      
      private var _prayIconBtn10:IconButton;
      
      private var _prayIcon10:Bitmap;
      
      private var _numContiner10:Component;
      
      private var _point:int;
      
      private var _tileList:SimpleTileList;
      
      public function ChristmasPrayFrame()
      {
         super();
         initView();
         addEvent();
         refreshView();
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
         _back = ComponentFactory.Instance.creatComponentByStylename("christmasPrayFrame.back");
         _titleBg = ComponentFactory.Instance.creatBitmap("asset.ChristmasPrayFrame.titleBg");
         _tree = ComponentFactory.Instance.creatBitmap("asset.ChristmasPrayFrame.tree");
         _lightBtn = ComponentFactory.Instance.creatComponentByStylename("christmasPrayFrame.lightBtn");
         _prayBtn = ComponentFactory.Instance.creatComponentByStylename("christmasPrayFrame.prayBtn");
         _timeTxtBg = ComponentFactory.Instance.creatComponentByStylename("christmasPrayFrame.timeTxtBg");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("christmasPrayFrame.timeTxt");
         _txt = ComponentFactory.Instance.creatComponentByStylename("christmasPrayFrame.txt");
         _lightUpBtn = ComponentFactory.Instance.creatComponentByStylename("christmasPrayFrame.lightUpBtn");
         _pointTxt = ComponentFactory.Instance.creatComponentByStylename("christmasPrayFrame.pointTxt");
         _previewBtn = ComponentFactory.Instance.creatComponentByStylename("christmasPrayFrame.previewBtn1");
         _previewBtn.icon.x = 34;
         _prayIconBtn = ComponentFactory.Instance.creatComponentByStylename("christmasPrayFrame.prayIconBtn");
         _numContiner = ComponentFactory.Instance.creatComponentByStylename("christmasPrayFrame.numContiner");
         _numBitmap = ComponentFactory.Instance.creatBitmapData("asset.ChristmasPrayFrame.numBitmap");
         _prayIconBtn.icon.y = 40.5;
         _lightIcon = ComponentFactory.Instance.creatBitmap("asset.ChristmasParyFrame.lightIcon");
         _prayIcon = ComponentFactory.Instance.creatBitmap("asset.ChristmasParyFrame.prayIcon");
         _treeMc = ComponentFactory.Instance.creat("asset.ChristmasFrame.treeMc");
         _mc = ComponentFactory.Instance.creat("asset.ChristmasFrame.mc");
         _item = new ChristmasPrayItem();
         _numBg = ComponentFactory.Instance.creatBitmap("asset.ChristmasFrame.iconBg");
         _numIcon = ComponentFactory.Instance.creatBitmap("asset.ChristmasParyFrame.prayIcon");
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("christmasRewardFrame.numTxt");
         _prayIconBtn10 = ComponentFactory.Instance.creatComponentByStylename("christmasPrayFrame.prayIconBtn10");
         _prayIconBtn10.icon.y = 38.5;
         _prayIcon10 = ComponentFactory.Instance.creatBitmap("asset.ChristmasParyFrame.prayIcon");
         _numContiner10 = ComponentFactory.Instance.creatComponentByStylename("christmasPrayFrame.numContiner10");
         _tileList = ComponentFactory.Instance.creatCustomObject("christmasPrayFrame.tileList",[5]);
         addToContent(_back);
         addToContent(_titleBg);
         addToContent(_tree);
         addToContent(_lightBtn);
         addToContent(_prayBtn);
         addToContent(_timeTxtBg);
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_lightBtn);
         _btnGroup.addSelectItem(_prayBtn);
         _btnGroup.selectIndex = 0;
         addToContent(_timeTxt);
         addToContent(_txt);
         addToContent(_treeMc);
         addToContent(_lightUpBtn);
         addToContent(_pointTxt);
         addToContent(_previewBtn);
         addToContent(_prayIconBtn);
         addToContent(_lightIcon);
         addToContent(_prayIcon);
         addToContent(_numContiner);
         addToContent(_prayIconBtn10);
         addToContent(_prayIcon10);
         addToContent(_numContiner10);
         addToContent(_numBg);
         addToContent(_numIcon);
         addToContent(_numTxt);
         _pointTxt.mouseEnabled = false;
         _numContiner.mouseChildren = _numContiner.mouseEnabled = false;
         _numContiner10.mouseChildren = _numContiner10.mouseEnabled = false;
         _prayIcon10.x = 343;
         _sprite = new Sprite();
         addToContent(_sprite);
         addToContent(_mc);
         addToContent(_item);
         addToContent(_tileList);
         initItem();
         _treeMc.x = 705;
         _treeMc.y = 351;
         _timeTxt.htmlText = LanguageMgr.GetTranslation("ChristmasFrame.timeTxt.text",model.openTimeStr,model.stopTimeStr);
         _txt.htmlText = LanguageMgr.GetTranslation("ChristmasPrayFrame.txt.text",lightGoodsName,lightHasCount,lightPoint);
         _pointTxt.text = lightPoint.toString();
         NumberViewUtils.refreshValue(prayPoint,_numContiner,_numBitmap,12,18,10,12,"0123456789");
         NumberViewUtils.refreshValue(prayPoint * 10,_numContiner10,_numBitmap,12,18,10,12,"0123456789");
         _mc.x = 500;
         _mc.y = 400;
         _mc.gotoAndStop(1);
         _mc.visible = false;
         _item.visible = false;
         _item.x = 460;
         _item.y = 265;
         _tileList.removeAllChild();
         _mask = new Sprite();
         _mask.graphics.beginFill(16777215,0);
         _mask.graphics.drawRect(0,0,1043,651);
         _mask.graphics.endFill();
         _mask.x = -17;
         _mask.y = -68;
         addToContent(_mask);
         _mask.visible = false;
         _numBg.x = 850;
         _numBg.y = 90;
         _numIcon.x = 855;
         _numIcon.y = 95;
         _numTxt.x = 872;
         _numTxt.y = 95;
         __onUpdateNumberHandler();
      }
      
      private function initItem() : void
      {
         var _loc3_:int = 0;
         var _loc2_:ChristmasPrayItem = null;
         var _loc1_:Array = TempleteManager.instance.christmasLotteryTempCate.getTemplatesByType(2);
         _loc3_ = 0;
         while(_loc3_ < 11)
         {
            _loc2_ = new ChristmasPrayItem();
            _loc2_.x = POINT_ARR[_loc3_][0];
            _loc2_.y = POINT_ARR[_loc3_][1];
            _loc2_.data = _loc1_[_loc3_] as ChristmasLotteryTempInfo;
            _sprite.addChild(_loc2_);
            _loc3_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _btnGroup.addEventListener("change",__tabChangeHandler);
         ChristmasManager.instance.addEventListener("EVENT_UPDATE",updateInfoHandler);
         _lightUpBtn.addEventListener("click",__lightUpBtnClickHandler);
         _prayIconBtn.addEventListener("click",__prayIconBtnClickHandler);
         _prayIconBtn10.addEventListener("click",__prayIconBtnClickHandler);
         _previewBtn.addEventListener("click",__previewBtnClickHandler);
         NotificationManager.instance.addEventListener("REFRESH_TOPTOOLS",__refreshTopToolsHandler);
         GoodsManager.instance.addEventListener("UPDATE_BAG",__onUpdateNumberHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__onUpdateNumberHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _btnGroup.removeEventListener("change",__tabChangeHandler);
         ChristmasManager.instance.removeEventListener("EVENT_UPDATE",updateInfoHandler);
         _lightUpBtn.removeEventListener("click",__lightUpBtnClickHandler);
         _prayIconBtn.removeEventListener("click",__prayIconBtnClickHandler);
         _prayIconBtn10.removeEventListener("click",__prayIconBtnClickHandler);
         _previewBtn.removeEventListener("click",__previewBtnClickHandler);
         NotificationManager.instance.removeEventListener("REFRESH_TOPTOOLS",__refreshTopToolsHandler);
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__onUpdateNumberHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__onUpdateNumberHandler);
      }
      
      private function __onUpdateNumberHandler(param1:BagEvent = null) : void
      {
         _numTxt.text = prayHasCount.toString();
      }
      
      private function __refreshTopToolsHandler(param1:NotificationEvent) : void
      {
         if(!model.isOpen)
         {
            dispose();
         }
      }
      
      private function __previewBtnClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("christmas",12,_btnGroup.selectIndex);
      }
      
      private function __prayIconBtnClickHandler(param1:MouseEvent) : void
      {
         if(param1.currentTarget == _prayIconBtn)
         {
            _point = prayPoint;
         }
         else
         {
            _point = prayPoint * 10;
         }
         var _loc2_:String = LanguageMgr.GetTranslation("active.expback.frame.selectbtntxt");
         var _loc3_:String = LanguageMgr.GetTranslation("ChristmasPrayFrame.prayIconBtn.content.text",_point,prayGoodsName);
         SharedManagerHelper.ins.needAlert("ChristmasPrayFrame_PrayIconBtn_clickHandler",sendPray,_loc2_,_loc3_);
      }
      
      private function sendPray() : void
      {
         if(prayHasCount < _point)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChristmasPrayFrame.noEnough.text",prayGoodsName));
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
         if(_point == prayPoint)
         {
            ChristmasManager.instance.opRequest(5,1);
         }
         else
         {
            ChristmasManager.instance.opRequest(5,10);
         }
      }
      
      private function showGoods() : void
      {
         var _loc4_:ChristmasLotteryTempInfo = null;
         var _loc3_:int = 0;
         var _loc2_:ChristmasPrayItem = null;
         var _loc1_:Array = model.result.split(",");
         if(_loc1_.length == 1)
         {
            _loc4_ = TempleteManager.instance.christmasLotteryTempCate.getTemplateByID(int(_loc1_[0]));
            if(_loc4_)
            {
               _item.visible = true;
               _item.data = _loc4_;
            }
         }
         else
         {
            _tileList.removeAllChild();
            _loc3_ = 0;
            while(_loc3_ < _loc1_.length)
            {
               _loc2_ = new ChristmasPrayItem();
               _loc4_ = TempleteManager.instance.christmasLotteryTempCate.getTemplateByID(int(_loc1_[_loc3_]));
               _loc2_.data = _loc4_;
               _tileList.addChild(_loc2_);
               _loc3_++;
            }
         }
         _timeId = setTimeout(close,2000);
      }
      
      private function close() : void
      {
         clearTimeout(_timeId);
         _mc.gotoAndStop(1);
         _mc.visible = false;
         _item.visible = false;
         _tileList.removeAllChild();
         _isPlaying = false;
         _mask.visible = false;
      }
      
      private function __lightUpBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = LanguageMgr.GetTranslation("active.expback.frame.selectbtntxt");
         var _loc3_:String = LanguageMgr.GetTranslation("ChristmasPrayFrame.lightUpBtn.content.text",lightPoint,lightGoodsName);
         SharedManagerHelper.ins.needAlert("ChristmasPrayFrame_LightUpBtn_clickHandler",sendLight,_loc2_,_loc3_);
      }
      
      private function sendLight() : void
      {
         if(lightHasCount < lightPoint)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChristmasPrayFrame.noEnough.text",lightGoodsName));
            return;
         }
         ChristmasManager.instance.opRequest(4);
      }
      
      private function updateInfoHandler(param1:NotificationEvent) : void
      {
         refreshView();
      }
      
      private function __tabChangeHandler(param1:Event) : void
      {
         refreshView();
      }
      
      public function refreshView() : void
      {
         if(_btnGroup.selectIndex == 0)
         {
            _back.setFrame(1);
            _timeTxtBg.setFrame(1);
            _txt.visible = true;
            _lightIcon.visible = true;
            _prayIcon.visible = false;
            _prayIconBtn.visible = false;
            _numContiner.visible = false;
            _sprite.visible = false;
            _numBg.visible = false;
            _numIcon.visible = false;
            _numTxt.visible = false;
            _prayIconBtn10.visible = false;
            _prayIcon10.visible = false;
            _numContiner10.visible = false;
            if(model.isLight == 1)
            {
               _lightUpBtn.visible = false;
               _pointTxt.visible = false;
               _lightIcon.visible = false;
               _timeTxtBg.setFrame(2);
               _txt.visible = false;
            }
            else
            {
               _lightUpBtn.visible = true;
               _pointTxt.visible = true;
               _lightIcon.visible = true;
            }
         }
         else
         {
            _back.setFrame(2);
            _timeTxtBg.setFrame(2);
            _txt.visible = false;
            _lightUpBtn.visible = false;
            _pointTxt.visible = false;
            _lightIcon.visible = false;
            _prayIcon.visible = true;
            _prayIconBtn.visible = true;
            _numContiner.visible = true;
            _sprite.visible = true;
            _numBg.visible = true;
            _numIcon.visible = true;
            _numTxt.visible = true;
            _prayIconBtn10.visible = true;
            _prayIcon10.visible = true;
            _numContiner10.visible = true;
         }
         if(model.isLight == 1)
         {
            _treeMc.gotoAndPlay(1);
            _treeMc.visible = true;
         }
         else
         {
            _treeMc.gotoAndStop(1);
            _treeMc.visible = false;
         }
         if(model.type == 5 && _isPlaying)
         {
            showGoods();
         }
         _numTxt.text = prayHasCount.toString();
      }
      
      private function get lightHasCount() : int
      {
         var _loc2_:int = int(ConfigInfoManager.instance.christmasLight);
         return int(GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(_loc2_));
      }
      
      private function get lightGoodsName() : String
      {
         var _loc1_:int = int(ConfigInfoManager.instance.christmasLight);
         var _loc2_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc1_);
         if(_loc2_)
         {
            return _loc2_.TemplateName;
         }
         return "";
      }
      
      private function get lightPoint() : int
      {
         var _loc1_:Array = TempleteManager.instance.christmasActivitiesTempCate.getTemplatesByType(1);
         if(_loc1_.length > 0)
         {
            return (_loc1_[0] as ChristmasActivitiesTempInfo).Para1;
         }
         return 0;
      }
      
      private function get prayHasCount() : int
      {
         var _loc1_:Array = ConfigInfoManager.instance.christmasWish;
         return int(GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(int(_loc1_[0])));
      }
      
      private function get prayGoodsName() : String
      {
         var _loc1_:int = int(ConfigInfoManager.instance.christmasWish[0]);
         var _loc2_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc1_);
         if(_loc2_)
         {
            return _loc2_.TemplateName;
         }
         return "";
      }
      
      private function get prayPoint() : int
      {
         return ConfigInfoManager.instance.christmasWish[1];
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
         clearTimeout(_timeId);
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_titleBg);
         _titleBg = null;
         ObjectUtils.disposeObject(_tree);
         _tree = null;
         ObjectUtils.disposeObject(_lightBtn);
         _lightBtn = null;
         ObjectUtils.disposeObject(_prayBtn);
         _prayBtn = null;
         ObjectUtils.disposeObject(_timeTxtBg);
         _timeTxtBg = null;
         ObjectUtils.disposeObject(_timeTxt);
         _timeTxt = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         ObjectUtils.disposeObject(_lightUpBtn);
         _lightUpBtn = null;
         ObjectUtils.disposeObject(_lightIcon);
         _lightIcon = null;
         ObjectUtils.disposeObject(_prayIcon);
         _prayIcon = null;
         ObjectUtils.disposeObject(_prayIcon10);
         _prayIcon10 = null;
         ObjectUtils.disposeObject(_pointTxt);
         _pointTxt = null;
         ObjectUtils.disposeObject(_previewBtn);
         _previewBtn = null;
         ObjectUtils.disposeObject(_prayIconBtn);
         _prayIconBtn = null;
         ObjectUtils.disposeObject(_prayIconBtn10);
         _prayIconBtn10 = null;
         ObjectUtils.disposeAllChildren(_sprite);
         _sprite = null;
         ObjectUtils.disposeViolentMc(_treeMc);
         _treeMc = null;
         ObjectUtils.disposeObject(_btnGroup);
         _btnGroup = null;
         super.dispose();
      }
   }
}

