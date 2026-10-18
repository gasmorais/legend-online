package christmas
{
   import carnvial.utils.CarnivalLockOper;
   import carnvial.utils.MoveSomeController;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.christmas.ChristmasModel;
   import yishi.datas.ConfigInfoManager;
   import yishi.events.NotificationEvent;
   import yishi.filter.UIFilter;
   import yishi.manager.ChristmasManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.view.base.NumberBitmap;
   import yishi.view.base.TextAddBitmap;
   
   public class ChristmasLuckyFrame extends Frame implements IManualSize
   {
      
      private var _bg:Image;
      
      private var _allCountTxt:FilterFrameText;
      
      private var _allCount:TextAddBitmap;
      
      private var _timeTxt:FilterFrameText;
      
      private var _turnFullFlg:Bitmap;
      
      private var _turnNeedBg:Bitmap;
      
      private var _carnTurnArrow:Image;
      
      private var _carnTurnDesTxt:FilterFrameText;
      
      private var _carnTurnTimeTxt:FilterFrameText;
      
      private var _turnLogT:FilterFrameText;
      
      private var _turnDi1:FilterFrameText;
      
      private var _turnDi2:FilterFrameText;
      
      private var _turnDi3:FilterFrameText;
      
      private var _turnDi4:FilterFrameText;
      
      private var _nextPointBit:NumberBitmap;
      
      private var _rechargeBtn:BaseButton;
      
      private var _firstBit:TextAddBitmap;
      
      private var _secondBit:TextAddBitmap;
      
      private var _thirdBit:TextAddBitmap;
      
      private var _fourBit:TextAddBitmap;
      
      private var _turnBtn:MovieClip;
      
      private var _firtCon:MoveSomeController;
      
      private var _secondCon:MoveSomeController;
      
      private var _thirdCon:MoveSomeController;
      
      private var _fourCon:MoveSomeController;
      
      private var _numData:BitmapData;
      
      private var _gray:Array;
      
      private var _pointMc:MovieClip;
      
      private var _pointConf:Array = [];
      
      private const POS_LIST:Array = [[655,128],[575,128],[494,128],[415,128]];
      
      private var _lockLayer:Sprite;
      
      public function ChristmasLuckyFrame()
      {
         super();
         initView();
         refreshView();
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
         _bg = ComponentFactory.Instance.creatComponentByStylename("christmasLuckyFrame.bg");
         _allCountTxt = ComponentFactory.Instance.creatComponentByStylename("christmasLuckyFrame.rechargeCountTxt");
         _allCount = ComponentFactory.Instance.creatCustomObject("christmasLuckyFrame.allCountBit");
         _allCount.initView("christmasLuckyFrame.pointNumTx","asset.core.SmallPointImg");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("christmasLuckyFrame.timeTxt");
         _allCount.x = 199;
         _turnFullFlg = ComponentFactory.Instance.creatBitmap("asset.ChristmasLuckyFrame.turnFullFlg");
         _turnNeedBg = ComponentFactory.Instance.creatBitmap("asset.ChristmasLuckyFrame.turnNeedBg");
         _carnTurnArrow = ComponentFactory.Instance.creatComponentByStylename("christmasLuckyFrame.carnTurnArrow");
         _carnTurnDesTxt = ComponentFactory.Instance.creatComponentByStylename("christmasLuckyFrame.carnTurnDesTxt");
         _carnTurnTimeTxt = ComponentFactory.Instance.creatComponentByStylename("christmasLuckyFrame.carnTurnTimeTxt");
         _numData = ComponentFactory.Instance.creatBitmap("asset.ChristmasLuckyFrame.turnNum").bitmapData;
         _nextPointBit = ComponentFactory.Instance.creatCustomObject("christmasLuckyFrame.turnNextPt");
         _nextPointBit.initParams("asset.ChristmasLuckyFrame.point","asset.carniver.pointNum",18,22,15,18,"0123456789",-80,2,0,80);
         _rechargeBtn = ComponentFactory.Instance.creatComponentByStylename("christmasLuckyFrame.rechageBtn");
         _firstBit = ComponentFactory.Instance.creatCustomObject("christmasLuckyFrame.firstBit");
         _firstBit.initView("christmasLuckyFrame.pointNumTx","asset.core.SmallPointImg");
         _secondBit = ComponentFactory.Instance.creatCustomObject("christmasLuckyFrame.secondBit");
         _secondBit.initView("christmasLuckyFrame.pointNumTx","asset.core.SmallPointImg");
         _thirdBit = ComponentFactory.Instance.creatCustomObject("christmasLuckyFrame.thirdBit");
         _thirdBit.initView("christmasLuckyFrame.pointNumTx","asset.core.SmallPointImg");
         _fourBit = ComponentFactory.Instance.creatCustomObject("christmasLuckyFrame.fourBit");
         _fourBit.initView("christmasLuckyFrame.pointNumTx","asset.core.SmallPointImg");
         _pointMc = ComponentFactory.Instance.creatCustomObject("asset.carniver.pointMcc");
         _pointMc.gotoAndStop(38);
         _pointMc.x = 656;
         _turnBtn = ComponentFactory.Instance.creatCustomObject("asset.carnival.turnBtnMc");
         _turnBtn.gotoAndStop(1);
         _turnBtn.buttonMode = true;
         _turnBtn.x = 755;
         _carnTurnDesTxt.text = LanguageMgr.GetTranslation("carnival.luckTurn.des");
         _turnLogT = ComponentFactory.Instance.creatComponentByStylename("christmasLuckyFrame.turnLogT");
         _turnDi1 = ComponentFactory.Instance.creatComponentByStylename("christmasLuckyFrame.turnDi1");
         _turnDi2 = ComponentFactory.Instance.creatComponentByStylename("christmasLuckyFrame.turnDi2");
         _turnDi3 = ComponentFactory.Instance.creatComponentByStylename("christmasLuckyFrame.turnDi3");
         _turnDi4 = ComponentFactory.Instance.creatComponentByStylename("christmasLuckyFrame.turnDi4");
         _turnLogT.text = LanguageMgr.GetTranslation("carnival.turn.log");
         _turnDi1.text = LanguageMgr.GetTranslation("carnival.turn.time1");
         _turnDi2.text = LanguageMgr.GetTranslation("carnival.turn.time2");
         _turnDi3.text = LanguageMgr.GetTranslation("carnival.turn.time3");
         _turnDi4.text = LanguageMgr.GetTranslation("carnival.turn.time4");
         addToContent(_bg);
         addToContent(_allCountTxt);
         addToContent(_allCount);
         addToContent(_timeTxt);
         addToContent(_turnFullFlg);
         addToContent(_turnNeedBg);
         addToContent(_carnTurnArrow);
         addToContent(_carnTurnDesTxt);
         addToContent(_carnTurnTimeTxt);
         addToContent(_turnLogT);
         addToContent(_turnDi1);
         addToContent(_turnDi2);
         addToContent(_turnDi3);
         addToContent(_turnDi4);
         addToContent(_nextPointBit);
         addToContent(_rechargeBtn);
         addToContent(_firstBit);
         addToContent(_secondBit);
         addToContent(_thirdBit);
         addToContent(_fourBit);
         addToContent(_pointMc);
         addToContent(_turnBtn);
         _allCountTxt.text = LanguageMgr.GetTranslation("carnival.luck.allGet");
         _timeTxt.htmlText = LanguageMgr.GetTranslation("ChristmasFrame.timeTxt.text",model.openTimeStr,model.stopTimeStr);
         initCons();
         _gray = [UIFilter.getGrayFilter()];
         _pointConf = ConfigInfoManager.instance.christmasRebate;
         _lockLayer = new Sprite();
         _lockLayer.graphics.beginFill(0,0);
         _lockLayer.graphics.drawRect(-17,-68,1043,651);
         _lockLayer.graphics.endFill();
         addToContent(_lockLayer);
         _lockLayer.mouseEnabled = false;
         _lockLayer.visible = false;
         CarnivalLockOper.Ins.regist(doLockOper);
      }
      
      private function doLockOper(param1:Boolean) : void
      {
         _lockLayer.mouseEnabled = param1;
         _lockLayer.visible = param1;
      }
      
      private function initCons() : void
      {
         var _loc1_:BitmapData = null;
         var _loc3_:int = 0;
         var _loc2_:Array = [];
         var _loc4_:Rectangle = new Rectangle(0,0,38,56);
         var _loc5_:Point = new Point();
         _loc3_ = 0;
         while(_loc3_ < 10)
         {
            _loc1_ = new BitmapData(38,56);
            _loc4_.x = 38 * _loc3_;
            _loc1_.copyPixels(_numData,_loc4_,_loc5_);
            _loc2_.push(_loc1_);
            _loc3_++;
         }
         _firtCon = creatMoveCC(_loc2_,1);
         addToContent(_firtCon);
         _secondCon = creatMoveCC(_loc2_,2);
         addToContent(_secondCon);
         _thirdCon = creatMoveCC(_loc2_,3);
         addToContent(_thirdCon);
         _fourCon = creatMoveCC(_loc2_,4);
         addToContent(_fourCon);
      }
      
      private function creatMoveCC(param1:Array, param2:int) : MoveSomeController
      {
         var _loc6_:Bitmap = null;
         var _loc4_:BitmapData = null;
         var _loc5_:int = 0;
         var _loc8_:Array = [];
         var _loc7_:Array = [];
         _loc5_ = 0;
         while(_loc5_ < 10)
         {
            _loc4_ = param1[_loc5_];
            _loc6_ = new Bitmap(_loc4_);
            _loc8_.push(_loc6_);
            _loc6_ = new Bitmap(_loc4_);
            _loc7_.push(_loc6_);
            _loc5_++;
         }
         var _loc3_:MoveSomeController = ComponentFactory.Instance.creatCustomObject("christmasLuckyFrame.turnNumCC.f" + param2,[_loc8_,_loc7_,90,4,2000,35,18,rollBack]);
         _loc3_.initMask(69,121,-18,-32);
         return _loc3_;
      }
      
      private function rollBack(param1:TextAddBitmap = null, param2:String = null) : void
      {
         CarnivalLockOper.Ins.doCall(false);
         if(param1)
         {
            param1.setText(param2);
         }
         updateBtnSate();
         if(_pointMc)
         {
            _pointMc.gotoAndPlay(1);
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _turnBtn.addEventListener("click",clickHandler);
         _rechargeBtn.addEventListener("click",rechargeHandler);
         ChristmasManager.instance.addEventListener("EVENT_UPDATE",updateInfoHandler);
         NotificationManager.instance.addEventListener("REFRESH_TOPTOOLS",__refreshTopToolsHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _turnBtn.removeEventListener("click",clickHandler);
         _rechargeBtn.removeEventListener("click",rechargeHandler);
         ChristmasManager.instance.removeEventListener("EVENT_UPDATE",updateInfoHandler);
         NotificationManager.instance.removeEventListener("REFRESH_TOPTOOLS",__refreshTopToolsHandler);
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
         var _loc2_:int = int(model.type);
         refreshView(true,_loc2_);
      }
      
      private function rechargeHandler(param1:MouseEvent) : void
      {
         RechargeAlertMannager.navigateToRechargePage();
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         _turnBtn.filters = _gray;
         _turnBtn.mouseEnabled = false;
         _turnBtn.gotoAndPlay(1);
         CarnivalLockOper.Ins.doCall(true);
         ChristmasManager.instance.opRequest(2);
      }
      
      private function getAllGetNum(param1:String) : int
      {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = param1.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ += int(param1.substr(_loc3_ - _loc4_ - 1,_loc4_ + 1));
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function refreshView(param1:Boolean = false, param2:int = -1) : void
      {
         var _loc12_:int = 0;
         var _loc9_:int = 0;
         var _loc5_:int = 0;
         var _loc16_:String = null;
         var _loc7_:int = 0;
         var _loc17_:int = 0;
         var _loc8_:MoveSomeController = null;
         var _loc4_:TextAddBitmap = null;
         var _loc3_:Array = null;
         var _loc19_:Array = null;
         var _loc6_:int = 0;
         var _loc18_:int = getAllGetNum("" + model.luckNum);
         _allCount.setText("" + _loc18_);
         var _loc20_:int = int(model.luckNum);
         var _loc11_:String = "" + _loc20_;
         var _loc14_:int = int(_pointConf.length);
         var _loc15_:int = -1;
         _loc9_ = 0;
         while(_loc9_ < _loc14_)
         {
            _loc12_ = int(_pointConf[_loc9_]);
            if(_loc12_ > model.totalCharge)
            {
               _loc15_ = _loc12_;
               break;
            }
            _loc9_++;
         }
         if(_loc15_ == -1)
         {
            _turnFullFlg.visible = true;
            _turnNeedBg.visible = false;
            _nextPointBit.visible = false;
         }
         else
         {
            _turnFullFlg.visible = false;
            _turnNeedBg.visible = true;
            _nextPointBit.visible = true;
            _nextPointBit.num = _loc15_ - model.totalCharge;
         }
         var _loc10_:int = _loc11_.length - 1 < 0 ? 0 : _loc11_.length - 1;
         _carnTurnArrow.x = POS_LIST[_loc10_][0];
         _carnTurnArrow.y = POS_LIST[_loc10_][1];
         var _loc13_:int = 4 - _loc11_.length;
         _loc7_ = 0;
         while(_loc7_ < _loc13_)
         {
            _loc11_ = "0" + _loc11_;
            _loc7_++;
         }
         if(param2 != 2)
         {
            updateBtnSate();
         }
         if(param1)
         {
            _loc3_ = [_firtCon,_secondCon,_thirdCon,_fourCon];
            _loc19_ = [_firstBit,_secondBit,_thirdBit,_fourBit];
            _loc8_ = _loc3_[_loc10_];
            _loc4_ = _loc19_[_loc10_];
            _loc6_ = 3 - _loc10_;
            _loc17_ = int(_loc16_ = _loc11_.substr(_loc6_,1));
            _loc16_ = _loc11_.substr(_loc6_,_loc10_ + 1);
            if(_loc8_ && _loc17_ > 0 && param2 == 2)
            {
               _loc8_.addCallParams([_loc4_,_loc16_]);
               _loc8_.start(_loc17_);
            }
         }
         else
         {
            updateBtnSate();
            _firstBit.setText(_loc5_ = int(_loc11_.substr(3,1)));
            _firtCon.initIdx(_loc5_);
            _loc5_ = int(_loc16_ = _loc11_.substr(2,1));
            _secondCon.initIdx(_loc5_);
            if(_loc5_ > 0)
            {
               _loc16_ = _loc11_.substr(2,2);
               _secondBit.setText(_loc16_);
            }
            else
            {
               _secondBit.setText("0");
            }
            _loc5_ = int(_loc16_ = _loc11_.substr(1,1));
            _thirdCon.initIdx(_loc5_);
            if(_loc5_ > 0)
            {
               _loc16_ = _loc11_.substr(1,3);
               _thirdBit.setText(_loc16_);
            }
            else
            {
               _thirdBit.setText("0");
            }
            _loc5_ = int(_loc16_ = _loc11_.substr(0,1));
            _fourCon.initIdx(_loc5_);
            if(_loc5_ > 0)
            {
               _loc16_ = _loc11_.substr(0,4);
               _fourBit.setText(_loc16_);
            }
            else
            {
               _fourBit.setText("0");
            }
         }
      }
      
      private function updateBtnSate() : void
      {
         _carnTurnTimeTxt.htmlText = LanguageMgr.GetTranslation("carnival.luckTurn.time",model.luckCount);
         if(model.luckCount > 0)
         {
            _turnBtn.filters = null;
            _turnBtn.mouseEnabled = true;
         }
         else
         {
            _turnBtn.filters = _gray;
            _turnBtn.mouseEnabled = false;
         }
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
         removeEvent();
         CarnivalLockOper.Ins.doCall(false);
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_allCountTxt);
         _allCountTxt = null;
         ObjectUtils.disposeObject(_allCount);
         _allCount = null;
         ObjectUtils.disposeObject(_timeTxt);
         _timeTxt = null;
         ObjectUtils.disposeObject(_turnFullFlg);
         _turnFullFlg = null;
         ObjectUtils.disposeObject(_turnNeedBg);
         _turnNeedBg = null;
         ObjectUtils.disposeObject(_carnTurnArrow);
         _carnTurnArrow = null;
         ObjectUtils.disposeObject(_carnTurnDesTxt);
         _carnTurnDesTxt = null;
         ObjectUtils.disposeObject(_carnTurnTimeTxt);
         _carnTurnTimeTxt = null;
         ObjectUtils.disposeObject(_firstBit);
         _firstBit = null;
         ObjectUtils.disposeObject(_secondBit);
         _secondBit = null;
         ObjectUtils.disposeObject(_thirdBit);
         _thirdBit = null;
         ObjectUtils.disposeObject(_fourBit);
         _fourBit = null;
         ObjectUtils.disposeViolentMc(_turnBtn);
         _turnBtn = null;
         ObjectUtils.disposeObject(_numData);
         _numData = null;
         ObjectUtils.disposeObject(_firtCon);
         _firtCon = null;
         ObjectUtils.disposeObject(_secondCon);
         _secondCon = null;
         ObjectUtils.disposeObject(_thirdCon);
         _thirdCon = null;
         ObjectUtils.disposeObject(_fourCon);
         _fourCon = null;
         ObjectUtils.disposeObject(_turnLogT);
         _turnLogT = null;
         ObjectUtils.disposeObject(_turnDi1);
         _turnDi1 = null;
         ObjectUtils.disposeObject(_turnDi2);
         _turnDi2 = null;
         ObjectUtils.disposeObject(_turnDi3);
         _turnDi3 = null;
         ObjectUtils.disposeObject(_turnDi4);
         _turnDi4 = null;
         ObjectUtils.disposeObject(_nextPointBit);
         _nextPointBit = null;
         ObjectUtils.disposeViolentMc(_pointMc);
         _pointMc = null;
         ObjectUtils.disposeObject(_rechargeBtn);
         _rechargeBtn = null;
         _gray = null;
         super.dispose();
      }
   }
}

