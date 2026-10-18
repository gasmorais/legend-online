package armyII.viewII.stone.item
{
   import cell.view.bag.BaseBagCell;
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.MediatorMananger;
   import yishi.manager.NotificationManager;
   
   public class StoneBagCell extends BaseBagCell
   {
      
      public static const NAME:String = "armyII.viewII.stone.item.StoneBagCell";
      
      public static const P_checkStyle:String = "checkStyle";
      
      private static const P_openStyle:String = "openStyle";
      
      public static const P_suitStyle:String = "suitStyle";
      
      public static const P_initBackStyle:String = "initBackStyle";
      
      protected var _mediatorKey:String;
      
      protected var _registed:Boolean;
      
      private var _checkStyle:String;
      
      private var _checkBtn:SelectedButton;
      
      private var _openStyle:String;
      
      private var _openBit:Bitmap;
      
      private var _isOpen:Boolean;
      
      private var _suitStyle:String;
      
      private var _suitBit:ScaleFrameImage;
      
      private var _isSuit:Boolean;
      
      private var _xing:int;
      
      public var needMediator:Boolean = false;
      
      private var _effect:MovieClip;
      
      private var _initBackStyle:String;
      
      private var _initBack:Bitmap;
      
      private var _tmax:TweenMax;
      
      private var _lastSuit:Boolean;
      
      private var _needEvent:Boolean;
      
      public function StoneBagCell()
      {
         super();
      }
      
      override public function set data(param1:GoodsInfo) : void
      {
         if(data != param1)
         {
            setNormalFilter();
         }
         super.data = param1;
         if(param1)
         {
            lock = param1.isLock;
            if(param1.isLock)
            {
               cacelCheckState(false);
            }
            _itemText.text = LanguageMgr.GetTranslation("public.level2",param1.strengthenGrade);
         }
         else
         {
            lock = false;
            cacelCheckState(false);
         }
         mouseEnabled = true;
         mouseChildren = true;
         if(!_registed && needMediator)
         {
            _registed = true;
            registerMediator();
         }
      }
      
      public function playEffect(param1:Number, param2:Boolean = false) : void
      {
         _needEvent = param2;
         if(_tmax != null)
         {
            _tmax.kill();
         }
         if(_effect == null)
         {
            _effect = ComponentFactory.Instance.creatCustomObject("asset.army.openHoleEffect");
            _effect.addFrameScript(_effect.totalFrames - 1,showBgFun);
         }
         _effect.gotoAndStop(_effect.totalFrames - 1);
         _back.visible = false;
         if(_initBack)
         {
            _initBack.visible = true;
         }
         if(_suitBit)
         {
            _suitBit.visible = false;
         }
         addChild(_effect);
         _lastSuit = _isSuit;
         _tmax = TweenMax.delayedCall(param1,delayCallFun);
      }
      
      private function delayCallFun() : void
      {
         if(_effect != null)
         {
            _effect.gotoAndPlay(1);
         }
      }
      
      private function showBgFun() : void
      {
         isSuit = _lastSuit;
         if(_effect != null)
         {
            _effect.stop();
         }
         _back.visible = true;
         if(_initBack)
         {
            _initBack.visible = false;
         }
         if(_effect != null && _effect.parent)
         {
            removeChild(_effect);
         }
         if(_needEvent)
         {
            NotificationManager.instance.sendNotification("StonebagCell.EffectOver");
         }
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,53,52);
      }
      
      override public function set backgroundStyle(param1:String) : void
      {
         ObjectUtils.disposeObject(_back);
         super.backgroundStyle = param1;
      }
      
      protected function registerMediator() : void
      {
         var _loc1_:Array = [StoneBagCellClickMediator,StoneBagCellDropMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"armyII.viewII.stone.item.StoneBagCell");
      }
      
      protected function unregisterMediator() : void
      {
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
         if(_effect != null)
         {
            _effect.addFrameScript(_effect.totalFrames - 1,null);
         }
         if(_tmax != null)
         {
            _tmax.kill();
         }
         _tmax = null;
      }
      
      override public function dispose() : void
      {
         unregisterMediator();
         if(_checkBtn)
         {
            _checkBtn.removeEventListener("click",selectHandler);
            ObjectUtils.disposeObject(_checkBtn);
            _checkBtn = null;
         }
         ObjectUtils.disposeObject(_openBit);
         _openBit = null;
         ObjectUtils.disposeObject(_suitBit);
         _suitBit = null;
         ObjectUtils.disposeViolentMc(_effect);
         _effect = null;
         ObjectUtils.disposeObject(_initBack);
         _initBack = null;
         super.dispose();
      }
      
      public function get checkStyle() : String
      {
         return _checkStyle;
      }
      
      public function set checkStyle(param1:String) : void
      {
         if(_checkStyle == param1)
         {
            return;
         }
         _checkStyle = param1;
         ObjectUtils.disposeObject(_checkBtn);
         onPropertiesChanged("checkStyle");
      }
      
      public function get openStyle() : String
      {
         return _openStyle;
      }
      
      public function set openStyle(param1:String) : void
      {
         if(_openStyle == param1)
         {
            return;
         }
         _openStyle = param1;
         ObjectUtils.disposeObject(_openBit);
         onPropertiesChanged("openStyle");
      }
      
      public function get suitStyle() : String
      {
         return _suitStyle;
      }
      
      public function set suitStyle(param1:String) : void
      {
         if(_suitStyle == param1)
         {
            return;
         }
         _suitStyle = param1;
         onPropertiesChanged("suitStyle");
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["checkStyle"])
         {
            _checkBtn = ComponentFactory.Instance.creatComponentByStylename(_checkStyle);
            _checkBtn.visible = false;
            _checkBtn.addEventListener("click",selectHandler);
         }
         if(_changedPropeties["initBackStyle"])
         {
            _initBack = ComponentFactory.Instance.creatBitmap(_initBackStyle);
            _initBack.visible = false;
         }
         if(_changedPropeties["openStyle"])
         {
            _openBit = ComponentFactory.Instance.creatBitmap(_openStyle);
         }
         if(_changedPropeties["suitStyle"])
         {
            _suitBit = ComponentFactory.Instance.creatComponentByStylename(_suitStyle);
            _suitBit.setFrame(2);
            _suitBit.mouseChildren = false;
            _suitBit.mouseEnabled = false;
            isSuit = false;
         }
      }
      
      private function selectHandler(param1:Event) : void
      {
         NotificationManager.instance.sendNotification("StoneBagCell.Event");
      }
      
      public function doCheckState() : void
      {
         if(_checkBtn)
         {
            _checkBtn.visible = true;
            _checkBtn.selected = true;
         }
      }
      
      public function cacelCheckState(param1:Boolean) : void
      {
         if(_checkBtn)
         {
            _checkBtn.visible = param1;
            _checkBtn.selected = false;
         }
      }
      
      public function get isChoose() : Boolean
      {
         if(_checkBtn && _checkBtn.visible && _checkBtn.selected)
         {
            return true;
         }
         return false;
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_initBack)
         {
            addChild(_initBack);
         }
         if(_checkBtn)
         {
            addChild(_checkBtn);
         }
         if(_openBit)
         {
            addChild(_openBit);
         }
         if(_suitBit)
         {
            addChild(_suitBit);
         }
         if(_lockImg)
         {
            addChild(_lockImg);
         }
         if(_shape)
         {
            _shape.visible = false;
         }
      }
      
      public function get isOpen() : Boolean
      {
         return _isOpen;
      }
      
      public function set isOpen(param1:Boolean) : void
      {
         _isOpen = param1;
         if(_openBit)
         {
            _openBit.visible = !_isOpen;
         }
      }
      
      public function get isSuit() : Boolean
      {
         return _isSuit;
      }
      
      public function set isSuit(param1:Boolean) : void
      {
         _isSuit = param1;
         if(_suitBit)
         {
            _suitBit.visible = _isSuit;
         }
      }
      
      public function get xing() : int
      {
         return _xing;
      }
      
      public function set xing(param1:int) : void
      {
         if(_xing == param1)
         {
            return;
         }
         _xing = param1;
         var _loc2_:Bitmap = _back as Bitmap;
         if(_loc2_)
         {
            _loc2_.bitmapData = ComponentFactory.Instance.creatBitmapData("asset.army.stone.shape" + _xing);
         }
         else
         {
            backgroundStyle = "asset.army.stone.shape" + _xing;
         }
      }
      
      public function get initBackStyle() : String
      {
         return _initBackStyle;
      }
      
      public function set initBackStyle(param1:String) : void
      {
         if(_initBackStyle == param1)
         {
            return;
         }
         _initBackStyle = param1;
         onPropertiesChanged("initBackStyle");
      }
   }
}

