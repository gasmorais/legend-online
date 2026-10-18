package carnvial.item
{
   import carnvial.utils.CarnivalLockOper;
   import carnvial.utils.MoveSomeController;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
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
   import mvc.module.carnival.CarnivalModel;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.CarnivalManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.TempleteManager;
   import yishi.view.base.NumberBitmap;
   import yishi.view.base.TextAddBitmap;
   
   public class CarnivalTurnItem extends Sprite
   {
      
      private const POS_LIST:Array = [[320,128],[240,128],[159,128],[80,128]];
      
      private var _turnBg:Bitmap;
      
      private var _turnTitle:Bitmap;
      
      private var _turnDesBg:Bitmap;
      
      private var _turnFullFlg:Bitmap;
      
      private var _turnNeedBg:Bitmap;
      
      private var _carnTurnArrow:Image;
      
      private var _carnTurnDesTxt:FilterFrameText;
      
      private var _carnTurnTimeTxt:FilterFrameText;
      
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
      
      private var _nextPointBit:NumberBitmap;
      
      private var _pointConf:Array = [];
      
      private var _turnLogT:FilterFrameText;
      
      private var _turnDi1:FilterFrameText;
      
      private var _turnDi2:FilterFrameText;
      
      private var _turnDi3:FilterFrameText;
      
      private var _turnDi4:FilterFrameText;
      
      private var _pointMc:MovieClip;
      
      private var _rechargeBtn:BaseButton;
      
      public function CarnivalTurnItem()
      {
         super();
         initView();
         refreshView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("CarnivalRebate");
         if(_loc1_)
         {
            _pointConf = _loc1_.ConfigValue.split(",");
         }
         _turnBg = ComponentFactory.Instance.creatBitmap("asset.carniver.turnBg");
         _turnTitle = ComponentFactory.Instance.creatBitmap("asset.carniver.turnTitle");
         _turnDesBg = ComponentFactory.Instance.creatBitmap("asset.carniver.turnDesBg");
         _turnFullFlg = ComponentFactory.Instance.creatBitmap("asset.carniver.turnFullFlg");
         _turnNeedBg = ComponentFactory.Instance.creatBitmap("asset.carniver.turnNeedBg");
         _carnTurnArrow = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.carnTurnArrow");
         _carnTurnDesTxt = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.carnTurnDesTxt");
         _carnTurnTimeTxt = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.carnTurnTimeTxt");
         _numData = ComponentFactory.Instance.creatBitmap("asset.carniver.turnNum").bitmapData;
         _nextPointBit = ComponentFactory.Instance.creatCustomObject("ui.carnival.turnNextPt");
         _nextPointBit.initParams("asset.carnival.point","asset.carniver.pointNum",18,22,15,18,"0123456789",-90,2,0,80);
         _rechargeBtn = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.rechageBtn");
         _firstBit = ComponentFactory.Instance.creatCustomObject("ui.carnival.firstBit");
         _firstBit.initView("ui.carnival.pointNumTx","asset.core.SmallPointImg");
         _secondBit = ComponentFactory.Instance.creatCustomObject("ui.carnival.secondBit");
         _secondBit.initView("ui.carnival.pointNumTx","asset.core.SmallPointImg");
         _thirdBit = ComponentFactory.Instance.creatCustomObject("ui.carnival.thirdBit");
         _thirdBit.initView("ui.carnival.pointNumTx","asset.core.SmallPointImg");
         _fourBit = ComponentFactory.Instance.creatCustomObject("ui.carnival.fourBit");
         _fourBit.initView("ui.carnival.pointNumTx","asset.core.SmallPointImg");
         _pointMc = ComponentFactory.Instance.creatCustomObject("asset.carniver.pointMcc");
         _pointMc.gotoAndStop(38);
         _turnBtn = ComponentFactory.Instance.creatCustomObject("asset.carnival.turnBtnMc");
         _turnBtn.gotoAndStop(1);
         _turnBtn.buttonMode = true;
         _carnTurnDesTxt.text = LanguageMgr.GetTranslation("carnival.luckTurn.des");
         _turnLogT = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.turnLogT");
         _turnDi1 = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.turnDi1");
         _turnDi2 = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.turnDi2");
         _turnDi3 = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.turnDi3");
         _turnDi4 = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.turnDi4");
         _turnLogT.text = LanguageMgr.GetTranslation("carnival.turn.log");
         _turnDi1.text = LanguageMgr.GetTranslation("carnival.turn.time1");
         _turnDi2.text = LanguageMgr.GetTranslation("carnival.turn.time2");
         _turnDi3.text = LanguageMgr.GetTranslation("carnival.turn.time3");
         _turnDi4.text = LanguageMgr.GetTranslation("carnival.turn.time4");
         addChild(_turnBg);
         addChild(_turnTitle);
         addChild(_turnDesBg);
         addChild(_turnFullFlg);
         addChild(_turnNeedBg);
         addChild(_carnTurnArrow);
         addChild(_carnTurnDesTxt);
         addChild(_carnTurnTimeTxt);
         addChild(_turnLogT);
         addChild(_turnDi1);
         addChild(_turnDi2);
         addChild(_turnDi3);
         addChild(_turnDi4);
         addChild(_nextPointBit);
         addChild(_rechargeBtn);
         addChild(_firstBit);
         addChild(_secondBit);
         addChild(_thirdBit);
         addChild(_fourBit);
         addChild(_pointMc);
         addChild(_turnBtn);
         initCons();
         _gray = [UIFilter.getGrayFilter()];
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
         addChild(_firtCon);
         _secondCon = creatMoveCC(_loc2_,2);
         addChild(_secondCon);
         _thirdCon = creatMoveCC(_loc2_,3);
         addChild(_thirdCon);
         _fourCon = creatMoveCC(_loc2_,4);
         addChild(_fourCon);
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
         var _loc3_:MoveSomeController = ComponentFactory.Instance.creatCustomObject("ui.carnival.turnNumCC.f" + param2,[_loc8_,_loc7_,90,4,2000,35,18,rollBack]);
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
         var _loc18_:Array = null;
         var _loc6_:int = 0;
         var _loc19_:int = int(model.luckNum);
         var _loc11_:String = "" + _loc19_;
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
         if(param2 != 4)
         {
            updateBtnSate();
         }
         if(param1)
         {
            _loc3_ = [_firtCon,_secondCon,_thirdCon,_fourCon];
            _loc18_ = [_firstBit,_secondBit,_thirdBit,_fourBit];
            _loc8_ = _loc3_[_loc10_];
            _loc4_ = _loc18_[_loc10_];
            _loc6_ = 3 - _loc10_;
            _loc17_ = int(_loc16_ = _loc11_.substr(_loc6_,1));
            _loc16_ = _loc11_.substr(_loc6_,_loc10_ + 1);
            if(_loc8_ && _loc17_ > 0 && param2 == 4)
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
      
      private function initEvent() : void
      {
         _turnBtn.addEventListener("click",clickHandler);
         _rechargeBtn.addEventListener("click",rechargeHandler);
      }
      
      private function removeEvent() : void
      {
         _turnBtn.removeEventListener("click",clickHandler);
         _rechargeBtn.removeEventListener("click",rechargeHandler);
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
         CarnivalManager.Instance.opRequest(4);
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
      
      private function get model() : CarnivalModel
      {
         return CarnivalManager.Instance.model;
      }
      
      public function dispose() : void
      {
         removeEvent();
         CarnivalLockOper.Ins.doCall(false);
         ObjectUtils.disposeObject(_turnBg);
         _turnBg = null;
         ObjectUtils.disposeObject(_turnTitle);
         _turnTitle = null;
         ObjectUtils.disposeObject(_turnDesBg);
         _turnDesBg = null;
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
         if(parent)
         {
            parent.removeChild(this);
         }
         _gray = null;
      }
   }
}

