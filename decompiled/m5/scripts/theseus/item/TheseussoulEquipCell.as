package theseus.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import mvc.module.theseus.TheseussoulModel;
   import mvc.module.theseus.WarFrameItemInfo;
   import theseus.mediator.TheseussoulEquipCellClickMediator;
   import theseus.mediator.TheseussoulEquipCellDropMediator;
   import yishi.manager.MediatorMananger;
   import yishi.utils.NumberViewUtils;
   import yishi.view.community.BaseWarItem;
   
   public class TheseussoulEquipCell extends BaseWarItem
   {
      
      public static const NAME:String = "theseus.item.TheseussoulEquipCell";
      
      public static const P_Bg1Style:String = "bg1Style";
      
      public static const P_Bg2Style:String = "bg2Style";
      
      public static const P_CellLvStyle:String = "cellLvStyle";
      
      public static const P_EquipStyle:String = "equipStyle";
      
      public static const P_FullStyleX:String = "fullStyleX";
      
      public static const P_FullStyleY:String = "fullStyleY";
      
      public static const P_FullStyle:String = "fullStyle";
      
      private var _sonType:int;
      
      private var _registed:Boolean;
      
      private var _mediatorKey:String;
      
      private var _bg1Style:String;
      
      private var _bg1:Bitmap;
      
      private var _bg2Style:String;
      
      private var _bg2:Bitmap;
      
      private var _cellLvStyle:String;
      
      private var _eCellLv:FilterFrameText;
      
      private var _equipStyle:String;
      
      private var _equipImg:ScaleFrameImage;
      
      private var _fullStyleY:int;
      
      private var _fullStyleX:int;
      
      private var _fullStyle:String;
      
      private var _fullBit:Bitmap;
      
      private var _strengNumSprite:Sprite;
      
      private var _strengImg:BitmapData;
      
      private var _suitIdx:int;
      
      public var needMediator:Boolean = true;
      
      public var model:TheseussoulModel;
      
      private var _redImg:Image;
      
      public function TheseussoulEquipCell()
      {
         super();
      }
      
      public function set fullStyleY(param1:int) : void
      {
         _fullStyleY = param1;
         onPropertiesChanged("fullStyleY");
      }
      
      public function set fullStyleX(param1:int) : void
      {
         _fullStyleX = param1;
         onPropertiesChanged("fullStyleX");
      }
      
      public function get fullStyle() : String
      {
         return _fullStyle;
      }
      
      public function set fullStyle(param1:String) : void
      {
         _fullStyle = param1;
         onPropertiesChanged("fullStyle");
      }
      
      public function get equipStyle() : String
      {
         return _equipStyle;
      }
      
      public function set equipStyle(param1:String) : void
      {
         _equipStyle = param1;
         onPropertiesChanged("equipStyle");
      }
      
      public function get cellLvStyle() : String
      {
         return _cellLvStyle;
      }
      
      public function set cellLvStyle(param1:String) : void
      {
         _cellLvStyle = param1;
         onPropertiesChanged("cellLvStyle");
      }
      
      public function get bg2Style() : String
      {
         return _bg2Style;
      }
      
      public function set bg2Style(param1:String) : void
      {
         _bg2Style = param1;
         onPropertiesChanged("bg2Style");
      }
      
      public function get bg1Style() : String
      {
         return _bg1Style;
      }
      
      public function set bg1Style(param1:String) : void
      {
         _bg1Style = param1;
         onPropertiesChanged("bg1Style");
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["fullStyle"])
         {
            _fullBit = ComponentFactory.Instance.creatBitmap(_fullStyle);
            _strengImg = ComponentFactory.Instance.creatBitmapData("asset.tips.numImg");
            if(_changedPropeties["fullStyleY"])
            {
               _fullBit.y = _fullStyleY;
            }
            if(_changedPropeties["fullStyleX"])
            {
               _fullBit.x = _fullStyleX;
            }
            _fullBit.scaleX = _fullBit.scaleY = 0.9;
            _fullBit.x = 2;
            _fullBit.y = 1;
            _strengNumSprite = new Sprite();
            _strengNumSprite.y = 5;
            _strengNumSprite.x = 12;
            _strengNumSprite.scaleX = _strengNumSprite.scaleY = 0.7;
            _strengNumSprite.mouseChildren = _strengNumSprite.mouseEnabled = false;
         }
         if(_changedPropeties["equipStyle"])
         {
            _equipImg = ComponentFactory.Instance.creatComponentByStylename(_equipStyle);
         }
         if(_changedPropeties["bg1Style"])
         {
            _bg1 = ComponentFactory.Instance.creatBitmap(_bg1Style);
         }
         if(_changedPropeties["bg2Style"])
         {
            _bg2 = ComponentFactory.Instance.creatBitmap(_bg2Style);
         }
         if(_changedPropeties["cellLvStyle"])
         {
            _eCellLv = ComponentFactory.Instance.creatComponentByStylename(_cellLvStyle);
         }
      }
      
      private function setStrengNum(param1:int) : void
      {
         NumberViewUtils.refreshValue(param1,_strengNumSprite,_strengImg,19,22,10,19,"0123456789");
      }
      
      override protected function addChildren() : void
      {
         if(_bg1)
         {
            addChild(_bg1);
         }
         if(_equipImg)
         {
            addChild(_equipImg);
         }
         super.addChildren();
         if(_bg2)
         {
            addChild(_bg2);
         }
         if(_profile)
         {
            removeChild(_profile);
            addChild(_profile);
         }
         if(_eCellLv)
         {
            addChild(_eCellLv);
         }
         if(_fullBit)
         {
            addChild(_fullBit);
            addChild(_strengNumSprite);
         }
      }
      
      override public function set data(param1:WarFrameItemInfo) : void
      {
         if(data != param1)
         {
            setNormalFilter();
         }
         super.data = param1;
         mouseEnabled = true;
         mouseChildren = true;
         if(param1)
         {
            _eCellLv.text = LanguageMgr.GetTranslation("public.level2",param1.warTempInfo.Property4);
         }
         else
         {
            _eCellLv.text = "";
         }
         if(_fullBit)
         {
            if(param1)
            {
               _fullBit.visible = param1.strengthen > 0;
               _strengNumSprite.visible = param1.strengthen > 0;
               setStrengNum(param1.strengthen);
            }
            else
            {
               _fullBit.visible = false;
               _strengNumSprite.visible = false;
            }
         }
         var _loc2_:String = _suitIdx + "_" + pos;
         if(needMediator && model.redDic[_loc2_])
         {
            if(!_redImg)
            {
               _redImg = ComponentFactory.Instance.creatComponentByStylename("ui.theseusEquipCell.Red");
            }
            addChild(_redImg);
         }
         else if(_redImg && _redImg.parent)
         {
            _redImg.parent.removeChild(_redImg);
         }
         if(!_registed && needMediator)
         {
            registerMediator();
         }
      }
      
      private function registerMediator() : void
      {
         _registed = true;
         var _loc1_:Array = [TheseussoulEquipCellClickMediator,TheseussoulEquipCellDropMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"theseus.item.TheseussoulEquipCell");
      }
      
      private function unRegisterMediator() : void
      {
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
      }
      
      public function set sonType(param1:int) : void
      {
         _sonType = param1;
         if(_equipImg)
         {
            _equipImg.setFrame(_sonType + 1);
         }
      }
      
      public function get sonType() : int
      {
         return _sonType;
      }
      
      override public function dispose() : void
      {
         unRegisterMediator();
         ObjectUtils.disposeObject(_bg2);
         _bg2 = null;
         ObjectUtils.disposeObject(_bg1);
         _bg1 = null;
         ObjectUtils.disposeObject(_equipImg);
         _equipImg = null;
         ObjectUtils.disposeObject(_eCellLv);
         _eCellLv = null;
         ObjectUtils.disposeObject(_fullBit);
         _fullBit = null;
         ObjectUtils.disposeObject(_strengNumSprite);
         _strengNumSprite = null;
         ObjectUtils.disposeObject(_strengImg);
         _strengImg = null;
         ObjectUtils.disposeObject(_redImg);
         _redImg = null;
         super.dispose();
      }
      
      public function get suitIdx() : int
      {
         return _suitIdx;
      }
      
      public function set suitIdx(param1:int) : void
      {
         _suitIdx = param1;
      }
   }
}

