package skytreasure.view
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import events.SkyTreasureEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import manager.LanguageMgr;
   import mvc.module.skytreasure.SkyTreasureModel;
   import yishi.manager.SkyTreasureManager;
   import yishi.view.tools.SimpleMovie;
   
   public class SkyTreasureBoxView extends Component implements Disposeable
   {
      
      private var _efMc:MovieClip;
      
      private var _boxArr:Array;
      
      private var _mask:Shape;
      
      private var _bitmap:Bitmap;
      
      private var _moveMc:MovieClip;
      
      private var _firstBtn:Image;
      
      private var _secondBtn:Image;
      
      private var _thirdBtn:Image;
      
      private var _fourBtn:Image;
      
      private var _fiveBtn:Image;
      
      private var _sixBtn:Image;
      
      private var _senvenBtn:Image;
      
      private var _eightBtn:Image;
      
      private var _VBox:VBox;
      
      public function SkyTreasureBoxView()
      {
         super();
         initView();
         initShape();
         initEvent();
      }
      
      public function get model() : SkyTreasureModel
      {
         return SkyTreasureManager.Instance.model;
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         initButtonList();
         setBtnVisible();
         _boxArr = [];
         var _loc1_:int = 0;
         _loc1_ = int(model.chargeRewardList.length);
         _loc2_ = 1;
         while(_loc2_ < _loc1_ + 1)
         {
            _boxArr[_loc2_ - 1] = ComponentFactory.Instance.creatCustomObject("skytreasure.SkyTreasureIntergalBoxView");
            _boxArr[_loc2_ - 1].boxIndex = _loc2_;
            _boxArr[_loc2_ - 1].y = 310 - 60 * (_loc2_ - 1);
            _boxArr[_loc2_ - 1].buttonMode = false;
            addChild(_boxArr[_loc2_ - 1]);
            _loc2_++;
         }
         _efMc = ComponentFactory.Instance.creatCustomObject("skytreasure.SkyTreasureBoxViewEf");
         _bitmap = ComponentFactory.Instance.creatBitmap("asset.skytreasure.kong");
         _moveMc = ComponentFactory.Instance.creatCustomObject("skytreasure.SkyTreasureMoveBoxViewEF");
         _moveMc.x = 134;
         addChild(_bitmap);
         addChild(_moveMc);
         addChild(_efMc);
      }
      
      private function initEvent() : void
      {
         SkyTreasureManager.Instance.addEventListener("SKYTREASURE_RANK_UPDATE",__chargeUpdate);
      }
      
      protected function __hitBox(param1:Event) : void
      {
      }
      
      private function removeEvent() : void
      {
         SkyTreasureManager.Instance.removeEventListener("SKYTREASURE_RANK_UPDATE",__chargeUpdate);
      }
      
      private function __chargeUpdate(param1:SkyTreasureEvent) : void
      {
         getPercent();
      }
      
      private function getPercent() : void
      {
         var _loc2_:MovieClip = null;
         var _loc1_:SimpleMovie = null;
         if(model.joinInfoVO.integral > -1)
         {
            showAddIntergal(model.joinInfoVO.integral);
         }
         if(model.joinInfoVO.height <= 0)
         {
            _moveMc.visible = false;
         }
         else if(!_moveMc.visible)
         {
            _moveMc.visible = true;
         }
         if(model.joinInfoVO.height <= 200)
         {
            _mask.y = _efMc.y + _efMc.height - model.joinInfoVO.height / 10 - 9;
            _moveMc.y = _mask.y - 2;
         }
         else if(model.joinInfoVO.height > 200 && model.joinInfoVO.height <= 1600)
         {
            _mask.y = 350 - (model.joinInfoVO.height - 200) / 200 * 62;
            _moveMc.y = _mask.y - 2;
         }
         else if(model.joinInfoVO.height > 1600 && model.joinInfoVO.height <= 1800)
         {
            _mask.y = -90 - (model.joinInfoVO.height - 1600) / 200 * 20 + 5;
            _moveMc.y = _mask.y - 2;
         }
         else
         {
            _mask.y = _efMc.y + 9;
            _moveMc.y = _mask.y;
         }
         if(model.joinInfoVO.height > 0)
         {
            _loc2_ = ComponentFactory.Instance.creat("asset.gemmaze.LightEffect");
            _loc1_ = new SimpleMovie(_loc2_);
            _moveMc.addChild(_loc1_);
         }
      }
      
      private function showAddIntergal(param1:int) : void
      {
         var _loc4_:String = "#DDF5FF";
         var _loc2_:TextFormat = new TextFormat();
         _loc2_.size = 18;
         _loc2_.bold = true;
         _loc2_.font = "Arial";
         var _loc3_:TextField = new TextField();
         _loc3_.textColor = 16777215;
         _loc3_.htmlText = LanguageMgr.GetTranslation("gemMaze.GemMazeBoxView.showAddIntergal",_loc4_,param1);
         _loc3_.x = 70;
         _loc3_.y = 395;
         addChild(_loc3_);
         _loc3_.setTextFormat(_loc2_);
         TweenLite.to(_loc3_,1,{
            "y":250,
            "onComplete":onShowAddIntergalComplete,
            "onCompleteParams":[_loc3_]
         });
         model.joinInfoVO.integral = -1;
      }
      
      private function onShowAddIntergalComplete(param1:TextField) : void
      {
         TweenLite.to(param1,1,{
            "y":100,
            "alpha":0,
            "onComplete":onMoveAddIntergalComplete,
            "onCompleteParams":[param1]
         });
      }
      
      private function onMoveAddIntergalComplete(param1:TextField) : void
      {
         try
         {
            removeChild(param1);
         }
         catch(e:Error)
         {
         }
      }
      
      private function initButtonList() : void
      {
         _VBox = ComponentFactory.Instance.creatComponentByStylename("skyTreasureFrame.BoxView.VBox");
         _firstBtn = ComponentFactory.Instance.creatComponentByStylename("skyTreasureFrame.firstBtn");
         _secondBtn = ComponentFactory.Instance.creatComponentByStylename("skyTreasureFrame.secondBtn");
         _thirdBtn = ComponentFactory.Instance.creatComponentByStylename("skyTreasureFrame.thirdBtn");
         _fourBtn = ComponentFactory.Instance.creatComponentByStylename("skyTreasureFrame.fourBtn");
         _fiveBtn = ComponentFactory.Instance.creatComponentByStylename("skyTreasureFrame.fiveBtn");
         _sixBtn = ComponentFactory.Instance.creatComponentByStylename("skyTreasureFrame.sixBtn");
         _senvenBtn = ComponentFactory.Instance.creatComponentByStylename("skyTreasureFrame.senvenBtn");
         _eightBtn = ComponentFactory.Instance.creatComponentByStylename("skyTreasureFrame.eightBtn");
         _firstBtn.scaleX = _secondBtn.scaleX = _thirdBtn.scaleX = _fourBtn.scaleX = _fiveBtn.scaleX = _sixBtn.scaleX = _senvenBtn.scaleX = _eightBtn.scaleX = 0.83;
         _firstBtn.scaleY = _secondBtn.scaleY = _thirdBtn.scaleY = _fourBtn.scaleY = _fiveBtn.scaleY = _sixBtn.scaleY = _senvenBtn.scaleY = _eightBtn.scaleY = 0.83;
         _firstBtn.tipData = 1;
         _secondBtn.tipData = 2;
         _thirdBtn.tipData = 3;
         _fourBtn.tipData = 4;
         _fiveBtn.tipData = 5;
         _sixBtn.tipData = 6;
         _senvenBtn.tipData = 7;
         _eightBtn.tipData = 8;
         _VBox.addChild(_eightBtn);
         _VBox.addChild(_senvenBtn);
         _VBox.addChild(_sixBtn);
         _VBox.addChild(_fiveBtn);
         _VBox.addChild(_fourBtn);
         _VBox.addChild(_thirdBtn);
         _VBox.addChild(_secondBtn);
         _VBox.addChild(_firstBtn);
         _firstBtn.visible = false;
         _secondBtn.visible = false;
         _thirdBtn.visible = false;
         _fourBtn.visible = false;
         _fiveBtn.visible = false;
         _sixBtn.visible = false;
         _senvenBtn.visible = false;
         _eightBtn.visible = false;
         addChild(_VBox);
      }
      
      private function setBtnVisible() : void
      {
         var _loc1_:int = int(model.chargeRewardList.length);
         if(_loc1_ == 1)
         {
            if(_firstBtn)
            {
               _firstBtn.visible = true;
            }
         }
         else if(_loc1_ == 2)
         {
            if(_firstBtn)
            {
               _firstBtn.visible = true;
            }
            if(_secondBtn)
            {
               _secondBtn.visible = true;
            }
         }
         else if(_loc1_ == 3)
         {
            if(_firstBtn)
            {
               _firstBtn.visible = true;
            }
            if(_secondBtn)
            {
               _secondBtn.visible = true;
            }
            if(_thirdBtn)
            {
               _thirdBtn.visible = true;
            }
         }
         else if(_loc1_ == 4)
         {
            if(_firstBtn)
            {
               _firstBtn.visible = true;
            }
            if(_secondBtn)
            {
               _secondBtn.visible = true;
            }
            if(_thirdBtn)
            {
               _thirdBtn.visible = true;
            }
            if(_fourBtn)
            {
               _fourBtn.visible = true;
            }
         }
         else if(_loc1_ == 5)
         {
            if(_firstBtn)
            {
               _firstBtn.visible = true;
            }
            if(_secondBtn)
            {
               _secondBtn.visible = true;
            }
            if(_thirdBtn)
            {
               _thirdBtn.visible = true;
            }
            if(_fourBtn)
            {
               _fourBtn.visible = true;
            }
            if(_fiveBtn)
            {
               _fiveBtn.visible = true;
            }
         }
         else if(_loc1_ == 6)
         {
            if(_firstBtn)
            {
               _firstBtn.visible = true;
            }
            if(_secondBtn)
            {
               _secondBtn.visible = true;
            }
            if(_thirdBtn)
            {
               _thirdBtn.visible = true;
            }
            if(_fourBtn)
            {
               _fourBtn.visible = true;
            }
            if(_fiveBtn)
            {
               _fiveBtn.visible = true;
            }
            if(_sixBtn)
            {
               _sixBtn.visible = true;
            }
         }
         else if(_loc1_ == 7)
         {
            if(_firstBtn)
            {
               _firstBtn.visible = true;
            }
            if(_secondBtn)
            {
               _secondBtn.visible = true;
            }
            if(_thirdBtn)
            {
               _thirdBtn.visible = true;
            }
            if(_fourBtn)
            {
               _fourBtn.visible = true;
            }
            if(_fiveBtn)
            {
               _fiveBtn.visible = true;
            }
            if(_sixBtn)
            {
               _sixBtn.visible = true;
            }
            if(_senvenBtn)
            {
               _senvenBtn.visible = true;
            }
         }
         else if(_loc1_ == 8)
         {
            if(_firstBtn)
            {
               _firstBtn.visible = true;
            }
            if(_secondBtn)
            {
               _secondBtn.visible = true;
            }
            if(_thirdBtn)
            {
               _thirdBtn.visible = true;
            }
            if(_fourBtn)
            {
               _fourBtn.visible = true;
            }
            if(_fiveBtn)
            {
               _fiveBtn.visible = true;
            }
            if(_sixBtn)
            {
               _sixBtn.visible = true;
            }
            if(_senvenBtn)
            {
               _senvenBtn.visible = true;
            }
            if(_eightBtn)
            {
               _eightBtn.visible = true;
            }
         }
      }
      
      private function initShape() : void
      {
         _mask = new Shape();
         _mask.graphics.beginFill(16777215,0);
         _mask.graphics.drawRect(0,0,_efMc.width,_efMc.height);
         _mask.graphics.endFill();
         _mask.x = _efMc.x;
         _mask.y = _efMc.y;
         _efMc.mask = _mask;
         addChild(_mask);
         getPercent();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_boxArr);
         _boxArr = [];
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         ObjectUtils.disposeObject(_efMc);
         _efMc = null;
         ObjectUtils.disposeObject(_moveMc);
         _moveMc = null;
         ObjectUtils.disposeObject(_mask);
         _mask = null;
         ObjectUtils.disposeObject(_VBox);
         _VBox = null;
         ObjectUtils.disposeObject(_firstBtn);
         _firstBtn = null;
         ObjectUtils.disposeObject(_secondBtn);
         _secondBtn = null;
         ObjectUtils.disposeObject(_thirdBtn);
         _thirdBtn = null;
         ObjectUtils.disposeObject(_fourBtn);
         _fourBtn = null;
         ObjectUtils.disposeObject(_fiveBtn);
         _fiveBtn = null;
         ObjectUtils.disposeObject(_sixBtn);
         _sixBtn = null;
         ObjectUtils.disposeObject(_senvenBtn);
         _senvenBtn = null;
         ObjectUtils.disposeObject(_eightBtn);
         _eightBtn = null;
      }
   }
}

